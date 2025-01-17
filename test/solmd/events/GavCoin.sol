// // SPDX-FileCopyrightText: 2020 Tenderize <info@tenderize.me>

// // SPDX-License-Identifier: GPL-3.0

// /* See contracts/COMPILERS.md */

pragma solidity ^0.8.0;

// natspec example
/**
@title GavCoin
@author Gavin Wood
*/
contract GavCoin {
    mapping (address => uint256) public balances;
    address owner;
    uint exchangeRate;

    constructor() {
        owner = msg.sender;
    }

    /**
    @notice Event on owner change
    @param newOwner The address of the recipient of the GavCoin
    @param previousOwner The GavCoin value to send
    */
    event OwnerChanged(address newOwner, address previousOwner);

    /**
    @notice Send `(valueInmGAV / 1000).fixed(0,3)` GAV from the account of
    `message.caller.address()`, to an account accessible only by `to.address()
    @dev This should be the documentation of the function for the developer docs
    @param to The address of the recipient of the GavCoin
    @param valueInmGAV The GavCoin value to send
    */
    function send(address to, uint256 valueInmGAV) public {
        if (balances[msg.sender] >= valueInmGAV) {
            balances[to] += valueInmGAV;
            balances[msg.sender] -= valueInmGAV;
        }
    }

    /**
    @notice change owner
    @dev dev
    @param _owner this is the owner
    @return previousOwner the previous owner
    */
    function setOwner(address _owner) public returns (address previousOwner) {
        previousOwner = owner;
        owner = _owner;
        emit OwnerChanged(owner, previousOwner);
        return previousOwner;
    }

    /**
    @notice create new gav coins
    @dev use this funciton to create new gavcoins from Ether
    */
    function mint() public payable {
        require(msg.value > 0);
        balances[msg.sender] += (msg.value * exchangeRate);
    }
}
