// SPDX-License-Identifier: GPL-3.0
pragma solidity >0.8.0;

// Dev Notes - This is a potentially insecure, naive wallet implementation just for the purposes of demonstration and for this tutorial.
// It is NOT AT ALL recommended to be used in Production or to store any real assets.
contract NaiveWallet {
  mapping(address => uint) public balances;

  event Deposit(address indexed from, uint256 indexed amount);
  event Transfer(address indexed from, address indexed to, uint256 indexed amount);
  event Withdraw(address indexed from, uint256 indexed amount);

  function deposit() public payable {
    require(msg.value > 0, "Deposit must be more than 0");
    balances[msg.sender] += msg.value;
    emit Deposit(msg.sender, msg.value);
  }

  function withdraw(uint256 _amount) public {
    require(_amount > 0, "Cannot withdraw an amount less than 0");
    require(balances[msg.sender] >= _amount, "Cannot withdraw more than you own");
    balances[msg.sender] -= _amount;
    (bool sent,) = payable(msg.sender).call{value: _amount}("");
    require(sent, "Failed to send Ether");
    emit Withdraw(msg.sender, _amount);
  }

  function transfer(address _to, uint256 _amount) public {
    require(_amount > 0, "Cannot transfer less than 0");
    require(balances[msg.sender] >= _amount, "Cannot transfer more than you own");
    balances[msg.sender] -= _amount;
    balances[_to] += _amount;
    emit Transfer(msg.sender, _to, _amount);
  }

  function getBalance(address _from) view public returns(uint){
    return balances[_from];
  }
}