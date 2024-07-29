CREATE DATABASE VineYards_CrudOperations

use VineYards_CrudOperations

CREATE TABLE country (
    CountryID INT PRIMARY KEY,
   CountryName VARCHAR(100) NOT NULL,
);

CREATE TABLE state (
    StateID INT PRIMARY KEY,
    StateName VARCHAR(100) NOT NULL,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES country(CountryID)
);

INSERT INTO country (CountryID, CountryName)
VALUES (1, 'India'),(2, 'Pakistan'),(3, 'China'),(4, 'USA'), (5, 'Sri Lanka');

INSERT INTO state (StateID, StateName, CountryID)
VALUES
    (1, 'Andhra Pradesh', 1),
    (2, 'Arunachal Pradesh', 1),
    (3, 'Assam', 1),
    (4, 'Bihar', 1),
    (5, 'Chhattisgarh', 1),
    (6, 'Goa', 1),
    (7, 'Gujarat', 1),
    (8, 'Haryana', 1),
    (9, 'Himachal Pradesh', 1),
    (10, 'Jharkhand', 1),
    (11, 'Karnataka', 1),
    (12, 'Kerala', 1),
    (13, 'Madhya Pradesh', 1),
    (14, 'Maharashtra', 1),
    (15, 'Manipur', 1),
    (16, 'Meghalaya', 1),
    (17, 'Mizoram', 1),
    (18, 'Nagaland', 1),
    (19, 'Odisha', 1),
    (20, 'Punjab', 1),
    (21, 'Rajasthan', 1),
    (22, 'Sikkim', 1),
    (23, 'Tamil Nadu', 1),
    (24, 'Telangana', 1),
    (25, 'Tripura', 1),
    (26, 'Uttar Pradesh', 1),
    (27, 'Uttarakhand', 1),
    (28, 'West Bengal', 1);


INSERT INTO state (StateID, StateName, CountryID)
VALUES
    (52, 'Western Province', 5),
    (53, 'Central Province', 5),
    (54, 'Northern Province', 5),
    (57, 'Eastern Province', 5);


INSERT INTO state (StateID, StateName, CountryID)
VALUES
    (41, 'California', 4),
    (42, 'Texas', 4),
    (43, 'New York', 4),
    (51, 'Hawaii', 4);


INSERT INTO state (StateID, StateName, CountryID)
VALUES
    (35, 'Beijing', 3),
    (36, 'Shanghai', 3),
    (37, 'Guangdong', 3),
    (40, 'Tibet', 3);
select * from country as c inner join state as s on s.CountryID=c.CountryID

CREATE TABLE department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    ManagerName VARCHAR(100)
);

INSERT INTO department (DepartmentID, DepartmentName, ManagerName)
VALUES
    (1, 'Sales', 'John Doe'),
    (2, 'Marketing', 'Jane Smith'),
    (3, 'Human Resources', 'Michael Johnson'),
    (4, 'IT', 'Emily Brown'),
    (5, 'Finance', 'David Lee');

	CREATE TABLE other_department (
    OtherDepartmentID INT PRIMARY KEY,
	OtherDepartmentName Varchar(50),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES department(DepartmentID)
);


INSERT INTO other_department (OtherDepartmentID, OtherDepartmentName, DepartmentID)
VALUES
    (1, 'Java Department', 4), 
    (2, '.NET Department', 4), 
    (3, 'HR Operations', 3),
    (4, 'Sales Operations', 1);


alter procedure GetDepartmentDetails
as begin 
select DepartmentID,DepartmentName  from department
end

Exec GetDepartmentDetails


create procedure GetOtherdepartmentdetails 
@departmentID int
as begin 
select * from other_department where DepartmentID = @departmentID
end

create procedure getstatesbyCountryID 
@countryId int
as begin 
select * from state where CountryID = @countryId
end

create procedure getcountries 
as begin 
select * from country
end

exec getcountries

exec  getstatesbyCountryID 2


exec GetOtherdepartmentdetails 4

select * from EmpInfo

