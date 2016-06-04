class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    puts "Session Instagram: #{session["devise.instagram_data"]}"
  end
end
