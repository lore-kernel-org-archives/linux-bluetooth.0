Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btusb: Use USB_INTERFACE_INFO to do device
 matching
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 16 Nov 2011 10:16:22 +0900
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF2759@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF2759@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321406185.15441.502.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> 1 Use USB_INTERFACE_INFO to do device matching, other than USB_DEVICE_INFO.
> 2 Delete desc.bInterfaceNumber != 0 check.
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)

this looks fine to me now. And isn't this a much cleaner patch ;)

> -	/* Interface numbers are hardcoded in the specification */
> -	data->isoc = usb_ifnum_to_if(data->udev, 1);
> +	/* According to HCI-USB specification, the interface for
> +	 * SCO data endpoint follows the interface for commands,
> +	 * events and ACL data
> +	 */

Minor nitpick here. It is SCO data endpoints (plural). Just resend the
patch with this fixed and feel free to add my ACK.

> +	data->isoc = usb_ifnum_to_if(data->udev,
> +		intf->cur_altsetting->desc.bInterfaceNumber + 1);
>  
>  	if (!reset)
>  		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


