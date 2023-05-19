CREATE DATABASE Escuela_Idiomas;
USE Escuela_Idiomas;

CREATE TABLE Usuarios (
Usuario_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
Apellidos varchar (100) NOT NULL,
Nombre varchar (100) NOT NULL,
Mail varchar (150) NOT NULL,
Contraseña INT NOT NULL,
Tipo varchar (50) NOT NULL
);

CREATE TABLE Cursos (
Curso_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
Tipo varchar (100) NOT NULL,
Coste int NOT NULL,
Nivel varchar (100) NOT NULL,
Fecha_Inscripcion date NOT NULL,
Fecha_Finalizacion date NOT NULL,
Usuario_ID INT NOT NULL,
FOREIGN KEY (Usuario_ID) REFERENCES Usuarios (Usuario_ID)
);

CREATE TABLE Lecciones (
Leccion_ID INT NOT NULL PRIMARY KEY,
Nivel varchar (100) NOT NULL,
Etapa varchar (100) NOT NULL,
Curso_ID int not null,
foreign key (Curso_ID) REFERENCES Cursos (Curso_ID)
);

CREATE TABLE Pagos (
Pago_ID INT NOT NULL PRIMARY KEY,
Estado varchar (100) NOT NULL,
Vía_Pago varchar (100) NOT NULL,
Curso_ID int not null,
Usuario_ID int not null,
FOREIGN KEY (Curso_ID) REFERENCES Cursos (Curso_Id),
FOREIGN KEY (Usuario_ID) REFERENCES Usuarios (Usuario_ID)
);

CREATE TABLE Procesos (
Usuario_ID int not null PRIMARY KEY,
Curso_ID int not null,
Leccion_ID int not null,
Completado_ID varchar (100) not null,
FOREIGN KEY (Curso_ID) REFERENCES Cursos (Curso_ID),
FOREIGN KEY (Leccion_ID) REFERENCES Lecciones (Leccion_ID)
);


INSERT INTO Usuarios (Usuario_ID, Apellidos, Nombre, Mail, Contraseña, Tipo) VALUES
(1, 'Martin', 'Carlos', 'carlos@gmail.es', 1221, 'Estudiante'),
(2, 'Vega', 'Julián', 'julian@gmail.es', 4554, 'Estudiante'),
(3, 'Gómez', 'Elena', 'elena@gmail.es', 7887, 'Estudiante'),
(4, 'Martinez', 'Maria', 'maria@gmail.es', 9669, 'Estudiante'),
(5, 'Alvarez', 'Estebán', 'esteban@gmail.es', 1001, 'Estudiante'),
(6, 'Ramirez', 'Lucia', 'lucia@gmail.es', 1805, 'Docente'),
(7, 'Garcia', 'Alejandro', 'alejandro@gmail.es', 1945, 'Docente'),
(8, 'Jimenez', 'Victor', 'victor@gmail.es', 7845, 'Docente'),
(9, 'Gonzalez', 'Rocio', 'rocio@gmail.es', 6512, 'Docente'),
(10, 'Carrasco', 'Jennifer', 'jennifer@gmail.es', 8841, 'Docente'),
(11, 'Muñoz', 'Elena', 'elena@gmail.es', 2624, 'Administradora');

INSERT INTO Cursos (Curso_ID, Tipo, Coste, Nivel, Fecha_Inscripcion, Fecha_Finalizacion, Usuario_ID) VALUES
(20, 'Castellano', 100, 'A1', '2016-09-22', '2020-06-22', 6),
(21, 'Ingles', 150, 'A2', '2017-09-22', '2021-06-22', 7),
(22, 'Aleman', 200, 'B1', '2018-09-22', '2022-06-22', 8),
(23, 'Chino', 180, 'B2', '2019-09-22', '2023-06-22', 9),
(24, 'Frances', 120, 'C1', '2020-09-22', '2024-06-22', 10);

INSERT INTO Lecciones (Leccion_ID, Nivel, Etapa, Curso_ID) VALUES
(10, 'Basico', 'Primera', 20),
(11, 'Intermedio', 'Segunda', 21),
(12, 'Avanzado', 'Tercera', 22),
(13, 'Profesional', 'Cuarta', 23);

INSERT INTO Pagos (Pago_ID, Estado, Vía_Pago, Curso_ID, Usuario_ID) VALUES
(00, 'Pagado', 'Efectivo', 20, 1),
(01, 'No Pagado', 'PayPal', 21, 2),
(02, 'A Plazos', 'Tarjeta Credito', 22, 3);

INSERT INTO Procesos (Usuario_ID, Curso_ID, Leccion_ID, Completado_ID) VALUES
(1, 20, 12, 'True'),
(2, 20, 13, 'False'),
(3, 21, 12, 'False'),
(4, 23, 11, 'True'),
(5, 24, 10, 'True');

SELECT * FROM Usuarios;

#--Consulta para obtener información de los usuarios y los cursos a los que están inscritos--
SELECT Usuarios.Usuario_ID, Usuarios.Nombre, Usuarios.Apellidos, Cursos.Tipo
FROM Usuarios
JOIN Cursos ON Usuarios.Usuario_ID = Cursos.Usuario_ID;

#--Consulta para obtener información de los pagos realizados por los usuarios y los cursos asociados--
SELECT Pagos.Pago_ID, Pagos.Estado, Usuarios.Nombre, Usuarios.Apellidos, Cursos.Tipo
FROM Pagos
JOIN Usuarios ON Pagos.Usuario_ID = Usuarios.Usuario_ID
JOIN Cursos ON Pagos.Curso_ID = Cursos.Curso_ID;


#--Consulta para obtener información completa sobre los procesos de aprendizaje de los usuarios, incluyendo detalles sobre los cursos y las lecciones--
SELECT Procesos.Usuario_ID, Usuarios.Nombre, Usuarios.Apellidos, Cursos.Tipo, Lecciones.Nivel, Lecciones.Etapa
FROM Procesos
JOIN Usuarios ON Procesos.Usuario_ID = Usuarios.Usuario_ID
JOIN Cursos ON Procesos.Curso_ID = Cursos.Curso_ID
JOIN Lecciones ON Procesos.Leccion_ID = Lecciones.Leccion_ID;


#-- información sobre los docentes y las asignaturas que imparten--
SELECT Usuarios.Nombre AS Docente, Usuarios.Apellidos, Cursos.Tipo AS Asignatura
FROM Usuarios
JOIN Cursos ON Usuarios.Usuario_ID = Cursos.Usuario_ID
WHERE Usuarios.Tipo = 'Docente';






