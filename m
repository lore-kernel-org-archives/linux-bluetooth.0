Return-Path: <cyrus@holtmann.org>
Message-ID: <547C4D47.6010606@gmx.de>
Date: Mon, 01 Dec 2014 12:13:11 +0100
From: Harvey <harv@gmx.de>
Reply-To: harv@gmx.de
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Adding Broadcom Support for BCM 20702AO of Fuijitsu Lifebook
 E751 with .driver_info = BTUSB_BCM_PATCHRAM },
References: <547C2F76.80000@gmx.de> <CA52376B-12C5-4A2E-9922-616A722D1D54@holtmann.org>
In-Reply-To: <CA52376B-12C5-4A2E-9922-616A722D1D54@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcel,

thank you for your answer

>> may I kindly ask to incorporate the bluetooth device of my
>> Laptop Fuijitsu Lifebook E751 to the list of devices supported
>> through loading firmware via .driver_info = BTUSB_BCM_PATCHRAM ?
>> 
>> Output of usb-devices:
>> 
>> T:  Bus=02 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  5 Spd=12  MxCh=
>> 0 D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1 P:
>> Vendor=0489 ProdID=e031 Rev=01.12 S:  Manufacturer=Broadcom Corp 
>> S:  Product=BCM20702A0
> 
> you need to send a patch adding the changes to the USB device
> table. The commit message should include the content of
> /sys/kernel/debug/usb/devices in the commit message and also
> instructions on how to get the firmware file needed for this
> hardware.

I extracted the firmware file from the windows driver and converted it
via hex2hcd. Is this an acceptable way to go?

Harvey

- -- 
I am root. If you see me laughing, you'd better have a backup!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlR8TUIACgkQi5aqmLBUSgn3/QCeKPXE41qCptCZQ77JPzyMZbyP
H1sAoIfE7nX2J0r2V0j1Nd+xkXbVs12x
=X0IM
-----END PGP SIGNATURE-----
