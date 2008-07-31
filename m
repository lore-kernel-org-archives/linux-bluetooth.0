Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Message-Id: <94E72E02-9C26-4FB4-8E0E-414B08E43F6A@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
In-Reply-To: <200807311452.24166.oliver@neukum.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: [rfc]btusb with SCO support
Date: Thu, 31 Jul 2008 16:03:13 +0200
References: <200807311452.24166.oliver@neukum.org>
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> here's my current version of btusb with SCO support. This is  
> preliminary.
> I am still looking at a way to delay using the higher altsettings  
> until SCO
> is actually used, but the timeouts seem to be too long to do the  
> obvious.

yeah, I was afraid of that switching the alternate settings is not as  
easy as the spec. might think. Personally I think it is a broken  
specification anyway. So the best assumption is that we have one SCO  
connection and that is either 8-bit or 16-bit. So we do the switching  
when we get the notify() callback for a changed voice setting.

> Furthermore, could somebody point me at the description of a test  
> setup
> for bluetooth?

So scotest works for basic testing and for the rest get a Bluetooth  
headset and then use the audio setup from wiki.bluez.org.

> --- linux-2.6/drivers/bluetooth/btusb.c	2008-07-31  
> 10:26:38.000000000 +0200
> +++ linux-btusb/drivers/bluetooth/btusb.c	2008-07-31  
> 13:57:17.000000000 +0200
> @@ -32,6 +32,8 @@
>
> #include <linux/usb.h>
>
> +#include "hci_usb.h"

Can we please not do that and just include the parts from hci_usb.h  
that we need directly here.

> static struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
>
> +	/* AVM BlueFRITZ! USB v2.0 */
> +	{ USB_DEVICE(0x057c, 0x3800) },
> +
> +	/* Bluetooth Ultraport Module from IBM */
> +	{ USB_DEVICE(0x04bf, 0x030a) },
> +
> +	/* ALPS Modules with non-standard id */
> +	{ USB_DEVICE(0x044e, 0x3001) },
> +	{ USB_DEVICE(0x044e, 0x3002) },
> +
> +	/* Ericsson with non-standard id */
> +	{ USB_DEVICE(0x0bdb, 0x1002) },
> +
> +	/* Canyon CN-BTU1 with HID interfaces */
> +	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = HCI_RESET },
> +
> 	{ }	/* Terminating entry */
> };
>
> MODULE_DEVICE_TABLE(usb, btusb_table);
>
> static struct usb_device_id blacklist_table[] = {
> +	/* CSR BlueCore devices */
> +	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = HCI_CSR },
> +
> +	/* Broadcom BCM2033 without firmware */
> +	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = HCI_IGNORE },
> +
> +	/* Broadcom BCM2035 */
> +	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = HCI_RESET |  
> HCI_WRONG_SCO_MTU },
> +	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET |  
> HCI_WRONG_SCO_MTU },
> +
> +	/* Broadcom BCM2045 */
> +	{ USB_DEVICE(0x0a5c, 0x2039), .driver_info = HCI_RESET |  
> HCI_WRONG_SCO_MTU },
> +	{ USB_DEVICE(0x0a5c, 0x2101), .driver_info = HCI_RESET |  
> HCI_WRONG_SCO_MTU },
> +
> +	/* IBM/Lenovo ThinkPad with Broadcom chip */
> +	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = HCI_RESET |  
> HCI_WRONG_SCO_MTU },
> +	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = HCI_RESET |  
> HCI_WRONG_SCO_MTU },
> +
> +	/* Targus ACB10US */
> +	{ USB_DEVICE(0x0a5c, 0x2100), .driver_info = HCI_RESET },
> +
> +	/* ANYCOM Bluetooth USB-200 and USB-250 */
> +	{ USB_DEVICE(0x0a5c, 0x2111), .driver_info = HCI_RESET },
> +
> +	/* HP laptop with Broadcom chip */
> +	{ USB_DEVICE(0x03f0, 0x171d), .driver_info = HCI_RESET |  
> HCI_WRONG_SCO_MTU },
> +
> +	/* Dell laptop with Broadcom chip */
> +	{ USB_DEVICE(0x413c, 0x8126), .driver_info = HCI_RESET |  
> HCI_WRONG_SCO_MTU },
> +
> +	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
> +	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET },
> +
> +	/* Kensington Bluetooth USB adapter */
> +	{ USB_DEVICE(0x047d, 0x105d), .driver_info = HCI_RESET },
> +	{ USB_DEVICE(0x047d, 0x105e), .driver_info = HCI_RESET |  
> HCI_WRONG_SCO_MTU },
> +
> +	/* ISSC Bluetooth Adapter v3.1 */
> +	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },
> +
> +	/* RTX Telecom based adapters with buggy SCO support */
> +	{ USB_DEVICE(0x0400, 0x0807), .driver_info = HCI_BROKEN_ISOC },
> +	{ USB_DEVICE(0x0400, 0x080a), .driver_info = HCI_BROKEN_ISOC },
> +
> +	/* CONWISE Technology based adapters with buggy SCO support */
> +	{ USB_DEVICE(0x0e5e, 0x6622), .driver_info = HCI_BROKEN_ISOC },
> +
> +	/* Belkin F8T012 and F8T013 devices */
> +	{ USB_DEVICE(0x050d, 0x0012), .driver_info = HCI_RESET |  
> HCI_WRONG_SCO_MTU },
> +	{ USB_DEVICE(0x050d, 0x0013), .driver_info = HCI_RESET |  
> HCI_WRONG_SCO_MTU },
> +
> +	/* Digianswer devices */
> +	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = HCI_DIGIANSWER },
> +	{ USB_DEVICE(0x08fd, 0x0002), .driver_info = HCI_IGNORE },
> +
> +	/* CSR BlueCore Bluetooth Sniffer */
> +	{ USB_DEVICE(0x0a12, 0x0002), .driver_info = HCI_SNIFFER },
> +
> +	/* Frontline ComProbe Bluetooth Sniffer */
> +	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = HCI_SNIFFER },
> 	{ }	/* Terminating entry */
> };

