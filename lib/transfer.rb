class Transfer
  attr_reader :sender,:receiver, :amount
  attr_accessor :status


  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount

    @status = "pending"

  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @status == "pending" && @sender.valid? && @amount < @sender.balance
      @receiver.balance= @receiver.balance + @amount
      @sender.balance= @sender.balance - @amount
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end

  end

  def reverse_transfer
    if @status == "complete"
      @receiver.balance= @receiver.balance - @amount
      @sender.balance= @sender.balance + @amount
      @status = "reversed"
    end
  end

end
