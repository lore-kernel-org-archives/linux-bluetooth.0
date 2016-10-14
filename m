Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Sebastian Hilbert <sebastian.hilbert@gmx.net>
To: linux-bluetooth@vger.kernel.org
Subject: multiple headsets for voice conference
Date: Fri, 14 Oct 2016 21:59:19 +0200
Message-ID: <5473190.yLOflKejXQ@basti-thinkpad-t410>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I was wondering if the following can be built using bluez. I would like two or 
more people to communicate in something like a voice conference while wearing 
BT headsets. 

I imagine that one can connect multiple BT dongles to a PC and pair each 
headset with one dongle.

As far as I know ALSA can be used to setup the audio devices. Likely a 
soundserver such as JACK2 can be used to manage the audio routing.

Is this the right path ? Or is there another/better way to establish a voice 
connection between multiple headset units ?

Any pointers are appreciated.

Sebastian 
