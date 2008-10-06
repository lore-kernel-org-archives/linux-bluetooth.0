Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez/git + 2.6.27-rc8 + Belkin F8T017 -> Can't read class of
	adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: Stuart Pook <kernel6org@pook.es>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48EA893E.2000704@pook.es>
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>
	 <48E3B3BF.6070205@pook.es>
	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>
	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net>
	 <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com>
	 <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>
		 <48EA7770.30307@pook.es> <1223325944.11272.227.camel@violet.holtmann.net>
	 <48EA893E.2000704@pook.es>
Content-Type: text/plain
Date: Tue, 07 Oct 2008 00:38:54 +0200
Message-Id: <1223332734.11272.244.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

> I hope that the quirk will make it into 2.6.27.
> 
> :; cat  /proc/bus/usb/devices
>
> T:  Bus=01 Lev=02 Prnt=03 Port=02 Cnt=03 Dev#=  6 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=050d ProdID=0017 Rev= 2.91
> S:  Manufacturer=Broadcom Corp
> S:  Product=BLUETOOTH USB +EDR ADAPTER Class 1 v2.1 UHE
> S:  SerialNumber=000A3A8494D9
> C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=  2mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

I doubt it since it is not in yet. Show me the output of hciconfig -a
for this so I can create a patch for it.

What is the exact model number of this one. Do you have to have a link
to the product website by any chance.

Regards

Marcel


