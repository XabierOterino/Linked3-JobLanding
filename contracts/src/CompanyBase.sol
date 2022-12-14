// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
* @notice Contract that stores all the data and functions related to companies
 */

contract CompanyBase{
    modifier onlyCompanies(){
        require(_companies[_addressToCompany[msg.sender]].owner!=address(0), "Company not found");
        _;
    }
    // Struct object of company
    struct Company{
        address owner;
        string name;
        string  mainPageURI;
        address[] team;
    }

    uint256 private _companyCount;
    Company[] private _companies; //list of the companies
    mapping(address=> uint256) private _addressToCompany; //mapping from address to Company struct

    /**
    * Adds a new company to the list
     */

    function _addCompany(string memory _name, string memory _mainPageURI , address account) internal{
       _companies[_companyCount].name = _name;
       _companies[_companyCount].mainPageURI = _mainPageURI;
       _companies[_companyCount].owner = account;
       _companies[_companyCount].team.push(account);
       _addressToCompany[account] = _companyCount;
        _companyCount++;
    }
    /**
    * Adds a new member to the company's team
     */
    function _hire(uint256 _companyId , address _account) internal{
        _companies[_companyId].team.push(_account);
    }

    function addressToCompany(address account) internal view returns(uint256){
        return _addressToCompany[account];
    }

    function Companies() public view returns(Company [] memory){
        return _companies;
    } 

}