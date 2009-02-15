Return-Path: <cyrus@holtmann.org>
Subject: how to set default alsa pcm device as bluetooth, so i can play
 flash  in firefox to bluetooth headset?
From: "Ted T. Logan" <tedtheologian@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Sun, 15 Feb 2009 14:33:37 -0600
Message-Id: <1234730017.6136.4.camel@home>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 I did this, but no go:

pcm.bluetoothstereo {
   type bluetooth
     device 00:18:E4:0C:4D:17 #headset
   profile "auto"
}

pcm.!default
{
        type plug
        slave.pcm "bluetoothstereo"

}




I can do things like
mplayer -ao alsa:device=bluetoothstereo

with no problem, and I hear fine through the headset.  However, I'd like
to be able to play flash audio from firefox through the headset.  What
am i doing wrong?

rpmq bluez
bluez-hcidump-1.42-2.fc10.i386
bluez-libs-4.22-2.fc10.i386
bluez-4.22-2.fc10.i386
bluez-gstreamer-4.22-2.fc10.i386
bluez-gnome-analyzer-1.8-11.fc10.i386
bluez-libs-devel-4.22-2.fc10.i386
bluez-gnome-1.8-11.fc10.i386
bluez-alsa-4.22-2.fc10.i386
bluez-cups-4.22-2.fc10.i386

