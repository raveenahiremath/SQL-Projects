
create database	sqlproject2
USE sqlproject2


--1.Extract those employeeID where employee salary is greater than manager salary
CREATE TABLE EMPLOYEE(EMPID INT NOT NULL,SALARY FLOAT NOT NULL,MANAGERID INT)
insert into EMPLOYEE values(1,10000,NULL)
insert into EMPLOYEE values(2,8000,1)
insert into EMPLOYEE values(3,12000,1)
insert into EMPLOYEE values(4,5000,2)
insert into EMPLOYEE values(5,7000,2)
insert into EMPLOYEE values(6,10000,5)
insert into EMPLOYEE values(7,3000,5)

select e.EMPID from
EMPLOYEE e
inner join
employee m
on e.MANAGERID = m.EMPID and e.SALARY > m.SALARY

--2.Select Customers who have done net positive shopping in the last 2 years starting from today.
create table customer(CUSTID varchar(50) NOT NULL,SALES INT NOT NULL,DATE_ DATE)

  INSERT INTO CUSTOMER
  select '1011',1000,'12/22/2018'
union select '1012',1011,' 05/16/2018'
union select '1033',1081,'01/11/2018'
union select '1043',1056,'09/25/2017'
union select '1087',11111,'09/28/2016'
union select '10I9',1789,'10/08/2015'
union select '11I6',1590,'06/17/2017'
union select '1043',1056,'09/25/2017'
union select '1011',-11111,'12/22/2018'
union select '1012',1011,'05/16/2018'
union select '1033',1081,'01/11/2018'
union select '1043',-11056,'09/25/2017'
union select '1087',11111,'09/28/2016'
union select '10I9',1789,'10/08/2015'
union select '11I6',1590,'06/17/2017'

select * from customer

select custid,sales from customer where SALES>0 and
date_ between DATEadd(YEAR,-2,GETDATE()) and GETDATE()


--3. Append CUST_INFO_TABLE1 and CUST_INFO_TABLE2 TO FORM CUSTINFO TABLE
create table CUST_INFO_TABLE1(CUSTID varchar(50) NOT NULL,CITY VARCHAR(50)NOT NULL,ADDRESS VARCHAR(50) NOT NULL)

INSERT INTO CUST_INFO_TABLE1
select '1011','BANGALORE','MARATHALLI'
union select '1012','MUMBAI','BANDRA'
union select '1033','CHENNAI','ADYAR'
union select '1043','KOLKATA','JADAVPUR'
union select '1087','BUBNESHWAR','ASHOK NAGAR'
union select '10I9','BANGALORE','VIJAYNAGAR'
union select '11I6','MUMBAI','ALTAMOUNT ROAD'

SELECT * FROM CUST_INFO_TABLE1

create table CUST_INFO_TABLE2(CUSTID varchar(50) NOT NULL,CITY VARCHAR(50)NOT NULL,ADDRESS VARCHAR(50) NOT NULL)
insert into CUST_INFO_TABLE2
select '1043','CHENNAI','BESANT NAGAR'
union select '1011','KOLKATA','PARK STREET'
union select '1012','BUBNESHWAR','BAPUJI NAGAR'
union select '1033','HYDERABAD','JUBLIEE HILLS'
union select '1043','THIRUVANANTHAPURAM','VARKALA'
union select '1087','CHENNAI','ANNA NAGAR'
union select '10I9','BANGALORE','MALLESHWARAM'
union select '11I6','DELHI','VASANT KUNJ'

select * from CUST_INFO_TABLE2

SELECT *
INTO CUSTINFO_TABLE
FROM
(
SELECT * From CUST_INFO_TABLE1
UNION all
SELECT * From CUST_INFO_TABLE2
) as A
SELECT * FROM CUSTINFO_TABLE


--4.Select customerid, address fields along with city who have done shopping in last one year starting from today
select ct.CUSTID,ADDRESS,city
from CUSTINFO_TABLE as ct
inner join customer as cu
on ct.CUSTID = cu.CUSTID
where cu.DATE_ between DATEadd(YEAR,-1,GETDATE()) and GETDATE()

--5. Create 3 groups with 5 customers in each group with decreasing order of sales

--6.update the Address to ‘INDIRANAGR’ where the city is BANGALORE
update CUSTINFO_TABLE
set address='INDIRANAGR'
WHERE city='BANGALORE'

select * from CUSTINFO_TABLE

--7.update CUSTOMER_TABLE with city from CUST_INFO_TABLE
alter table customer
add city varchar(20)

update customer
set customer.city=CUSTINFO_TABLE.city from customer
inner join CUSTINFO_TABLE
on customer.CUSTID=CUSTINFO_TABLE.CUSTID
				
--8. find cumulative sum of SALES for each custid
select custid,SUM(sales) as [total sales]
from customer
group by custid
order by SUM(sales) desc

