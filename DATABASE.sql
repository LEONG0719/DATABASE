-- Active: 1735461067548@@127.0.0.1@3306@systems

CREATE DATABASE IF NOT EXISTS systems; 
USE systems;

--ENTITY 1 StaffPosition
CREATE TABLE IF NOT EXISTS StaffPosition(

    Position VARCHAR(10)  NOT NULL,
    Salary   DECIMAL(8,2),

    CONSTRAINT STFPosition_Position_PK PRIMARY KEY (Position)
);
--ENTITY 2 StaffPostcode

CREATE TABLE IF NOT EXISTS StaffPostcode(

    Postcode INT(5)      NOT NULL,
    State    VARCHAR(10) NOT NULL,

    CONSTRAINT STFPostcode_Postcode_PK PRIMARY KEY (Postcode)
);

--ENTITY 3 Staff

CREATE TABLE IF NOT EXISTS Staff(

    Staff_ID   VARCHAR(5)  NOT NULL,
    Name       VARCHAR(20) NOT NULL,
    Position   VARCHAR(10) NOT NULL,
    DoorplatNo INT(4)      NOT NULL,
    StreetNo   VARCHAR(20) NOT NULL,
    GardenName VARCHAR(30) NOT NULL,
    Postcode   INT(5)      NOT NULL,
    City       VARCHAR(10) NOT NULL,
    Country    VARCHAR(10) NOT NULL,
  
    CONSTRAINT STF_Staff_ID_PK PRIMARY KEY (Staff_ID),
    CONSTRAINT STF_Position_FK FOREIGN KEY (Position) REFERENCES StaffPosition (Position),
    CONSTRAINT STF_Postcode_FK FOREIGN KEY (Postcode) REFERENCES StaffPostcode (Postcode)
);

