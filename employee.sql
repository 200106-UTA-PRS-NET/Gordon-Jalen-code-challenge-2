create database employee;
use employee;

create table Department(
	ID int primary key identity,
	Name varchar(max),
	Location varchar(max),
)

create table Employee(
	ID int primary key identity,
	Firstname varchar(max)not null,
	Lastname varchar(max) not null,
	SSN char(9) not null unique,
	DeptID int foreign key references department(ID)
)

create table EmpDetails(
	ID int primary key identity,
	EmployeeID int foreign key references Employee(ID),
	Salary money not null,
	Address_1 varchar(max) not null,
	Address_2 varchar(max),
	City varchar(max) not null,
	[State] varchar(max) not null,
	Country varchar(max)
)

insert into Department(Name, Location) values ('Security', 'Building A 202'), ('Human Resources', 'Building A 123'), ('Business Administration', 'Building B 222');
insert into Employee(Firstname, Lastname, SSN, DeptID) values ('Billy', 'Bob', '123456789', 1), ('Timmy', 'Turner', '987654321', 2), ('Jimmy', 'Neutron', '123459876', 3);
insert into EmpDetails(EmployeeID, Salary, Address_1, Address_2, City, State, Country) values (1, 5000, '5612 8th Street', 'Willow 532', 'Dallas', 'Texas', 'USA'), (2, 3200, '3122 2nd Avenue', 'Old Town Road', 'Arlington', 'Texas', 'USA'), (3, 10000, '454 1st Street', null, 'Fortworth', 'Texas', 'USA');

insert into Department(name, location) values ('Marketing', 'Building 1, Floor 1');
insert into Employee(firstname, lastname, ssn, deptid) values ('Tina', 'Smith', '321654987', 4);
insert into EmpDetails(employeeID, salary, address_1, address_2, city, state, country) values (4, 33000, '1234 2nd Street', 'Apt 512', 'Texas City', 'Texas', 'USA');

select firstname as 'First Name', lastname as 'Last Name'
from employee where employee.deptid in
	(select id from Department where Department.name = 'Marketing');

select sum(salary) as 'Summed Salary' from EmpDetails
where employeeID in (select id from employee where deptid in
	(select id from Department where Department.name = 'Marketing'));

select department.name as 'Department', count(employee.id) as 'Num. Employees'
from department join employee on Department.id = employee.deptid
group by department.name;

update EmpDetails set salary = 90000
where employeeID in (select id from employee where firstname = 'Tina' and lastname = 'Smith');