class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :carts
  belongs_to :current_cart, :class_name => "Cart"

  def create_current_cart
    @new_cart = carts.create(:user_id => self.id)
    self.current_cart_id = @new_cart.id
    save
  end

  def remove_cart
    self.current_cart_id = nil
    current_cart = nil
    save
  end
end