--ENTITY 4 Telephone
CREATE TABLE IF NOT EXISTS Telephone(

    Staff_ID VARCHAR(5)  NOT NULL,
    TelNo    VARCHAR(15) NOT NULL,

    CONSTRAINT TP_Staff_ID_TELNO_PK PRIMARY KEY (Staff_ID, TelNo),
    CONSTRAINT TP_Staff_ID_FK       FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 5 Supervision

CREATE TABLE IF NOT EXISTS Supervision(

    SuperviseeID VARCHAR(5) NOT NULL,
    SupervisorID VARCHAR(5) NOT NULL,

    CONSTRAINT SPV_Supervisee_Staff_ID PRIMARY KEY (SuperviseeID),
    CONSTRAINT SPV_Supervisee_FK       FOREIGN KEY (SuperviseeID) REFERENCES Staff (Staff_ID),
    CONSTRAINT SPV_Supervisor_FK       FOREIGN KEY (SupervisorID) REFERENCES Staff (Staff_ID)
);

--ENTITY 6 Stock

CREATE TABLE IF NOT EXISTS Stock(

    StockCheckDate  DATE         NOT NULL,
    StockValuesIn   DECIMAL(8,2) NOT NULL,
    StockValuesLeft DECIMAL(8,2) NOT NULL,
    Staff_ID        VARCHAR(5)   NOT NULL,

    CONSTRAINT STK_CheckDate   PRIMARY KEY (StockCheckDate),
    CONSTRAINT STK_Staff_ID_FK FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 7 Report

CREATE TABLE IF NOT EXISTS Report(

    ReportDate  DATE NOT NULL,
    TotalSales  DECIMAL(8,2) NOT NULL,
    TotalCost   DECIMAL(8,2) NOT NULL,
    TotalProfit DECIMAL(8,2) NOT NULL,
    Staff_ID    VARCHAR(5)   NOT NULL,

    CONSTRAINT RP_ReportDate_PK PRIMARY KEY (ReportDate),
    CONSTRAINT RP_Staff_ID_FK   FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID) 
);

--ENTITY 8 Menu

CREATE TABLE IF NOT EXISTS Menu(

    MenuID   VARCHAR(5)  NOT NULL,
    MenuName VARCHAR(30) NOT NULL UNIQUE, 
    Staff_ID VARCHAR(5)  NOT NULL,

    CONSTRAINT MN_MenuID_PK   PRIMARY KEY (MenuID),
    CONSTRAINT MN_Staff_ID_FK FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 9 InfoMenu

CREATE TABLE IF NOT EXISTS InfoMenu(

    MenuName  VARCHAR(30)  NOT NULL UNIQUE,
    MenuPrice DECIMAL(8,2) NOT NULL,
    Category  VARCHAR(20)  NOT NULL,

    CONSTRAINT IFMN_MenuName_PK PRIMARY KEY (MenuName),
    CONSTRAINT IFMN_MenuName_FK FOREIGN KEY (MenuName) REFERENCES Menu (MenuName)
);

--ENTITY 10 Cashier

CREATE TABLE IF NOT EXISTS Cashier(

    Staff_ID VARCHAR(5) NOT NULL,
    POS_LoginPin INT(6) NOT NULL,

    CONSTRAINT CSH_Staff_ID_PK PRIMARY KEY (Staff_ID),
    CONSTRAINT CSH_Staff_ID_FK FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 11 Counters

CREATE TABLE IF NOT EXISTS Counters(

    CounterDate      DATE         NOT NULL,
    EnterCounterCash DECIMAL(8,2) NOT NULL,
    LeaveCounterCash DECIMAL(8,2) NOT NULL,
    Staff_ID         VARCHAR(5)   NOT NULL,

    CONSTRAINT CTR_CounterDate_PK PRIMARY KEY (CounterDate),
    CONSTRAINT CTR_Staff_ID_FK    FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 12 Payment

CREATE TABLE IF NOT EXISTS Payment(

    PaymentNo     INT(10)     NOT NULL,
    PaymentMethod VARCHAR(15) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL,
    ReportDate    DATE        NOT NULL,
    CounterDate   DATE        NOT NULL,

    CONSTRAINT PM_PaymentNo_PK   PRIMARY KEY (PaymentNo),
    CONSTRAINT PM_ReportDate_FK  FOREIGN KEY (ReportDate)  REFERENCES Report (ReportDate),
    CONSTRAINT PM_CounterDate_FK FOREIGN KEY (CounterDate) REFERENCES Counters (CounterDate)
);

--ENTITY 13 Chef

CREATE TABLE IF NOT EXISTS Chef(

    Staff_ID              VARCHAR(5)  NOT NULL,
    Assigned_MenuCategory VARCHAR(30) NOT NULL,

    CONSTRAINT CF_Staff_ID_PK PRIMARY KEY (Staff_ID)
);

--ENTITY 14 Orders

CREATE TABLE IF NOT EXISTS Orders(

    OrderNo     INT(10)     NOT NULL,
    Quantity    INT(2)      NOT NULL,
    OrderStatus VARCHAR(10) NOT NULL,
    Staff_ID    VARCHAR(5)  NOT NULL,
    MenuID      VARCHAR(5)  NOT NULL,

    CONSTRAINT OD_OrderNo_PK  PRIMARY KEY (OrderNo),
    CONSTRAINT OD_Staff_ID_FK FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID),
    CONSTRAINT OD_MenuID_FK   FOREIGN KEY (MenuID)   REFERENCES Menu  (MenuID)
);

--ENTITY 15 Handling

CREATE TABLE IF NOT EXISTS Handling(

    KitchenOperationDate DATE       NOT NULL,
    Timestart            TIME       NOT NULL,
    TimeDone             TIME       NOT NULL,
    Staff_ID             VARCHAR(5) NOT NULL,
    OrderNo              INT(10)    NOT NULL,

    CONSTRAINT HD_Kitchen_PK  PRIMARY KEY (OrderNo),
    CONSTRAINT HD_Staff_ID_FK FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID),
    CONSTRAINT HD_OrderNO_FK  FOREIGN KEY (OrderNo)  REFERENCES Orders (OrderNo)
);

--ENTITY 16 OrderDetails

CREATE TABLE IF NOT EXISTS OrderDetails(

    OrderDetail VARCHAR(15),
    OrderNo     INT(10) NOT NULL,

    CONSTRAINT ODDT_ODetail_OrderNo_PK PRIMARY KEY (OrderDetail, OrderNo),
    CONSTRAINT ODDT_OrderNo_FK         FOREIGN KEY (OrderNo) REFERENCES Orders (OrderNo)
);

--ENTITY 17 CustomerName

CREATE TABLE IF NOT EXISTS CustomerName(

    PhoneNumber VARCHAR(12) NOT NULL,
    Name        VARCHAR(20) NOT NULL ,
    Customer_Age INT(5)     NOT NULL,

    CONSTRAINT CN_Phonenumber_PK PRIMARY KEY (PhoneNumber)
);

--ENTITY 18 Customer

CREATE TABLE IF NOT EXISTS Customer(

    CustomerNo INT(10)      NOT NULL,
    PhoneNumber VARCHAR(12) NOT NULL,

    CONSTRAINT CST_CustomerNo_PK  PRIMARY KEY (CustomerNo),
    CONSTRAINT CST_PhoneNumber_FK FOREIGN KEY (PhoneNumber) REFERENCES CustomerName (PhoneNumber)
);

--ENTITY 19 Making

CREATE TABLE IF NOT EXISTS Making(

    CustomerNo INT(10) NOT NULL,
    PaymentNo  INT(10) NOT NULL,
    OrderNo    INT(10) NOT NULL,
    
    CONSTRAINT MK_Making_PK     PRIMARY KEY (CustomerNo, PaymentNo, OrderNo),
    CONSTRAINT MK_CustomerNo_FK FOREIGN KEY (CustomerNo) REFERENCES Customer (CustomerNo),
    CONSTRAINT MK_PaymentNo_FK  FOREIGN KEY (PaymentNo)  REFERENCES Payment  (PaymentNo),
    CONSTRAINT MK_OrderNo_FK    FOREIGN KEY (OrderNo)    REFERENCES Orders   (OrderNo)
);

--ENTITY 20 CustPayment

CREATE TABLE IF NOT EXISTS CustPayment(

    PaymentNo   INT(10)      NOT NULL,
    DatePayment DATE         NOT NULL,
    TimePayment TIME         NOT NULL,
    PayPrice    DECIMAL(8,2) NOT NULL,

    CONSTRAINT CP_PaymentNo_PK PRIMARY KEY (PaymentNo),
    CONSTRAINT CP_PaymentNo_FK FOREIGN KEY (PaymentNo) REFERENCES Payment (PaymentNo)
);

--ALTER TABLE

ALTER TABLE orders
MODIFY OrderStatus VARCHAR(20) NOT NULL;

ALTER TABLE chef
ADD CONSTRAINT CF_Staff_ID_FK FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID);

ALTER TABLE CustomerName
DROP COLUMN Customer_Age;

--INSERTING DATA

INSERT INTO StaffPosition (Position, Salary)
VALUES 
    ('Owner', NULL),
    ('Chef', 3000.00),
    ('Cashier', 2000.00);

INSERT INTO StaffPostcode (Postcode, State)
VALUES 
    (12345, 'Selangor'),
    (54321, 'Johor'),
    (67890, 'Penang'),
    (81300, 'Johor');

INSERT INTO Staff (Staff_ID, Name, Position, DoorplatNo, StreetNo, GardenName, Postcode, City, Country)
VALUES 
    ('OW001', 'John Doe', 'Owner', 12, 'Jalan ABC', 'Rose Garden', 12345, 'Shah Alam', 'Malaysia'),
    ('CR001', 'Alice Lee', 'Cashier', 56, 'Jalan GHI', 'Tulip Garden', 67890, 'GeorgeTown', 'Malaysia'),
    ('CF001', 'Jane Smith', 'Chef', 34, 'Jalan DEF', 'Orchid Garden', 54321, 'JohorBahru', 'Malaysia'),
    ('CF002', 'Ali', 'Chef', 37, 'Jalan DEF', 'Orchid Garden', 54321, 'JohorBahru', 'Malaysia'),
    ('CF003', 'Ahmad', 'Chef', 56, 'Jalan HIJ', 'Sun Garden', 81300, 'JohorBahru', 'Malaysia');

INSERT INTO Telephone (Staff_ID, TelNo)
VALUES 
    ('OW001', '0123456789'),
    ('CR001', '0119876543'),
    ('CF001', '0165432109'),
    ('CF002', '0146869875'),
    ('CF003', '0167468390');

INSERT INTO Supervision (SuperviseeID, SupervisorID)
VALUES 
    ('CR001', 'OW001'),
    ('CF001', 'OW001'),
    ('CF002', 'OW001'),
    ('CF003', 'OW001');

INSERT INTO Stock (StockCheckDate, StockValuesIn, StockValuesLeft, Staff_ID)
VALUES 
    ('2025-01-01', 100.00, 1000.00, 'CR001');

INSERT INTO Report (ReportDate, TotalSales, TotalCost, TotalProfit, Staff_ID)
VALUES 
    ('2025-01-01', 54.00, 27.00, 27.00, 'OW001');

INSERT INTO Menu (MenuID, MenuName, Staff_ID)
VALUES 
    ('MR001', 'Nasi Goreng Kampung', 'OW001'),
    ('MN001', 'Mee Goreng', 'OW001'),
    ('MW001', 'Pasta', 'OW001'),
    ('MW002', 'Burger', 'OW001'),
    ('MW003', 'Pizza', 'OW001');

INSERT INTO InfoMenu (MenuName, MenuPrice, Category)
VALUES 
    ('Nasi Goreng Kampung', 6.00, 'Rice'),
    ('Mee Goreng', 6.00, 'Noodle'),
    ('Pasta', 6.00, 'Western'),
    ('Burger', 6.00, 'Western'),
    ('Pizza', 10.00, 'Western');

INSERT INTO Cashier (Staff_ID, POS_LoginPin)
VALUES 
    ('CR001', 123456);

INSERT INTO Counters (CounterDate, EnterCounterCash, LeaveCounterCash, Staff_ID)
VALUES 
    ('2025-01-01', 500.00, 506.00, 'CR001');

INSERT INTO Payment (PaymentNo, PaymentMethod, PaymentStatus, ReportDate, CounterDate)
VALUES 
    (1001, 'Credit Card', 'Completed', '2025-01-01', '2025-01-01'),
    (1002, 'Credit Card', 'Completed', '2025-01-01', '2025-01-01'),
    (1003, 'Touch n Go', 'Incompleted', '2025-01-01', '2025-01-01'),
    (1004, 'Credit Card', 'Completed', '2025-01-01', '2025-01-01'),
    (1005, 'Cash', 'Completed', '2025-01-01', '2025-01-01'),
    (1006, 'Debit Card', 'Completed', '2025-01-01', '2025-01-01');

INSERT INTO Chef (Staff_ID, Assigned_MenuCategory)
VALUES 
    ('CF001', 'Rice'),
    ('CF002', 'Noodles'),
    ('CF003', 'Western');

INSERT INTO Orders (OrderNo, Quantity, OrderStatus, Staff_ID, MenuID)
VALUES 
    (2001, 2, 'Completed', 'CF001', 'MR001'),
    (2002, 1, 'In Progress', 'CF002', 'MN001'),
    (2003, 1, 'Completed', 'CF003', 'MW001'),
    (2004, 2, 'Completed', 'CF003', 'MW003'),
    (2005, 1, 'In Progress', 'CF003', 'MW003'),
    (2006, 1, 'Completed', 'CF003', 'MW003');

INSERT INTO Handling (KitchenOperationDate, Timestart, TimeDone, Staff_ID, OrderNo)
VALUES 
    ('2025-01-01', '08:04:09', '08:13:56', 'CF001', 2001),
    ('2025-01-01', '09:01:45', '09:10:57', 'CF002', 2002),
    ('2025-01-01', '10:56:34', '11:59:10', 'CF003', 2003),
    ('2025-01-01', '10:59:10', '11:15:10', 'CF003', 2004),
    ('2025-01-01', '13:34:22', '13:50:11', 'CF003', 2005),
    ('2025-01-01', '14:54:11', '15:10:23', 'CF003', 2006);

INSERT INTO OrderDetails (OrderDetail, OrderNo)
VALUES 
    ('Add Spicy', 2001),
    ('No Spicy', 2002),
    ('No Spicy', 2003),
    ('Take Away', 2004),
    ('Take Away', 2005),
    ('Take Away', 2006);

INSERT INTO CustomerName (PhoneNumber, Name)
VALUES 
    ('0123456789', 'Michael Tan'),
    ('0118876543', 'Emily Wong'),
    ('0118276543', 'Wong'),
    ('0187998543', 'Ng'),
    ('0183749495', 'Gui'),
    ('0102846789', 'Leon');

INSERT INTO Customer (CustomerNo, PhoneNumber)
VALUES 
    (3001, '0123456789'),
    (3002, '0118876543'),
    (3003, '0118276543'),
    (3004, '0187998543'),
    (3005, '0183749495'),
    (3006, '0102846789');

INSERT INTO Making (CustomerNo, PaymentNo, OrderNo)
VALUES 
    (3001, 1001, 2001),
    (3002, 1002, 2002),
    (3003, 1003, 2003),
    (3004, 1004, 2004),
    (3005, 1005, 2005),
    (3006, 1006, 2006);

INSERT INTO CustPayment (PaymentNo, DatePayment, TimePayment, PayPrice)
VALUES 
    (1001, '2025-01-01', '08:03:09', 12.00),
    (1002, '2025-01-01', '09:01:12', 6.00),
    (1003, '2025-01-01', '10:55:56', 6.00),
    (1004, '2025-01-01', '10:58:10', 10.00),
    (1005, '2025-01-01', '13:33:22', 10.00),
    (1006, '2025-01-01', '14:52:11', 10.00);

--UPDATING DATA

UPDATE Payment
SET PaymentStatus = 'Completed'
WHERE PaymentNo = 1003;

UPDATE Orders
SET OrderStatus = 'Completed'
WHERE OrderNo = 2002;

UPDATE Orders
SET OrderStatus = 'Completed'
WHERE OrderNo = 2005;

--1)Retrieve Details of Staff and their Supervision

