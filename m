Return-Path: <cyrus@holtmann.org>
Message-ID: <4E6A0ED1.5050802@gmail.com>
Date: Fri, 09 Sep 2011 15:04:17 +0200
From: Alexander Skwar <alexanders.mailinglists+nospam@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth Mailingliste <linux-bluetooth@vger.kernel.org>
Subject: Audio output (a2dp) is skipping a lot
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.


I've got an Arctic P311 bluetooth headset[1] and on my PC, I'm using
a Hama Nano-Bluetooth-USB-Adapter Version 3.0+EDR Class1 dongle[2].
The system is a openSUSE 11.4 64bit PC with KDE 4.6.0 and PulseAudio
pulseaudio-0.9.22-6.11.1.x86_64.

I noticed, that the audio output in a2dp mode is quite "jerky" (haven't
tried the mono hsp mode). Not really surprisingly, I found a lot of
messages like the following in my /var/log/messages, when I grep for
"pulseaudio"[3]:

[…]
Sep  9 11:37:38 ewzw032 pulseaudio[2984]: module-bluetooth-device.c: 
Skipping 296858 us (= 52364 bytes) in audio stream
[…]

Sound thus sounds terrible.

When I then disconnect the Bluetooth connection and connect again, sound
is fine. At least most of the time - earlier today, sound was messed
up also right after building the connection.

Normally, I play music with Amarok. But I found, that even much more
simple commands like the following create bad output:

   paplay -d bluez_sink.00_1A_7D_60_67_1F -p /usr/share/sounds/pop.wav

   env PULSE_SINK=bluez_sink.00_1A_7D_60_67_1F \
     mpg123 -a pulse /home/ask/tmp/Test.mp3

In "lsusb", the BT dongle is this:

Bus 001 Device 048: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth 
Dongle (HCI mode)

You can find the "lsusb -v" output for this device on pastebin[4].

Is there anything that can be done about this?


Links:

[1] Arctic P311 -> http://www.arctic.ac/en/p/sound/headsets/35/p311.html
[2] Hama BT Dongle -> http://x.co/Zaev --> 
http://www.hama.de/portal/articleId*28219728/action*2563/searchMode*1/bySearch*49238
[3] /var/log/messages -> http://pastebin.com/vUMEY9R4
[4] lsusb -v -d 0a12:0001 -> http://pastebin.com/xzYSWB9w


Best regards,

Alexander
-- 
↯     Lifestream (Twitter, Blog, …) ↣ http://sup.skwar.me/     ↯
↯  Chat (Jabber/Google Talk) ↣ a@skwar.me ; Twitter: @alexs77  ↯
