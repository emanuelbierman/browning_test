# require 'rack-flash'

class PostsController < ApplicationController

  post '/posts' do
    @board = Board.find_by(id: params[:board][:id])
    if logged_in?
      @post = Post.create(content: params[:post][:content])
      @user = current_user
      @post.user = @user
      @user.posts << @post
      @post.board = @board
      @board.posts << @post
    end
    redirect to "/boards/#{@board.id}"
  end

  patch '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    @post.update(content: params[:post][:content]) unless params[:post][:content].blank?
    redirect to "/users/#{@post.user.id}"
  end

  delete '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    user_id = @post.user.id
    @post.destroy
    redirect to "/users/#{user_id}"
  end
end
