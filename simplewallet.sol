// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

// This contract allows users to activate an account, deposit Ether, and withdraw it later
contract SimpleWallet {

    // Struct to store each user's details
    struct userDetails {
        address owner;     // The user's address
        uint256 amount;    // How much Ether they've deposited
        bool isActive;     // Whether their account is active or not
    }

    // Mapping to associate each address with its userDetails
    mapping(address => userDetails) public userInfo;

    // Event emitted when a user deposits Ether
    event registerDeposit(address _user, uint256 _amount);

    // Event emitted when a user withdraws Ether
    event registerWithdraw(address _user, uint256 _amount);

    // Event emitted when someone tries to send Ether directly to the contract
    event Received(address sender, uint256 amount);

    // Function to activate the user's account
    function activateAccount() external {
        // Make sure the user hasn't already activated their account
        require(!userInfo[msg.sender].isActive, "Already active");

        // Initialize the user's info in the mapping
        userInfo[msg.sender] = userDetails({
            owner: msg.sender,
            amount: 0,
            isActive: true
        });
    }

    // Function for users to deposit Ether into their account
    function depositFunds() external payable {
        // Require a minimum deposit of 0.0001 ether
        require(msg.value >= 0.0001 ether, "Not enough funds");

        // Make sure the user's account is activated
        require(userInfo[msg.sender].isActive, "Account not active");

        // Increase the user's stored balance
        userInfo[msg.sender].amount += msg.value;

        // Emit the deposit event
        emit registerDeposit(msg.sender, msg.value);
    }

    // Function for users to withdraw Ether from their account
    function withdrawFunds(uint256 _amount) external {
        // Ensure the user has enough balance
        require(userInfo[msg.sender].amount >= _amount, "Not enough funds");

        // Make sure the user's account is active
        require(userInfo[msg.sender].isActive, "Account not active");

        // Subtract the amount from the user's balance
        userInfo[msg.sender].amount -= _amount;

        // Attempt to send Ether back to the user
        (bool sent, ) = userInfo[msg.sender].owner.call{value: _amount}("");
        require(sent, "Failed to transfer");

        // Emit the withdrawal event
        emit registerWithdraw(msg.sender, _amount);
    }

    // Function to return the caller's current balance in the contract
    function getBalance() public view returns (uint256) {
        return userInfo[msg.sender].amount;
    }

    // Fallback receive function to reject direct transfers
    receive() external payable {
        emit Received(msg.sender, msg.value);
        // Don't allow direct sending of Ether without calling depositFunds
        revert("Direct ether transfer is not allowed");
    }
}
