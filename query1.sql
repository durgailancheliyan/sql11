create database sql4
use sql4
create table student ( rollno int, stuname varchar(50),age int)
select * from student
alter table student add column department varchar(30)
alter table student change  department dept varchar(30)
drop table student
drop database sql4
DATE - format YYYY-MM-DD
DATETIME - format: YYYY-MM-DD HH:MI:SS
TIMESTAMP - format: YYYY-MM-DD HH:MI:SS
YEAR - format YYYY or YY
-------------------------------------------------
view---
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
------------------------------------------------
use offices
create view viewsql3 as select * from empdetails where age= 26
select * from viewsql3
select * from office
create view viewoff
as select * from office where salary =40000
select * from viewoff

create view viewstudentdet as select rollno,

empname,address,place
from empdetails
 select * from viewstudentdet

CREATE VIEW viewstudent AS
SELECT *
FROM office
WHERE condition;
select * from viewstudent
------------------------------------------------------
any and subquery
SELECT column_name(s)
FROM table_name
WHERE column_name operator ANY
  (SELECT column_name
  FROM table_name
  WHERE condition);
  -------------------------------------------------------------------
  all or any
  SELECT column_name(s)
FROM table_name
WHERE column_name operator ALL
  (SELECT column_name
  FROM table_name
  WHERE condition);
  ------------------------------------------------------------------
  INSERT INTO SELECT statement copies 
  data from one table and inserts it into another table.
  
 --- INSERT INTO table2
SELECT * FROM table1
WHERE condition;

---INSERT INTO table2 (column1, column2, column3, ...)
SELECT column1, column2, column3, ...
FROM table1
WHERE condition;
------------------------------------------------------------------------------
The CASE statement goes through conditions and returns a value when the first condition is met (like an if-then-else statement). 
So, once a condition is true, it will stop reading and return the result. If no conditions are true, it returns the value in the ELSE 

CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;

example 
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN 'The quantity is greater than 30'
    WHEN Quantity = 30 THEN 'The quantity is 30'
    ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails;

SELECT CustomerName, City, Country
FROM Customers
ORDER BY
(CASE
    WHEN City IS NULL THEN Country
    ELSE City
END);

-------------------------------------------------------------------------------------------
MySQL IFNULL() Function
SELECT ProductName, UnitPrice * (UnitsInStock + IFNULL(UnitsOnOrder, 0))
FROM Products;



use offices

 select * from office
 
 SELECT a.rollno, a.empname, a.age
FROM empdetails AS a WHERE a.rollno 
in (
    SELECT b.rollno
    FROM office AS b
    WHERE b.salary = 40000)
    
SELECT * FROM office
 select * from empdetails

SELECT column_name(s)
FROM table_name
WHERE column_name operator ALL
  (SELECT column_name
  FROM table_name
  WHERE condition)


use std


select * from stdtable
use std
SELECT regno, stuage,
CASE
    WHEN stuage > 24 THEN 'age is greater than 24'
    WHEN stuage = 24 THEN 'age is 24'
    ELSE 'age is under 24'
END AS textf
FROM stdtable;
use offices
select * from empdetails where  place like "c%"
select * from empdetails where place is  null
select distinct * from empdetails
select  * from empdetails where not (age=26 and rollno =101)
select  count(rollno) as regid , place from empdetails group by place having count(rollno) =2
select * from empdetails where age between 24 and 25
select  * from empdetails limit 2

select  * from empdetails order by rollno asc
select b.rollno,a.empname,a.empwork,b.age ,b.place
from office as a 
inner join empdetails as b on a.rollno = b.rollno

select count(rollno),place from empdetails where place is not null 
group by place having count(rollno) > 2
use offices

 
   SELECT * FROM empdetails where rollno > all (
    SELECT rollno
    FROM office
    WHERE salary = 40000
);
 SELECT * FROM empdetails where rollno = all (
    SELECT rollno
    FROM office
    WHERE salary = 40000
);

INSERT INTO office2
SELECT * FROM office
WHERE salary = 40000 ;

select * from empdetails3
create table office2 (rollno int , empname varchar(50), empwork varchar(50), salary int)
create table empdetails3 (rollno int , empname varchar(50), age int, phoneno varchar(20), address varchar(100), place varchar(50))
  insert into empdetails3
  select * from empdetails where place ="chennai"
use offices
select * from empdetails3
-----------------------------
index
CREATE INDEX index
ON TABLE column;
CREATE INDEX idx_empname
ON empdetails (empname);
create table office2 (rollno int , empname varchar(50), empwork varchar(50), salary int)
------------------------------------------------
CREATE TABLE Orders (
    ID int NOT NULL,
    OrderNumber int NOT NULL,
    OrderDate date DEFAULT GETDATE()
);
-----------------------------------------------
Stored Procedure
---------------
DELIMITER &&  
CREATE PROCEDURE procedure_name [[IN | OUT | INOUT] parameter_name datatype [, parameter datatype]) ]    
BEGIN    
    Declaration_section    
    Executable_section    
