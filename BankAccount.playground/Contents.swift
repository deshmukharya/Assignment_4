//Parent class
class BankAccount {
    //properties
    let accountNumber: String
    var initialBalance: Double
    
    //computed property balance
    var balance: Double {
        get{
            return initialBalance
        }
        set{
            initialBalance = newValue
        }
    }
    
    init(accountNumber: String, initialBalance: Double) {
        self.accountNumber = accountNumber
        self.initialBalance = initialBalance
    }
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func withdraw(amount: Double) {
       balance -= amount
    }
    
    
    deinit {
        print("Account \(accountNumber) is being closed.")
    }
}

class SavingsAccount: BankAccount {
    let interestRate: Double
    
    init(accountNumber: String, initialBalance: Double, interestRate: Double) {
        self.interestRate = interestRate
        super.init(accountNumber: accountNumber, initialBalance: initialBalance)
    }
    
    override func withdraw(amount: Double) {
    let minimumBalance = 100.0
        if(balance - amount > minimumBalance) {
        balance -= amount
        }
        else{
            print("You cannot withdraw money")
        }
       
    }
    
    func applyInterest() {
        let  interest = balance * interestRate
       
    }
    
    override var balance: Double {
        get{
            
         var interest = super.balance * interestRate
          
          return super.balance + interest
        }
        set{
          
            super.balance = newValue
        }
    }
    
  
    func statement() -> Void{
      print("Account Number is \(accountNumber) and initial balance is \(super.initialBalance)")
    }
}

class CurrentAccount: BankAccount {
    let overdraftLimit: Double
    
    init(accountNumber: String, initialBalance: Double, overdraftLimit: Double) {
        self.overdraftLimit = overdraftLimit
        super.init(accountNumber: accountNumber, initialBalance: initialBalance)
    }
    
    override func withdraw(amount: Double) {
        let currentBalance = super.balance + overdraftLimit
        if amount <= currentBalance {
           balance -= amount
        } else {
            print("Withdrawal failed. Exceeds overdraft limit.")
        }
    }
    
    override var balance: Double {
        get{
            return super.balance + overdraftLimit
        }
        set{
            super.balance = newValue
        }
    }
}

let account1 = BankAccount(accountNumber: "A56T", initialBalance: 890)
print("Initial balanace in the account is \(account1.initialBalance)")

print("Deposit $50  int the account")
account1.deposit(amount: 50)
print("Balance after depositing $50 is \(account1.balance)")


let account2 = SavingsAccount(accountNumber: "BV67", initialBalance: 100, interestRate: 0.05)
account2.statement()
account2.applyInterest()
print("Current balance after applying interest is \(account2.balance)")

account2.withdraw(amount:4)
print("Current balance after withdrawing $4 is \(account2.initialBalance)")

let currentAccount = CurrentAccount(accountNumber: "C123", initialBalance: 500, overdraftLimit: 200)
print("Initial Balance: \(currentAccount.initialBalance)")
print("Overdraft Limit: \(currentAccount.overdraftLimit)")
print("Current Balance: \(currentAccount.balance)")

let withdrawalAmount = 700
print("Attempting to withdraw $\(withdrawalAmount)")
currentAccount.withdraw(amount: Double(withdrawalAmount))

print("Current Balance: \(currentAccount.initialBalance)")



