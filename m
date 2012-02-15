Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Feb 2012 09:17:11 +0100
From: Fabrice DELENTE <delentef@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Wireless bluetooth headset
Message-ID: <20120215081711.GA4385@smtp.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

I'd like to use my bluetooth headset in linux; I have successfully
paired and used it with my cell phone and an android tablet. But I
can't get mplayer in linux to output its sound there.

I have tried the test-audio script (in bluez-49.8/test) to
successfully establish a connection to the headset, but when I try
with mplayer, I get

# mplayer -ao alsa:device=btheadset file.mp3
...snip...
bt_audio_service_open: connect() failed: Connection refused (111)
[AO_ALSA] Playback open error: Connection refused
Failed to initialize audio driver 'alsa:device=btheadset'
Could not open/initialize audio device -> no sound.
Audio: no sound
Video: no video


Exiting... (End of file)

so there seems to be a connection problem (I have configured the
"btheadset" pcm in my .asoundrc:

pcm.btheadset {
type bluetooth
device "00:18:91:D0:7A:24"
profile "auto"
}
ctl.btheadset {
type bluetooth
}
)

When I tried simple-agent to register the PIN of the set, I get

# ./simple-agent hci0 $HEAR01
Creating device failed: org.bluez.Error.AlreadyExists: Already Exists

so the PIN must already be registered.

What must I do next? This is under Slackware linux, so I can't use
gnome or KDE tools; I have successfully used the set in Ubuntu by the
way).

Thanks!

-- 
F. Delente
