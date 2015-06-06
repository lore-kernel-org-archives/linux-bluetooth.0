Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2] Bluetooth: btusb: add one more device to fixed Invalid initialization bug for kernel since 3.x
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4734021.0ryETfeH92@it1765>
Date: Sat, 6 Jun 2015 06:37:36 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <992B0672-260B-4BF7-92C8-D6858C8C3A1C@holtmann.org>
References: <4734021.0ryETfeH92@it1765>
To: Aleksey <info@dv2c.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aleksey,

> That patch correct typo in "Roper Class 1 Bluetooth Dongle" since 4.x kernel

so is it 3.x or 4.x?

And please keep the subject line short.

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
> 
> 
> Signed-off-by: Aleksei Volkov <info@dv2c.ru>
> ---
> drivers/bluetooth/btusb.c | 1+-
> 1 file changed, 1 insertion(+), 1 deletion(-)

I can not apply the patch via git am. Please test this against bluetooth-next kernel. It makes it a lot easier for me if it just works since otherwise I have manually rebuild that patch.

Regards

Marcel

