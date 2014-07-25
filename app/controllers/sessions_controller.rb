class SessionsController < ApplicationController
  def index
  end
  def new
  end
  def create
    if params[:email] == "test@test.com" and params[:password] == "sekret"
      redirect_to root_url, notice: "Logged in successfully."
    else
      flash[:error] = "Invalid email or password."
      render 'new'
    end
  end
end
