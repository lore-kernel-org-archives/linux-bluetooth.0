Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Jun 2009 07:23:17 +0200
Subject: Mixed Results Playing mp3
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E06B17B90@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've been trying various tools to play mp3 files to a Bluetooth headset whilst I decide whether to buy some a2dp headphones . Using the following and the .asoundrc at the bottom of the post:

bluez-4.41
dbus-1.2.14
dbus-glib-0.80
alsa-1.0.20
kernel-2.6.29.2

I get the following results:

1. mplayer-gtk1 (svn 29308): plays without problems

2. xmms-1.2.11: no error messages, but produces "noise" and "clicks" (the bluez wiki mentions "issues" with xmms).

3. aplay-1.0.20: Is it possible to play mp3 with aplay, if so, what command is required?

4. mpg123-1.8.1: "mpg123 -v -a plug:bluetooth file.mp3", "mpg123 -v -a bluetooth file.mp3", no error messages, but produces "noise" and "clicks"

I don't see why xmms and mpg123 wouldn't work and there are no error messages or pointers from "bluetoothd -dn" - does anybody have any ideas?

-----------
pcm.rawbluetooth {
   type bluetooth
   device 00:12:EE:A6:1D:F4
}

pcm.bluetooth {
   type plug
   slave {
      pcm {
         type bluetooth
         device 00:12:EE:A6:1D:F4
      }
   }
}
