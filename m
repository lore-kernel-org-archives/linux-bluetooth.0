Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 16:42:55 +0100
From: Fabrice DELENTE <delentef@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Using a headset: alsa says connection refused?
Message-ID: <20120217154255.GA3377@smtp.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

I have a bluetooth headset that I have successfully used with a cell
phone and an Android tablet.

I'd like to use it with mplayer on may laptop (under Slackware 13.37).

I have the BT address, and the test-audio script in bluez-4.98/test
works (at least, I hear two beeps in the headphone, and hcitool con
shows

# hcitool con 
Connections:
        < ACL 00:18:91:D0:7A:24 handle 42 state 1 lm MASTER AUTH ENCRYPT

so I guess it is possible to connnect to the device. However, if I try
hcitool cc $HEADSET, the connection is closed immediately...)

I created an ~/.asoundrc with:

pcm.btheadset {
   type plug
   slave {
       pcm {
           type bluetooth
           device "00:18:91:D0:7A:24"
           profile "auto"
       }   
   }   
   hint {
       show on
       description "BlueTooth Halterrego H.EAR 01 Headset"
   }   
}
ctl.btheadset {
  type bluetooth
}

but when I try to use it with mplayer:

# mplayer -ao alsa:device=btheadset file.mp3

I get

bt_audio_service_open: connect() failed: Connection refused (111)
[AO_ALSA] Playback open error: Connection refused
Failed to initialize audio driver 'alsa:device=btheadset'
Could not open/initialize audio device -> no sound.
Audio: no sound
Video: no video


Exiting... (End of file)

What did I miss? (I recompiled bluez with support for alsa and alsa
with support for bluetooth)

Thanks!

-- 
F. Delente
