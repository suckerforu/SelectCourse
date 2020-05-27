/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2020/5/17 09:17:36                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Major') and o.name = 'FK_MAJOR_REFERENCE_DEPARTME')
alter table Major
   drop constraint FK_MAJOR_REFERENCE_DEPARTME
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Student') and o.name = 'FK_STUDENT_REFERENCE_MAJOR')
alter table Student
   drop constraint FK_STUDENT_REFERENCE_MAJOR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Teacher') and o.name = 'FK_TEACHER_REFERENCE_DEPARTME')
alter table Teacher
   drop constraint FK_TEACHER_REFERENCE_DEPARTME
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('sc_info') and o.name = 'FK_SC_INFO_REFERENCE_STUDENT')
alter table sc_info
   drop constraint FK_SC_INFO_REFERENCE_STUDENT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('sc_info') and o.name = 'FK_SC_INFO_REFERENCE_COURSE')
alter table sc_info
   drop constraint FK_SC_INFO_REFERENCE_COURSE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('sc_info') and o.name = 'FK_SC_INFO_REFERENCE_TEACHER')
alter table sc_info
   drop constraint FK_SC_INFO_REFERENCE_TEACHER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Course')
            and   type = 'U')
   drop table Course
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Department')
            and   type = 'U')
   drop table Department
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Major')
            and   type = 'U')
   drop table Major
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Manager')
            and   type = 'U')
   drop table Manager
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Student')
            and   type = 'U')
   drop table Student
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Teacher')
            and   type = 'U')
   drop table Teacher
go

if exists (select 1
            from  sysobjects
           where  id = object_id('sc_info')
            and   type = 'U')
   drop table sc_info
go

/*==============================================================*/
/* Table: Course                                                */
/*==============================================================*/
create table Course (
   courseID             char(2)              not null,
   courseName           nvarchar(50)         null,
   courseCredit         decimal              null,
   courseClass          int                  null,
   courseDesc           nvarchar(500)        null,
   constraint PK_COURSE primary key (courseID)
)
go

/*==============================================================*/
/* Table: Department                                            */
/*==============================================================*/
create table Department (
   deptID               char(2)              not null,
   deptName             nvarchar(20)         not null,
   deptPhone            nvarchar(11)         not null,
   deptDesc             nvarchar(300)        not null,
   constraint PK_DEPARTMENT primary key (deptID)
)
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Department')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'deptID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Department', 'column', 'deptID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '院系ID',
   'user', @CurrentUser, 'table', 'Department', 'column', 'deptID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Department')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'deptName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Department', 'column', 'deptName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '院系名称',
   'user', @CurrentUser, 'table', 'Department', 'column', 'deptName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Department')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'deptPhone')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Department', 'column', 'deptPhone'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '院系电话',
   'user', @CurrentUser, 'table', 'Department', 'column', 'deptPhone'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Department')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'deptDesc')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Department', 'column', 'deptDesc'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '院系介绍',
   'user', @CurrentUser, 'table', 'Department', 'column', 'deptDesc'
go

/*==============================================================*/
/* Table: Major                                                 */
/*==============================================================*/
create table Major (
   majorID              char(2)              not null,
   deptID               char(2)              null,
   majorName            nvarchar(50)         null,
   constraint PK_MAJOR primary key (majorID)
)
go

/*==============================================================*/
/* Table: Manager                                               */
/*==============================================================*/
create table Manager (
   managerID            int                  identity(1,1),
   managerName          nvarchar(20)         null,
   manegerSex           char(2)              null,
   managerPwd           nvarchar(20)         null,
   managerPhone         nvarchar(11)         null,
   constraint PK_MANAGER primary key (managerID)
)
go

/*==============================================================*/
/* Table: Student                                               */
/*==============================================================*/
create table Student (
   stuID                char(10)             not null,
   majorID              char(2)              null,
   stuName              nvarchar(20)         null,
   stuSex               char(2)              null,
   stuLoginPwd          nvarchar(20)         null,
   stuGrade             nvarchar(20)         null,
   constraint PK_STUDENT primary key (stuID)
)
go

/*==============================================================*/
/* Table: Teacher                                               */
/*==============================================================*/
create table Teacher (
   teaID                char(10)             not null,
   deptID               char(2)              null,
   teaName              nvarchar(20)         null,
   teaSex               char(2)              null,
   teaPhone             nvarchar(11)         null,
   constraint PK_TEACHER primary key (teaID)
)
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Teacher')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'teaID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'teaID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '老师ID',
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'teaID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Teacher')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'deptID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'deptID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '院系ID',
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'deptID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Teacher')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'teaName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'teaName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '老师名字',
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'teaName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Teacher')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'teaSex')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'teaSex'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '老师性别',
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'teaSex'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Teacher')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'teaPhone')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'teaPhone'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '老师电话',
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'teaPhone'
go

/*==============================================================*/
/* Table: sc_info                                               */
/*==============================================================*/
create table sc_info (
   scID                 int                  identity,
   stuID                char(10)             null,
   courseID             char(2)              null,
   teaID                char(10)             null,
   constraint PK_SC_INFO primary key (scID)
)
go

alter table Major
   add constraint FK_MAJOR_REFERENCE_DEPARTME foreign key (deptID)
      references Department (deptID)
go

alter table Student
   add constraint FK_STUDENT_REFERENCE_MAJOR foreign key (majorID)
      references Major (majorID)
go

alter table Teacher
   add constraint FK_TEACHER_REFERENCE_DEPARTME foreign key (deptID)
      references Department (deptID)
go

alter table sc_info
   add constraint FK_SC_INFO_REFERENCE_STUDENT foreign key (stuID)
      references Student (stuID)
go

alter table sc_info
   add constraint FK_SC_INFO_REFERENCE_COURSE foreign key (courseID)
      references Course (courseID)
go

alter table sc_info
   add constraint FK_SC_INFO_REFERENCE_TEACHER foreign key (teaID)
      references Teacher (teaID)
go

