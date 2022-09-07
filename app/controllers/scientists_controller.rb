class ScientistsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable
    
    def index
        render json: Scientist.all
    end

    def show
        scientist = find_scientist
        render json: scientist, serializer: ScientistShowSerializer
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist
    end

    def update
        scientist = find_scientist
        scientist.update!(scientist_params)
        render json:scientist
    end

    def destroy
        scientist = find_scientist
        scientist.destroy
        head :no_content
    end

    private

    def find_scientist
        Scientist.find_by!(id:params[:id])
    end

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

    def render_not_found(invalid)
        render json: {error: "Scientist not found"}, status: :not_found
    end

    def render_unprocessable(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: 422
    end


end