create table EmpInfo 
		(	
		EmpID int primary key identity(100,1),	
		EmpName varchar(50),	
		EmpWorkPhone  Varchar(13),	
		EmpCellPhone varchar(13),
		EmpDOB Date,
		EmpAge smallInt,
		EmpDOJ Date,
		EmpGender varchar(50), 
		Empcaddress varchar(100),	
		Emppaddress varchar(100),
		EmpEmail varchar(50),
		CountryID int FOREIGN KEY REFERENCES Country(CountryID),
		StateID int FOREIGN KEY REFERENCES [state](StateID),
		DepartmentID int FOREIGN KEY REFERENCES Department(DepartmentID),
		otherDepartmentID int FOREIGN KEY REFERENCES other_department(otherDepartmentID),
		)

		select * from EmpInfo

Alter PROCEDURE Sp_InsertEmployeeInfo
		@EmpName varchar(50),
		@EmpWorkPhone  Varchar(13),	
		@EmpCellPhone varchar(13),
		@EmpDOB Date,
		@EmpAge smallInt,
		@EmpDOJ Date,
		@EmpGender varchar(50), 
		@Empcaddress varchar(100),	
		@Emppaddress varchar(100),
		@EmpEmail varchar(50),
		@CountryID int,
		@StateID int,
		@DepartmentID int,
		@otherDepartmentID int,
		@Jobtitle varchar(100)
AS BEGIN 
		INSERT INTO EmpInfo values(
			@EmpName,
			@EmpWorkPhone,
			@EmpCellPhone,
			@EmpDOB,
			@EmpAge,
			@EmpDOJ,
			@EmpGender,
			@Empcaddress,
			@Emppaddress,
			@EmpEmail,
			@CountryID,
			@StateID,
			@DepartmentID,
			@otherDepartmentID,
			@Jobtitle
			)
End

alter table EmpInfo add Jobtitle varchar(100)

exec Sp_InsertEmployeeInfo 'Gadekari Mahesh','+918897193624','+918897193624','1999-05-28',23,'2024-05-28','Male','hyd','Ameerpet','GadekariMahesh53@gmail.com',1,1,1,1

select * from EmpInfo

select Emp.EmpID,Emp.EmpName,Emp.EmpWorkPhone,Emp.EmpCellPhone,Emp.EmpEmail,Emp.Empcaddress,,dept.ManagerName from EmpInfo as Emp  left Join department as dept on emp.departmentID = dept.DepartmentID

Alter procedure Sp_GetEmployesList
	as Begin 
	select 
		Emp.EmpID,
		Emp.EmpName,
		Emp.EmpWorkPhone,
		Emp.EmpCellPhone,
		Emp.EmpEmail,
		Emp.Empcaddress,
		Emp.Jobtitle,
		dept.ManagerName
	from EmpInfo as Emp
	left Join 
	department as dept 
	on emp.departmentID = dept.DepartmentID
End



create procedure Sp_UpdateEmployeeById
		@EmpID int,
		@EmpName varchar(50),
		@EmpWorkPhone  Varchar(13),	
		@EmpCellPhone varchar(13),
		@EmpDOB Date,
		@EmpAge smallInt,
		@EmpDOJ Date,
		@EmpGender varchar(50), 
		@Empcaddress varchar(100),	
		@Emppaddress varchar(100),
		@EmpEmail varchar(50),
		@CountryID int,
		@StateID int,
		@DepartmentID int,
		@otherDepartmentID int,
		@Jobtitle varchar(100)
AS BEGIN
	UPDATE EmpInfo with(rowlock)
	set 
		EmpName = @EmpName,
		EmpWorkPhone = @EmpWorkPhone,
		EmpCellPhone=@EmpCellPhone,
		EmpDOB = @EmpDOB,
		EmpAge=@EmpAge,
		EmpDOJ = @EmpDOJ,
		EmpGender=@EmpGender,
		Empcaddress=@Empcaddress,
		EmpEmail=@EmpEmail,
		CountryID=@CountryID,
		StateID=@StateID,
		DepartmentID=@DepartmentID,
		otherDepartmentID=@otherDepartmentID,
		Jobtitle=@Jobtitle
	where EmpID=@EmpID
End


exec Sp_GetEmployesList

Create procedure Sp_GetEmployeeByID
@EmpID int
as begin 
select * from EmpInfo with(nolock) where Empid=@EmpID
End


exec Sp_GetEmployeeByID 100


Create procedure sp_deleteEmployeeByID
@EmpID int
as begin 
	Delete from EmpInfo where Empid=@EmpID
End


exec sp_deleteEmployeeByID 100
