require 'active_record/spec_helper'
require_all File.dirname(__FILE__) + "/../../shared/" 

def preconfigure
  CanTango.configure do |config|
    config.permit_engine.set :on
    config.permission_engine.set :off
  end
end

describe 'Licenses usage' do
  context 'Musicianslicense applied to UserRolePermit' do
    before(:each) {
      preconfigure
      @user = User.create!(:email => "kris@gmail.com", :role => 'user')
    }

    let(:current_user) { @user }
    let(:ability) { current_user_ability(:user) }

    it "should be allowed to read Song" do
      ability.should be_allowed_to(:read, Song)
    end

    it "should be allowed to write Tune" do
      ability.should be_allowed_to(:write, Tune)
    end

    it "should be allowed to manage Concerto" do
      ability.should be_allowed_to(:read, Concerto)
    end

    it "should be allowed to write Tune" do
      ability.should_not be_allowed_to(:manage, Improvisation)
    end
  end
end
