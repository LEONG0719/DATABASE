-- Active: 1735461067548@@127.0.0.1@3306@systems@classicmodels

CREATE DATABASE IF NOT EXISTS systems;
USE systems;

--ENTITY 1
CREATE TABLE IF NOT EXISTS StaffPosition(

    Position VARCHAR(10) NOT NULL,
    Salary   DECIMAL(8,2) NOT NULL,

    CONSTRAINT Position_PK PRIMARY KEY (Position)
);
--ENTITY NEW

CREATE TABLE IF NOT EXISTS StaffPostcode(

    Postcode INT(5) NOT NULL,
    State    VARCHAR(10) NOT NULL,

    CONSTRAINT Postcode_PK PRIMARY KEY (Postcode)
);

--ENTITY 2

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
  
    CONSTRAINT Staff_ID_PK PRIMARY KEY (Staff_ID),
    CONSTRAINT Position_FK FOREIGN KEY (Position) REFERENCES StaffPosition (Position),
    CONSTRAINT Postcode_FK FOREIGN KEY (Postcode) REFERENCES StaffPostcode (Postcode)
);

--ENTITY 3(waiting verify)
CREATE TABLE IF NOT EXISTS Telephone(

    Staff_ID VARCHAR(5) NOT NULL,
    TelNo    VARCHAR(15)    NOT NULL,

    CONSTRAINT Staff_ID_TELNO_PK PRIMARY KEY (Staff_ID,TelNo),
    CONSTRAINT Staff_ID_FK       FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 4(waiting verify)

CREATE TABLE IF NOT EXISTS Supervision(

    Supervisor_ID VARCHAR(5) NOT NULL,
    Staff_ID      VARCHAR(5) NOT NULL,

    CONSTRAINT Supervisor_Staff_ID PRIMARY KEY (Supervisor_ID,Staff_ID),
    CONSTRAINT Staff_ID_FK1        FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID),
    CONSTRAINT Supervisor_ID       FOREIGN KEY (Supervisor_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 5

CREATE TABLE IF NOT EXISTS Stock(

    StockCheckDate  DATE NOT NULL,
    StockValuesIn   DECIMAL(8,2) NOT NULL,
    StockValuesLeft DECIMAL(8,2) NOT NULL,
    Staff_ID        VARCHAR(5)  NOT NULL,

    CONSTRAINT Checkdate    PRIMARY KEY (StockCheckDate),
    CONSTRAINT Staff_ID_FK2 FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 6

CREATE TABLE IF NOT EXISTS Report(

    ReportDate  DATE NOT NULL,
    TotalSales  DECIMAL(8,2) NOT NULL,
    TotalCost   DECIMAL(8,2) NOT NULL,
    TotalProfit DECIMAL(8,2) NOT NULL,
    Staff_ID    VARCHAR(5)  NOT NULL,

    CONSTRAINT ReportDATE_PK PRIMARY KEY (ReportDate),
    CONSTRAINT Staff_ID_FK3  FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID) 
);

--ENTITY 7

CREATE TABLE IF NOT EXISTS Menu(

    MenuID   VARCHAR(5)  NOT NULL,
    MenuName VARCHAR(30) NOT NULL UNIQUE, 
    Staff_ID VARCHAR(5)  NOT NULL,

    CONSTRAINT MenuID_PK    PRIMARY KEY (MenuID),
    CONSTRAINT Staff_ID_FK4 FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 8

CREATE TABLE IF NOT EXISTS InfoMenu(

    MenuName  VARCHAR(30) NOT NULL UNIQUE,
    MenuPrice DECIMAL(8,2)  NOT NULL,
    Category  VARCHAR(10) NOT NULL,

    CONSTRAINT MenuName_PK PRIMARY KEY (MenuName),
    CONSTRAINT MenuName_FK FOREIGN KEY (MenuName) REFERENCES Menu (MenuName)
);

--ENTITY 9
CREATE TABLE IF NOT EXISTS Cashier(

    Staff_ID VARCHAR(5)  NOT NULL,
    POS_LoginPin INT(6)  NOT NULL,

    CONSTRAINT Staff_ID_PK PRIMARY KEY (Staff_ID),
    CONSTRAINT Staff_ID_FK5 FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 10

CREATE TABLE IF NOT EXISTS Counters(

    CounterDate      DATE        NOT NULL,
    EnterCounterCash DECIMAL(8,2) NOT NULL,
    LeaveCounterCash DECIMAL(8,2) NOT NULL,
    Staff_ID         VARCHAR(5)  NOT NULL,

    CONSTRAINT CounterDate_PK PRIMARY KEY (CounterDate),
    CONSTRAINT Staff_ID_FK6    FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 11

CREATE TABLE IF NOT EXISTS Payment(

    PaymentNo     INT(10)     NOT NULL,
    PaymentMethod VARCHAR(15) NOT NULL,
    PaymentStatus VARCHAR(10) NOT NULL,
    ReportDate    DATE        NOT NULL,
    CounterDate   DATE        NOT NULL,

    CONSTRAINT PaymentNo_PK     PRIMARY KEY (PaymentNo),
    CONSTRAINT ReportDate_FK    FOREIGN KEY (ReportDate)  REFERENCES Report (ReportDate),
    CONSTRAINT CounterDate_FK   FOREIGN KEY (CounterDate) REFERENCES Counters (CounterDate)
);

--ENTITY 12

CREATE TABLE IF NOT EXISTS Chef(

    Staff_ID              VARCHAR(5) NOT NULL,
    Assigned_MenuCategory VARCHAR(10)   NOT NULL,

    CONSTRAINT Staff_ID_PK  PRIMARY KEY (Staff_ID),
    CONSTRAINT Staff_ID_FK7 FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

--ENTITY 13

CREATE TABLE IF NOT EXISTS Handling(

    KitchenOperationDate DATE NOT NULL,
    Timestart            TIME NOT NULL,
    TimeDone             TIME NOT NULL,

    CONSTRAINT Kitchen_PK PRIMARY KEY (KitchenOperationDate)
);

--ENTITY 14(order)

CREATE TABLE IF NOT EXISTS Orders(

    OrderNo     INT(10)    NOT NULL,
    Quantity    INT(2)     NOT NULL,
    OrderStatus VARCHAR(9) NOT NULL,
    Staff_ID    VARCHAR(5) NOT NULL,
    MenuID      VARCHAR(5) NOT NULL,

    CONSTRAINT OrderNo_PK   PRIMARY KEY (OrderNo),
    CONSTRAINT Staff_ID_FK8 FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID),
    CONSTRAINT MenuID_FK    FOREIGN KEY (MenuID)   REFERENCES Menu  (MenuID)
    
);

--ENTITY 15(CANNOT NULL IN ORDERDETAILS)

CREATE TABLE IF NOT EXISTS OrderDetails(

    OrderDetail VARCHAR(15) UNIQUE,
    OrderNo     INT(10) NOT NULL,

    CONSTRAINT Order_Detail_No PRIMARY KEY (OrderDetail, OrderNo),
    CONSTRAINT OrderNo_FK      FOREIGN KEY (OrderNo) REFERENCES Orders (OrderNo)
);

--ENTITY 16

CREATE TABLE IF NOT EXISTS CustomerName(

    PhoneNumber VARCHAR(12) NOT NULL,
    Name        VARCHAR(20) NOT NULL ,

    CONSTRAINT Phonenumber_PK PRIMARY KEY (PhoneNumber)
);

--ENTITY 17

CREATE TABLE IF NOT EXISTS Customer(

    CustomerNo INT(10) NOT NULL,
    PhoneNumber VARCHAR(12) NOT NULL,

    CONSTRAINT CustomerNo_PK PRIMARY KEY (CustomerNo),
    CONSTRAINT PhoneNumber_FK FOREIGN KEY (PhoneNumber) REFERENCES CustomerName (PhoneNumber)
);

--ENTITY 18(WAITING verify)

CREATE TABLE IF NOT EXISTS Making(

    CustomerNo INT(10) NOT NULL,
    PaymentNo  INT(10) NOT NULL,
    OrderNo    INT(10) NOT NULL,
    
    CONSTRAINT Making_PK    PRIMARY KEY (CustomerNo,PaymentNo,OrderNo),
    CONSTRAINT CustomerNo_FK FOREIGN KEY (CustomerNo) REFERENCES Customer (CustomerNo),
    CONSTRAINT PaymentNo_FK  FOREIGN KEY (PaymentNo)  REFERENCES Payment  (PaymentNo),
    CONSTRAINT OrderNo_FK1   FOREIGN KEY (OrderNo)    REFERENCES Orders   (OrderNo)
);

--ENTITY 19

CREATE TABLE IF NOT EXISTS CustPayment(

    PaymentNo   INT(10)      NOT NULL,
    DatePayment DATE         NOT NULL,
    TimePayment TIME         NOT NULL,
    PayPrice    DECIMAL(8,2) NOT NULL,

    CONSTRAINT PaymentNo_PK   PRIMARY KEY (PaymentNo),
    CONSTRAINT PaymentNo_FK1  FOREIGN KEY (PaymentNo)  REFERENCES Payment  (PaymentNo)
);


DROP DATABASE systems;





