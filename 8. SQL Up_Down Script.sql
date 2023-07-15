--DOWN 
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_User_User_ID')
        ALTER TABLE [User] DROP CONSTRAINT fk_User_User_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_Doctor_Organization_ID')
        ALTER TABLE Doctor DROP CONSTRAINT fk_Doctor_Organization_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_Patient_Doctor_ID')
        ALTER TABLE Patient DROP CONSTRAINT fk_Patient_Doctor_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_Donor_Organization_ID')
        ALTER TABLE Donor DROP CONSTRAINT fk_Donor_Organization_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_Donor_User_ID')
        ALTER TABLE Donor DROP CONSTRAINT fk_Donor_User_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_Organ_available_Donor_ID')
        ALTER TABLE Organ_available DROP CONSTRAINT fk_Organ_available_Donor_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_Transaction_Donor_ID')
        ALTER TABLE [Transaction] DROP CONSTRAINT fk_Transaction_Donor_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_Transaction_Patient_ID')
        ALTER TABLE [Transaction] DROP CONSTRAINT fk_Transaction_Patient_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_Organization_phone_no_Organization_ID')
        ALTER TABLE Organization_phone_no DROP CONSTRAINT fk_Organization_phone_no_Organization_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_Doctor_phone_no_Doctor_ID')
        ALTER TABLE Doctor_phone_no DROP CONSTRAINT fk_Doctor_phone_no_Doctor_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_Organization_head_Organization_ID')
        ALTER TABLE Organization_head DROP CONSTRAINT fk_Organization_head_Organization_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_emergency_contacts_Patient_ID')
        ALTER TABLE emergency_contacts DROP CONSTRAINT fk_emergency_contacts_Patient_ID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_Patient_Blood_Group_Patient_ID ')
        ALTER TABLE Patient_Blood_Group DROP CONSTRAINT fk_Patient_Blood_Group_Patient_ID 

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = ' fk_Donor_Blood_Group_Donor_ID ')
        ALTER TABLE Donor_Blood_Group DROP CONSTRAINT  fk_Donor_Blood_Group_Donor_ID
        
DROP TABLE IF EXISTS login
DROP TABLE IF EXISTS [user]
DROP TABLE IF EXISTS user_phone_no
DROP TABLE IF EXISTS organization
DROP TABLE IF EXISTS doctor
DROP TABLE IF EXISTS patient
DROP TABLE IF EXISTS donor
DROP TABLE IF EXISTS organ_available
DROP TABLE IF EXISTS [transaction]
DROP TABLE IF EXISTS organization_phone_no
DROP TABLE IF EXISTS doctor_phone_no
DROP TABLE IF EXISTS organization_head
DROP TABLE IF EXISTS emergency_contacts
DROP TABLE IF EXISTS medical_insurance
DROP TABLE IF EXISTS medical_insurance
DROP TABLE IF EXISTS Patient_Blood_Group
DROP TABLE IF EXISTS Donor_Blood_Group


-- UP METADATA

CREATE TABLE login
(
   username varchar(20) not null,
   password varchar(20) not null
)
--table #1
CREATE TABLE [User](
    User_ID int NOT NULL,
    Name varchar(20) NOT NULL,
    Date_of_Birth date NOT NULL,
    Medical_insurance int,
    Medical_history varchar(20),
    Street varchar(20),
    City varchar(20),
    State varchar(20),
    CONSTRAINT pk_User_User_ID primary key (User_ID),
)

--table #2
CREATE TABLE User_phone_no(
   User_ID int NOT NULL,
   phone_no varchar(15),
  
)
alter table [User]
   add CONSTRAINT fk_User_User_ID foreign key (User_ID)
   references [User](User_ID)

--table #3

CREATE TABLE organization (
    Organization_ID int NOT NULL,
    Organization_name varchar(20) NOT NULL,
    Location varchar(20),
    Government_approved int, --0 or 1
    Constraint pk_organization_Organization_ID primary key (Organization_ID),
)

--table #4

CREATE TABLE Doctor(
  Doctor_ID int NOT NULL,
  Doctor_Name varchar(20) NOT NULL,
  Department_Name varchar(20) NOT NULL,
  organization_ID int NOT NULL,

  Constraint pk_Doctor_Doctor_ID primary key (Doctor_ID)
)
 alter table  Doctor 
 add constraint  fk_Doctor_Organization_ID foreign key (Organization_ID)
 references organization(Organization_ID)

 --table #5

 create table Patient (
    Patient_ID int NOT NULL,
    Patient_name varchar(50),
    organ_req varchar(20) NOT NULL,
    reason_of_procurement varchar(20),
    Doctor_ID int NOT NULL,
    User_ID int NOT NULL,
    CONSTRAINT pk_Patient_Patient_ID primary key (Patient_ID),  
   )
