Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4E6A0ED1.5050802@gmail.com>
References: <4E6A0ED1.5050802@gmail.com>
From: Alexander Skwar <alexanders.mailinglists+nospam@gmail.com>
Date: Tue, 13 Sep 2011 12:31:47 +0200
Message-ID: <CADn-QaMAK7eZKWcr4ZJS3hvwkHQbYUBMpCMi-5jE3AH1k4TE-Q@mail.gmail.com>
Subject: Re: Audio output (a2dp) is skipping a lot
To: linux-bluetooth Mailingliste <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello again.


On Fri, Sep 9, 2011 at 15:04, Alexander Skwar
<alexanders.mailinglists+nospam@gmail.com> wrote:
> Hi.
>
>
> I've got an Arctic P311 bluetooth headset[1] and on my PC, I'm using
> a Hama Nano-Bluetooth-USB-Adapter Version 3.0+EDR Class1 dongle[2].
> The system is a openSUSE 11.4 64bit PC with KDE 4.6.0 and PulseAudio
> pulseaudio-0.9.22-6.11.1.x86_64.



I've got a "new"/"different" Bluetooth dongle, which seems to be the
same device...

In lsusb:

Bus 001 Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)

With this new BT dongle, sound is just as skippy as it was with my "old"
bluetooth dongle.

I think this allows to rule out the assumption, that the BT dongle is
broken. As the headsets work just fine on Android and on OS X, I think
we can also conclude that the headsets are okay.

Why is it, that Linux is unable to keep up a good connection to the BT
headset and thus is skipping *a lot*?

Distance between BT dongle and headset: Tested from a few centimeters
to 1-2 meters. Direct line of sight. Normal office environment.

Could somebody with better knowledge maybe try to explain why this is
so bad? :(


Thanks a lot,
Alexander



> I noticed, that the audio output in a2dp mode is quite "jerky" (haven't
> tried the mono hsp mode). Not really surprisingly, I found a lot of
> messages like the following in my /var/log/messages, when I grep for
> "pulseaudio"[3]:
>
> […]
> Sep  9 11:37:38 ewzw032 pulseaudio[2984]: module-bluetooth-device.c:
> Skipping 296858 us (= 52364 bytes) in audio stream
> […]
>
> Sound thus sounds terrible.
>
> When I then disconnect the Bluetooth connection and connect again, sound
> is fine. At least most of the time - earlier today, sound was messed
> up also right after building the connection.
>
> Normally, I play music with Amarok. But I found, that even much more
> simple commands like the following create bad output:
>
>  paplay -d bluez_sink.00_1A_7D_60_67_1F -p /usr/share/sounds/pop.wav
>
>  env PULSE_SINK=bluez_sink.00_1A_7D_60_67_1F \
>    mpg123 -a pulse /home/ask/tmp/Test.mp3
>
> In "lsusb", the BT dongle is this:
>
> Bus 001 Device 048: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> Dongle (HCI mode)
>
> You can find the "lsusb -v" output for this device on pastebin[4].
>
> Is there anything that can be done about this?
>
>
> Links:
>
> [1] Arctic P311 -> http://www.arctic.ac/en/p/sound/headsets/35/p311.html
> [2] Hama BT Dongle -> http://x.co/Zaev -->
> http://www.hama.de/portal/articleId*28219728/action*2563/searchMode*1/bySearch*49238
> [3] /var/log/messages -> http://pastebin.com/vUMEY9R4
> [4] lsusb -v -d 0a12:0001 -> http://pastebin.com/xzYSWB9w
>
>
> Best regards,
>
> Alexander
> --
> ↯     Lifestream (Twitter, Blog, …) ↣ http://sup.skwar.me/     ↯
> ↯  Chat (Jabber/Google Talk) ↣ a@skwar.me ; Twitter: @alexs77  ↯
>



-- 
Alexander
--
↯    Lifestream (Twitter, Blog, …) ↣ http://alexs77.soup.io/     ↯
↯ Chat (Jabber/Google Talk) ↣ a.skwar@gmail.com , AIM: alexws77  ↯
