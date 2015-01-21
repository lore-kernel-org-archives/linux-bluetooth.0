Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH resend 3/5] Bluetooth: Add support for Broadcom 413c:8143
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1421827196-25277-3-git-send-email-jesse.sung@canonical.com>
Date: Wed, 21 Jan 2015 00:26:53 -0800
Cc: linux-bluetooth@vger.kernel.org,
	Gavin Guo <gavin.guo@canonical.com>
Message-Id: <8EF40417-2881-482A-834C-B6FA7C63D176@holtmann.org>
References: <1421827196-25277-1-git-send-email-jesse.sung@canonical.com> <1421827196-25277-3-git-send-email-jesse.sung@canonical.com>
To: Wen-chien Jesse Sung <jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wein-chien,

> From: Gavin Guo <gavin.guo@canonical.com>
> 
> The device require external patchram firmware to work and need to
> add corresponding id in the btusb.c.
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=08 Cnt=03 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=413c ProdID=8143 Rev=01.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=20689D1FAF94
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Signed-off-by: Gavin Guo <gavin.guo@canonical.com>
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index cde222b..83cc221 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -107,6 +107,8 @@ static const struct usb_device_id btusb_table[] = {
> 	{ USB_DEVICE(0x0b05, 0x17cb) },
> 	{ USB_DEVICE(0x413c, 0x8197),
> 	  .driver_info = BTUSB_BCM_PATCHRAM },
> +	{ USB_DEVICE(0x413c, 0x8143),
> +	  .driver_info = BTUSB_BCM_PATCHRAM },

please stop doing line-breaks here. This can fit easily on a single line.

And I really prefer the section from /sys/kernel/debug/usb/devices instead of the usb-devices script.

Regards

Marcel

