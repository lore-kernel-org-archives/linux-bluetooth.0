Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 16 Nov 2011 18:24:40 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btusb: Use USB_INTERFACE_INFO to do device
 matching
Message-ID: <20111116202440.GL16865@joana>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF2759@nasanexd02b.na.qualcomm.com>
 <1321406185.15441.502.camel@aeonflux>
 <07BBB2AAB1A10A488A2AD166C7CB8B0DEF28C2@nasanexd02b.na.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF28C2@nasanexd02b.na.qualcomm.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

* Yao, Costa <cqyao@qca.qualcomm.com> [2011-11-16 02:14:45 +0000]:

> 1 Use USB_INTERFACE_INFO to do device matching, other than USB_DEVICE_INFO.
> 2 Delete desc.bInterfaceNumber != 0 check.
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2bd87d4..39dd65c 100644
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
> @@ -918,10 +918,6 @@ static int btusb_probe(struct usb_interface *intf,
>  
>  	BT_DBG("intf %p id %p", intf, id);
>  
> -	/* interface numbers are hardcoded in the spec */
> -	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
> -		return -ENODEV;
> -
>  	if (!id->driver_info) {
>  		const struct usb_device_id *match;
>  		match = usb_match_id(intf, blacklist_table);
> @@ -1017,8 +1013,12 @@ static int btusb_probe(struct usb_interface *intf,
>  
>  	hdev->owner = THIS_MODULE;
>  
> -	/* Interface numbers are hardcoded in the specification */
> -	data->isoc = usb_ifnum_to_if(data->udev, 1);
> +	/* According to HCI-USB specification, the interface for
> +	 * SCO data endpoints follows the interface for commands,
> +	 * events and ACL data
> +	 */
> +	data->isoc = usb_ifnum_to_if(data->udev,
> +		intf->cur_altsetting->desc.bInterfaceNumber + 1);
>  
>  	if (!reset)
>  		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);

Patch doesn't apply, please rebase and resend, fixing the trailing whitespace
issues. Also add the Acked-by message to your patch.


Applying: RE: [PATCH] Bluetooth: btusb: Use USB_INTERFACE_INFO to do device matching
/home/padovan/p/linux-trees/bluetooth-next/.git/rebase-apply/patch:15: trailing whitespace.
        /* Bluetooth USB interface */
/home/padovan/p/linux-trees/bluetooth-next/.git/rebase-apply/patch:16: trailing whitespace.
        { USB_INTERFACE_INFO(0xe0, 0x01, 0x01) },
/home/padovan/p/linux-trees/bluetooth-next/.git/rebase-apply/patch:37: trailing whitespace.
        /* According to HCI-USB specification, the interface for
/home/padovan/p/linux-trees/bluetooth-next/.git/rebase-apply/patch:38: trailing whitespace.
         * SCO data endpoints follows the interface for commands,
/home/padovan/p/linux-trees/bluetooth-next/.git/rebase-apply/patch:39: trailing whitespace.
         * events and ACL data
error: patch failed: drivers/bluetooth/btusb.c:57
error: drivers/bluetooth/btusb.c: patch does not apply
Patch failed at 0001 RE: [PATCH] Bluetooth: btusb: Use USB_INTERFACE_INFO to do device matching
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

	Gustavo
