require 'pry'

class UsersController < ApplicationController

  get '/' do
    erb :'/index'
  end

  get '/signup' do  # signup / GET request / Create action
    erb :'/users/signup'
  end

  post '/signup' do   #signup / POST request / Create action
  	@user = User.new(params)   #  @user = User.new(:username =>params[:username], :email =>params[:email], :password =>params[:password])
			if @user.save
					session[:user_id] = @user.id
					redirect to '/tweets/tweets'
			else
					redirect to '/signup'
			end
		end

  get "/login" do   #login = Get action
    erb :'/users/login'
  end

  post "/login" do   #login - POST action
    @user = User.find_by(params)   #@user = User.find_by(:username => params[:username], :password => params[:password])
    if @user && @user.authenticate(password: params[:password], username: params[:username])
      session[:user_id] = @user.id
      redirect "/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do    # Get request / show action
    @user = User.find_by(params[:slug])
    erb :'/users/show'
  end

  patch '/users/show' do
    @user = User.find_by(params[:slug])
    @user.username = update.(params[:slug])
    @user.username = User.find_by(username: params[:username])
    slug = @user.slug
     @user.save
    erb :'/users/#{user.slug}'
  end

  get '/logout' do   # Get request / logout action
    if logged_in? && @user = current_user
        session.clear
      else
        redirect to '/login'
      end
    end

helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
