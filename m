Return-Path: <cyrus@holtmann.org>
Subject: Re: problem in btusb driver for linux-2.6.30
From: Marcel Holtmann <marcel@holtmann.org>
To: Kartikey Parmar <kartikey2781@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-bluetooth@vger.kernel.org,
	linux-usb@vger.kernel.org
In-Reply-To: <6887eb5d0909110514l14350045q5978f0eabbde2eb1@mail.gmail.com>
References: <6887eb5d0909102327u2ca531d1q35d027839495a978@mail.gmail.com>
	 <200909110832.16244.oliver@neukum.org>
	 <6887eb5d0909110514l14350045q5978f0eabbde2eb1@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 15:40:06 +0200
Message-Id: <1252676406.8931.75.camel@violet>
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kartikey,

and again top posting, are you serious?

> kindly find /proc/bus/usb/devices output below:
> 
> *****************************************************************************************
> 
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1d6b ProdID=0001 Rev= 2.06
> S:  Manufacturer=Linux 2.6.30 ohci_hcd
> S:  Product=AT91 OHCI
> S:  SerialNumber=at91
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=16 #Cfgs=  1
> P:  Vendor=1131 ProdID=1001 Rev= 3.73
> S:  Manufacturer=ISSC
> S:  Product=ISSCEDRBTA
> C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
> 
> *********************************************************************************************

this shows that the driver picked up the device perfectly fine without
any problems. Your initial problem description doesn't make what you see
here.

Regards

Marcel


