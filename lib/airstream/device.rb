
module Airstream

  class Device

    attr_reader :player, :video_title

    def initialize(receiver)
      @receiver = receiver
    end

    def file=(file)
      if file.class == Video
        self.video = file
      # when
        # TODO Image then self.image = file
      else
        raise "Unknown file type send to device"
      end
      block_while_loading
    end

    def block_while_loading
      sleep 0.2 until position != 0
    end

    def image=(image_file)
      @receiver.send_image image_file
    end

    def video=(video)
      @player = @receiver.send_video video.url
      @video_title = video.to_s
    end

    def pause
      @player.pause
    end

    def resume
      @player.resume
    end

    def scrub(seconds=nil)
      @player.scrub seconds
    end

    def duration
      self.scrub["duration"]
    end

    def position
      self.scrub["position"]
    end
  end
end
