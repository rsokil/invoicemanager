class EstimatesController < ApplicationController
  before_action :set_estimate, only: [:show, :edit, :update, :destroy, :preview,
                                      :mail, :duplicate, :mark_as_sent, :close]

  # GET /estimates
  # GET /estimates.json
  def index
    @estimates = current_user.estimates.all
  end

  # GET /estimates/1
  # GET /estimates/1.json
  def show
  end

  # GET /estimates/new
  def new
    @estimate = current_user.estimates.new
    @estimate.items.build
  end

  # GET /estimates/1/edit
  def edit
  end

  # POST /estimates
  # POST /estimates.json
  def create
    @estimate = current_user.estimates.new(estimate_params)
    respond_to do |format|
      if @estimate.save
        format.html { redirect_to @estimate, notice: 'Estimate was successfully created.' }
        format.json { render :show, status: :created, location: @estimate }
      else
        format.html { render :new }
        format.json { render json: @estimate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estimates/1
  # PATCH/PUT /estimates/1.json
  def update
    respond_to do |format|
      if @estimate.update(estimate_params)
        format.html { redirect_to @estimate, notice: 'Estimate was successfully updated.' }
        format.json { render :show, status: :ok, location: @estimate }
      else
        format.html { render :edit }
        format.json { render json: @estimate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estimates/1
  # DELETE /estimates/1.json
  def destroy
    @estimate.destroy
    respond_to do |format|
      format.html { redirect_to estimates_url, notice: 'Estimate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def preview
    respond_to do |format|
      format.pdf do
        render :pdf => 'index'
      end
    end
  end

  def mail
    @estimate.mail!
    respond_to do |format|
      format.html { redirect_to estimates_url(@estimate), notice: 'Estimate was Mailed successfully.' }
      format.json { head :no_content }
    end
  end

  def duplicate
    @estimate.duplicate!
    respond_to do |format|
      format.html { redirect_to estimates_url(@estimate), notice: 'Estimate was marked as duplicate.' }
      format.json { head :no_content }
    end
  end

  def close
    @estimate.close!
    respond_to do |format|
      format.html { redirect_to estimates_url(@estimate), notice: 'Estimate was closed.' }
      format.json { head :no_content }
    end
  end

  def mark_as_sent
    @estimate.mark_as_sent!
    respond_to do |format|
      format.html { redirect_to estimates_url(@estimate), notice: 'Estimate was marked as Mailed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estimate
      @estimate = current_user.estimates.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estimate_params
      params.require(:estimate).permit(:summary, :receiver_tokens, :date, :estimate_number,
                                       :due_on, :estimate_notes, :id, items_attributes: [ :id, :estimate_category_tokens, :quantity,
                                                                    :rate, :amount, :_destroy])
    end

end
