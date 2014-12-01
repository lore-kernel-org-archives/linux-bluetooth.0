Return-Path: <cyrus@holtmann.org>
Message-ID: <547C2F76.80000@gmx.de>
Date: Mon, 01 Dec 2014 10:05:58 +0100
From: Harvey <harv@gmx.de>
Reply-To: harv@gmx.de
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Adding Broadcom Support for BCM 20702AO of Fuijitsu Lifebook E751
 with .driver_info = BTUSB_BCM_PATCHRAM },
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all,

may I kindly ask to incorporate the bluetooth device of my Laptop
Fuijitsu Lifebook E751 to the list of devices supported through
loading firmware via
.driver_info = BTUSB_BCM_PATCHRAM ?

Output of usb-devices:

T:  Bus=02 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e031 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0

Thank you
Harvey

- -- 
I am root. If you see me laughing, you'd better have a backup!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlR8L24ACgkQi5aqmLBUSgkg9ACghILHWr1QUXmd7urkUgXCYQ5b
OsoAn3Q+sY7/VRVPFJDFAAVwGLRI372i
=Vnh0
-----END PGP SIGNATURE-----
