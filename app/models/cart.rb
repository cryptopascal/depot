class Cart < ActiveRecord::Base
  #attr_accessible :line_items
  attr_accessible :line_items
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      if current_item.quantity.nil?
        current_item.quantity = 0
      end
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
      current_item.quantity = 1
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
