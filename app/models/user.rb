class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:instagram]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).take
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.instagram_data"]
        user.uid = data["uid"]
        user.provider = data["provider"]
        user.password = Devise.friendly_token
      end
    end
  end
end
