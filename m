Return-Path: <cyrus@holtmann.org>
From: Dirk Langner <dirkolus@gmx.de>
To: linux-bluetooth@vger.kernel.org
Subject: Support for Mobile Action MA-720
Date: Wed, 7 Jan 2009 01:20:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200901070120.04434.dirkolus@gmx.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

I'm trying to get my Bluetooth USB stick running, which is a Mobile Action 
MA-720. Does anybody got it working? If so, how? I've searched all over the 
web and didn't find a definite statement. MA-700 seemed to work, though.

When connected, the bluetooth adapter says in messages:
Jan  6 20:07:56 mickey kernel: Bluetooth: HCI device and connection manager 
initialized
Jan  6 20:07:56 mickey kernel: Bluetooth: HCI socket layer initialized
Jan  6 20:07:56 mickey kernel: Bluetooth: L2CAP ver 2.8
Jan  6 20:07:56 mickey kernel: Bluetooth: L2CAP socket layer initialized
Jan  6 20:07:56 mickey kernel: Bluetooth: RFCOMM socket layer initialized
Jan  6 20:07:56 mickey kernel: Bluetooth: RFCOMM TTY layer initialized
Jan  6 20:07:56 mickey kernel: Bluetooth: RFCOMM ver 1.8

but a 
# hciconfig 
remains empty, although the USB stick is active (as USB device):
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=ff(vend.) Sub=ff Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0df7 ProdID=0722 Rev= 0.00
S:  Manufacturer=MobileAction Technology Inc.
S:  Product=Bluetooth Dongle
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
E:  Ad=02(O) Atr=03(Int.) MxPS=   8 Ivl=10ms

Any ideas, what's going wrong?

Thanks, 
	Dirk

P.S.: Is there a list of supported Bluetooth USB sticks?
