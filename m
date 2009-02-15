Return-Path: <cyrus@holtmann.org>
Subject: Can get skype working with mono bluetooth earpiece, but not stereo
  bluetooth headset
From: "Ted T. Logan" <tedtheologian@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Sun, 15 Feb 2009 14:32:22 -0600
Message-Id: <1234729942.6136.3.camel@home>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have skype working fine with my mono bluetooth earpiece, moto 550, but
I can't get it working correctly with my iogear stereo headset.

I get audio, but the other person/skype test call cannot hear me.
However, I can hear myself echo when I talk.

pcm.bluetoothstereo {
   type bluetooth
     device 00:18:E4:0C:4D:17 #headset
   profile "auto"
}


I do notice I have to remove "profile" line to get it working at all
with skype.

Here's the entry for my WORKING h550
pcm.bluetoothh550 {
   type bluetooth
   device 00:1A:0E:08:03:90 # h550
}


in either case, I choose sound in/out in skype as the device mentioned.

fc10 machine
rpmq bluez
bluez-4.22-2.fc10.i386
bluez-libs-4.22-2.fc10.i386
bluez-cups-4.22-2.fc10.i386
bluez-gnome-1.8-11.fc10.i386
pybluez-0.15-2.fc10.i386
bluez-hcidump-1.42-2.fc10.i386
bluez-alsa-4.22-2.fc10.i386
bluez-libs-devel-4.22-2.fc10.i386
bluez-gstreamer-4.22-2.fc10.i386


