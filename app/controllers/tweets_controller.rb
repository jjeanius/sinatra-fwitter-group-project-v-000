require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do  # tweet / GET request / read action
    tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do    #CREATE action - GET request
    erb :'tweets/new'
  end

  post '/tweets' do     #CREAT action - POST request
    @tweet = Tweet.new(params)   #@tweet = Tweet.create(:content =>params[:content], :user_id =>params[:user_id])
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end


  get '/tweets/:id' do   # Get action / Update request
    @tweet = Tweet.find(params[:id])
    @tweet_id = params[:id]
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do   # Patch action /update request
    @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
        @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  post '/tweets/:id/delete' do   # Delete action / Delete request
    if logged_in? && current_user
        @tweet = find_by(params[:id])
        @tweet.clear
    else
      redirect "/login"
    end
  end

  get '/tweets' do     # Get request / check if user login
    if logged_in
      user = current_user
      erb :'/tweets'
    else
      redirect to '/login'
    end
  end

end

  helpers do

    def logged_in
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end
