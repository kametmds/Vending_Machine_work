# require "/Users/kame/workspace/DIC_work/Vending_Machine_work/VendingMachine.rb"
# @vm = VendingMachine.new
class Product
  attr_reader :name, :price, :quantity, :items

  def initialize(args)
    @name = args[:name]
    @price = args[:price]
    @quantity = args[:quantity]
    @items = items
  end

  def items
    items = Hash.new { |h,k| h[k] = Hash.new { |h,k| h[k] = {} } }
    items[@name][:price] = @price
    items[@name][:quantity] = @quantity
    items
  end
end

class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze

  def initialize
    @slot_money = 0
    @sales = 0
    @coke = Product.new(price: 120, name: "coke", quantity: 3)
    @redbull = Product.new(name: "redbul", price: 200, quantity: 5)
    @water = Product.new(quantity: 1, price: 100, name: "water")
    product_list()
  end

  def product_list
    @product_list = {}
      [@coke.items, @redbull.items, @water.items].each do |h|
        @product_list.merge!(h)
      end
      @product_list
  end

  def slot_money(money)
    if MONEY.include?(money)
      @slot_money += money
      nil
    else
      money
    end
  end

  def current_slot_money
    @slot_money
  end

  def valid?
    (@slot_money >= @product_list[@name][:price]) && (@product_list[@name][:quantity] > 0)
  end

  def purchase(name)
    @name = name.to_sym
    if valid?()
      @product_list[@name][:quantity] -= 1
      @sales += @product_list[@name][:price]
      @slot_money -= @product_list[@name][:price]
      return_money()
    end
  end

  def purchasable
    display_list = @product_list.select do |key, value|
      @product_list[key][:quantity] > 0
      @product_list[key][:price] <= @slot_money
    end
    display_list
  end

  def return_money
      slot_money = @slot_money
      @slot_money = 0
      slot_money
  end

  def profit
    @sales
  end
end