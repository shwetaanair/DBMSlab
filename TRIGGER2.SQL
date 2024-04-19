cec@user:~$ sqlplus shweta as sysdba

SQL*Plus: Release 11.2.0.2.0 Production on Fri Apr 19 09:36:15 2024

Copyright (c) 1982, 2011, Oracle.  All rights reserved.

Enter password: 
ERROR:
ORA-01031: insufficient privileges


Enter user-name: shweta
Enter password: 

Connected to:
Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

SQL> select * from stock;
select * from stock
              *
ERROR at line 1:
ORA-00942: table or view does not exist


SQL> create table stock(item varchar(20),stockavail int);

Table created.

SQL> insert into stock values('pen',20);        

1 row created.

SQL> insert into stock values('pncil',30);

1 row created.

SQL> insert into stock values('scale',40);

1 row created.

SQL> insert into stock values('eraser',10);

1 row created.

SQL> insert into stock values('gelpen',25');
ERROR:
ORA-01756: quoted string not properly terminated


SQL> insert into stock values('box',25);

1 row created.

SQL> select * from stock;

ITEM		     STOCKAVAIL
-------------------- ----------
pen			     20
pncil			     30
scale			     40
eraser			     10
box			     25

SQL> create table purchase(id int,item varchar(20),no.ofitems int,price int);
create table purchase(id int,item varchar(20),no.ofitems int,price int)
                                                *
ERROR at line 1:
ORA-01748: only simple column names allowed here


SQL> create table purchase(id int primary key,item varchar(20),no_of_item int,price int);

Table created.

SQL> insert into purchase values(101,'pen',20,15);

1 row created.

SQL> insert into purchase values(101,'pencil',30,10);
insert into purchase values(101,'pencil',30,10)
*
ERROR at line 1:
ORA-00001: unique constraint (SHWETA.SYS_C007030) violated


SQL> insert into purchase values(102,'pencil'30,10);
insert into purchase values(102,'pencil'30,10)
                                        *
ERROR at line 1:
ORA-00917: missing comma


SQL> ;
  1* insert into purchase values(102,'pencil'30,10)
SQL> insert into purchase values(102,'pencil',30,10);

1 row created.

SQL> insert into purchase values(103,'scale',40,13);

1 row created.

SQL> insert into purchase values(104,'eraser',10,15);

1 row created.

SQL> insert into purchase values(105,'box',45,46);

1 row created.

SQL> select * from purchase;

	ID ITEM 		NO_OF_ITEM	PRICE
---------- -------------------- ---------- ----------
       101 pen				20	   15
       102 pencil			30	   10
       103 scale			40	   13
       104 eraser			10	   15
       105 box				45	   46

SQL> gedit trigger2.sql
SP2-0734: unknown command beginning "gedit trig..." - rest of line ignored.
SQL> desc stock
 Name					   Null?    Type
 ----------------------------------------- -------- ----------------------------
 ITEM						    VARCHAR2(20)
 STOCKAVAIL					    NUMBER(38)

SQL> desc purchase
 Name					   Null?    Type
 ----------------------------------------- -------- ----------------------------
 ID					   NOT NULL NUMBER(38)
 ITEM						    VARCHAR2(20)
 NO_OF_ITEM					    NUMBER(38)
 PRICE						    NUMBER(38)

SQL> delete from stock;

5 rows deleted.

SQL> insert into stock values('pen',20); 

1 row created.

SQL> insert into stock values('pncil',30);

1 row created.

SQL> insert into stock values('scale',40);

1 row created.

SQL> insert into stock values('eraser',10);

1 row created.

SQL> select * from stock;

ITEM		     STOCKAVAIL
-------------------- ----------
pen			     20
pncil			     30
scale			     40
eraser			     10

SQL> set serveroutput on
SQL> delete from purchase;

5 rows deleted.

SQL> select * from purchase;

no rows selected

SQL> @trigger2_1.sql

Trigger created.

SQL> insert into purchase values(101,'pen',5,20);
stock update

1 row created.

SQL> select * from purchase;

	ID ITEM 		NO_OF_ITEM	PRICE
---------- -------------------- ---------- ----------
       101 pen				 5	   20

SQL> select * from stock;

ITEM		     STOCKAVAIL
-------------------- ----------
pen			     15
pncil			     30
scale			     40
eraser			     10

create or replace trigger stock_updation after insert on purchase for each row
when(new.no_of_item>0)
begin
update stock set stockavail=stockavail-:new.no_of_item where item=:new.item;
dbms_output.put_line('stock update');
end;
/
