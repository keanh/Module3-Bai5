create database demo;
use demo;
create table Products(
id int not null primary key,
productCode varchar(15) not null,
productName varchar(50) not null,
productPrice double not null,
productAmount int not null,
productDescription text not null,
productStatus text not null
);

insert into Products values(1,'SP1','Giay',1500000,15,'dep','dang con');
insert into Products values(2,'SP2','Dep',350000,20,'dep','dang con');
insert into Products values(3,'SP3','Quan',4800000,1,'dep','dang con');
insert into Products values(4,'SP4','Ao',900000,142,'dep','dang con');

alter table Products add index productCode_index(productCode);
alter table Products add index productNameAndPrice_index(productName,productPrice);
explain select * from Products where productPrice = 350000 and productName = 'Dep';
explain select * from Products where productCode = 'SP3';

create view productView as select productCode, productName, productPrice, productStatus from Products;
create or replace view productView as select productCode, productName, productAmount, productPrice, productStatus from Products;
drop view productView;

call demo.showAllProducts();
call demo.deleteProduct(4,'SP4');
call demo.updateProduct(2,'SP2','Nuoc',10000,1);

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProduct`(ID int,
productCode1 varchar(15),
productName1 varchar(50),
productPrice1 double,
productAmount1 int
)
BEGIN
update Products
set productName = productName1,
productPrice =  productPrice1,
productAmount = productAmount1
where id = ID and productCode = productCode1;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteProduct`(ID int,Ma_SP varchar(15))
BEGIN
delete from Products where id = ID and productCode = Ma_SP;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllProducts`()
BEGIN
select * from Products;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `addProduct`(id int,
productCode varchar(15),
productName varchar(50),
productPrice double,
productAmount int,
productDescription text,
productStatus text)
BEGIN
	insert into Products values(id,productCode,productName,productPrice,productAmount,productDescription,productStatus);
END