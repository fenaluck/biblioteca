--creando comunas para las direcciones
INSERT INTO comunas (nombre) 
VALUES 
    ('Temuco'),
    ('Santiago'),
    ('Panguipulli');
INSERT INTO direcciones (comuna_id, calle, numero)
VALUES
    (2, 'AVENIDA', 1),
    (2, 'PASAJE', 2),
    (2, 'AVENIDA', 2),
    (2, 'AVENIDA', 3),
    (2, 'PASAJE', 3);

INSERT INTO socios (rut, nombre, apellido, telefono, direccion_id)
VALUES
    ('1111111-1', 'JUAN', 'SOTO', '911111111',1),
    ('2222222-2', 'ANA', 'PEREZ', '922222222',2),
    ('3333333-3', 'SANDRA', 'AGUILAR', '933333333',3),
    ('4444444-4', 'ESTEBAN', 'JEREZ', '944444444',4),
    ('5555555-5', 'SILVANA', 'MUÑOZ', '955555555',5);

INSERT INTO libros (isbn, titulo, num_pagina, dias_prestamos)
VALUES
    ('111-1111111-111', 'CUENTOS DE TERROR', 344, 7),
    ('222-2222222-222', 'POESIAS CONTEMPORANEAS', 167, 7),
    ('333-3333333-333', 'HISTORIA DE ASIA', 511, 14),
    ('444-4444444-444', 'MANUAL DE MECANICA', 298, 14);

INSERT INTO autores (codigo, nombre, apellido, nacimiento, fallecimiento)
VALUES
    (3, 'JOSE', 'SALGADO', 1968, 2020),
    (4, 'ANA', 'SALGADO', 1972, null),
    (1, 'ANDRES', 'ULLOA', 1982, null),
    (2, 'SERGIO', 'MARDONES', 1950, 2012),
    (5, 'MARTIN', 'PORTA', 1976, null);

INSERT INTO libros_autores (tipo_autor,libro_isbn, autor_codigo)
VALUES
    ('PRINCIPAL','111-1111111-111', 3),
    ('COAUTOR','111-1111111-111', 4),
    ('PRINCIPAL','222-2222222-222', 1),
    ('PRINCIPAL','333-3333333-333', 2),
    ('PRINCIPAL','444-4444444-444', 5);

INSERT INTO prestamos (socios_rut, libro_isbn, fecha_prestamo, fecha_devolucion_esperada)
VALUES
    ('1111111-1','111-1111111-111','2020-01-20','2020-01-27'),
    ('5555555-5','222-2222222-222','2020-01-20','2020-01-30'),
    ('3333333-3','333-3333333-333','2020-01-22','2020-01-30'),
    ('4444444-4','444-4444444-444','2020-01-23','2020-01-30'),
    ('2222222-2','111-1111111-111','2020-01-27','2020-02-04'),
    ('1111111-1','444-4444444-444','2020-01-31','2020-02-12'),
    ('3333333-3','222-2222222-222','2020-01-31','2020-02-12');


--Mostrar todos los libros que posean menos de 300 páginas

SELECT titulo FROM libros WHERE num_pagina < 300;

--Mostrar todos los autores que hayan nacido después del 01-01-1970

SELECT nombre, apellido, nacimiento FROM autores WHERE nacimiento > 1970;

--Cual es el libro más solicitado

SELECT libros.titulo, COUNT(libros.titulo) AS veces_prestadas
FROM libros
JOIN prestamos ON libros.isbn = prestamos.libro_isbn
GROUP BY libros.titulo
ORDER BY veces_prestadas
DESC LIMIT 1;

--consulta costo de cada usuario con mas de 7 dias 
select socios.nombre, libros.titulo, (((fecha_devolucion_esperada - fecha_prestamo)-7)*100) as multa 
from socios join prestamos on socios.rut = prestamos.socios_rut join libros on prestamos.libro_isbn = libros.isbn 
where (fecha_devolucion_esperada - fecha_prestamo)>7 and libros.dias_prestamos =7
UNION 
select socios.nombre, libros.titulo, (((fecha_devolucion_esperada - fecha_prestamo)-14)*100) as multa 
from socios join prestamos on socios.rut = prestamos.socios_rut join libros on prestamos.libro_isbn = libros.isbn 
where (fecha_devolucion_esperada - fecha_prestamo)>14 and libros.dias_prestamos = 14;