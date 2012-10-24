Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Oct 2012 09:56:25 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Dwaine Garden VE3GIF <dwainegarden@rogers.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Add support for Atheros [04ca:3004]
Message-ID: <20121024115625.GD13884@joana>
References: <1351054633.13513.YahooMailNeo@web125402.mail.ne1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1351054633.13513.YahooMailNeo@web125402.mail.ne1.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dwaine,

* Dwaine Garden VE3GIF <dwainegarden@rogers.com> [2012-10-23 21:57:13 -0700]:

> Add another vendor specific ID for Atheros AR3012 device.
> This chip is wrapped by Lite-On Technology Corp.
> 
> output of usb-devices:T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=01 Dev#=  3 Spd=12   MxCh= 0

Break a line before pasting the output in the patch.

> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=04ca ProdID=3004 Rev= 0.02
> S:  Manufacturer=Atheros Communications
> S:  Product=Bluetooth USB Host Controller
> S:  SerialNumber=Alaska Day 2006
> 
> Signed-off-by: Dwaine Garden <DwaineGarden@rogers.com>  ---
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index fc2de55..1486f15 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -75,6 +75,7 @@ static struct usb_device_id ath3k_table[] = {
> { USB_DEVICE(0x0CF3, 0x3004) },
> { USB_DEVICE(0x0CF3, 0x311D) },
> { USB_DEVICE(0x13d3, 0x3375) },
> +	{ USB_DEVICE(0x04CA, 0x3004) },
> { USB_DEVICE(0x04CA, 0x3005) },
> { USB_DEVICE(0x13d3, 0x3362) },
> { USB_DEVICE(0x0CF3, 0xE004) },
> @@ -102,6 +103,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
> { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> { USB_DEVICE(0x0cf3, 0x311D), .driver_info = BTUSB_ATH3012 },
> { USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
> { USB_DEVICE(0x04ca, 0x3005), .driver_info =
>  BTUSB_ATH3012 },
> {
>  USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
> { USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index debda27..0529cee 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -132,6 +132,7 @@ static struct usb_device_id blacklist_table[] = {
> { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> { USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
> { USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
> { USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
> { USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
> { USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },

You patch is still broken, please use git-send-email to send it to the mailing
list and also make sure it apply cleanly on the latest bluetooth-next tree
before sending. Thanks.

	Gustavo
