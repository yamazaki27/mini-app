class PostsController < ApplicationController

  before_action :move_to_index, except: [:index]

  def index
    @posts = Post.all.page(params[:page]).per(4).order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
    redirect_to controller: :posts, action: :index
  end

  def destroy
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.destroy
    end
    redirect_to user_path(current_user)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.update(post_params)
    end
  end

  def show
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.destroy
    end
    redirect_to user_path(current_user)
  end

  private
  def post_params
    params.require(:post).permit(:text).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
