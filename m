Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btusb: add one more device to fixed Invalid initialization bug for kernel since 3.x
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1778954.MznHKqOsQy@it1765>
Date: Fri, 15 May 2015 16:02:31 +0200
Cc: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <3D353336-A532-4E7D-A382-8F011985BC35@holtmann.org>
References: <1849903.jsc2NzCIHo@vwd-1> <1588358.UJXQXaaSbI@leonov> <B6FB3590-0B82-4112-B1E8-1AA006CC4124@holtmann.org> <1778954.MznHKqOsQy@it1765>
To: Aleksey Volkov <info@dv2c.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aleksey,

>> so I made a typo, then we just need a patch correcting this typo that also includes /sys/kernel/debug/usb/devices for this dongle to make sure this does not happen again.
>> 
> 
> Patch correcting this typo exist in first mail.
> 
> Content /sys/kernel/debug/usb/devices for these dongle:
> 
> T:  Bus=05 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=1310 ProdID=0001 Rev=15.00
> S:  Manufacturer=SiW
> S:  Product=SiW
> S:  SerialNumber=E7BB050D0B00
> C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 50mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 

please include this in the original patch you sent and send a v2 of that patch.

Regards

Marcel

