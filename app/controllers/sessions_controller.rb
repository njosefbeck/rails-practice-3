class SessionsController < ApplicationController

  def new
  end

  def create
    # The @ here makes this an instance variable
    @user = User.find_by(email: params[:session][:email].downcase)
    # below also could be written: user && user.authenticate
    if @user&.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
