Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 29 Mar 2009 03:28:18 -0700
Message-ID: <7337540c0903290328o57d99321h638315cdf79c8e52@mail.gmail.com>
Subject: Flood of "urb ... submission failed" with bluetooth headset
From: Ludovico Cavedon <ludovico.cavedon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

When I try to play some audio on the my bluetooth headset, my syslog
is flooded with messages like

btusb_send_frame: hci0 urb ffff8800624bd800 submission failed

The command I tried are:

  aplay -D plug:headset /usr/share/sounds/card_shuffle.wav
->The headset activates, but I do not hear the audio and the syslog
keep being flooded until I kill aplay

 mplayer -ao alsa:device=headset /usr/share/sounds/card_shuffle.wav
->works with low quality, but the syslog still gets flooded for the
duration of the wav file

Linux distribution: Ubuntu jaunty beta

$ uname -a
Linux cavedon-laptop 2.6.28-11-generic #38-Ubuntu SMP Fri Mar 27
10:01:17 UTC 2009 x86_64 GNU/Linux

Bluez: 4.32

My bluetooth device:
hci0: Type: USB
 BD Address: 00:1A:6B:BB:82:5D ACL MTU: 1017:8 SCO MTU: 64:8
 UP RUNNING PSCAN
 RX bytes:168363 acl:40 sco:3262 events:97 errors:2
 TX bytes:162252 acl:42 sco:7210 commands:57 errors:586
 Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
 Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
 Link policy: RSWITCH HOLD SNIFF PARK
 Link mode: SLAVE ACCEPT
 Name: 'cavedon-laptop-0'
 Class: 0x0a010c
 Service Classes: Networking, Capturing
 Device Class: Computer, Laptop
 HCI Ver: 2.0 (0x3) HCI Rev: 0x2129 LMP Ver: 2.0 (0x3) LMP Subver: 0x41cf
 Manufacturer: Broadcom Corporation (15)

Dmesg: http://launchpadlibrarian.net/24477639/BootDmesg.txt
Other info about my system:
https://bugs.edge.launchpad.net/ubuntu/+source/linux/+bug/350839/comments/1


Thank you in advance,
Ludovico
