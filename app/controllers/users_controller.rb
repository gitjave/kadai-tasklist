class UsersController < ApplicationController
  def show
    if current_user.id == params[:id].to_i
    @user = User.find(params[:id])
    else
    redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      
      flash[:success] = "ユーザー登録成功"
      redirect_to login_url
    else
      flash.now[:danger] = "ユーザー登録失敗"
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
