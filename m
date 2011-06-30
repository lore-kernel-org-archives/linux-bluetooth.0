Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jun 2011 18:11:49 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: "Li, Steven" <yongli@qca.qualcomm.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Add Atheros AR3012 one PID/VID supported
Message-ID: <20110630211149.GE25602@joana>
References: <73DDB75979F36A42B75F3E2B6EB2943401031D5E@nasanexd02c.na.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <73DDB75979F36A42B75F3E2B6EB2943401031D5E@nasanexd02c.na.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Li, Steven <yongli@qca.qualcomm.com> [2011-06-29 07:14:47 +0000]:

> 
> The new Ath3k needs to download patch and radio table,
> and it keeps same PID/VID even after downloading the patch and radio
> table. This patch is to use the bcdDevice (Device Release Number) to
> judge whether the chip has been patched or not. The init bcdDevice
> value of the chip is 0x0001, this value increases after patch and
> radio table downloading.
> 
> Signed-off-by: Steven.Li <yongli@qca.qualcomm.com>
> ---
>  drivers/bluetooth/ath3k.c |    5 +++++
>  drivers/bluetooth/btusb.c |   12 +++++++++++-
>  2 files changed, 16 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 6bacef3..a585473 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -375,6 +375,11 @@ static int ath3k_probe(struct usb_interface *intf,
>  
>  	/* load patch and sysconfig files for AR3012 */
>  	if (id->driver_info & BTUSB_ATH3012) {
> +
> +		/* New firmware with patch and sysconfig files already loaded */
> +		if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x0001)
> +			return -ENODEV;
> +
>  		ret = ath3k_load_patch(udev);
>  		if (ret < 0) {
>  			BT_ERR("Loading patch file failed");
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c2de895..91d13a9 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -54,6 +54,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_BCM92035		0x10
>  #define BTUSB_BROKEN_ISOC	0x20
>  #define BTUSB_WRONG_SCO_MTU	0x40
> +#define BTUSB_ATH3012		0x80
>  
>  static struct usb_device_id btusb_table[] = {
>  	/* Generic Bluetooth USB device */
> @@ -110,7 +111,7 @@ static struct usb_device_id blacklist_table[] = {
>  	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
>  
>  	/* Atheros 3012 with sflash firmware */
> -	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_IGNORE },
> +	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
>  
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
> @@ -914,6 +915,15 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
>  		return -ENODEV;
>  
> +	if (id->driver_info & BTUSB_ATH3012) {
> +		struct usb_device *udev = interface_to_usbdev(intf);
> +
> +		/* Old firmware would otherwise let ath3k driver load
> +		 * patch and sysconfig files */
> +		if (le16_to_cpu(udev->descriptor.bcdDevice) <= 0x0001)
> +			return -ENODEV;
> +	}
> +

Patch does no apply

Applying: Bluetooth: Add Atheros AR3012 one PID/VID supported
/home/padovan/p/linux-trees/bluetooth-next-2.6/.git/rebase-apply/patch:14: trailing whitespace.

/home/padovan/p/linux-trees/bluetooth-next-2.6/.git/rebase-apply/patch:15: trailing whitespace.
                /* New firmware with patch and sysconfig files already loaded */
/home/padovan/p/linux-trees/bluetooth-next-2.6/.git/rebase-apply/patch:16: trailing whitespace.
                if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x0001)
/home/padovan/p/linux-trees/bluetooth-next-2.6/.git/rebase-apply/patch:17: trailing whitespace.
                        return -ENODEV;
/home/padovan/p/linux-trees/bluetooth-next-2.6/.git/rebase-apply/patch:18: trailing whitespace.

	Gustavo

