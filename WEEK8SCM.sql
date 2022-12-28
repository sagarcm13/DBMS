create database f;
use f;
create table flight(
flno int,
fromm varchar(20),
too varchar(20),
distance int,
departs time,
arrives time,
price real,
primary key(flno));

create table aircraftt(
aid int,
aname varchar(20),
cruisingrange int,
primary key(aid));

create table employee(
eid int,
ename varchar(20),
salary real,
primary key(eid));

create table certified(
eid int,
aid int,
foreign key(eid) references employee(eid),
foreign key (aid) references aircraftt(aid));

insert into flight values(1,'bangalore','delhi',500,'06:00:00','09:00:00',5000);
insert into flight values(2,'bangalore','chennai',300,'07:00:00','08:50:00',3000);
insert into flight values(3,'trivandrum','delhi',800,'08:00:00','11:30:00',6000);
insert into flight values(4,'bangalore','frankfurt',10000,'06:00:00','23:30:00',50000);
insert into flight values(5,'kolkata','delhi',2400,'11:00:00','03:30:00',9000);
insert into flight values(6,'bangalore','frankfurt',8000,'09:00:00','23:00:00',40000);

insert into employee values(101,'avinash',50000);
insert into employee values(102,'lokesh',60000);
insert into employee values(103,'rakesh',70000);
insert into employee values(104,'santosh',820000);
insert into employee values(105,'tilak',5000);

insert into aircraftt values(1,'airbus',2000),(2,'boeing',700),(3,'	jetairways',550)
,(4,'indigo',5000),(5,'boeing',4500),(6,'airbus',2200);

insert into certified values(101,4),(101,5),(101,6),(102,1),(102,3),(102,5)
,(103,2),(103,3),(103,5),(103,6),(104,6),(104,1),(104,6),(104,3),(105,3);
insert into certified values(101,2);

select * from flight;
select * from aircraftt;
select * from employee;
select * from certified;

#1 Find the names of aircraft such that all pilots certified to operate them have salaries more than Rs.80,000.
select aname from aircraftt a, employee e, certified c 
where e.eid= c.eid and a.aid=c.aid and e.salary>80000;

#2 For each pilot who is certified for more than three aircrafts, find the eid and	 the maximum cruisingrange of the aircraft for which she or he is certified.
select e.eid,max(a.cruisingrange) from employee e, certified c ,aircraftt a
where e.eid=c.eid and a.aid=c.aid
group by e.eid having count(a.aid)>3;

#3 Find the names of pilots whose salary is less than the price of the cheapest route from Bengaluru to Frankfurt.
select ename from employee e
where salary< (select min(price) from flight where too='frankfurt');

#4For all aircraft with cruising range over 1000 Kms, find the name of the aircraft and the average salary of all pilots certified for this aircraft.
select a.aid, a.aname,avg(e.salary) from employee e, certified c, aircraftt a
where a.aid=c.aid and e.eid=c.eid and a.cruisingrange>1000
group by a.aid;

#5Find the names of pilots certified for some Boeing aircraft	
select distinct ename from employee e,certified c,aircraftt a
where a.aid =c.aid and e.eid=c.eid and aname='boeing';

#6Find the aids of all aircraft that can be used on routes from Bengaluru to New Delhi.
select aid from aircraftt a
where cruisingrange >(select distance from flight where fromm ='bangalore' and too= 'delhi' );