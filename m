Return-Path: <cyrus@holtmann.org>
Date: Sat, 29 May 2010 18:59:36 +0200
From: Christian Birchinger <joker@netswarm.net>
To: linux-bluetooth@vger.kernel.org
Subject: SCO/audio is causing btusb_send_frame: hci0 urb submission failed
Message-ID: <20100529165936.GA29536@netswarm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

I'm trying to use a bluetooth headset but i get errors from
the btusb module (see below).

The device fully works and plays fine on a Thinkpad R61 and
it's onboard bluetooth:
Bus 001 Device 008: ID 0a5c:2110 Broadcom Corp. Bluetooth Controller
(linux 2.6.33 + bluez 4.64)

It fails with this USB stick though (kernel output below):
Bus 002 Device 005: ID 0a5c:2100 Broadcom Corp. Bluetooth 2.0+eDR dongle
Bus 002 Device 004: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub (part of BCM2046 Bluetooth)
(linux 2.6.34 + bluez 4.64)

It also fails with another stick:
Bus 002 Device 008: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
(same box as with the other stick)
In this case i always get the "submission failed" flood from
below, no matter what sco fix options i use (or none).

I use this to test the setup:
mplayer -ao alsa:device=bluetooth <file>
...
AO: [alsa] 8000Hz 1ch s16le (2 bytes per sample)
...

dmesg btusb (no options):
-------------------
btusb_submit_isoc_urb: hci0 urb ffff88022a09ac00 submission failed (28)
(one single print per attempt)

player hangs after 0.8s and needs to be shut down with ctrl-C.


dmesg btusb (force_scofix=1):
-----------------------
btusb_send_frame: hci0 urb ffff880204416400 submission failed
btusb_send_frame: hci0 urb ffff880204416600 submission failed
btusb_send_frame: hci0 urb ffff88022a108a00 submission failed
(excessive flood)

player acts like it's playing but theres no sound.


Pairing and even button reporting works in all cases. It's only
the audio playback that triggers the player hang and btusb dmesg
output.

The USB dongle works fine with an input device (SixAxis) or file
transfers over obex to/from a phone. It's only audio that fails.

Consulting the btusb.c and comparing the IDs and chips i only
see BTUSB_WRONG_SCO_MTU and therefore force_scofix=1, but that
doesn't solve it.

There have been lots of SCO commits so if any of those changes
could affect me, i'd be really thankfull for pointers.

CU, Christian
