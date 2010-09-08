Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 7 Sep 2010 20:35:20 -0500
Message-ID: <AANLkTi=Q=E2uUBXuyBuOdrxiyWU+meiFLkaef3xvwQ1=@mail.gmail.com>
Subject: MP3 over A2DP issue
From: pl bossart <bossart.nospam@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I have been doing some experiments to extend PulseAudio to support
compressed data, so that the audio routing is simplified a great deal.
I've already completed the work for AC3 passthrough over SPDIF/HDMI,
works fine and the concept holds water.
Now I am trying to send MP3 over A2DP through PulseAudio. I removed
SBC encoding, detect mp3 frames and handle timings, now I am almost
done and of course I am stuck with a stupid issue.
I can't seem to open an MP3 connection to my Nokia BH-103 headset, for
some reason the BT_OPEN request fails. Here's the log I am getting.

D: module-bluetooth-device.c: Connected to the bluetooth audio service
D: module-bluetooth-device.c: Sending BT_REQUEST -> BT_GET_CAPABILITIES
D: module-bluetooth-device.c: Trying to receive message from audio service...
D: module-bluetooth-device.c: Received BT_RESPONSE <- BT_GET_CAPABILITIES
D: module-bluetooth-device.c: Payload size is 26 6
E: module-bluetooth-device.c: BT Codec: seid 1 transport 0 type 1
length 13 configured 1 lock 0 data 15
E: module-bluetooth-device.c: BT Codec: seid 2 transport 0 type 3
length 13 configured 0 lock 0 data 15
E: module-bluetooth-device.c: MPEG caps detected
E: module-bluetooth-device.c: channel_mode 15 crc 1 layer 1 frequency
7 mpf 0 bitrate 65279
E: module-bluetooth-device.c: mpeg seid 2
E: module-bluetooth-device.c: SBC caps detected
E: module-bluetooth-device.c: channel_mode 15 frequency 15
allocation_method 3 subbands 3 block_length 15 min_bitpool 2
max_bitpool 51
E: module-bluetooth-device.c: sbc seid 1
D: module-bluetooth-device.c: Got device capabilities
D: module-bluetooth-device.c: Sending BT_REQUEST -> BT_OPEN
D: module-bluetooth-device.c: Trying to receive message from audio service...
D: module-bluetooth-device.c: Received BT_ERROR <- BT_OPEN
E: module-bluetooth-device.c: Received error condition: Invalid argument
E: module-bluetooth-device.c: BT_OPEN expect failed
I: card.c: Changed profile of card 1 "bluez_card.00_0B_

And here's the log using the gstreamer ad2p sink, it shows the same
type of error (but this time this isn't my code...):
[ume@localhost bluez]$ gst-launch filesrc
location=~/AURAL/Audio/maxwork.mp3 ! mp3parse ! a2dpsink
device=00:0B:E4:94:31:9D
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
0:00:00.021572200  4939  0x95df668 ERROR              avdtpsink
audio/gstavdtpsink.c:1328:gst_avdtp_sink_audioservice_recv:<avdtpsink>
BT_OPEN failed : Invalid argument(22)
0:00:00.021609480  4939  0x95df668 ERROR              avdtpsink
audio/gstavdtpsink.c:1085:gst_avdtp_sink_configure:<avdtpsink> Error
while receiving device confirmation
WARNING: from element
/GstPipeline:pipeline0/GstA2dpSink:a2dpsink0/GstAvdtpSink:avdtpsink:
Internal data flow problem.
Additional debug info:
gstbasesink.c(3436): gst_base_sink_chain_unlocked ():
/GstPipeline:pipeline0/GstA2dpSink:a2dpsink0/GstAvdtpSink:avdtpsink:
Received buffer without a new-segment. Assuming timestamps start from 0.
0:00:00.021884764  4939  0x95df668 ERROR              avdtpsink
audio/gstavdtpsink.c:1328:gst_avdtp_sink_audioservice_recv:<avdtpsink>
BT_START_STREAM failed : Success(0)
0:00:00.021904018  4939  0x95df668 ERROR              avdtpsink
audio/gstavdtpsink.c:937:gst_avdtp_sink_stream_start:<avdtpsink> Error
while stream start confirmation
ERROR: from element /GstPipeline:pipeline0/GstFileSrc:filesrc0:
Internal data flow error.

SBC connections work fine with gst-launch filesrc
location=~/AURAL/Audio/viol-1mn.wav ! wavparse ! sbcenc ! a2dpsink
device=00:0B:E4:94:31:9D

So is there something wrong with this specific headset, am I doing
anything wrong in the configuration? And what can I do in terms of
instrumentation to find the issue?
Or is it an issue with a bad seid reported by the device? When I use
the SBC seid in the BT_OPEN request, the open works fine. As soon as I
use the mpeg seid, things go south.

Bear with me, I am far from my audio comfort zone here. Any pointers
would be appreciated.
Thanks,
-Pierre
