class ApplicationController < ActionController::Base
	include Pundit
	include ProjectsHelper

	protect_from_forgery
	protect_from_forgery with: :exception

	before_action :authenticate_user!, except: [:home_page]

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	private

		def user_not_authorized(exception)
			policy_name = exception.policy.class.to_s.underscore

			flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
			redirect_to(root_path)
		end
end
