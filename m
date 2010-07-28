Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 28 Jul 2010 19:02:13 +0200
Message-ID: <AANLkTi=LHJF7-ymBrchWWy_QyM1qThYkigr3Hx=M6e7n@mail.gmail.com>
Subject: Headset problem
From: Josu Lazkano <josu.lazkano@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, I have a Debian Squeeze laptop, I am using the same OS on other
laptop and I can use a bluetooth headset to speak with PulseAudio.
When I connect
(pairing) the headset I can select the bluetooth device on PulseAudio
and I can use it, but
not with the other laptop.

This is my bt device info:

# hciconfig features
hci0:   Type: BR/EDR  Bus: USB
       BD Address: 00:10:C6:xx:xx:xx  ACL MTU: 377:10  SCO MTU: 16:0
       UP RUNNING PSCAN ISCAN
       RX bytes:5691 acl:77 sco:51 events:125 errors:2
       TX bytes:2239 acl:81 sco:0 commands:43 errors:0

I use Gnome bluetooth preference to pair the devices. I don't know
what info put here, can you help with this?

This is the bluetooth device that works:

# hciconfig features
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:21:85:xx:xx:xx  ACL MTU: 310:10  SCO MTU: 64:8
	UP RUNNING PSCAN
	RX bytes:312623 acl:19325 sco:0 events:302 errors:0
	TX bytes:2074 acl:11 sco:0 commands:41 errors:0


Thanks for all.

-- 
Josu Lazkano
