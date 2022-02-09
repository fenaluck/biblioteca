-- creando la base de datos biblioteca
create database Biblioteca;
--creando tablas
create table comunas(
id serial not null,
nombre varchar (255) not null,
primary key (id));
create table direcciones(
id serial,
calle varchar (255) not null,
numero varchar (255) not null,
comuna_id int not null,
primary key (id));


create table socios(
rut varchar (255) not null,
nombre varchar (255) not null,
apellido varchar (255) not null,
telefono varchar (255) not null,
direccion_id integer not null,
primary key (rut),
foreign key (direccion_id) REFERENCES direcciones(id));

create table libros(
isbn varchar (255) not null,
titulo varchar (255) not null,
num_pagina int not null,
dias_prestamos int not null,
primary key (isbn));

create table autores(
codigo int not null,
nombre varchar (25) not null,
apellido varchar (25) not null,
nacimiento int not null,
fallecimiento int,
primary key (codigo));

create table libros_autores(
tipo_autor varchar(25),
libro_isbn varchar (255) not null,
autor_codigo int not null,
primary key (libro_isbn, autor_codigo),
foreign key (libro_isbn) references libros(isbn),
foreign key (autor_codigo)references autores(codigo));

create table prestamos (
socios_rut varchar (255) not null,
libro_isbn varchar (255) not null,
fecha_prestamo date not null,
fecha_devolucion_esperada date not null,
fecha_real_devolucion date,
id serial not null,
primary key (id),
foreign key (socios_rut) references socios(rut),
foreign key (libro_isbn) references libros (isbn));
