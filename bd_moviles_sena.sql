-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-10-2023 a las 23:51:00
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_moviles_sena`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actualizar_profesion`
--

CREATE TABLE `actualizar_profesion` (
  `anterior_cod_profesion` int(11) NOT NULL,
  `anterior_profesion` varchar(15) NOT NULL,
  `nuevo_cod_profesion` int(11) NOT NULL,
  `nueva_profesion` varchar(15) NOT NULL,
  `rol` varchar(50) NOT NULL,
  `actualizado` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE `ciudad` (
  `cod_ciudad` int(11) NOT NULL,
  `cIudad` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ciudad`
--

INSERT INTO `ciudad` (`cod_ciudad`, `cIudad`) VALUES
(12, 'NEIVA'),
(18, 'CALI'),
(24, 'ESPINAL');

--
-- Disparadores `ciudad`
--
DELIMITER $$
CREATE TRIGGER `actulizar_ciudad_bu` BEFORE UPDATE ON `ciudad` FOR EACH ROW begin
insert into ciudades_actualizadas (Anterior_Cod_ciudad,Anterior_Ciudad,Nuevo_Cod_ciudad,Nuevo_Ciudad,Rol_BD,Fecha_Acatulizacion)
values (old. cod_ciudad,old.cIudad, NEW. cod_ciudad,NEW.cIudad ,corrent_user() ,now());
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades_actualizadas`
--

CREATE TABLE `ciudades_actualizadas` (
  `Anterior_Cod_ciudad` int(11) NOT NULL,
  `Anterior_Ciudad` varchar(30) NOT NULL,
  `Nuevo_Cod_ciudad` int(11) DEFAULT NULL,
  `Nuevo_Ciudad` varchar(30) NOT NULL,
  `Rol_BD` varchar(30) NOT NULL,
  `Fecha_Acatulizacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades_registro_anterior`
--

CREATE TABLE `ciudades_registro_anterior` (
  `Anterior_Cod_ciudad` int(11) NOT NULL,
  `Anterior_Ciudad` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correo`
--

CREATE TABLE `correo` (
  `Documento` int(11) NOT NULL,
  `Email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `correo`
--

INSERT INTO `correo` (`Documento`, `Email`) VALUES
(3466, 'Andreaa@jj.com'),
(8896, 'milozano@hot.es'),
(4345, 'dlozano@yah.es'),
(4345, 'diegolozano@gml.com');

--
-- Disparadores `correo`
--
DELIMITER $$
CREATE TRIGGER `borrar_correo_bd` BEFORE DELETE ON `correo` FOR EACH ROW BEGIN
INSERT INTO evento_diparador (registro, fecha) VALUES (CONCAT('Se registro una documento con el id ', old.documento, ' y mail ', old.email), now() );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertar_correo_ai` AFTER INSERT ON `correo` FOR EACH ROW BEGIN
INSERT INTO evento_diparador (registro, fecha) VALUES (CONCAT('Se registro una ciudad con el id ', NEW.documento, ' y el nombre ', NEW.email), now() );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_correo_bu` BEFORE UPDATE ON `correo` FOR EACH ROW BEGIN
INSERT INTO evento_diparador (registro, fecha) VALUES (CONCAT('correo antiguo ', old.email, ' correo nuevo  ', NEW.email), now() );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento_diparador`
--

CREATE TABLE `evento_diparador` (
  `Id_vigilante` int(11) NOT NULL,
  `registro` varchar(150) DEFAULT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `evento_diparador`
--

INSERT INTO `evento_diparador` (`Id_vigilante`, `registro`, `fecha`) VALUES
(1, 'Se registro una ciudad con el id 1234 y el nombre kjkj@gmail.com', '2023-08-29'),
(2, 'correo antiguo Didilva@msn.com correo nuevo  jesus@', '2023-08-29'),
(3, 'correo antiguo diegosilva@hot.es correo nuevo  jesus@', '2023-08-29'),
(4, 'correo antiguo kjkj@gmail.com correo nuevo  jesus@', '2023-08-29'),
(5, 'Se registro una documento con el id 1234 y mail jesus@', '2023-08-29'),
(6, 'Se registro una documento con el id 1234 y mail jesus@', '2023-08-29'),
(7, 'Se registro una documento con el id 1234 y mail jesus@', '2023-08-29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movil`
--

CREATE TABLE `movil` (
  `Documento` int(11) NOT NULL,
  `Telefono` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `movil`
--

INSERT INTO `movil` (`Documento`, `Telefono`) VALUES
(3466, '31345678'),
(3466, '31678990'),
(8896, '31845678'),
(4345, '30023567'),
(4345, '31234578');

--
-- Disparadores `movil`
--
DELIMITER $$
CREATE TRIGGER `almacienar_registro_movil_bd` BEFORE DELETE ON `movil` FOR EACH ROW begin
insert into   movil_registro_anterior  values (old.Documento ,old.Telefono);
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movil_registro_anterior`
--

CREATE TABLE `movil_registro_anterior` (
  `anterior_Documento` int(11) NOT NULL,
  `anterior_Telefono` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `movil_registro_anterior`
--

INSERT INTO `movil_registro_anterior` (`anterior_Documento`, `anterior_Telefono`) VALUES
(1234, '31234567');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `Documento` int(11) NOT NULL,
  `CodCiudad` int(11) NOT NULL,
  `Nombres` varchar(15) NOT NULL,
  `Apellidos` varchar(15) NOT NULL,
  `Sexo` char(1) NOT NULL,
  `CodProfesion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`Documento`, `CodCiudad`, `Nombres`, `Apellidos`, `Sexo`, `CodProfesion`) VALUES
(1234, 12, 'Diego', 'Silva', 'M', 10),
(3466, 24, 'Andrea', 'Amaya', 'F', 1),
(4345, 12, 'Diego', 'Lozano', 'M', 20),
(8896, 18, 'Milena', 'Lozano', 'F', 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesiones`
--

CREATE TABLE `profesiones` (
  `CodProfesion` int(11) NOT NULL,
  `Profesion` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `profesiones`
--

INSERT INTO `profesiones` (`CodProfesion`, `Profesion`) VALUES
(1, 'Dios'),
(8, 'Jesus'),
(10, 'aseos'),
(20, 'OBRERO'),
(78, 'jesus');

--
-- Disparadores `profesiones`
--
DELIMITER $$
CREATE TRIGGER `almacienar_registro_profesion_bd` BEFORE UPDATE ON `profesiones` FOR EACH ROW begin
insert into   actualizar_profesion(anterior_cod_profesion,anterior_profesion,nuevo_cod_profesion,nueva_profesion,actualizado) values (old.CodProfesion,old.Profesion,new.CodProfesion,new.Profesion, 
corrent_user(),now());
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertar_profresion_ai` AFTER INSERT ON `profesiones` FOR EACH ROW BEGIN
INSERT INTO repartidor_vigilante (registro) VALUES (CONCAT('Se registro una ciudad con el id ', NEW.codProfesion, ' y el nombre ', NEW.Profesion));
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`cod_ciudad`);

--
-- Indices de la tabla `correo`
--
ALTER TABLE `correo`
  ADD KEY `Documento` (`Documento`);

--
-- Indices de la tabla `evento_diparador`
--
ALTER TABLE `evento_diparador`
  ADD PRIMARY KEY (`Id_vigilante`);

--
-- Indices de la tabla `movil`
--
ALTER TABLE `movil`
  ADD KEY `Documento` (`Documento`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`Documento`),
  ADD KEY `CodCiudad` (`CodCiudad`),
  ADD KEY `CodProfesion` (`CodProfesion`);

--
-- Indices de la tabla `profesiones`
--
ALTER TABLE `profesiones`
  ADD PRIMARY KEY (`CodProfesion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `evento_diparador`
--
ALTER TABLE `evento_diparador`
  MODIFY `Id_vigilante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `correo`
--
ALTER TABLE `correo`
  ADD CONSTRAINT `correo_ibfk_1` FOREIGN KEY (`Documento`) REFERENCES `personas` (`Documento`);

--
-- Filtros para la tabla `movil`
--
ALTER TABLE `movil`
  ADD CONSTRAINT `movil_ibfk_1` FOREIGN KEY (`Documento`) REFERENCES `personas` (`Documento`);

--
-- Filtros para la tabla `personas`
--
ALTER TABLE `personas`
  ADD CONSTRAINT `personas_ibfk_1` FOREIGN KEY (`CodCiudad`) REFERENCES `ciudad` (`cod_ciudad`),
  ADD CONSTRAINT `personas_ibfk_2` FOREIGN KEY (`CodProfesion`) REFERENCES `profesiones` (`CodProfesion`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
