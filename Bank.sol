// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Bank{

    mapping(address => uint) balances;
    address public owner;
    event logDeposit (address walletAddress , uint amountOfTransfer);
    event sendMoney (address from , address to , uint amount);

    constructor(){
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }


    function deposit() public payable returns(uint){
        require((balances[msg.sender]+ msg.value) >= balances[msg.sender]);
        balances[msg.sender] += msg.value;
        emit logDeposit(msg.sender, msg.value);
        return balances[msg.sender];
    }

    function withdraw(uint amontOfWithdraw , address to) public payable onlyOwner() returns(uint balance){
        require(amontOfWithdraw <= balances[msg.sender]);
        emit sendMoney(msg.sender, to, (amontOfWithdraw + msg.value));
        balances[msg.sender] -= amontOfWithdraw;
        payable (msg.sender).transfer(amontOfWithdraw);
        return balances[msg.sender];
    }

    function returnBalance() public view returns(uint){
        return balances[msg.sender];
    }

    function returnBalanceOfTransferdWallet(address wallet) view  public returns(uint){
        return balances[wallet];
    }
}