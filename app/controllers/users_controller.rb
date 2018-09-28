class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = current_user.nickname
    @posts = user.posts.page(params[:page]).per(4).order("created_at DESC")
  end
end