SELECT 

    s.Staff_ID,
    s.Name,
    s.Position,
    sp.SupervisorID

FROM Staff s
LEFT JOIN supervision sp
ON (s.Staff_ID = sp.SuperviseeID)
WHERE supervisorID IS NOT NULL
ORDER BY Staff_ID;

--2)Retrieve Details of Menu
SELECT 

    m.MenuID, 
    m.MenuName, 
    im.MenuPrice

FROM Menu m
LEFT JOIN InfoMenu im ON m.MenuName = im.MenuName
ORDER BY MenuID;

--3)Retrieve Details of All Completed Orders and Corresponding Payment
SELECT 
    o.OrderNo, 
    o.Quantity, 
    o.OrderStatus, 
    cp.PayPrice, 
    cp.DatePayment, 
    cp.TimePayment
FROM Orders o
JOIN Making mk ON o.OrderNo = mk.OrderNo
JOIN CustPayment cp ON mk.PaymentNo = cp.PaymentNo
WHERE o.OrderStatus = 'Completed'
ORDER BY OrderNo;

--4)Show Total Sales and Profit by Report Date
SELECT 
    ReportDate, 
    SUM(TotalSales)  TotalSales, 
    SUM(TotalProfit)  TotalProfit
FROM Report
GROUP BY ReportDate;

--5)Total Revenue by Payment Method
SELECT 
    p.PaymentMethod, 
    SUM(cp.PayPrice) TotalRevenue
FROM Payment p
JOIN CustPayment cp ON p.PaymentNo = cp.PaymentNo
GROUP BY p.PaymentMethod;

--6)Staff details
SELECT * FROM STAFF
NATURAL JOIN  StaffPosition;


SHOW TABLES;

DROP DATABASE systems;