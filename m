Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH] Bluetooth: btusb: Add new NFA344A entry.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJH2EMzpFJ0cOrBu7hfNRn1JqKUuQdQhO36MNqWXOceqF5i21w@mail.gmail.com>
Date: Wed, 25 Oct 2017 16:08:58 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <034B49F1-9371-4D12-A7D4-AACBB6B484B5@holtmann.org>
References: <CAJH2EMzpFJ0cOrBu7hfNRn1JqKUuQdQhO36MNqWXOceqF5i21w@mail.gmail.com>
To: Bartosz Chronowski <ext.bartosz.chronowski@tieto.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

> This change allows proper low power mode entry in suspend.

please include /sys/kernel/debug/usb/devices entries for this hardware.

> 
> Signed-off-by: Bartosz Chronowski <ext.bartosz.chronowski@tieto.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7a5c06a..513a7a5 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -272,6 +272,7 @@ static const struct usb_device_id blacklist_table[] = {
>  { USB_DEVICE(0x0cf3, 0xe301), .driver_info = BTUSB_QCA_ROME },
>  { USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
>  { USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
> + { USB_DEVICE(0x0489, 0xe09f), .driver_info = BTUSB_QCA_ROME },

And some email serviced garbled up the tabs here.

Regards

Marcel
