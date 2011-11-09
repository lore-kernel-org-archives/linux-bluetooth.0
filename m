Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btusb: Add support for Qualcomm Atheros
 composite chip 3006
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 09 Nov 2011 16:48:33 +0900
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C9B@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C9B@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320824916.15441.328.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> AR3006 is a composite device, and interface 0 is used for hid function, not for bluetooth function.
> We should make the following changes:
> 1 Blacklist AR3006 PID/VID in btusb_table
> 2 Add composite_device_table in btusb.c to register composite device
> 3 For AR3006 composite device, interface 3 is used for data->isoc
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c |   37 ++++++++++++++++++++++++++++++++++++-
>  1 files changed, 36 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 9db2476..d306dec 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -55,6 +55,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_BROKEN_ISOC	0x20
>  #define BTUSB_WRONG_SCO_MTU	0x40
>  #define BTUSB_ATH3012		0x80
> +#define BTUSB_ATH3006		0x0100
>  
>  static struct usb_device_id btusb_table[] = {
>  	/* Generic Bluetooth USB device */
> @@ -100,6 +101,9 @@ static struct usb_device_id btusb_table[] = {
>  	/* Canyon CN-BTU1 with HID interfaces */
>  	{ USB_DEVICE(0x0c10, 0x0000) },
>  
> +	/* Qualcomm Atheros with HID interfaces */
> +	{ USB_DEVICE(0x0cf3, 0x3006) },
> +
>  	{ }	/* Terminating entry */
>  };
>  
> @@ -122,6 +126,7 @@ static struct usb_device_id blacklist_table[] = {
>  
>  	/* Atheros 3012 with sflash firmware */
>  	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x0cf3, 0x3006), .driver_info = BTUSB_ATH3006 },
>  
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
> @@ -179,6 +184,18 @@ static struct usb_device_id blacklist_table[] = {
>  	{ }	/* Terminating entry */
>  };

I do not understand why the device has to be in both tables. That makes
no sense to me.
 
> +/*
> + * For composite device, interface 0 may be not for bluetooth function.
> + * It is better to let the vendor code to handle this situation.
> + * So, we use composite_device_table to record the composite devices.
> + */
> +static struct usb_device_id composite_device_table[] = {
> +	/* Qualcomm Atheros composite device 3006 */
> +	{ USB_DEVICE(0x0cf3, 0x3006) },
> +
> +	{ }	/* Terminating entry */
> +};
> +

And again, another 3rd table with the same entry. Why do you need this?

>  #define BTUSB_MAX_ISOC_FRAMES	10
>  
>  #define BTUSB_INTR_RUNNING	0
> @@ -912,13 +929,25 @@ static int btusb_probe(struct usb_interface *intf,
>  	struct btusb_data *data;
>  	struct hci_dev *hdev;
>  	int i, err;
> +	const struct usb_device_id *match_comp_dev;
>  
>  	BT_DBG("intf %p id %p", intf, id);
>  
> +	/* For composite device
> +	* it may not the case that interface 0 is for bluetooth function.
> +	*/
> +	match_comp_dev = usb_match_id(intf, composite_device_table);
> +	if (match_comp_dev) {
> +		if (intf->cur_altsetting->desc.bInterfaceNumber != 2)
> +			return -ENODEV;
> +		goto match_id;
> +	}
> +

So seriously, this can be done via the main table and .driver_info. The
composite table is total waste.

>  	/* interface numbers are hardcoded in the spec */
>  	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
>  		return -ENODEV;
>  
> +match_id:

I do not like this forward jump.

>  	if (!id->driver_info) {
>  		const struct usb_device_id *match;
>  		match = usb_match_id(intf, blacklist_table);
> @@ -938,7 +967,8 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
>  		return -ENODEV;
>  
> -	if (id->driver_info & BTUSB_ATH3012) {
> +	if ((id->driver_info & BTUSB_ATH3012) ||
> +				(id->driver_info & BTUSB_ATH3006)) {
>  		struct usb_device *udev = interface_to_usbdev(intf);
>  
>  		/* Old firmware would otherwise let ath3k driver load
> @@ -1062,6 +1092,11 @@ static int btusb_probe(struct usb_interface *intf,
>  		}
>  	}
>  
> +	if (id->driver_info & BTUSB_ATH3006) {
> +		BT_ERR("hardcoded: Interface 3");
> +		data->isoc = usb_ifnum_to_if(data->udev, 3);
> +	}
> +
>  	if (data->isoc) {
>  		err = usb_driver_claim_interface(&btusb_driver,
>  							data->isoc, data);

Actually I am more and more thinking that something is done here way too
complicated. Please post the /proc/bus/usb/devices content for this
device before and after firmware got loaded.

Regards

Marcel


