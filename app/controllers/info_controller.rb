class InfoController < ApplicationController
  def who_bought
    @product = Product.find(params[:id])
    @orders = @product.orders
    respond_to do |format|
      format.html
      #format.xml { render :layout => false }
      
      ##Autogenerating the XML
      #format.xml { render :layout => false ,
      #            :xml => @product.to_xml(:include => :orders) }
      
      ##Atom Feeds:
      #format.atom { render :layout => false }
      
      ##JSON feeds:
      format.json { render :layout => false ,
                  :json => @product.to_json(:include => :orders) }
    end
  end

protected
  def authorize
  end
end
