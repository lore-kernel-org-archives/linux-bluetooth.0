Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 13:10:03 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Add support for Atheros [04ca:3005]
Message-ID: <20120327161002.GD9856@joana>
References: <1332815576-27800-1-git-send-email-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332815576-27800-1-git-send-email-acelan.kao@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi AceLan,

* AceLan Kao <acelan.kao@canonical.com> [2012-03-27 10:32:55 +0800]:

> Add another vendor specific ID for Atheros AR3012 device.
> This chip is wrapped by Lite-On Technology Corp.
> 
> output of usb-devices:
> T:  Bus=04 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=04ca ProdID=3005 Rev=00.02
> S:  Manufacturer=Atheros Communications
> S:  Product=Bluetooth USB Host Controller
> S:  SerialNumber=Alaska Day 2006
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/bluetooth/ath3k.c |    2 ++
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 07f14d1..2364644 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -71,6 +71,7 @@ static struct usb_device_id ath3k_table[] = {
>  
>  	/* Atheros AR3012 with sflash firmware*/
>  	{ USB_DEVICE(0x0CF3, 0x3004) },
> +	{ USB_DEVICE(0x04CA, 0x3005) },
>  
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xE02C) },
> @@ -87,6 +88,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
>  
>  	/* Atheros AR3012 with sflash firmware*/
>  	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
>  
>  	{ }	/* Terminating entry */
>  };
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 789c9b5..1908ba8 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -127,6 +127,7 @@ static struct usb_device_id blacklist_table[] = {
>  
>  	/* Atheros 3012 with sflash firmware */
>  	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },

You need to rebase your patch against bluetooth-next, it doesn't apply
anymore.

	Gustavo
