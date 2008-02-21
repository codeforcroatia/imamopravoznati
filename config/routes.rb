# config/routes.rb:
# Mapping URLs to controllers for FOIFA.
#
# Copyright (c) 2007 UK Citizens Online Democracy. All rights reserved.
# Email: francis@mysociety.org; WWW: http://www.mysociety.org/
#
# $Id: routes.rb,v 1.35 2008-02-21 18:32:43 francis Exp $

ActionController::Routing::Routes.draw do |map|
    # The priority is based upon order of creation: first created -> highest priority.

    # Sample of regular route:
    # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
    # Keep in mind you can assign values other than :controller and :action
    
    map.with_options :controller => 'request' do |request|
      request.frontpage           '/',            :action => 'frontpage'
      request.auto_complete_for_public_body_query 'auto_complete_for_public_body_query', :action => 'auto_complete_for_public_body_query'

      request.request_list   '/list',        :action => 'list'
      request.new_request    '/new',         :action => 'new'
      request.new_request_to_body    '/new/:public_body_id',         :action => 'new'
      request.show_request     '/request/:id', :action => 'show'
      request.describe_state   '/request/:id/describe', :action => 'describe_state'
      request.show_response    '/request/:id/response/:incoming_message_id', :action => 'show_response'
      request.get_attachment   '/request/:id/response/:incoming_message_id/attach/:part/*file_name', :action => 'get_attachment'
    end

    map.with_options :controller => 'user' do |user|
      user.signin '/signin',        :action => 'signin'
      user.signup '/signup',        :action => 'signup'
      user.signout '/signout',      :action => 'signout'
      user.signchange '/signchange',      :action => 'signchange'
      user.confirm '/c/:email_token', :action => 'confirm'
      user.show_user '/user/:simple_name', :action => 'show'
    end

    map.with_options :controller => 'help' do |help|
      help.help_general '/help/:action',            :action => :action
    end

    map.show_public_body "/body/:simple_short_name", :controller => 'body', :action => 'show'

    # NB: We don't use routes to *construct* admin URLs, as they need to be relative
    # paths to work on the live site proxied over HTTPS to secure.mysociety.org
    map.connect '/admin/:action', :controller => 'admin', :action => 'index'
    map.connect '/admin/body/:action/:id', :controller => 'admin_public_body'
    map.connect '/admin/request/:action/:id', :controller => 'admin_request'
    map.connect '/admin/user/:action/:id', :controller => 'admin_user'

    # Sample of named route:
    # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
    # This route can be invoked with purchase_url(:id => product.id)

    # You can have the root of your site routed by hooking up '' 
    # -- just remember to delete public/index.html.
    # map.connect '', :controller => "welcome"

    # Allow downloading Web Service WSDL as a file with an extension
    # instead of a file named 'wsdl'
    map.connect ':controller/service.wsdl', :action => 'wsdl'

    # Install the default route as the lowest priority.
    # FAI: Turned off for now, as to be honest I don't trust it from a security point of view.
    # Somebody is bound to leave a method public in a controller that shouldn't be.
    #map.connect ':controller/:action/:id.:format'
    #map.connect ':controller/:action/:id'
    # map.connect '/:controller/:action'
end