Both table updates should be a separate patch and we can even submit  
that for 2.6.27 inclusion. I was just to lazy to do that, but I have  
it on my todo list, but the Simple Pairing support had higher priority.

Also the HCI_RESET thing needs to be turn-around. We always do  
HCI_RESET except for some chips where it will break (old CSR ones for  
example).

> +static struct usb_driver btusb_driver;
> +
> +static int reset = 0;
> +module_param(reset, bool, 0644);
> +MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
> +
> +static int force_scofix;
> +module_param(force_scofix, bool, 0644);
> +MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers  
> size");
> +
> +static int disable_scofix;
> +module_param(disable_scofix, bool, 0644);
> +MODULE_PARM_DESC(disable_scofix, "Disable fixup of wrong SCO buffer  
> size");
> +
> +static int ignore_csr;
> +module_param(ignore_csr, bool, 0644);
> +MODULE_PARM_DESC(ignore_csr, "Ignore devices with id 0a12:0001");
> +
> +static int ignore_sniffer;
> +module_param(ignore_sniffer, bool, 0644);
> +MODULE_PARM_DESC(ignore_sniffer, "Ignore devices with id 0a12:0002");
> +
> +static int ignore_dga;
> +module_param(ignore_dga, bool, 0644);
> +MODULE_PARM_DESC(ignore_dga, "Ignore devices with id 08fd:0001");
> +
> +static int override_ignore;
> +module_param(override_ignore, bool, 0644);
> +MODULE_PARM_DESC(override_ignore, "Drive blacklisted devices");

This is my personal taste. I want the variable at the top, but the  
module_param() and the description at the bottom with the other  
defines for the module.

> -	struct work_struct work;
> -
> 	struct usb_anchor tx_anchor;
> 	struct usb_anchor intr_anchor;
> 	struct usb_anchor bulk_anchor;
> +	struct usb_anchor sco_anchor;
>
> 	struct usb_endpoint_descriptor *intr_ep;
> 	struct usb_endpoint_descriptor *bulk_tx_ep;
> 	struct usb_endpoint_descriptor *bulk_rx_ep;
> +	struct usb_host_endpoint *isoc_out_ep;
> +	struct usb_host_endpoint *isoc_in_ep;
> +
> +	struct usb_interface *iso;
> };

