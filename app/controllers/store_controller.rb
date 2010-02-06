class StoreController < ApplicationController
  def index
    #session[:counter] ||= 0     /*same as below */
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
    @count = session[:counter]
    @products = Product.find_products_for_sale
    @cart = find_cart
  end

  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    # @cart.add_product(product)
    @current_item = @cart.add_product(product)
    respond_to do |format|
      format.js if request.xhr?
      format.html {redirect_to_index(nil)}
    end
    session[:counter] = 0
    # redirect_to_index
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid product #{params[:id]}")
    redirect_to_index("Invalid product")

  end
  
  def empty_cart
    session[:cart] = nil
    # flash[:notice] = "Your cart is currently empty"
    redirect_to_index("Your cart is currently empty")
  end

  private
    def find_cart
      session[:cart] ||= Cart.new
    end
    
    def redirect_to_index(msg)
      flash[:notice] = msg if msg
      redirect_to :action => 'index'
    end
end
