class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :new, :create, :edit, :update, :destroy, :task_params]
  before_action :correct_user, only:[:destroy]
  
  def index
    if logged_in?
    redirect_to current_user
    end
  end

  def show
    if current_user.tasks.find_by(id: params[:id].to_i)
    @task = current_user.tasks.find_by(id: params[:id].to_i)
    else
      redirect_to root_url
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクが正常に投稿されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクが投稿されませんでした"
      render :new
    end
  end

  def edit
    unless @task = current_user.tasks.find_by(id: params[:id].to_i)
    redirect_to root_url
    end
    
  end

  def update
    unless @task = current_user.tasks.find_by(id: params[:id])
    redirect_to root_url
    end
    
    if @task.update(task_params)
      flash[:success] ="タスクは正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクは更新されませんでした"
      render :edit
    end      
  end

  def destroy
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to tasks_url
  end
  
  private
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
