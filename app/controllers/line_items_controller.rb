class LineItemsController < ApplicationController
  def create
   current_user.create_current_cart unless current_user.current_cart
   if current_user.current_cart.items.include?(Item.find(params[:item_id]))
     @item = current_user.current_cart.line_items.find(params[:item_id])
     @item.quantity += 1
   else
     line_item = current_user.current_cart.add_item(params[:item_id])
   end
   if line_item.save
     redirect_to cart_path(current_user.current_cart), {notice: 'Item added to cart!'}
   else
     redirect_to store_path, {notice: 'Unable to add item'}
   end
  end
end