ALTER TABLE Patient ADD CONSTRAINT fk_Patient_Doctor_ID foreign key (Doctor_ID)
REFERENCES Doctor(Doctor_ID)

 --table #6

 CREATE TABLE Donor(
    Donor_ID int NOT NULL,
    Donor_name varchar(20),
    organ_donated varchar(20) NOT NULL,
    reason_of_donation varchar(20),
    Organization_ID int NOT NULL,
    User_ID int NOT NULL,
    CONSTRAINT pk_Donor_Donor_ID primary key (Donor_ID)
)
 --1 fk
 alter table Donor add constraint fk_Donor_Organization_ID foreign key (Organization_ID)
 references organization(Organization_ID)
 --2 fk
alter table Donor add constraint fk_Donor_User_ID foreign key (User_ID)
 references [User](User_ID)

--table #7
CREATE TABLE Organ_available(
  Organ_ID int  NOT NULL,
  Organ_name varchar(20) NOT NULL,
  Donor_ID int NOT NULL,
  CONSTRAINT pk_Organ_available_Organ_ID PRIMARY KEY (Organ_ID),
)
ALTER TABLE Organ_available ADD CONSTRAINT fk_Organ_available_Donor_ID foreign key (Donor_ID)
REFERENCES Donor(Donor_ID)
   
 --table #8
CREATE TABLE [Transaction](
  Patient_ID int NOT NULL,
  Organ_ID int NOT NULL,
  Donor_ID int NOT NULL,
  Date_of_transaction date NOT NULL,
  Status int NOT NULL, --#0 or 1
  CONSTRAINT pk_Transaction primary key (Patient_ID, Organ_ID),
);
   
 Alter Table [Transaction] ADD CONSTRAINT fk_Transaction_Patient_ID FOREIGN KEY(Patient_ID) 
 REFERENCES Patient(Patient_ID)
  
 Alter Table [Transaction] ADD CONSTRAINT fk_Transaction_Donor_ID FOREIGN KEY(Donor_ID)
 REFERENCES Donor(Donor_ID)
   
   
 --table #9
CREATE TABLE Organization_phone_no(
  Organization_ID int NOT NULL,
  Phone_no varchar(15),  
);

Alter Table Organization_phone_no ADD Constraint fk_Organization_phone_no_Organization_ID FOREIGN KEY(Organization_ID)
REFERENCES Organization(Organization_ID)
   
   
--table #10
CREATE TABLE Doctor_phone_no(
  Doctor_ID int NOT NULL,
  Phone_no varchar(15),
  
);

Alter Table Doctor_phone_no ADD Constraint fk_Doctor_phone_no_Doctor_ID FOREIGN KEY (Doctor_ID)
REFERENCES Doctor(Doctor_ID)
  
--table #11
CREATE TABLE Organization_head(
  Organization_ID int NOT NULL,
  Employee_ID int NOT NULL,
  Name varchar(20) NOT NULL,
  Date_of_joining date NOT NULL,
  Term_length int NOT NULL,
  CONSTRAINT pk_Organization_head primary key (Organization_ID, Employee_ID),
 );
 Alter Table Organization_head ADD Constraint fk_Organization_head_Organization_ID foreign key (Organization_ID) 
 References Organization(Organization_ID) 

 --table #12
 CREATE TABLE emergency_contacts(
    Patient_id INT  NOT NULL,
    emergency_contact_firstname VARCHAR(255) NOT NULL,
    emergency_contact_lastname VARCHAR(255) NOT NULL,
    emergency_contact_address VARCHAR(255) NOT NULL,
    emergency_contact_email VARCHAR(255) NOT NULL,
    CONSTRAINT pk_emergency_contacts_Patient_id PRIMARY KEY (Patient_id)
)
ALTER TABLE emergency_contacts
    ADD CONSTRAINT fk_emergency_contacts_Patient_ID FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)

--table #13
CREATE TABLE Medical_insurance(
    insurance_company VARCHAR(100) NOT NULL,
    Transplantation_coverage VARCHAR(50) NOT NULL,
)
--table #14
CREATE TABLE Patient_Blood_Group(
    Patient_id INT  NOT NULL,
    Blood_Group VARCHAR(100),
    CONSTRAINT pk_Patient_Blood_Group_Patient_id PRIMARY KEY (Patient_id),
)
ALTER TABLE Patient_Blood_Group ADD CONSTRAINT fk_Patient_Blood_Group_Patient_ID FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)

--table #15
CREATE TABLE Donor_Blood_Group(
    Donor_id INT NOT NULL,
    Blood_Group VARCHAR(3),
    CONSTRAINT pk_Donor_Blood_Group_Donor_id PRIMARY KEY (Donor_id),
)
ALTER TABLE Donor_Blood_Group ADD CONSTRAINT fk_Donor_Blood_Group_Donor_ID FOREIGN KEY (Donor_ID)
        REFERENCES Donor(Donor_ID)

-- Show Table
SELECT * FROM [USER];
SELECT * FROM User_phone_no;
SELECT * FROM organization;
SELECT * FROM doctor;
SELECT * FROM patient;
SELECT * FROM donor;
SELECT * FROM organ_available;
SELECT * FROM [transaction];
SELECT * FROM organization_phone_no;
SELECT * FROM doctor_phone_no;
SELECT * FROM organization_head;
SELECT * from emergency_contacts;
SELECT * FROM medical_insurance;
SELECT * FROM Patient_Blood_Group;
SELECT * FROM Donor_Blood_Group;
