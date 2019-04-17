class TuteesController < ApplicationController

  def tutee_params
    params.require(:tutee).permit(:first_name, :last_name, :sid, :priviledge, :email, :birthdate, :gender, :ethnicity,
                                  :major, :dsp, :transfer, :year, :pronoun)
  end

  def login
    @tutee = Tutee.where(:email => params[:email].downcase).first()
    if not @tutee.nil? then redirect_to tutee_path(@tutee) else redirect_to new_tutee_path end
  end

  def index
  end

  def show
    @courses = [Course.find_by_semester(Course.current_semester)]
    @requests = Request.where(:tutee_id => params[:id])
    @tutee = Tutee.find_by_id(params[:id])
  end

  def new
  end

  def edit
    @tutee = Tutee.find params[:id]
  end

  def create
    tutee_params[:email] = tutee_params[:email].downcase!
    @tutee = Tutee.create!(tutee_params)
    flash[:message] = "Account for #{@tutee.first_name} was successfully created."
    redirect_to tutee_path(@tutee)
  end

  def update
    @tutee = Tutee.find params[:id]
    tutee_params[:email] = tutee_params[:email].downcase!
    @tutee.update!(tutee_params)
    flash[:message] = "Information was successfully updated."
    redirect_to tutee_path(@tutee)
  end

  def destroy
  end
end
