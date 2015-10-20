# TODO: Add support for both JSON and HTML

class MapsController < ApplicationController
  before_action :set_map, only: [:show, :edit, :update, :destroy, :points]

  # GET /maps
  # GET /maps.json
  def index
    @maps = Map.all
  end

  # GET /maps/1
  # GET /maps/1.json
  def show
    render json: @map
  end

  # GET /maps/new
  def new
    @map = Map.new
  end

  # GET /maps/1/edit
  def edit

  end

  # POST /maps
  # POST /maps.json
  def create
    # If they have a shareable link, verify that it is acceptable
    @errors = Array.new
    params = map_params
    @map = Map.create(map_params)
    if @map.valid?
      render json: @map
    else
      @errors = @map.errors.messages
      render json: {'errors' => @errors}
    end
  end

  # PATCH/PUT /maps/1
  # PATCH/PUT /maps/1.json
  def update
    # If they have a shareable link, verify that it is acceptable
    # If they change from an existing shareable link, make sure that the old link is freed up
    @errors = Array.new
    params = map_params
    @map = Map.update(map_params)
    if @map.valid?
      render json: @map
    else
      @errors = @map.errors.messages
      render json: {'errors' => @errors}
    end
  end

  def shareable
    # TODO: Find map it belongs to and redirect to that
  end

  # DELETE /maps/1
  # DELETE /maps/1.json
  def destroy
    # If they have a shareable link, make sure it gets deleted as well
    @map.destroy 
  end

  def points
    params = point_params
    dataset_id = @map.dataset_id

    # TODO: later this will be optemized
    redirect_to :controller => 'datasets', :action => 'points', 
      :id => dataset_id, :num_points => params[:num_points],
      :display_val => params[:display_val],
      :filter_val => params[:filter_val]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_map
      @map = Map.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def map_params
      params.permit(:id, :name, :owner, :dataset, :display_variable, :filter_variable, :styling)
    end

    def point_params
      params.permit(:id, :num_points, :display_val, :filter_val)
    end
end