create database Supplier_d1;
use Supplier_d1;
create table suppliers_1BM21CS181
(
sid int primary key,
sname varchar(20),
city varchar(20)
);
create table suppliers_1BM21CS181	
(
sid int primary key,
sname varchar(20),
city varchar(20)
);
create table parts_1BM21CS181
(
pid int primary key,
pname varchar(20),
color varchar(10)
);
create table catalog_1BM21CS181
(
sid int,
pid int,
foreign key(sid)references suppliers(sid) on delete cascade,
foreign key(pid) references parts(pid) on delete cascade,
cost float,
primary key(sid,pid)
);	
insert into suppliers values(10001, "Acme Widget","Bangalore"), (10002,
"Johns","Kolkata"),
(10003,"Vimal","Mumbai"), (10004,"Reliance","Delhi"),
(10005,"Mahindra","Mumbai");

insert into parts values(20001,"Book","Red"),
(20002,"Pen","Red"), (20003,"Pencil","Green"),
(20004,"Mobile","Green"), (20005,"Charger","Black");

insert into catalog values(10001, 20001,10),
(10001, 20002,10), (10001, 20003,30),
(10001, 20004,10), (10001, 20005,10),
(10002, 20001,10), (10002, 20002,20),
(10003, 20003,30), (10004, 20003,40);

#todo1
select distinct pname from parts pa,catalog ca,suppliers s
where ca.sid=s.sid and pa.pid=ca.pid;

#todo2
select sname from suppliers s
where ((select count(pa.pid) from parts pa)=(select  count(c.pid)from catalog c where 	c.sid=s.sid));

#todo3
select s.sname
from suppliers s
where (select count(*) from catalog c1, suppliers s1, parts p1 
where c1.pid = p1.pid and c1.sid = s1.sid and color = "Red" and c1.sid = s.sid group by color) = 
(select count(*) from parts where color="Red" group by color);

#todo4
select p.pname
from parts p, catalog c
where p.pid = c.pid and c.sid = (select sid from suppliers where sname ="Acme Widget")
 and not exists(select * from catalog c1 where c1.pid = c.pid and c1.sid != c.sid);
 
 #todo5
select s.sid
from suppliers s, catalog c
where s.sid = c.sid and c.cost > (select avg(c1.cost)
                                  from catalog c1
                                  where c1.pid = c.pid
                                  group by c1.pid);
                                  
#todo6
select s.sname, c.pid
from suppliers s, catalog c
where s.sid = c.sid and c.cost = (select max(c1.cost)
                                  from catalog c1
                                  where c1.pid = c.pid
                                  group by c1.pid);