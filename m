Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth USB device keeps same PID/VID after downloading the
 patch and radio table
From: Marcel Holtmann <marcel@holtmann.org>
To: "Li, Steven" <yongli@qca.qualcomm.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Date: Thu, 09 Jun 2011 12:18:04 +0200
In-Reply-To: <73DDB75979F36A42B75F3E2B6EB29434010129F0@nasanexd02c.na.qualcomm.com>
References: <6AAC4214B9104E409FF4885ACB62A96101A78ADA81@SHEXMB-01.global.atheros.com>
	 <6AAC4214B9104E409FF4885ACB62A96101A78ADABF@SHEXMB-01.global.atheros.com>
	 <73DDB75979F36A42B75F3E2B6EB29434010129F0@nasanexd02c.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1307614687.2589.31.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steven,

> > I deleted your last email by accident. Can you re-send it please.
> 
> As you may lose the mail. I'd like to introduce our condition again.
> 
> As to the Atheros 3011 chip.  yes, it uses DFU mode to download the firmware.
> Instead of downloading the firmware, the new Atheros 3012 chip needs to download patch and radio table.
> The patch and radio table are used to fix those bugs found after chip shipping or for some other specific use.
> And  the Atheros 3012 chip itself is a native bluetooth device. Even without downloading patch and radio table, it can work.
> 
> So with this design, the Atheros 3012 chip always keeps same PID/VID even after downloading the patch and radio
> table. Due to this limitation, we have problems with current btusb.c implementation.
> 
> We have to have a work around way,  this is to use the bcdDevice (Device Release Number) to judge 
> whether the Atheros 3012 chip has been patched or not.
> The init bcdDevice value of this chip is 0x0001,  we can increase this value after patch and radio table downloading.
> 
> Do you think it is possible ?

now I understand your problem. So in theory you have a full Bluetooth
device working according to the HCI standard. And you are using vendor
HCI commands to patch the firmware.

So this is similar to what we are doing with a lot of UART based devices
when using hciattach.

For now, I am fine using bcdDevice number. In the end we have to create
a pre-stage for loading further instructions or patches into the device.
We had plans for this pre-stage already, but never implemented them.

> From 2dc0e703ed392f41d91984b0cfd1da56f6f173cb Mon Sep 17 00:00:00 2001
> From: Steven.Li <Steven.Li@Atheros.com>
> Date: Thu, 26 May 2011 17:06:52 +0800
> Subject: [PATCH] Use bcdDevice(Device Release Number) to exclude the ath3k and btusb driver.
> 
> ---
>  drivers/bluetooth/ath3k.c |    5 ++++-
>  drivers/bluetooth/btusb.c |    9 ++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 6bacef3..c99fb08 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -375,6 +375,9 @@ static int ath3k_probe(struct usb_interface *intf,
>  
>  	/* load patch and sysconfig files for AR3012 */
>  	if (id->driver_info & BTUSB_ATH3012) {
> +		if(le16_to_cpu(udev->descriptor.bcdDevice > 0x0001)) 

This needs to be like this:

	"if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x0001)"

Otherwise you endian swapping is not really doing what it is suppose to
be doing.

> +			return -ENODEV;
> +
>  		ret = ath3k_load_patch(udev);
>  		if (ret < 0) {
>  			BT_ERR("Loading patch file failed");
> @@ -390,7 +393,7 @@ static int ath3k_probe(struct usb_interface *intf,
>  			BT_ERR("Set normal mode failed");
>  			return ret;
>  		}
> -		ath3k_switch_pid(udev);
> +		/* ath3k_switch_pid(udev); */

This is hopefully just a change for testing. Otherwise you break the
other drivers that really do need the PID switching. So please fix this.

>  		return 0;
>  	}
>  
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c2de895..9b67b22 100644
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
> @@ -914,6 +915,12 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
>  		return -ENODEV;
>  
> +	if (id->driver_info & BTUSB_ATH3012) {
> +		struct usb_device *udev = interface_to_usbdev(intf);
> +		if(le16_to_cpu(udev->descriptor.bcdDevice <= 0x0001)) 

See comment above.

> +			return -ENODEV;
> +	}
> +
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;

Regards

Marcel


