Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: bluetooth a2dp sink w/o pulseaudio
Date: Mon, 24 Jun 2013 15:51:05 -0400
Message-ID: <82D0F41172C8884FA074EBCBCC9AD5464456A6@FLINT.pickering.lenbrook.com>
From: "Clint Reitsma" <CReitsma@lenbrook.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have spent some time trying to get an A2DP audio sink working with the
alsa plugin but have had no luck (bluez 4.101 using bluez-tools).  I see
the alsa plugin has been removed in bluez 5 and everyone is using the
pulse audio plugin; but this isn't an option on our system as we can't
run pulseaudio.  Has anyone had an a2dp stereo sink working with just
the alsa plugin?  The sink shows up on an iPad and I play audio but the
stream seems to keep suspending:

bluetoothd[24673]: audio/avdtp.c:avdtp_parse_cmd() Received START_CMD
bluetoothd[24673]: audio/a2dp.c:start_ind() Sink 0x54b50758: Start_Ind
bluetoothd[24673]: audio/avdtp.c:avdtp_ref() 0x54b57388: ref=3
bluetoothd[24673]: audio/avdtp.c:avdtp_sep_set_state() stream state
changed: OPEN -> STREAMING
bluetoothd[24673]: audio/avdtp.c:avdtp_unref() 0x54b57388: ref=2
bluetoothd[24673]: audio/avdtp.c:session_cb()
bluetoothd[24673]: audio/avdtp.c:avdtp_parse_resp() SUSPEND request
succeeded
bluetoothd[24673]: audio/avdtp.c:avdtp_sep_set_state() stream state
changed: STREAMING -> OPEN
bluetoothd[24673]: audio/a2dp.c:suspend_cfm() Sink 0x54b50758:
Suspend_Cfm
bluetoothd[24673]: audio/avdtp.c:session_cb()
bluetoothd[24673]: audio/avdtp.c:avdtp_parse_cmd() Received START_CMD


I tried tracing through an "arecord -f cd -c 2 -D Bluetooth | aplay" but
it was failing on the refine capabilities.  First without a supported
channel format so I added "mode stereo" to asound.conf.  Then channels
succeeded but was saying no supported formats.  

If the alsa plugin does not work for a stereo a2dp sink, I am wondering
if anyone can help me with a simple method that can pipe audio straight
to aplay, is this possible?  Any programs or scripts that can do this?  

If not, would my best option be looking through the pulseaudio plugin
and writing a standalone program to do the same thing except?
Appreciate any help you can give.  

Regards,
Clint

