

CREATE TABLE Employee(
					EmployeeID INT IDENTITY PRIMARY KEY, 
					EmpName VARCHAR(20),
					Phone NVARCHAR(12), 
					Email NVARCHAR(30)
					)

INSERT INTO Employee VALUES('Ganga','1234567890','Ganga@gmail.com'),  
							('Ram','1234567890','Ram@gmail.com'),                   
							('Rahul','1234567890','Rahul@gmail.com'),             
							('Ravi','1234567890','Ravi@gmail.com'),               
							('Shyam','1234567890','Shyam@gmail.com')

SELECT * FROM Employee


CREATE TABLE Manufacturer(  
MfName NVARCHAR(20) PRIMARY KEY, 
							City VARCHAR(20),   
							State VARCHAR(20)
							)


INSERT INTO Manufacturer VALUES('Lenovo','Charity','South Dakota'),       
								('IBM','Seattle','Washington'),        
								('Acer','Pierre','South Dakota'),      
								('Apple','Buffalo','New York'),         
								('Dell','Dallas','Texas')

SELECT * FROM Manufacturer



CREATE TABLE Computer(  
					SerialNumber INT IDENTITY PRIMARY KEY, 
					MfName NVARCHAR(20)    
					CONSTRAINT fk_mfname    
					FOREIGN KEY (MfName)     
					REFERENCES Manufacturer(MfName)   
					ON DELETE CASCADE, 
					Model NVARCHAR(20),  
					Weight NUMERIC(7,2), 
					EmployeeID INT     
					CONSTRAINT fk_empid    
					FOREIGN KEY (EmployeeID)   
					REFERENCES Employee(EmployeeID)    
					ON DELETE CASCADE
					)

INSERT INTO Computer VALUES('Lenovo','A1',3.0,1),       
						('IBM','B1',2.0,NULL),                       
						('Apple','A2',1.7,3),                      
						('Apple','A3',1.0,NULL),                    
						('Dell','B2',4.0,4)

SELECT * FROM Computer


--- Question 1 ---
--List the manufacturers’ names that are located in South Dakota.
SELECT MfName FROM Manufacturer WHERE State LIKE 'South Dakota'


--- Question 2 ---
--Calculate the average weight of the computers in use.
SELECT AVG(Weight) AS [Average Weight Of Computers] FROM Computer WHERE EmployeeID IS NOT NULL


--- Question 3 ---
--List the employee names for employees whose Phone starts with 2
SELECT EmpName FROM Employee WHERE Phone LIKE '2%'



--- Question 4 ---
--List the serial numbers for computers that have a weight below average
SELECT SerialNumber FROM Computer
WHERE Weight < (SELECT AVG(Weight) FROM Computer)


--- Question 5 ---
--List the manufacturer names of companies that do not have any computers in use. Use a subquery.
SELECT MfName FROM Computer WHERE MfName IN (SELECT MfName FROM Computer WHERE EmployeeID IS NOT NULL)


--- Question 6 ---
--List the employee name, their computer serial number, and the city that they were manufactured in. Use a join.
SELECT e.EmpName,c.SerialNumber, m.city FROM Computer c
INNER JOIN Employee e
ON e.EmployeeID = c.EmployeeID
INNER JOIN Manufacturer m
ON c.MfName = m.MfName


--- Question 7 -----Write a Procedure  that takes EmployeeId  and List the serial number, manufacturer name, model, and weight of computer that belong to the specified employeeid.
CREATE PROCEDURE sp_ComputerDetailByEmployee
@EmployeeID INT
AS
BEGIN    SELECT SerialNumber,MfName,Model,Weight FROM Computer  
WHERE EmployeeID = @EmployeeID
END

 sp_ComputerDetailByEmployee 1

