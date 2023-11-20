create database SchoolDiaryDB

-- Таблица классов
CREATE TABLE Class (
    id INT PRIMARY KEY,
    classNumber INT,
    alphabeticIdentifier NVARCHAR(1)
);

-- Таблица учителей
CREATE TABLE Teacher (
    id INT PRIMARY KEY,
    name NVARCHAR(50),
    surname NVARCHAR(50)
);

-- Таблица предметов
CREATE TABLE Subject (
    id INT PRIMARY KEY,
    name NVARCHAR(50)
);

-- Таблица студентов
CREATE TABLE Student (
    id INT PRIMARY KEY,
    name NVARCHAR(50),
    surname NVARCHAR(50),
    dateOfBirth DATE,
    classId INT,
    FOREIGN KEY (classId) REFERENCES Class(id)
);

-- Таблица родителей
CREATE TABLE Parent (
    id INT PRIMARY KEY,
    name NVARCHAR(50),
    surname NVARCHAR(50),
    contactInfo NVARCHAR(100)
);

-- Таблица оценок
CREATE TABLE Grade (
    id INT PRIMARY KEY,
    value DECIMAL(4, 2),
    studentId INT,
    subjectId INT,
    lessonId INT,
    teacherId INT,
    FOREIGN KEY (studentId) REFERENCES Student(id),
    FOREIGN KEY (subjectId) REFERENCES Subject(id),
    FOREIGN KEY (lessonId) REFERENCES Lesson(id),
    FOREIGN KEY (teacherId) REFERENCES Teacher(id)
);

-- Таблица уроков
CREATE TABLE Lesson (
    id INT PRIMARY KEY,
    date DATE,
    teacherId INT,
    classId INT,
    subjectId INT,
    FOREIGN KEY (teacherId) REFERENCES Teacher(id),
    FOREIGN KEY (classId) REFERENCES Class(id),
    FOREIGN KEY (subjectId) REFERENCES Subject(id)
);

-- Таблица, связывающая студентов и родителей (для связи многие-ко-многим)
CREATE TABLE Student_Parent (
    studentId INT,
    parentId INT,
    PRIMARY KEY (studentId, parentId),
    FOREIGN KEY (studentId) REFERENCES Student(id),
    FOREIGN KEY (parentId) REFERENCES Parent(id)
);

-- Таблица связи между классами и учителями
CREATE TABLE Class_Teacher (
    classId INT,
    teacherId INT,
    PRIMARY KEY (classId, teacherId),
    FOREIGN KEY (classId) REFERENCES Class(id),
    FOREIGN KEY (teacherId) REFERENCES Teacher(id)
);

-- Таблица связи между классами и предметами
CREATE TABLE Class_Subject (
    classId INT,
    subjectId INT,
    PRIMARY KEY (classId, subjectId),
    FOREIGN KEY (classId) REFERENCES Class(id),
    FOREIGN KEY (subjectId) REFERENCES Subject(id)
);



-- Создание таблицы для отслеживания изменений в учениках
CREATE TABLE StudentChanges (
    ChangeID INT IDENTITY(1,1) PRIMARY KEY,
    StudentId INT,
    OldClassId INT,
    NewClassId INT,
    ChangeDate DATETIME,
    FOREIGN KEY (StudentId) REFERENCES Student(id)
);