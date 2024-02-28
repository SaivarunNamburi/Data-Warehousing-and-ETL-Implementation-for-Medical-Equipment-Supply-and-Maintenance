-- Hospital Table
CREATE TABLE medicalod.Hospital (
    HospitalID SERIAL PRIMARY KEY,
    HospitalName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
   	State VARCHAR(255),
   	Zipcode VARCHAR(255),
    PhoneNo VARCHAR(255),
    Revenue float,
    EquipmentID INT REFERENCES medicalod.MedicalEquipment(EquipmentID),
    DepartmentID INT REFERENCES medicalod.Department(DepartmentID)
);


-- Supplier Table
CREATE TABLE medicalod.Supplier (
    SupplierID SERIAL PRIMARY KEY,
    SupplierLastName VARCHAR(255),
    SupplierFirstName VARCHAR(255),
    SupplierDesignation VARCHAR(255),
    SupplierGender VARCHAR(255),
    SupplierEntity VARCHAR(255),
    SupplierAddress VARCHAR(255),
    SupplierCity VARCHAR(255),
    SupplierState VARCHAR(255),
    SupplierZipcode VARCHAR(255),
    SupplierSpeciality VARCHAR(255),
    TotalAmount float,
    AmountPaid float,
    AmountOwed float
);

-- Maintenance Technician
CREATE TABLE medicalod.MaintenanceTechnician (
    TechnicianID SERIAL PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
   	ManagerID INT REFERENCES medicalod.Supplier(SupplierID)
);


-- Department/Location Table
CREATE TABLE medicalod.Department (
    DepartmentID SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(255),
    Description TEXT
);

-- Regulations Table
CREATE TABLE medicalod.Regulations (
    RegulationID VARCHAR(10) PRIMARY KEY,
    RegulationName VARCHAR(255),
    Description text,
    Category VARCHAR(255),
    EffectiveDate DATE,
    ExpirationDate DATE
);

-- Equipment Table
CREATE TABLE medicalod.MedicalEquipment (
    EquipmentID SERIAL PRIMARY KEY,
    EquipmentName VARCHAR(255),
    EquipmentCode VARCHAR(255),
    RegulationID VARCHAR(10) REFERENCES medicalod.Regulations(RegulationID),
    DepartmentID INT REFERENCES medicalod.Department(DepartmentID),
    UserID INT
);

-- Decomissiong Table
CREATE TABLE medicalod.Decommissioning (
    DecommissiongID VARCHAR(10) PRIMARY KEY,
    EquipmentID INT REFERENCES medicalod.MedicalEquipment(EquipmentID),
    DecommissiongDate timestamp,
    Reason TEXT
);

-- Allocation Table
CREATE TABLE medicalod.Allocation (
    AllocationID VARCHAR(10) PRIMARY KEY,
    AllocationDate Date,
    DepartmentID INT REFERENCES medicalod.Department(DepartmentID),
    ReturnDate Date,
    EquipmentID INT REFERENCES medicalod.MedicalEquipment(EquipmentID)
);



-- MaintenanceType Table
CREATE TABLE medicalod.MaintenanceType (
    MaintenanceTypeID SERIAL PRIMARY KEY,
    MaintenanceTypeName VARCHAR(255),
    Description TEXT,
    MaintenanceCost INT
);

-- Sample data for MaintenanceType table
INSERT INTO medicalod.MaintenanceType (MaintenanceTypeName, Description) VALUES
    ('Preventive Maintenance', 'Routine maintenance to prevent issues proactively.'),
    ('Corrective Maintenance', 'Repair or fix equipment when it malfunctions.'),
    ('Scheduled Maintenance', 'Planned maintenance based on a fixed schedule.'),
    ('Emergency Maintenance', 'Immediate maintenance for critical issues.'),
    ('Calibration', 'Adjusting and calibrating equipment for accuracy.'),
    ('Software Update', 'Updating equipment software for performance and security.'),
    ('Cleaning and Sanitization', 'Cleaning and sanitizing equipment regularly.'),
    ('Hardware Replacement', 'Replacing hardware components as needed.'),
    ('Inspection', 'Regular inspections to identify potential issues.'),
    ('Upgrades', 'Upgrading equipment for improved functionality.');

   
