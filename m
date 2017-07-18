Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v2] Bluetooth: btusb: Fix memory leak in play_deferred
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1500343579-9831-1-git-send-email-jeffy.chen@rock-chips.com>
Date: Tue, 18 Jul 2017 08:44:06 +0200
Cc: linux-kernel@vger.kernel.org, xiyou.wangcong@gmail.com,
        briannorris@chromium.org, dianders@chromium.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        linux-bluetooth@vger.kernel.org
Message-Id: <6E21F79E-93AA-4461-BA6B-67715501714F@holtmann.org>
References: <1500343579-9831-1-git-send-email-jeffy.chen@rock-chips.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Oliver Neukum <oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> Currently we are calling usb_submit_urb directly to submit deferred tx
> urbs after unanchor them.
> 
> So the usb_giveback_urb_bh would failed to unref it in usb_unanchor_urb
> and cause memory leak:
> unreferenced object 0xffffffc0ce0fa400 (size 256):
> ...
>  backtrace:
>    [<ffffffc00034a9a8>] __save_stack_trace+0x48/0x6c
>    [<ffffffc00034b088>] create_object+0x138/0x254
>    [<ffffffc0009d5504>] kmemleak_alloc+0x58/0x8c
>    [<ffffffc000345f78>] __kmalloc+0x1d4/0x2a0
>    [<ffffffc0006765bc>] usb_alloc_urb+0x30/0x60
>    [<ffffffbffc128598>] alloc_ctrl_urb+0x38/0x120 [btusb]
>    [<ffffffbffc129e7c>] btusb_send_frame+0x64/0xf8 [btusb]
> 
> Free those urbs after completed to avoid the leak, and also fix the
> error handling.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v2:
> Call usb_free_urb instead of reusing submit_tx_urb.
> 
> drivers/bluetooth/btusb.c | 20 +++++++++++++++++---
> 1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 0d533b2..a22a08b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3260,19 +3260,33 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
> 	return 0;
> }
> 
> +static void btusb_deferred_tx_complete(struct urb *urb)
> +{
> +	btusb_tx_complete(urb);
> +	usb_free_urb(urb);
> +}
> +
> static void play_deferred(struct btusb_data *data)
> {
> 	struct urb *urb;
> 	int err;
> 
> 	while ((urb = usb_get_from_anchor(&data->deferred))) {
> +		/* Add a hook to free urb after completed */
> +		urb->complete = btusb_deferred_tx_complete;
> +
> 		err = usb_submit_urb(urb, GFP_ATOMIC);
> -		if (err < 0)
> -			break;
> +		if (err < 0) {
> +			if (err != -EPERM && err != -ENODEV)
> +				BT_ERR("%s urb %p submission failed (%d)",
> +				       data->hdev->name, urb, -err);
> +			kfree(urb->setup_packet);
> +			usb_free_urb(urb);
> +			continue;
> +		}
> 
> 		data->tx_in_flight++;
> 	}
> -	usb_scuttle_anchored_urbs(&data->deferred);
> }

can I get an ack from you on this one?

Regards

Marcel