Call the later one either *isoc or *sco. Actually *sco_intf might make  
a lot sense since you have the sco_anchor.

> +static void btusb_sco_rx_complete(struct urb *urb)
> +{
> +	struct btusb_data *data = urb->context;
> +	int status = urb->status;
> +	int i;
> +
> +	if (!test_bit(HCI_RUNNING, &data->flags))
> +		goto out;
> +	if (status < 0)
> +		goto out;
> +
> +	for (i=0; i < urb->number_of_packets; i++) {
> +		BT_DBG("desc %d status %d offset %d len %d", i,
> +				urb->iso_frame_desc[i].status,
> +				urb->iso_frame_desc[i].offset,
> +				urb->iso_frame_desc[i].actual_length);

Small coding style nitpick in the for loop. And yes I know, that is  
wrong in hci_usb.c driver, too :)

> 		if (!urb->iso_frame_desc[i].status) {
> +			data->hdev->stat.byte_rx += urb->iso_frame_desc[i].actual_length;
> +			hci_recv_fragment(data->hdev, HCI_SCODATA_PKT,
> +				urb->transfer_buffer + urb->iso_frame_desc[i].offset,
> +				urb->iso_frame_desc[i].actual_length);
> +		}
> +	}
> +
> +	usb_anchor_urb(urb, &data->sco_anchor);
> +	i = usb_submit_urb(urb, GFP_ATOMIC);
> +	if (i < 0) {
> +		usb_unanchor_urb(urb);
> +out:
> +		kfree(urb->transfer_buffer);
> +	}
> +}

This label is ugly. Please just simple to the kfree in the error case  
directly in the test at the top of the function. Also please not re- 
use the i from the loop iterator and lets just check directly here  
without storing the result. Since we don't do anything usefull with it  
anyway, it gives us no benefit and would make the code a little bit  
easier to read.

> static int btusb_open(struct hci_dev *hdev)
> {
> 	struct btusb_data *data = hdev->driver_data;
> +	static DEFINE_MUTEX(open_mut);

I dislike static mutex definition inside functions. Just move this to  
a global mutex.

> +static void btusb_fill_isoc_desc(struct urb *urb, int len, int mtu)
> +{
> +	int offset = 0, i;
> +
> +	BT_DBG("len %d mtu %d", len, mtu);
> +
> +	for (i=0; i < HCI_MAX_ISOC_FRAMES && len >= mtu; i++, offset +=  
> mtu, len -= mtu) {
> +		urb->iso_frame_desc[i].offset = offset;
> +		urb->iso_frame_desc[i].length = mtu;
> +		BT_DBG("desc %d offset %d len %d", i, offset, mtu);
> +	}

Same coding style comment as above. We also might wanna break this  
complex for-loop up in easier code.

> +	if (id->driver_info == HCI_IGNORE && !override_ignore)
> +		return -ENODEV;
> +	if (ignore_sniffer && id->driver_info & HCI_SNIFFER)
> +		return -ENODEV;
> +	if (ignore_csr && id->driver_info & HCI_CSR)
> +		return -ENODEV;
> +	if (ignore_dga && id->driver_info & HCI_DIGIANSWER)
> +		return -ENODEV;

This as to be a separate patch with the blacklist stuff.

Regards

Marcel