-- MaintenanceLog Table
CREATE TABLE medicalod.MaintenanceLog (
    LogID SERIAL PRIMARY KEY,
    EquipmentID INT REFERENCES medicalod.MedicalEquipment(EquipmentID),
    TechnicianID INT REFERENCES medicalod.MaintenanceTechnician(TechnicianID),
    MaintenanceDate DATE,
    MaintenanceTypeID INT REFERENCES medicalod.MaintenanceType(MaintenanceTypeID),
    Description TEXT
);

-- Patients Table
CREATE TABLE medicalod.Patients (
    PatientID SERIAL PRIMARY KEY,
    Gender VARCHAR(10),
    AgeCategory VARCHAR(255),
    Description TEXT,
    PaymentAmount INT,
    procedure INT,
    EquipmentID INT REFERENCES medicalod.MedicalEquipment(EquipmentID)
    
);
  
-- EquipmentSupplier Table
CREATE TABLE medicalod.EquipmentSupplier (
    EquipmentID INT REFERENCES medicalod.MedicalEquipment(EquipmentID),
    SupplierID INT REFERENCES medicalod.Supplier(SupplierID)
);


-- Inventory Table
CREATE TABLE medicalod.SpareInventory (
    ItemCode VARCHAR(50),
    ItemDescription	VARCHAR(255),
    PartDescription	VARCHAR(255),
    IsExpiryDateRequired VARCHAR(255),
    MinPrice INT,
    MaxPrice INT,	
    Brand VARCHAR(255),
    Status VARCHAR(255),	
    ExpiryAgeMonths	INT,
    CurrentStock INT,
	SupplierID INT REFERENCES medicalod.Supplier(SupplierID),
	CONSTRAINT pk_spare_inventory PRIMARY KEY (ItemCode, ItemDescription, PartDescription,SupplierID)
);

-- UserAccess Table
CREATE TABLE medicalod.UserAccess (
    UserID SERIAL PRIMARY KEY,
    UserFirstName VARCHAR(255),
    UserLastName VARCHAR(255),
    Role VARCHAR(255),
    PhoneNo VARCHAR(255)
);

-- SupplierManager Table
CREATE TABLE medicalod.SupplierManager (
    UserID INT REFERENCES medicalod.UserAccess(UserID),
    DepartmentID INT REFERENCES medicalod.Department(DepartmentID)
);

-- Order Details Table
CREATE TABLE medicalod.Orderdetails (
    OrderID SERIAL PRIMARY KEY,
    OrderName VARCHAR(255),
    Description VARCHAR(255),
    ItemCode VARCHAR(255),
    ItemDescription VARCHAR(255),
    PartDescription VARCHAR(255),	
    SupplierID	INT ,
    EquipmentID INT	REFERENCES medicalod.MedicalEquipment(EquipmentID),
    TotalCost FLOAT,
    Quantity INT

);


-- PaymentDetails Table
CREATE TABLE medicalod.PaymentDetails (
    PaymentID SERIAL PRIMARY KEY,
    SupplierID INT REFERENCES medicalod.Supplier(SupplierID),
	EquipmentID INT	REFERENCES medicalod.MedicalEquipment(EquipmentID),
	Amount FLOAT,
	PurchaseDate Date,
	InvoiceNo VARCHAR(255),
	LogID INT REFERENCES medicalod.MaintenanceLog(LogID)
);


-- Usertechnician Table
CREATE TABLE medicalod.UserTechnician (
    UserID INT REFERENCES medicalod.UserAccess(UserID),
    TechnicianID INT REFERENCES medicalod.MaintenanceTechnician(TechnicianID)
);


-- SCD
CREATE TABLE medicalod.Supplierlog (
	supplierlogid serial primary key,
    SupplierID INT,
    SupplierLastName VARCHAR(255),
    SupplierFirstName VARCHAR(255),
    SupplierDesignation VARCHAR(255),
    SupplierGender VARCHAR(255),
    SupplierEntity VARCHAR(255),
    SupplierAddress VARCHAR(255),
    SupplierCity VARCHAR(255),
    SupplierState VARCHAR(255),
    SupplierZipcode VARCHAR(255),
    SupplierSpeciality VARCHAR(255),
    TotalAmount float,
    AmountPaid float,
    AmountOwed float,
    Task varchar(255),
    StartDate Timestamp,
    EndDate Timestamp,
    IsCurrent varchar(255)
);




