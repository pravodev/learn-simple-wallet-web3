# 🪙 SimpleWallet Smart Contract

A simple Ethereum wallet smart contract written in **Solidity**.  
This contract allows users to **deposit**, **transfer**, and **withdraw** Ether safely.

---

## 📜 License

This project is licensed under the **GNU General Public License v3.0 (GPL-3.0)**.

---

## ⚙️ Contract Overview

**Contract Name:** `SimpleWallet`  
**Solidity Version:** `>=0.7.0 <0.9.0`

---

## 🚀 Features

- **Deposit Ether** using standard function calls, `receive()`, or `fallback()`.
- **Transfer balance** to another address inside the contract.
- **Withdraw Ether** to your external wallet.
- **View balances** of any address.
- **Event logging** for all major actions (Deposit, Transfer, Withdrawal).

---

## 📦 Functions

### `constructor()`
Initializes the contract and sets the **deployer as the owner**.

---

### `deposit() external payable`
Deposits Ether into your wallet.  
Emits a **Deposit** event.

**Usage:**
```solidity
simpleWallet.deposit{value: 1 ether}();
```

---

### `receive() external payable`  
Automatically handles plain Ether transfers.

**Usage:**
```solidity
// Directly send Ether to the contract
address(simpleWallet).transfer(1 ether);
```

---

### `fallback() external payable`
Catches any unknown calls and treats them as deposits.

---

### `getBalance(address user) external view returns (uint)`
Returns the current balance of a user stored in the contract.

**Example:**
```solidity
uint myBalance = simpleWallet.getBalance(msg.sender);
```

---

### `transferBalance(address to, uint amount) external`
Transfers balance **within the contract** from the sender to another address.

**Requirements:**
- Sender must have enough balance.
- Destination address cannot be zero.

**Emits:** `Transfer`

---

### `withdrawBalance(uint amount) external`
Withdraws Ether from your internal balance to your wallet address.

**Requirements:**
- Amount must be greater than zero.
- Must have enough balance.

**Emits:** `Withdrawal`

---

## 📡 Events

| Event | Description |
|--------|-------------|
| `Deposit(address indexed user, uint amount)` | Triggered when Ether is deposited. |
| `Transfer(address indexed from, address indexed to, uint amount)` | Triggered when internal balances are transferred. |
| `Withdrawal(address indexed user, uint amount)` | Triggered when Ether is withdrawn. |

---

## 🧪 Example Interaction (Remix)

1. **Deploy** the contract in Remix IDE.
2. **Deposit Ether** by sending value via the `deposit()` function.
3. **Check balance** with `getBalance(address)`.
4. **Transfer balance** using `transferBalance(address, amount)`.
5. **Withdraw balance** using `withdrawBalance(amount)`.

---

## ⚠️ Security Notes

- The contract uses **`call`** for withdrawals (safe with checks).
- Does **not** implement access control beyond sender-based balance tracking.
- Designed for **educational/demo purposes**, not production wallets.

---

## 🧾 Author

Developed for demonstration of Solidity wallet functionality.  
Feel free to fork and extend!

---