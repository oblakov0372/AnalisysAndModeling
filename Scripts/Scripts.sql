CREATE PROCEDURE InsertStudent
    @Name NVARCHAR(50),
    @Surname NVARCHAR(50),
    @DateOfBirth DATE,
    @ClassId INT
AS
BEGIN
    INSERT INTO Student (Name, Surname, DateOfBirth, ClassId)
    VALUES (@Name, @Surname, @DateOfBirth, @ClassId)
END
GO

CREATE PROCEDURE GetStudents
AS
BEGIN
    SELECT name, surname, classId
    FROM Student;
END
GO

CREATE FUNCTION CalculateAge (@dateOfBirth DATE)
RETURNS INT
AS
BEGIN
    DECLARE @age INT;
    SET @age = DATEDIFF(YEAR, @dateOfBirth, GETDATE());
    RETURN @age;
END
GO

CREATE TRIGGER TrackStudentChanges
ON Student
AFTER UPDATE
AS
BEGIN
    IF UPDATE(classId)
    BEGIN
        DECLARE @OldClassId INT, @NewClassId INT, @StudentId INT, @ChangeDate DATETIME;
        SELECT @OldClassId = deleted.classId, @NewClassId = inserted.classId, @StudentId = inserted.id, @ChangeDate = GETDATE()
        FROM deleted, inserted;

        INSERT INTO StudentChanges (StudentId, OldClassId, NewClassId, ChangeDate)
        VALUES (@StudentId, @OldClassId, @NewClassId, @ChangeDate);
    END
END

