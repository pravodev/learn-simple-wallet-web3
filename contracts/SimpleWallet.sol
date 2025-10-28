// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SimpleWallet
{
    address private owner;

    mapping(address => uint) private balances;

    event Deposit(address indexed user, uint amount);
    event Transfer(address indexed from, address indexed to, uint amount);
    event Withdrawal(address indexed user, uint amount);

    constructor() {
        owner = msg.sender;
    }

    function _deposit() private {
        require(msg.value > 0, "The total of deposit must more than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function deposit() external payable {
        _deposit();
    }

    receive() external payable { 
        _deposit();
    }

    fallback() external payable { 
        _deposit();
    }

    function getBalance(address user) external view returns (uint) {
        return balances[user];
    }

    function transferBalance(address to, uint amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        require(to != address(0), "Address zero");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }

    function withdrawBalance(uint amount) external {
        require(amount > 0, "The total amount must more than zero.");
        require(balances[msg.sender ] >= amount, "Insufficient balance.");
        balances[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed Transfer.");
        
        emit Withdrawal(msg.sender, amount);
    }
}