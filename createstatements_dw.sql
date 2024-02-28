--1. MaintenanceDate -- Done verified
 CREATE TABLE medicaldw.MaintenanceDate (
    DateKey Serial not null,
    DayDate Date,
    MonthKey INT
   );
  
--2. MaintenanceMonth --- Done verified
  CREATE TABLE medicaldw.MaintenanceMonth (
    MonthKey Serial not null,
    MaintenanceMonth INT,
    Year INT
   );
  
--3. MaintenanceYear --- Done verified
    CREATE TABLE medicaldw.MaintenanceYear (
    Year INT
   );
  
--4. City --- Done verified
  CREATE TABLE medicaldw.City (
    CityKey SERIAL not null,
    CityName VARCHAR(255),
    StateKey INT
	);

--5. State --- Done verified
CREATE TABLE medicaldw.State (
    StateKey SERIAL not null,
    StateName VARCHAR(255)
);


--6. SupplierDim ---- Done verified
CREATE TABLE medicaldw.SupplierDim (
    SupplierKey Serial not null,
    SupplierID INT,
    SupplierName VARCHAR(255),
    SupplierGender VARCHAR(255),
    SupplierSpeciality VARCHAR(255),
    SupplierDesignation VARCHAR(255),
    SupplierAddress VARCHAR(255),
    SupplierZipCode VARCHAR(255),
    SupplierState VARCHAR(255),
    SupplierCity VARCHAR(255),
    SupplierEntity VARCHAR(255),
    TotalAmount FLOAT,
    AmountPaid FLOAT,
    AmountOwed FLOAT,
    ValidFrom DATE,
    ValidTo DATE,
    IsCurrent BOOLEAN
);

--7. Maintenance Tech Dim -- Done verified
CREATE TABLE medicaldw.MaintenanceTechDim (
    MaintenanceTechKey Serial not null,
    TechnicianID INT,
    FullName VARCHAR(255),
    SupplierID INT,
    HistoricalSupplierID INT
);


--8. Department Dim ----- Done verified
CREATE TABLE medicaldw.DepartmentDim (
    DepartmentKey Serial not null,
    DepartmentID INT,
    DepartmentName VARCHAR(255)
);
   
--9. Equipment Dim ---- Done verified
CREATE TABLE medicaldw.EquipmentDim (
    EquipmentKey SERIAL not null,
    EquipmentID INT,
    EquipmentName VARCHAR(255),
    EquipmentCode VARCHAR(255),
    RegulationKey INT,
    DepartmentKey INT
);

--10. Regulation Dim --- Done verified
CREATE TABLE medicaldw.RegulationDim (
    RegulationKey SERIAL not null,
    RegulationID INT,
    RgualtionCode VARCHAR(255),
    Description VARCHAR(255),
    EffectiveDate Date,
    ExpiryDate Date
);

--11. DecommissiongDim --- Done verified
CREATE TABLE medicaldw.DecommissioningDim (
    DecommissionKey SERIAL not null,
    DecommissioningID Varchar(255),
    EquipKey INT,
    DecommissioningDate DATE,
    Reason TEXT
);


--12. PatientDim --- Done verified
CREATE TABLE medicaldw.PatientsDim (
    PatientKey SERIAL not null,
    PatientID INT,
    Gender VARCHAR(10),
    AgeCategory VARCHAR(255),
    Description TEXT,
    PaymentAmount INT,
    Procedure INT,
    EuipKey INT
);

--13. MaintenanceTypeDim --- Done verified
CREATE TABLE medicaldw.MaintenanceTypeDim (
    MaintenanceTypeKey SERIAL not null,
    MaintenanceTypeID INT,
    MaintenanceTypeName VARCHAR(255),
    Description TEXT,
    MaintenanceCost INT,
    ValidFrom DATE,
    ValidTo DATE,
    IsCurrent BOOLEAN
);

--14. HospitalDim --- Done Verified
CREATE TABLE medicaldw.HospitalDim (
    HospitalKey Serial not null,
    HospitalID INT,
    HospitalName VARCHAR(255),
    Address VARCHAR(255),
    Zipcode VARCHAR(255),
    CityKey INT,
    EquipKey INT,
    DepartmentKey INT,
    PhoneNo VARCHAR(255),
    Revenue FLOAT
);


--15. AllocationDim -- Done Verified
CREATE TABLE medicaldw.AllocationDim (
    AllocationKey SERIAL not null,
    AllocationID Varchar(255),
    AllocationDate Date,
    ReturnDate Date,
    EquipmentKey INT
);


