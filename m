Return-Path: <cyrus@holtmann.org>
Message-ID: <4920099A.9030109@powercraft.nl>
Date: Sun, 16 Nov 2008 12:52:58 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: possible sbc codec bug with audio glitches
Content-Type: multipart/mixed;
 boundary="------------010804060207080902070805"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010804060207080902070805
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everybody,

At celinux 2008 this month I talked to Marcel Holtmann and showed him
some issues I encountered with bluez.

One of my bigger issues is that I got audio glitches when listing to
high quality audio (dvds) with an sensitive DJ bluetooth headset.

I let Marcel listen to the problem and he also hears them and things it
may be something with the SBC codec. But since Marcel is no expert on
the SBC codec part, we would like to ask for the help of others to solve
this issue.

The glitches/distortions can be heard on a Motorola Bluetooth S805
stereo headset and listing to a dvd audio for example intro music of
Stargate Atlantis.

The strange thing is that I can only hear the glitches on the right side
of the headset.

I reported my first encounter with the issue on may 2008:
http://sourceforge.net/mailarchive/message.php?msg_name=4819B1A7.2070702%40powercraft.nl

I hope somebody would be willing/able to help out. I have seen some very
nice post about the bad performance of the SBC codec, and I hope you
guys can also have a look at this.

Best regards,

Jelle


--------------010804060207080902070805
Content-Type: application/x-sh;
 name="setup-bluetooth-motorola-s805.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup-bluetooth-motorola-s805.sh"

#!/bin/bash

echo "setup-bluetooth-motorola-s805.sh"

echo 'pcm.headset {
    type bluetooth
    #~ device 00:0D:18:A0:35:70
    #~ device 00:53:53:FB:7E:9C # Nokia BH-801
    device 00:0C:55:D1:C9:78 # Motorola S805
    #~ device 00:0D:FD:18:6E:3C # Motorola S9
    #~ device 20:07:09:15:A9:5A # Samsung WEP210
    profile hifi
    #~ profile voice
    #profile auto
}
pcm.softvol {
    type softvol
    slave.pcm headset
    control.name Headset
    control.card 0
}
pcm.!default {
    #~ type hw
    #~ card 0
    type plug
    slave.pcm softvol
}' > ~/.asoundrc

#~ sudo /etc/init.d/bluetooth restart
#~ sudo /etc/init.d/alsa-utils restart

echo "done, you can close this windows now"

exit


--------------010804060207080902070805--
