Return-Path: <cyrus@holtmann.org>
Message-ID: <4A2A6021.1070408@wowway.com>
Date: Sat, 06 Jun 2009 07:25:05 -0500
From: "John R." <johnr@wowway.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: aplay: pcm_write:1269: write error: Input/output error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bluez: 4.39
kernel: 2.6.29.2

When attempting to play a wav file I get a short blip of sound but it 
errors out and stops every time:

aplay -D bluetooth ross.wav
Playing WAVE 'ross.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
aplay: pcm_write:1269: write error: Input/output error

If I try and play a stereo 44100 Hz file there is no blip of sound just 
the same error.

Any suggestions on where to look?   I have used AudioDevices Wiki page 
for configuration.

asoundrc:

pcm.bluetoothraw {
   type bluetooth
   device XX:XX:XX:XX:XX:XX
   profile auto
}

pcm.bluetooth {
   type plug
   slave {
        pcm bluetoothraw
   }
}



Thanks,

John