--16. MaintenanceLogDim -- Done Verified
CREATE TABLE medicaldw.MaintenanceLogDim (
    LogKey SERIAL not null,
    LogID Int,
    EquipKey INT,
    MaintenanceTechID INT,
    MaintenanceDate DATE,
    MaintenanceTypeID INT,
    Description TEXT,
    HistoricalMaintenanceTypeID INT
);

--17. UseraccessDim --- Done Verified
CREATE TABLE medicaldw.UserAccessDim (
    UserAccessKey SERIAL not null,
    UserID INT,
    UserName VARCHAR(255),
    Role VARCHAR(255),
    PhoneNo VARCHAR(255),
    SupplierID INT
);

--18. ItemdescDim -- Done Verified
CREATE TABLE medicaldw.ItemdescDim (
    ItemKey SERIAL not null,
    ItemDescription VARCHAR(255),
    PartDescription VARCHAR(255)
);

--19. OrderDetailsDim -- Done Verified
CREATE TABLE medicaldw.OrderDetailsDim (
    OrderDetailsKey SERIAL not null,
    OrderID INT,
    OrderName VARCHAR(255),
    Description VARCHAR(255),
    ItemCode VARCHAR(255),
    ItemKey INT,
    SupplierID INT,
    EquipKey INT,
    TotalCost FLOAT,
    Quantity INT
);

--20. PaymentDetailsDim
CREATE TABLE medicaldw.PaymentDetailsDim (
    PaymentKey SERIAL not null,
    PaymentID INT,
    SupplierID INT,
    EquipKey INT,
    LogID INT,
    Amount FLOAT,
    Discount INT,
    UpdatedAmount INT,
    PurchaseDate Date,
    PaymentDescription VARCHAR(255),
    InvoiceNo VARCHAR(255)
);


--21. SpareInventoryDim
CREATE TABLE medicaldw.SpareInventoryDim (
	InventoryKey Serial not null,
    UniqueValue Varchar(255),
    MinPrice INT,
    MaxPrice INT,
    Brand VARCHAR(255),
    ExpiryAgeMonths INT,
    CurrentStock INT   
);

--22. MaintenanceFact
CREATE TABLE medicaldw.MaintenanceFact (
    MaintenanceFactKey SERIAL not null,
    MaintenanaceTechKey INT,
    MaintenanceLogKey INT,
    OrderDetailsKey INT,
    HospitalKey INT,
    PaymentKey INT,
    MaintenanceTypeKey INT,
    TotalMaintenanceAmount FLOAT,
    AmountPaidMaintenance FLOAT,
    MaintenancePercent FLOAT,
    HospitalRevenue FLOAT
);


--22. SupplierFact 
CREATE TABLE medicaldw.SupplierFact (
    SupplierFactKey SERIAL not null,
    EquipKey INT,
    SupplierKey INT,
    OrderDetailsKey INT,
    PaymentKey INT,
    TotalSupplyAmount FLOAT,
    TotalSupplyCost FLOAT,
    AmountPaid FLOAT,
    SupplierPercent FLOAT
);

"""

State -> City -> Year -> Month -> Date -> Department -> Supplier -> MaintenanceType -> MaintenanceTech -> Regulation -> 
Equipment -> Decommissioning -> Patients -> Allocation -> Hospital -> Useraccess -> MaintenanceLog -> Itemdesc -> 
Orderdetails -> Paymentdetails -> Spareinventory -> MaitenanceFact -> SupplierFact

"""




--- Truncate Statements
truncate table medicaldw.maintenancefact restart identity;
truncate table medicaldw.supplierfact restart identity;
truncate table medicaldw.state restart identity;
truncate table medicaldw.city restart identity;
truncate table medicaldw.maintenanceyear restart identity;
truncate table medicaldw.maintenancemonth restart identity;
truncate table medicaldw.maintenancedate restart identity;
truncate table medicaldw.maintenancetechdim restart identity;
truncate table medicaldw.maintenancetypedim restart identity;
truncate table medicaldw.allocationdim restart identity;
truncate table medicaldw.regulationdim restart identity;
truncate table medicaldw.decommissioningdim restart identity;
truncate table medicaldw.departmentdim restart identity;
truncate table medicaldw.equipmentdim restart identity;
truncate table medicaldw.hospitaldim restart identity;
truncate table medicaldw.itemdescdim restart identity;
truncate table medicaldw.maintenancelogdim restart identity;
truncate table medicaldw.orderdetailsdim restart identity;
truncate table medicaldw.patientsdim restart identity;
truncate table medicaldw.paymentdetailsdim restart identity;
truncate table medicaldw.spareinventorydim restart identity;
truncate table medicaldw.supplierdim restart identity;







