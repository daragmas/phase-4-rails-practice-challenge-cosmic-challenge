class MissionsController < ApplicationController

    def create
        mission = Mission.create!(params.permit(:name, :scientist_id, :planet_id))
        planet = Planet.find_by!(id:params[:planet_id])
        render json: planet
        rescue_from ActiveRecord::RecordInvalid => invalid
            render json: {errors: invalid.record.errors.full_messages}, status: :unpocessable_entity
    end
end
