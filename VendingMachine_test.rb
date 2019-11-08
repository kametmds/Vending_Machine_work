require 'minitest/autorun'
require './VendingMachine.rb'

class VendingMachineTest < Minitest::Test
  def setup
    @vm = VendingMachine.new
  end

  def test_product_list
    assert @vm.product_list
  end

  def test_slot_money
    assert_equal nil, @vm.slot_money(500)
    assert_equal 400, @vm.slot_money(400)
  end

  def test_current_slot_money
    @vm.slot_money(500)
    assert_equal @vm.current_slot_money, 500
    @vm.slot_money(400)
    assert_equal @vm.current_slot_money, 500
  end

  def test_purchase
    @vm.slot_money(500)
    assert_equal @vm.purchase("water"), 400
  end

  def test_return_money
    @vm.slot_money(500)
    assert_equal 500, @vm.return_money
  end

  def profit
    @vm.slot_money(500)
    @vm.purchase("coke")
    assert_equal 120, @vm.profit
  end
end