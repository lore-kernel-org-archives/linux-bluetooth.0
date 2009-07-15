Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jul 2009 23:49:10 +0900
From: Chan-Yeol Park <chanyeol.park@samsung.com>
Subject: Is it possible that user change a stream path between Speaker and
 Bluetooth like normal phone?
In-reply-to: <2d5a2c100901050453w403ee755u61549a52b6514b65@mail.gmail.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-id: <002301ca055b$69c4fa00$3d4eee00$%park@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
References: <200812301246.25781.siarhei.siamashka@nokia.com>
 <200901051027.57446.siarhei.siamashka@nokia.com>
 <2d5a2c100901050453w403ee755u61549a52b6514b65@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

If you know or possible,
Could you explain me how to change stream path between Speaker or Bluetooth
with BlueZ gstreamer plug-in like normal phone?

In my case, I could see it works well with a gstreamer output-selector
element except some case.

1. User listens to Bluetooth Stereo Audio.
2. Switch off the headset when stream position is about 5 second from the
start of the song.
3. Gstreamer Plug-in gst_avdtp_sink_render() we could see
g_io_channel_write()works well even though headset is already off.
4. When stream position is about 9 second, g_io_channel_write() function is
blocked....-.-;
5. When it is 14 second , g_io_chhanel_write() returns with timeout error.

It's problem that at 14 second , gstreamer could not do anything even if
they know the error...

Related to this scenario , Do you have a good idea?

As a matter of fact, I try to avoid blocking , I change g_io_channel_write()
as non-blocking call.
Because Non blocking call makes the situation to the gstreamer like normal
condition. So we can change it easily as usual.

But the side effects occurs that music stream is mixed..when wireless
communication doesn't work well-.-;



Regards.
Chanyeol




