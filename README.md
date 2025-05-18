# 🔐 SimpleWallet

**SimpleWallet** is a beginner-friendly Ethereum smart contract that allows users to **activate accounts**, **deposit Ether**, and **withdraw funds** securely.  
It’s designed to help new Solidity developers understand foundational concepts such as:

- `structs`
- `mappings`
- Ether transfers
- Events
- Access control

---

## 🚀 Features

- ✅ User must activate their account before any operations.
- 💰 Users can securely deposit ETH (minimum `0.0001 ETH`).
- 💸 Users can withdraw their balance at any time.
- ⛔ Direct ETH transfers to the contract are **reverted** and logged.
- 📣 Events emitted for all key interactions (deposits, withdrawals, rejected ETH).

---

## 🛠 Contract Overview

```solidity
contract SimpleWallet

The SimpleWallet smart contract contains:

    A userDetails struct for each user's wallet state.

    A mapping to store user data by address.

    Deposit, withdrawal, and account activation functions.

    A receive() function to reject unintended ETH transfers.

    Events to log and monitor wallet activity.

⚙️ Functions Explained
🔐 activateAccount()

function activateAccount() external

    Initializes the caller’s account.

    Must be called before deposits/withdrawals.

    Only callable once per address.

💰 depositFunds()

function depositFunds() external payable

    Requires the user to be active.

    Requires a minimum of 0.0001 ETH.

    Adds msg.value to the user's internal balance.

    Emits registerDeposit.

💸 withdrawFunds(uint256 _amount)

function withdrawFunds(uint256 _amount) external

    Requires user to be active.

    Requires sufficient balance.

    Deducts _amount and transfers it back to the user.

    Emits registerWithdraw.

📈 getBalance()

function getBalance() public view returns (uint256)

    Returns the user’s current internal wallet balance.

⛔ receive() external payable

receive() external payable

    Reverts the transaction if someone sends ETH directly.

    Emits a Received event before reverting.

📡 Events

    registerDeposit(address user, uint256 amount) — triggered on deposit.

    registerWithdraw(address user, uint256 amount) — triggered on withdrawal.

    Received(address sender, uint256 amount) — triggered on direct ETH attempt.

🧪 How to Use

    Deploy the contract on Remix using compiler version 0.8.30.

    Call activateAccount() to initialize your wallet.

    Call depositFunds() and attach some ETH (≥ 0.0001 ETH).

    Call getBalance() to check your stored funds.

    Call withdrawFunds(uint256 amount) to withdraw ETH back to your wallet.

🧬 Testing in Remix

    Open Remix IDE.

    Create a new .sol file and paste the contract code.

    Compile with Solidity 0.8.30.

    Deploy and interact with the UI:

        activateAccount() → Initializes your user record.

        depositFunds() → Attach at least 0.0001 ETH under “Value”.

        getBalance() → Confirms ETH is tracked.

        withdrawFunds(amount) → Withdraws ETH to your wallet.

🔮 Future Improvements

    Add ERC20 token support using IERC20, approve, and transferFrom.

    Implement pausable/emergency stop feature (OpenZeppelin).

    Add ownership/admin roles for privileged operations.

    Introduce withdrawal limits or time-based locks.

    Build a frontend with React + Ethers.js or Next.js for interaction.

📄 License

This project is licensed under the MIT License.
📬 Contact

Feel free to contribute, suggest improvements, or reach out if you're learning Solidity and want feedback!


---
