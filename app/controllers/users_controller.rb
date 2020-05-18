class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      # Could have also used redirect_to user_url(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      # Adding strong parameters here
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
