Drop database Sistema_Cafeteria;
create database Sistema_Cafeteria;
use Sistema_Cafeteria;

create table Proveedores(
	ID_Proveedor varchar (10) primary key,
    Nombre_Proveedor varchar(35),
    Direccion_Proveedor varchar(50),
    Telefono_Proveedor int
)engine = InnoDB default charset=latin1;

create table Sucursal(
	ID_Sucursal varchar(10) primary key,
    Direccion_Sucursal varchar(80),
    Telefono_Sucursal int,
    Correo_Sucursal varchar(80)
)engine = InnoDB default charset=latin1;

create table Moneda(
	ID_Moneda varchar(10) primary key,
    Nombre_Moneda varchar(20) not null,
    Tipo_Cambio float,
    Estatus_Moneda char(1)
)engine = InnoDB default charset=latin1;

create table Movimiento_Moneda(
	ID_Moneda varchar(10), /*Foranea*/
    Fecha_Movimiento date,
    Movimiento_Cambio float,
    
    primary key(ID_Moneda, Fecha_Movimiento),
    foreign key (ID_Moneda) references Moneda(ID_Moneda)
    
)engine = InnoDB default charset=latin1;

create table Empresa(
	ID_Empresa varchar(10) primary key,
    Nombre_Empresa varchar(50) not null,
    Direccion_Empresa varchar(80),
    Telefono_Empresa int,
    Correo_Empresa varchar(50)
)engine = InnoDB default charset=latin1;

create table Serie(
	ID_Serie varchar(10) primary key,
    Nombre_Serie varchar(35) not null
)engine = InnoDB default charset=latin1;

create table Compra_Encabezado(
	ID_Compra_Enc varchar(10) primary key,
	ID_Serie varchar(10), /*Foranea*/
    ID_Sucursal varchar(10), /*Foranea*/
    ID_Empresa varchar(10), /*Foranea*/
    Fecha_Compra date,
    Total_Compra float,
    ID_Moneda varchar(10), /*Foranea*/
    ID_Proveedor varchar(10), /*Foranea*/
    CompraE_Estatus char(1),
    /*Foraneas*/
    foreign key (ID_Proveedor) references Proveedores(ID_Proveedor),
    foreign key (ID_Serie) references Serie(ID_Serie),
    foreign key (ID_Sucursal) references Sucursal(ID_Sucursal),
    foreign key (ID_Empresa) references Empresa(ID_Empresa),
    foreign key (ID_Moneda) references Moneda(ID_Moneda)
)engine = InnoDB default charset=latin1;

create table Marca_Producto(
	ID_Marca varchar(10) primary key,
    Nombre_Marca varchar(35),
    Estado_Marca char(1)
)engine = InnoDB default charset=latin1;

create table Linea_Producto(
	ID_Linea varchar(10) primary key,
    Nombre_Linea varchar(35),
    Estado_Linea char(1)
)engine = InnoDB default charset=latin1;

create table Productos(
	ID_Producto varchar(10) primary key,
    Nombre_Producto varchar(35),
    ID_Marca varchar(10), /*Foranea*/
    ID_Linea varchar(10), /*Foranea*/
    Precio_Producto float,
    Costo_Producto float,
    
    /*Llaves Foraneas*/
    foreign key (ID_Marca) references Marca_Producto(ID_Marca),
    foreign key (ID_Linea) references Linea_Producto(ID_Linea)
)engine = InnoDB default charset=latin1;

create table Bodega(
	ID_Bodega varchar(10) primary key,
    Nombre_Bodega varchar(35),
    Direccion_Bodega varchar(80),
    Telefono_Bodega int
)engine = InnoDB default charset=latin1;

create table Existencias (
	ID_Existencia varchar(10) primary key,
    ID_Producto varchar(10), /*Foranea*/
    Stock int,
    ID_Bodega varchar(10), /*Foranea*/
    
    /*Llave foranea*/
    foreign key (ID_Bodega) references Bodega (ID_Bodega),
    foreign key (ID_Producto) references Productos (ID_Producto)
)engine = InnoDB default charset=latin1;

create table Compra_Detalle(
	ID_Compra_Enc varchar (10), /*Foranea*/
    ID_Sucursal varchar(10), /*Foranea*/
    ID_Empresa varchar(10), /*Foranea*/
    ID_Producto varchar(10), /*Foranea*/
    Cantidad_compra int,
    
    /*Llaves foraneas*/
	foreign key (ID_Compra_Enc) references Compra_Encabezado (ID_Compra_Enc),
    foreign key (ID_Sucursal) references Sucursal (ID_Sucursal),
    foreign key (ID_Empresa) references Empresa (ID_Empresa),
    foreign key (ID_Producto) references Productos (ID_Producto)
)engine = InnoDB default charset=latin1;

create table Division(
	ID_Division varchar(10) primary key,
    Nombre_Division varchar(35),
    Estado_Division char(1)
)engine = InnoDB default charset=latin1;

