# transfer class acts as a space for a transaction between two instances of the bank account class
# you can't just transfer money to another account without the bank running checks first
# transfer instances will do all of this and check the validity of the accounts before the transaction occurs
# transfer instances should be able to rejecrt a transfer if the accounts arent't calid or if the sender doesn't have the money
# transfers start out as a pending status and can be executed and go to a complete state
# they can also do a rejected status
# a completed transfer can also be reversed and go into a "reversed" status

class Transfer
  attr_accessor :sender, :receiver, :amount
  attr_reader :status
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end
  
  def valid?
    @sender.valid?
    @receiver.valid?
  end
  
  def execute_transaction
    if valid? && @status == "pending" && sender.balance > amount
      sender.deduction(self.amount)
      receiver.deposit(self.amount)
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
  
  def reverse_transfer
    if @status == completed
      sender.deposit(self.amount)
      receiver.deduction(self.amount)
      @status = "reversed"
    end
  end
end
