class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      if @user.activated?
        log_in @user
        remember_user user
        redirect_to @user
      else
        flash[:warning] = t "sessions.create.account_not_activated"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "error"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def remember_user user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
