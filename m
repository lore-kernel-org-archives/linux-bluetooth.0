Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btusb: Use USB_INTERFACE_INFO to do device
 matching
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 15 Nov 2011 11:23:08 +0900
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF0628@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF0628@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321323791.15441.473.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> 1 Use USB_INTERFACE_INFO to do device matching, other than USB_DEVICE_INFO.
> 2 And we try to find the first interface containing the interrupt endpoint.
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c |   63 ++++++++++++++++++++++++--------------------
>  1 files changed, 34 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2bd87d4..2575256 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -57,8 +57,8 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_ATH3012		0x80
>  
>  static struct usb_device_id btusb_table[] = {
> -	/* Generic Bluetooth USB device */
> -	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
> +	/* Bluetooth USB interface */
> +	{ USB_INTERFACE_INFO(0xe0, 0x01, 0x01) },
>  
>  	/* Broadcom SoftSailing reporting vendor specific */
>  	{ USB_DEVICE(0x05ac, 0x21e1) },
> @@ -912,14 +912,35 @@ static int btusb_probe(struct usb_interface *intf,
>  				const struct usb_device_id *id)
>  {
>  	struct usb_endpoint_descriptor *ep_desc;
> +	struct usb_endpoint_descriptor *intr_ep = NULL;
> +	struct usb_endpoint_descriptor *bulk_tx_ep = NULL;
> +	struct usb_endpoint_descriptor *bulk_rx_ep = NULL;
>  	struct btusb_data *data;
>  	struct hci_dev *hdev;
>  	int i, err;
>  
>  	BT_DBG("intf %p id %p", intf, id);
>  
> -	/* interface numbers are hardcoded in the spec */
> -	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
> +	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
> +		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
> +
> +		if (usb_endpoint_is_int_in(ep_desc)) {
> +			intr_ep = ep_desc;
> +			continue;
> +		}
> +
> +		if (usb_endpoint_is_bulk_out(ep_desc)) {
> +			bulk_tx_ep = ep_desc;
> +			continue;
> +		}
> +
> +		if (usb_endpoint_is_bulk_in(ep_desc)) {
> +			bulk_rx_ep = ep_desc;
> +			continue;
> +		}
> +	}
> +
> +	if (!intr_ep || !bulk_tx_ep || !bulk_rx_ep)
>  		return -ENODEV;
>  
>  	if (!id->driver_info) {
> @@ -954,29 +975,9 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (!data)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
> -		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
> -
> -		if (!data->intr_ep && usb_endpoint_is_int_in(ep_desc)) {
> -			data->intr_ep = ep_desc;
> -			continue;
> -		}
> -
> -		if (!data->bulk_tx_ep && usb_endpoint_is_bulk_out(ep_desc)) {
> -			data->bulk_tx_ep = ep_desc;
> -			continue;
> -		}
> -
> -		if (!data->bulk_rx_ep && usb_endpoint_is_bulk_in(ep_desc)) {
> -			data->bulk_rx_ep = ep_desc;
> -			continue;
> -		}
> -	}
> -
> -	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep) {
> -		kfree(data);
> -		return -ENODEV;
> -	}
> +	data->intr_ep = intr_ep;
> +	data->bulk_tx_ep = bulk_tx_ep;
> +	data->bulk_rx_ep = bulk_rx_ep;

so what is wrong with just this approach:

@@ -907,10 +907,6 @@ static int btusb_probe(struct usb_interface *intf,
 
        BT_DBG("intf %p id %p", intf, id);
 
-       /* interface numbers are hardcoded in the spec */
-       if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
-               return -ENODEV;
-
        if (!id->driver_info) {
                const struct usb_device_id *match;
                match = usb_match_id(intf, blacklist_table);
 
>  	data->cmdreq_type = USB_TYPE_CLASS;
>  
> @@ -1017,8 +1018,12 @@ static int btusb_probe(struct usb_interface *intf,
>  
>  	hdev->owner = THIS_MODULE;
>  
> -	/* Interface numbers are hardcoded in the specification */
> -	data->isoc = usb_ifnum_to_if(data->udev, 1);
> +	/* Note: As HCI-USB description,
> +	 * We can expect isoc interface to be bInterfaceNumber + 1.
> +	 * Or it is better to check all interfaces to look for isoc.
> +	 */

And this comment is misleading.

	/* According to HCI-USB specification the interface for
	 * SCO data endpoints follows the interface for commands,
	 * events and ACL data */

Use this one instead.

> +	data->isoc = usb_ifnum_to_if(data->udev,
> +		intf->cur_altsetting->desc.bInterfaceNumber + 1);
>  
>  	if (!reset)
>  		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);

        if (data->isoc) {
                err = usb_driver_claim_interface(&btusb_driver,
                                                        data->isoc, data);
                if (err < 0) {
                        hci_free_dev(hdev);
                        kfree(data);
                        return err;
                }
        }

And please prepare and extra patch on top of this one, that adds a check
for the proper interface descriptor. We only wanna claim the ISOC
interface if they are actually Cls=e0(wlcon) Sub=01 Prot=01. Otherwise
we should not claim that interface.

Regards

Marcel


