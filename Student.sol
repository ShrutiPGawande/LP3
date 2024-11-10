// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract StudentData {
    struct Student {
        uint id;
        string name;
        uint age;
    }
    Student[] private students;
    mapping(uint => bool) public studentExists;
    mapping(uint => Student) private studentData; // New mapping for accessing by id
    event StudentAdded(uint id, string name, uint age);
    receive() external payable {}
    fallback() external payable {}
    function addStudent(uint _id, string memory _name, uint _age) public {
        require(!studentExists[_id], "ID already exists.");
        Student memory newStudent = Student(_id, _name, _age);
        students.push(newStudent);
        studentExists[_id] = true;
        studentData[_id] = newStudent; // Store student by id
        emit StudentAdded(_id, _name, _age);
    }
    function getStudentCount() public view returns (uint) {
        return students.length;
    }
    function getStudentById(uint _id) public view returns (uint, string memory, uint) {
        require(studentExists[_id], "Student ID does not exist.");
        Student memory student = studentData[_id];
        return (student.id, student.name, student.age);
    }
}