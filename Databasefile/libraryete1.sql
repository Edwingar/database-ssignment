-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-12-2019 a las 16:56:41
-- Versión del servidor: 10.1.36-MariaDB
-- Versión de PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `libraryete1`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_book` (IN `id` INT)  BEGIN
Select Title_book
from
books
where
Id_book In(select distinct Id_book from Borrows);

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authors`
--

CREATE TABLE `authors` (
  `Id_author` int(11) NOT NULL,
  `Name_author` varchar(50) NOT NULL,
  `Phone_number` int(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `authors`
--

INSERT INTO `authors` (`Id_author`, `Name_author`, `Phone_number`) VALUES
(1, 'Benjamin Graham', 831563534),
(2, 'Margaret Michael', 831563534),
(3, 'Oliver Green', 831563534),
(4, 'George W Gerwig', 899987647),
(5, 'Benjamin Graham', 899766458);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authors_books`
--

CREATE TABLE `authors_books` (
  `Books_id_book` int(11) NOT NULL,
  `Authors_id_author` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bookaudy`
--

CREATE TABLE `bookaudy` (
  `id` int(11) NOT NULL,
  `Action_bookaudy` varchar(20) NOT NULL,
  `Id_book` int(11) NOT NULL,
  `Action_date` date NOT NULL,
  `doneby` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bookaudy`
--

INSERT INTO `bookaudy` (`id`, `Action_bookaudy`, `Id_book`, `Action_date`, `doneby`) VALUES
(1, 'Insert', 0, '2019-11-17', 'Localhost');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `books`
--

CREATE TABLE `books` (
  `Id_book` int(11) NOT NULL,
  `Title_book` varchar(50) NOT NULL,
  `Type_book` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `books`
--

INSERT INTO `books` (`Id_book`, `Title_book`, `Type_book`) VALUES
(1, 'Lo que el viento se llevo', 'Drama'),
(2, 'The Fault in our Stars', 'Romance'),
(3, 'You', 'Drama'),
(4, 'The intelligent investor', 'Investment'),
(5, 'Perseverance', 'Motivation'),
(8, 'hello', 'drama');

--
-- Disparadores `books`
--
DELIMITER $$
CREATE TRIGGER `after_delete_books` AFTER DELETE ON `books` FOR EACH ROW insert into bookaudy (Action_bookaudy, Id_book, Action_date, doneby) values ('Deleted',0, now(),'Localhost')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_books` AFTER INSERT ON `books` FOR EACH ROW insert into bookaudy (Action_bookaudy, Id_book, Action_date, doneby) values ('Insert',books.Id_book, now(),'Localhost')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_books` AFTER UPDATE ON `books` FOR EACH ROW insert into bookaudy (Action_bookaudy, Id_book, Action_date, doneby) values ('Update',0, now(),'Localhost')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `borrows`
--

CREATE TABLE `borrows` (
  `borrow_id` int(10) NOT NULL,
  `Taken_date` date DEFAULT NULL,
  `Return_date` date DEFAULT NULL,
  `Books_id_book` int(11) NOT NULL,
  `Students_id_student` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `borrows`
--

INSERT INTO `borrows` (`borrow_id`, `Taken_date`, `Return_date`, `Books_id_book`, `Students_id_student`) VALUES
(1, '2019-11-12', '2019-11-15', 2, 1),
(2, '2019-11-10', '2019-11-11', 2, 1),
(3, '2019-12-17', '2019-12-19', 4, 1),
(4, '2019-12-15', '2019-12-28', 8, 2),
(5, '2019-12-15', '2019-12-21', 5, 2),
(6, '2019-12-16', '2019-12-07', 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publisher`
--

CREATE TABLE `publisher` (
  `Id_publisher` int(11) NOT NULL,
  `Name_publisher` varchar(50) NOT NULL,
  `Nacionality` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `publisher`
--

INSERT INTO `publisher` (`Id_publisher`, `Name_publisher`, `Nacionality`) VALUES
(1, 'Edwin Garces', 'Venezuela'),
(2, 'Eduard cuadros', 'Venezuela'),
(3, 'Thiago almaida', 'Brazil'),
(4, 'Jesus Romero', 'France'),
(5, 'Joan Scully', 'Ireland');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publisher_books`
--

CREATE TABLE `publisher_books` (
  `Books_id` int(11) NOT NULL,
  `publisher_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `publisher_books`
--

INSERT INTO `publisher_books` (`Books_id`, `publisher_id`) VALUES
(1, 4),
(2, 3),
(3, 5),
(4, 2),
(5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `students`
--

CREATE TABLE `students` (
  `Id_student` int(11) NOT NULL,
  `Name_Student` varchar(50) DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  `Course` varchar(50) DEFAULT NULL,
  `Books_id_book` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `students`
--

INSERT INTO `students` (`Id_student`, `Name_Student`, `Gender`, `Course`, `Books_id_book`) VALUES
(1, 'Michelle Borgas', 'F', 'IT', 1),
(2, 'Edwin Graces', 'M', 'IT', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`Id_author`);

--
-- Indices de la tabla `authors_books`
--
ALTER TABLE `authors_books`
  ADD PRIMARY KEY (`Books_id_book`,`Authors_id_author`),
  ADD KEY `fkauthor_books_author` (`Authors_id_author`);

--
-- Indices de la tabla `bookaudy`
--
ALTER TABLE `bookaudy`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`Id_book`);

--
-- Indices de la tabla `borrows`
--
ALTER TABLE `borrows`
  ADD PRIMARY KEY (`borrow_id`),
  ADD KEY `fkborrow_books` (`Books_id_book`),
  ADD KEY `fkborrow_students` (`Students_id_student`);

--
-- Indices de la tabla `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`Id_publisher`);

--
-- Indices de la tabla `publisher_books`
--
ALTER TABLE `publisher_books`
  ADD PRIMARY KEY (`Books_id`,`publisher_id`),
  ADD KEY `fkpublisher_book_publisher` (`publisher_id`);

--
-- Indices de la tabla `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`Id_student`),
  ADD KEY `fkstudent_books` (`Books_id_book`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `authors`
--
ALTER TABLE `authors`
  MODIFY `Id_author` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `bookaudy`
--
ALTER TABLE `bookaudy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `books`
--
ALTER TABLE `books`
  MODIFY `Id_book` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `borrows`
--
ALTER TABLE `borrows`
  MODIFY `borrow_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `publisher`
--
ALTER TABLE `publisher`
  MODIFY `Id_publisher` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `students`
--
ALTER TABLE `students`
  MODIFY `Id_student` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `authors_books`
--
ALTER TABLE `authors_books`
  ADD CONSTRAINT `fkauthor_author_books` FOREIGN KEY (`Books_id_book`) REFERENCES `books` (`Id_book`),
  ADD CONSTRAINT `fkauthor_books_author` FOREIGN KEY (`Authors_id_author`) REFERENCES `authors` (`Id_author`);

--
-- Filtros para la tabla `borrows`
--
ALTER TABLE `borrows`
  ADD CONSTRAINT `fkborrow_books` FOREIGN KEY (`Books_id_book`) REFERENCES `books` (`Id_book`),
  ADD CONSTRAINT `fkborrow_students` FOREIGN KEY (`Students_id_student`) REFERENCES `students` (`Id_student`);

--
-- Filtros para la tabla `publisher_books`
--
ALTER TABLE `publisher_books`
  ADD CONSTRAINT `fkpublisher_book_publisher` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`Id_publisher`),
  ADD CONSTRAINT `fkpublisher_publisher_books` FOREIGN KEY (`Books_id`) REFERENCES `books` (`Id_book`);

--
-- Filtros para la tabla `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fkstudent_books` FOREIGN KEY (`Books_id_book`) REFERENCES `books` (`Id_book`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
