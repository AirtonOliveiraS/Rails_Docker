class UserEnrollmentsController < ApplicationController
  before_action :set_user_enrollment, only: %i[ show edit update destroy ]
  before_action :require_user_logged_in!, only: [:show, :edit, :create, :update]
  skip_before_action :verify_authenticity_token

  # GET /user_enrollments
  def index
    @user_enrollments = UserEnrollment.all
  end

  # GET /user_enrollments/1
  def show
  end

  # GET /user_enrollments/new
  def new
    @user_enrollment = UserEnrollment.new
  end

  # GET /user_enrollments/1/edit
  def edit
  end

  # POST /user_enrollments
  def create
    usuario_id = Current.user.id
    request_params = params["user_enrollment"]
    academium_name = request_params["academium_name"]
    academium_id = Academium.where(nome: academium_name).pluck(:id).first
    @user_enrollment = UserEnrollment.new(usuario_id: usuario_id, academium_id: academium_id, active: true)

    if @user_enrollment.save
      redirect_to @user_enrollment, notice: "User enrollment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_enrollments/1
  def update
    if @user_enrollment.update(user_enrollment_params)
      redirect_to @user_enrollment, notice: "User enrollment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /user_enrollments/1
  def destroy
    @user_enrollment.destroy
    redirect_to user_enrollments_url, notice: "User enrollment was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_enrollment
      @user_enrollment = UserEnrollment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_enrollment_params
      params.require(:user_enrollment).permit(:active, :usuario_id, :academium_id)
    end
end
