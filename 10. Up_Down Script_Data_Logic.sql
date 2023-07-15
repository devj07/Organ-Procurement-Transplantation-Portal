--TRIGGER
--table 16
create table log (
  querytime datetime,
  comment varchar(255)
);

--donor log

drop trigger ADD_DONOR_LOG;

create trigger ADD_DONOR_LOG
on Donor after insert 
as
begin
DECLARE @insertedId INT
SELECT @insertedId = Donor_ID from inserted
PRINT(@insertedId) 
insert into log values
(getdate(), concat('Inserted new Donor: ' , @insertedId));
end 

create trigger UPDATE_DONOR_LOG
on Donor after update 
as
begin
DECLARE @insertedId INT
SELECT @insertedId = Donor_ID from inserted
PRINT(@insertedId) 
insert into log values
(getdate(), concat('Updated Donor: ' , @insertedId));
end 

create trigger DELETE_DONOR_LOG
on Donor after delete 
as
begin
DECLARE @insertedId INT
SELECT @insertedId = Donor_ID from deleted
PRINT(@insertedId) 
insert into log values
(getdate(), concat('Deleted Donor: ' , @insertedId));
end 

--Patient log

create trigger ADD_PATIENT_LOG
on Patient after insert 
as
begin
DECLARE @insertedId INT
SELECT @insertedId = Patient_ID from inserted
PRINT(@insertedId) 
insert into log values
(getdate(), concat('Inserted new Patient: ' , @insertedId));
end 

drop trigger UPDATE_PATIENT_LOG;

create trigger UPDATE_PATIENT_LOG
on Patient after update 
as
begin
DECLARE @insertedId INT
SELECT @insertedId = Patient_ID from inserted
PRINT(@insertedId) 
insert into log values
(getdate(), concat('Updated Patient: ' , @insertedId));
end 

create trigger DELETE_PATIENT_LOG
on Patient after delete 
as
begin
DECLARE @insertedId INT
SELECT @insertedId = Patient_ID from deleted
PRINT(@insertedId) 
insert into log values
(getdate(), concat('Deleted Patient: ' , @insertedId));
end 


update Donor set reason_of_donation = 'change my mind' where Donor_ID = 3

delete from Donor where Donor_ID = 3

delete from Patient where Patient_ID = 3

update Patient set reason_of_procurement = 'need it PLEASE' where Patient_ID = 3

delete from Patient where Patient_ID = 3

insert into Patient values
(11111,'Heart','Reason-11111',63,48);
select * from [log]



--stored procedure
create PROCEDURE get_donor_from_user
as 
select * from Donor d INNER JOIN [User] u ON d.User_ID = u.User_Id
Go
--stored procedure
Exec get_donor_from_user

--JOIN
select Name,phone_no from [User] u INNER JOIN User_phone_no p on u.User_ID=p.User_Id