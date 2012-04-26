Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Ryan Lewis <me@ryanlewis.net>
Date: Wed, 25 Apr 2012 23:07:09 -0400
Message-ID: <CA+L2dvFR7vF0Kjt6EknWvxqnUXpvckqWSdPgU7vxR_vrrhk8Gw@mail.gmail.com>
Subject: update for btusb
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a Fujitsu T901 which reports this bluetooth chip :
$ lsusb
..
Bus 002 Device 006: ID 0489:e031 Foxconn / Hon Hai
..

It does not work out of the box, here is usb-devices:

T:  Bus=02 Lev=02 Prnt=02 Port=03 Cnt=04 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e031 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=9439E59707C7
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

After reviewing this file:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob_plain;f=drivers/bluetooth/btusb.c;hb=HEAD

	/* Broadcom BCM20702A0 */
	{ USB_DEVICE(0x0a5c, 0x21e3) },
	{ USB_DEVICE(0x0a5c, 0x21e6) },
	{ USB_DEVICE(0x0a5c, 0x21e8) },
	{ USB_DEVICE(0x0a5c, 0x21f3) },
	{ USB_DEVICE(0x413c, 0x8197) },


It is clear that my device is simply not listed. I will attempt to
compile a modified driver and see if it makes things work, and if it
does, i'll submit a patch (if necessary).


Thanks,
-rhl