END &&  
DELIMITER ;   
select* from student
call officesemp();
----------------------------------------------------
USE `offices`;
DELIMITER $$
USE `offices`$$
create PROCEDURE `officesemp2` ()
BEGIN
select * from empdetails where rollno in (101,102);

END$$
DELIMITER ;
--------------------------------------------------------
call officesemp1;

-------------------------------------------------------------
DELIMITER $$
USE `offices`$$
ALTER PROCEDURE student (in var int)
BEGIN
select * from student;
END$$

DELIMITER ;
-----------------------------------------------------------
DELIMITER $$

USE `offices`$$

CREATE PROCEDURE office4(IN num INT)
BEGIN
    -- Example query using the input parameter
    SELECT * FROM office WHERE rollno = num;
END$$

DELIMITER ;
 call  office1(103);
-----------------------------------------------------
DELIMITER $$

USE `offices`$$

CREATE PROCEDURE office1()
BEGIN
    select count(rollno),place from empdetails where place is not null 
group by place having count(rollno) > 2
END$$

DELIMITER ;
 call  office1(101);
 -----------------------------------------------------------------------
 DELIMITER $$

CREATE PROCEDURE office3(
    IN var INT,
    OUT place_count INT,
    OUT place_name VARCHAR(255)
)
BEGIN
    -- Initialize OUT parameters
    SET place_count = 0;
    SET place_name = '';

    -- Fetch results and store them in OUT parameters
    SELECT COUNT(rollno), place
    INTO place_count, place_name
    FROM empdetails
    WHERE place IS NOT NULL
    GROUP BY place
    HAVING COUNT(rollno) > 2
    LIMIT 1;  -- Assuming you want only one record for demonstration
END$$

DELIMITER ;
-- Declare variables to hold the OUT parameter values
CALL office2(101, @place_count, @place_name);

-- Retrieve the OUT parameter values
SELECT @place_count AS place_count, @place_name AS place_name;
--------------------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE UpdateDepartmentInfo(
    INOUT dept_id INT,
    OUT emp_count INT,
    OUT dept_name VARCHAR(255)
)
BEGIN
    -- Initialize OUT parameters
    SET emp_count = 0;
    SET dept_name = '';

    -- Fetch the count of employees for the given department ID
    SELECT COUNT(*) INTO emp_count
    FROM employees
    WHERE department_id = dept_id;

    -- Fetch the department name
    SELECT department_name INTO dept_name
    FROM departments
    WHERE department_id = dept_id;
    
    -- Optionally update the dept_id parameter (for demonstration purposes)
    -- For instance, adding a suffix or modifying the ID
    SET dept_id = dept_id + 1000;  -- Example modification, adjust as needed
END$$

DELIMITER ;

-- Declare variables to hold parameter values
SET @dept_id = 101;   -- Example department ID to pass as INOUT
SET @emp_count = 0;
SET @dept_name = '';

-- Call the procedure
CALL UpdateDepartmentInfo(@dept_id, @emp_count, @dept_name);
CALL UpdateDepartmentInfo(101, 1, 'cs');

-- Retrieve and display the results
SELECT @dept_id AS updated_dept_id, @emp_count AS employee_count, @dept_name AS department_name;
----------------------------------------------------------------------------------------------------------------------------------------
----trigger insert
DELIMITER //
CREATE TRIGGER after_insert_office3
AFTER INSERT ON office2
FOR EACH ROW
BEGIN
    INSERT INTO empdetails3 (rollno, empname, age, phoneno, address, place)
    VALUES (NEW.rollno, NEW.empname, NULL, NULL, NULL, NULL);
END;
//
DELIMITER ;
INSERT INTO office2 (rollno, empname, empwork, salary) 
VALUES (121, 'ram', 'Developer', 50000);
---------------------------------------------------------------------------------------------------------------
select * from office2
select * from empdetails3
---------------------------------------------------------------------------------------------------------------
DELIMITER //

CREATE TRIGGER after_update_office2
AFTER UPDATE ON office2
FOR EACH ROW
BEGIN
    UPDATE empdetails3 
    SET empname = NEW.empname
    WHERE rollno = NEW.rollno;
END;

//

DELIMITER ;

UPDATE office2 
SET empname = 'Jane Doe'
WHERE rollno = 1;

------------------------------------------------------------------------------------------------------------------
DELETE FROM office2 
WHERE rollno = 1;

DELIMITER //

CREATE TRIGGER after_delete_office2
AFTER DELETE ON office2
FOR EACH ROW
BEGIN
    DELETE FROM empdetails3 
    WHERE rollno = OLD.rollno;
END;

//

DELIMITER ;

