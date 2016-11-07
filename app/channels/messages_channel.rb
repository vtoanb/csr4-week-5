# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(content)
    @message = Message.new content: content['message']
    @message.ip = 'noip'
    if @message.save
      ActionCable.server.broadcast('messages', action: 'append', data: render_message(@message))
    else
    end
  end

  def test(data)
    ActionCable.server.broadcast('messages', action: 'append', data: "Test: #{data}")
  end


  private

  def render_message(message)
    ApplicationController.render(
      partial: 'messages/message',
      locals: {message: message}
    )
  end
end