create table Clientes(
	NIT_Cliente varchar(10) primary key, 
    Nombre_Cliente varchar (35),
    Apellido_Cliente varchar(35),
    Telefono_Cliente int,
    Direccion_Cliente varchar(80)
)engine = InnoDB default charset=latin1;

create table Puesto_Vendedor(
	ID_Puesto varchar(10) primary key,
    Nombre_Puesto varchar(35)
)engine = InnoDB default charset=latin1;

create table Vendedores( /*Empleado*/
	ID_Vendedor varchar(10) primary key,
    Nombre_Vendedor varchar(35),
    Apellido_Vendedor varchar(35),
    Direccion_Vendedor varchar(80),
    Fecha_Nacimiento date,
    ID_Puesto varchar (10), /*Foranea*/
    
    /*Foranea*/
    foreign key (ID_Puesto) references Puesto_Vendedor(ID_Puesto)
)engine = InnoDB default charset=latin1;

create table Cartera_Clientes(
	/*Llaves Foraneas*/
	NIT_Cliente varchar(10),
    ID_Vendedor varchar(10),
    ID_Division varchar(10), 
    
    primary key (NIT_Cliente, ID_Vendedor, ID_Division),/*Llaves compuestas*/
    foreign key (NIT_Cliente) references Clientes(NIT_Cliente),
    foreign key (ID_Vendedor) references Vendedores(ID_Vendedor),
    foreign key (ID_Division) references Division(ID_Division)
)engine = InnoDB default charset=latin1;

create table Venta_Encabezado(
	ID_VentaEnc varchar(10), /*primaria*/
    ID_Empresa varchar(10), /*Foranea*/
    ID_Sucursal varchar(10), /*Foranea*/
    ID_Serie varchar(10), /*Foranea*/
    NIT_Cliente varchar(10), /*Foranea*/
    ID_Moneda varchar(10), /*Foranea*/
    Total_Venta float,
    Fecha_Venta date,
    
    /*Primarias*/
    primary key (ID_VentaEnc, ID_Empresa, ID_Sucursal, ID_Serie),
    
    /*Llave Foranea*/
    foreign key (ID_Serie) references Serie(ID_Serie),
    foreign key (NIT_Cliente) references Clientes(NIT_Cliente),
    foreign key (ID_Sucursal) references Sucursal(ID_Sucursal),
    foreign key (ID_Empresa) references Empresa(ID_Empresa),
    foreign key (ID_Moneda) references Moneda(ID_Moneda)
)engine = InnoDB default charset=latin1;

create table Venta_Detalle (
	ID_VentaEnc varchar(10), /*Foranea*/
    ID_Empresa varchar(10), /*Foranea*/
    ID_Sucursal varchar(10), /*Foranea*/
    ID_Producto varchar(10), /*Foranea*/
    Fecha_Venta date,
    Cantidad_Venta int,
	Costo_Venta float,
    Precio_Venta float,
    Orden_Venta varchar(10) primary key,
    
    /*Llaves foraneas*/
    foreign key (ID_VentaEnc) references Venta_Encabezado (ID_VentaEnc),
    foreign key (ID_Producto) references Productos (ID_Producto),
    foreign key (ID_Sucursal) references Sucursal (ID_Sucursal),
    foreign key (ID_Empresa) references Empresa (ID_Empresa)
)engine = InnoDB default charset=latin1;

/*Tablas de la tarea*/
create table grupo(
	ID_Grupo varchar(10) primary key,
    Nombre_Grupo varchar(50),
    ID_Empresa varchar(10), /*Foranea*/
    
    foreign key (ID_Empresa) references Empresa(ID_Empresa)
)engine = InnoDB default charset=latin1;

create table Usuario( -- login de usuario
	ID_Usuario varchar(10) primary key,
    Password_Usuario varchar(35) not null,
    ID_Empresa varchar(10), /*Foranea*/
    Sesiones varchar(60),
    IP varchar(15),
    /*Para saber a que empresa va a entrar el administrador*/
    foreign key (ID_Empresa) references Empresa(ID_Empresa)
)engine = InnoDB default charset=latin1;

create table Personal( /*Multiempresa con diferente ID_Personal y diferente contraseña en el registro*/
	ID_Personal varchar(10) primary key,
	ID_Vendedor varchar(10),
    ID_Empresa varchar(10),
    ID_Sucursal varchar(10),
    Horario datetime,
    
    foreign key (ID_Vendedor) references Vendedores(ID_Vendedor),
    foreign key (ID_Empresa) references Empresa(ID_Empresa),
    foreign key (ID_Sucursal) references Sucursal(ID_Sucursal)
)engine = InnoDB default charset=latin1;

create table Registro( -- registro de un usuario (para el gerente)
	ID_Personal varchar(10), /*Foranea*/
    Password_Personal varchar(35),
    
    /*Foranea*/
    foreign key (ID_Personal) references Personal(ID_Personal) 
)engine = InnoDB default charset=latin1;