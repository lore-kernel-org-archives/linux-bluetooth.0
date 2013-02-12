Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPjuhm5ojRkhYBa3n_N1XBkQfE1xpM-uXekLDCgXqFFs-psWNw@mail.gmail.com>
References: <CAPjuhm59ObSQvs5eF1-2wRg239ht3wXmRq=_7dD1wza5hLPo9A@mail.gmail.com>
	<CAPjuhm5ojRkhYBa3n_N1XBkQfE1xpM-uXekLDCgXqFFs-psWNw@mail.gmail.com>
Date: Tue, 12 Feb 2013 16:17:06 -0500
Message-ID: <CAPjuhm4P9ze35fdmPnN3JQ_QhTRvAPTN9q8gNivTuYoSau_eKQ@mail.gmail.com>
Subject: Fwd: Beginner Using a2dpsink, avdtpsink, and rtpsbcpay
From: John Westing <john.blank.westing@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm using Ubuntu 12.04 and was hoping to payload and send MP3s using
Bluetooth and the BlueZ GStreamer plugin. My first test was to see if
I could stream SBC audio so I used the following command

gst-launch filesrc location=~/music/song.mp3 ! flump3dec ! sbcenc !
a2dpsink device=00:01:1A:FA:5C:AA

and it streamed correctly. Next I wanted to see if I could use the
rtpsbcpay RTP payloader element, so executed the command

gst-launch filesrc location= ~/music/song.mp3 ! flump3dec ! sbcenc !
rtpsbcpay min-frames=-1 ! avdtpsink device= 00:01:1A:FA:5C:AA

but it failed with the following errors:

Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
0:00:02.056144952 2475 0x8cdb690 ERROR avdtpsink
audio/gstavdtpsink.c:1912:gst_avdtp_sink_audioservice_recv:<avdtpsink0>
BT_START_STREAM failed : Success(0)
0:00:02.057025034 2475 0x8cdb690 ERROR avdtpsink
audio/gstavdtpsink.c:1507:gst_avdtp_sink_stream_start:<avdtpsink0>
Error while stream start confirmation
0:00:02.063086880 2475 0x8cdb690 WARN basesrc
gstbasesrc.c:2625:gst_base_src_loop:<filesrc0> error: Internal data
flow error.
0:00:02.063446032 2475 0x8cdb690 WARN basesrc
gstbasesrc.c:2625:gst_base_src_loop:<filesrc0> error: streaming task
paused, reason error (-5)
ERROR: from element /GstPipeline:pipeline0/GstFileSrc:filesrc0:
Internal data flow error.
Additional debug info:
gstbasesrc.c(2625): gst_base_src_loop ():
/GstPipeline:pipeline0/GstFileSrc:filesrc0:
streaming task paused, reason error (-5)
ERROR: pipeline doesn't want to preroll.
Setting pipeline to NULL ...
Freeing pipeline ...

I looked at the code for a2dpsink and it simply loads the 2 elements
into a GstBin, I don't see why the functionality would be different
when using rtpsbcpay and avdtpsink explicitly.

If I can't use the rtpsbcpay element to payload SBC data I'm not going
be able to paylod MP3 data either. Does anyone have any idea what the
problem is?

John
