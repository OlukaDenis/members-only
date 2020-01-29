class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "New post added"
      redirect_to root_url
    end
  end

  def index
    @posts = Post.all
  end

  private

  # Confirms the logged in user
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in to continue!"
      redirect_to login_url
    end
  end

  def post_params
    params.require(:post).permit(:body, :title)
  end
end
