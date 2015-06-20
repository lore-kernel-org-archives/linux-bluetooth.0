Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek devices into module device table
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BLU436-SMTP489DFA77355813D75F34209EA30@phx.gbl>
Date: Sat, 20 Jun 2015 23:58:11 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Drake <drake@endlessm.com>,
	Larry Finger <Larry.Finger@lwfinger.net>
Message-Id: <C825257E-3CD1-4037-BC23-12D48F680EF9@holtmann.org>
References: <BLU436-SMTP489DFA77355813D75F34209EA30@phx.gbl>
To: Xi Ruoyao <xry111@outlook.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Xi,

> In 'commit a2698a9bf9b0 ("Bluetooth: btusb: Add Realtek
> 8723A/8723B/8761A/8821A support"), support of some Realtek
> devices was added to the Generic Bluetooth USB driver in kernel.
> However, these devices are not in the module device table of 
> btusb.ko, so the kernel wouldn't probe them at all.
> 
> To fix this, add four entries in the device table btusb_table,
> based on code from <https://github.com/lwfinger/rtl8723au_bt>
> ('new' branch).
> 
> This enables bluetooth support in the Lenovo Ideapad Yoga 13
> which has RTL8723AU USB device, with product ID 0bda:1724.
> 
> Signed-off-by: Xi Ruoyao <xry111@outlook.com>
> ---
> drivers/bluetooth/btusb.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3c10d4d..dd87623 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -148,6 +148,12 @@ static const struct usb_device_id btusb_table[] = {
> 	{ USB_DEVICE(0x8087, 0x0a5a),
> 	  .driver_info = BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
> 
> +	/* Realtek Bluetooth  */
> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01) },
> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bd5, 0xe0, 0x01, 0x01) },
> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xe0, 0x01, 0x01) },
> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xe0, 0x01, 0x01) },
> +

I highly doubt these are needed. There is a generic entry for an USB transport that is already covering these.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
