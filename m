Return-Path: <cyrus@holtmann.org>
Message-ID: <733296.28621.qm@web95406.mail.in2.yahoo.com>
References: <6AC5A55546F64545AE996F8200E3AC4E069AA3A5@NL0105EXC01V01.eur.slb.com> <6AC5A55546F64545AE996F8200E3AC4E06A506A2@NL0105EXC01V01.eur.slb.com>
Date: Thu, 18 Jun 2009 16:39:05 +0530 (IST)
From: Balaji Palaniswami <balaji_palaniswami@yahoo.com>
Subject: Re: bluetooth, dbus and bluetooth headsets
To: John Frankish <j-frankish@slb.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06A506A2@NL0105EXC01V01.eur.slb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>






----- Original Message ----
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Sent: Thursday, 18 June, 2009 12:13:30 PM
Subject: RE: bluetooth, dbus and bluetooth headsets


-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of John Frankish
Sent: 15 June, 2009 13:49
To: linux-bluetooth@vger.kernel.org
Subject: bluetooth, dbus and bluetooth headsets

I've been trying to get a bt headset to work again with bluez for some time now, so I'd appreciate any help available on this - about the last time it worked was circa bluez-4.17 - I used:

Dbus-1.2.1
Dbus-glib-0.76
Bluez-gnome-1.8
Alsa-1.0.17

If I use more recent versions of bluez - I've tried all the way to bluez-4.41 - I can get other bt devices to work as long as I use /etc/dbus-1/system.d/bluetooth.conf from circa bluez-4.17, but I cannot get a bt headset to work.

I saw in this list that a more recent version of dbus might help getting a bt headset to work again, so I tried:

Dbus-1.2.14
Dbus-glib-0.80

..but then bluez-gnome does not find any devices to pair with, even if "hcitool scan" does find available devices. "simple-agent" does not seem to work up to bluez-4.41, so I cannot try to pair with the bt headset by that method either.

1. Are there prescribed versions of dbus, dbus-glib, alsa, etc that are required in order for a bt headset to work?

2. Why do I need to use an old /etc/dbus-1/system.d/bluetooth.conf for bluetoothd to start?

3. Is "simple-agent" supposed to work (I've seen various posts about required patches for dbus, etc)?

Thanks, John
--
To answer my own post for the benefit of anybody that might be struggling with this:

The trick was to run bluetooth-wizard from bluez-gnome as root, it then works with the /etc/dbus-1/system.d/bluetooth.conf from bluez-4.41, pairs with my bt headset and aplay/arecord produce the expected result.

The headset works with:

bluez-4.41
bluez-gnome-1.8
dbus-1.2.14
dbus-glib-0.80
alsa-1.0.20
kernel-2.6.29.2

John ,

I upgraded kernel to 2.6.30.rc8 , bluez-4.41, dbus 1.2.14  from Ubuntu 9.04 .I have verified bluez-gnome is 1.8,dbus-glib-80 default.For alsa ,what do i need install ? I found that there are lot of packages in ALSA main page such as driver ,library , utlility ,plugin firmware ,tools. After installation  one of alsa package, i am not able to login again.Please share your installation procedure.

Thanks,
Balaji.P

To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



      ICC World Twenty20 England &#39;09 exclusively on YAHOO! CRICKET http://cricket.yahoo.com

