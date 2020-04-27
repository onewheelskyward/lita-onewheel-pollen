require 'spec_helper'

def mock_up(filename)
  mock = File.open("spec/fixtures/#{filename}.html").read
  allow(RestClient).to receive(:get) { mock }
end

describe Lita::Handlers::OnewheelPollen, lita_handler: true do
  it 'pollens' do
    # mock_up ''
    send_command 'pollen'
    expect(replies.last).to include("\u000314NASDAQ - \u0003LULU: \u000302$233.01\u0003")
    expect(replies.last).to include('(Lululemon Athletica Inc.)')
  end
end
