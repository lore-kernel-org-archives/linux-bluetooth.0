Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btusb: Use USB_INTERFACE_INFO to do device
 matching
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 14 Nov 2011 18:32:20 +0900
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEEEF58@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEEEF58@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321263144.15441.465.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> 1 Use USB_INTERFACE_INFO to do device matching, other than USB_DEVICE_INFO.
> 2 And we try to find the first interface containing the interrupt endpoint.
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 9db2476..80d7e2d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -58,7 +58,7 @@ static struct usb_driver btusb_driver;
>  
>  static struct usb_device_id btusb_table[] = {
>  	/* Generic Bluetooth USB device */
> -	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
> +	{ USB_INTERFACE_INFO(0xe0, 0x01, 0x01) },
>  
>  	/* Broadcom SoftSailing reporting vendor specific */
>  	{ USB_DEVICE(0x05ac, 0x21e1) },

this actually means that some of the USB_DEVICE entries can be removed.
Please go through our commit logs for btusb.c and figure out which ones
can be removed and send a separate patch for that.

> @@ -915,9 +915,14 @@ static int btusb_probe(struct usb_interface *intf,
>  
>  	BT_DBG("intf %p id %p", intf, id);
>  
> -	/* interface numbers are hardcoded in the spec */
> -	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
> +	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
> +		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
> +
> +		if (usb_endpoint_is_int_in(ep_desc))
> +			break;
> +
>  		return -ENODEV;
> +	}

There is no point in walking the endpoint list twice in the probe
function. Store possible candidates for int_in, bulk_out and bulk_in
descriptors so that later on we can just assign them to our data.

Then we can just check if this interface has int and proper bulk
endpoints available. And in error case return ENODEV.

Actually thinking about it, we already do that, so just removing the
hardcoded check for desc.bInterfaceNumber != 0 should do the trick.

>  	if (!id->driver_info) {
>  		const struct usb_device_id *match;
> @@ -1014,8 +1019,9 @@ static int btusb_probe(struct usb_interface *intf,
>  
>  	hdev->owner = THIS_MODULE;
>  
> -	/* Interface numbers are hardcoded in the specification */
> -	data->isoc = usb_ifnum_to_if(data->udev, 1);
> +
> +	data->isoc = usb_ifnum_to_if(data->udev,
> +		1+intf->cur_altsetting->desc.bInterfaceNumber);

And here you need to to check all interfaces. Just assuming it is +1
might not be good enough. Or at least put a proper comment in here that
we expect the ISOC interface to be +1. And then don't do 1+, I prefer to
have bInterfaceNumber + 1.

Regards

Marcel


