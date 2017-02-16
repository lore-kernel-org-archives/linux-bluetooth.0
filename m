Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support for 413c:8143
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1484034073-12440-1-git-send-email-jesse.sung@canonical.com>
Date: Thu, 16 Feb 2017 17:31:41 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3E0923ED-4892-4607-A040-2A4CEC75003B@holtmann.org>
References: <1484034073-12440-1-git-send-email-jesse.sung@canonical.com>
To: Wen-chien Jesse Sung <jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wen-chien,

> This is a Boardcom module and requires patchram to work.
> 
> T: Bus=01 Lev=03 Prnt=03 Port=01 Cnt=02 Dev#= 5 Spd=12 MxCh= 0
> D: Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=413c ProdID=8143 Rev= 1.12
> S: Manufacturer=Broadcom Corp
> S: Product=BCM20702A0
> S: SerialNumber=20689D1FAF94
> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr= 0mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
> E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> I: If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> I: If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> I: If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> I: If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> I: If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E: Ad=84(I) Atr=02(Bulk) MxPS= 32 Ivl=0ms
> E: Ad=04(O) Atr=02(Bulk) MxPS= 32 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

I changed it to use USB_VENDOR_AND_INTERFACE_INFO and then applied it to bluetooth-next tree.

Regards

Marcel

