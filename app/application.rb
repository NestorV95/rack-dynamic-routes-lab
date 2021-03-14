class Application

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
            if req.path.match(/items/)
                item_name = req.path.split("/items/").last
                item = @@items.find{|i| i.name == item_name}
                resp.write item.price
            elsif req.path.match(/search/)
                search_term = req.param["item"]
                resp.write "#{search_term} is one of our items"
            else
                resp.write "Item not found"
                resp.status 400
            end
       resp.finish
    end  

end

# 1.)Your application should only accept the /items/<ITEM NAME> route. Everything else should 404
# 2.)If a user requests /items/<Item Name> it should return the price of that item
# 3.)IF a user requests an item that you don't have, then return a 400 and an error message