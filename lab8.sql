
--1
create database library_db;
--2
create table members(
    member_id serial primary key,
    member_name varchar(90),
    city varchar(90),
    membership_level integer,
    librarian_id integer
);
insert into members(member_id, member_name, city,membership_level,librarian_id)
values(1001, 'John Doe', 'New York',1,2001),
      (1002,'Alice Johnson','California',2,2002),
      (1003, 'Bob Smith', 'London', 1, 2003),
(1004, 'Sara Green', 'Paris', 3, 2004),
(1005, 'David Brown', 'New York', 1, 2001),
(1006, 'Emma White', 'Berlin', 2, 2005),
(1007, 'Olivia Black', 'Rome', 3, 2006);

create table borrowings(
    borrowing_id serial primary key,
    borrow_date date,
    return_date date,
    member_id integer,
    librarian_id integer,
    book_id integer
);
insert into borrowings (borrowing_id, borrow_date, return_date, member_id, librarian_id, book_id) VALUES
(30001, '2023-01-05', '2023-01-10', 1002, 2002, 5001),
(30002, '2022-07-10', '2022-07-17', 1003, 2003, 5002),
(30003, '2021-05-12', '2021-05-20', 1001, 2001, 5003),
(30004, '2020-04-08', '2020-04-15', 1006, 2005, 5004),
(30005, '2024-02-08', '2024-02-29', 1007, 2006, 5005),
(30006, '2023-06-02', '2023-06-12', 1005, 2001, 5001);

create table librarians(
    librarian_id serial primary key,
    name varchar(90),
    city varchar(90),
    commission float
);
insert into librarians(librarian_id, name,city,commission)
values(2001,'Michael Green', 'New York', 0.15),
      (2002,'Anna Blue','California', 0.13),
      (2003,'Chris Red', 'London', 0.12),
      (2004, 'Emma Yellow', 'Paris', 0.14),
      (2005,'David Purple', 'Berlin', 0.12),
      (2006,'Laura Orange','Rome', 0.13);

--3
create view librarians_in_ny as select * from librarians
where city ='New York';
--4
create view borrowing_record
as select borrowings.borrowing_id, borrowings.borrow_date,members.member_name, librarians.name from borrowings
join members on borrowings.member_id=members.member_id
join librarians on borrowings.librarian_id=librarians.librarian_id;
grant select on borrowing_record to library_user;--so user could only read data without changing it
--5
create view highest_membership_level
as select * from members
where membership_level=(select max(membership_level) from members);
grant select on highest_membership_level to library_user;

--6
create view librarians_count
as select city, count(*) from librarians
group by city;

--7
create view librarians_with_multiple_members AS
select l.librarian_id, l.name, COUNT(DISTINCT m.member_id) from librarians l
join members m ON l.librarian_id = m.librarian_id
group by l.librarian_id, l.name
having COUNT(DISTINCT m.member_id) > 1;

--8
create role intern;
grant library_user to intern


