class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :cheack,only: [:edit,:update]


  def new
    @user = User.new
  end

  def create

    user = User.new(user_params)
    user.save
    redirect_to book_params_path
  end

  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
    @user = current_user
  end

  def show
    @book = Book.new
    @users = User.all
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  if @user == current_user
    render "edit"
  else
    redirect_to user_path
  end
  end

  def update
    @user =User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def cheack
        @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end
end
