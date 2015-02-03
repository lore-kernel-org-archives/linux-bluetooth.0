Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support for Lite-On (04ca) Broadcom based, BCM43142
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422899414-1949-1-git-send-email-matej.dubovy@gmail.com>
Date: Mon, 2 Feb 2015 23:59:35 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4BF120E6-472D-45C8-B09C-8046746D182B@holtmann.org>
References: <E2038F3C-0E8B-4A01-81E0-D9CC2B2C468D@holtmann.org> <1422899414-1949-1-git-send-email-matej.dubovy@gmail.com>
To: Matej Dubovy <matej.dubovy@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matej,

> Please add support for sub BT chip on the combo card
> Broadcom 43142A0 (in Lenovo E145), 04ca:2007
> 
> /sys/kernel/debug/usb/devices
> 
> T:  Bus=05 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=04ca ProdID=2007 Rev= 1.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM43142A0
> S:  SerialNumber=28E347EC73BD
> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Firmware for 04ca:2007 can be extracted from the latest Lenovo E145
> Bluetooth driver for Windows (driver is however described as BCM20702
> but contains also firwmare for BCM43142).
> Search for BCM43142A0_001.001.011.0122.0153.hex within hex files, then
> it must be converted using hex2hcd utility. Rename file to
> BCM43142A0-04ca-2007.hcd, then move to /lib/firmware/brcm/.
> ---
> drivers/bluetooth/btusb.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

