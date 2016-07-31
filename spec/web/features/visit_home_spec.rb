require 'features_helper'

describe 'Visit home page' do
  it 'is successfull' do
    visit '/'

    page.body.must_include 'Bookshelf'
  end
end
