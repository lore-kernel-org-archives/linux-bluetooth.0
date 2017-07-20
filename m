Return-Path: <oneukum@suse.com>
Message-ID: <1500541861.10409.2.camel@suse.com>
Subject: Re: [PATCH v5] Bluetooth: btusb: Fix memory leak in play_deferred
From: Oliver Neukum <oneukum@suse.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
Cc: briannorris@chromium.org, dianders@chromium.org, Johan Hedberg
	 <johan.hedberg@gmail.com>, xiyou.wangcong@gmail.com, Marcel Holtmann
	 <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 20 Jul 2017 11:11:01 +0200
In-Reply-To: <1500511321-16092-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1500511321-16092-1-git-send-email-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag, den 20.07.2017, 08:42 +0800 schrieb Jeffy Chen:
> Currently we are calling usb_submit_urb directly to submit deferred tx
> urbs after unanchor them.
> 
> So the usb_giveback_urb_bh would failed to unref it in usb_unanchor_urb
> and cause memory leak:
> unreferenced object 0xffffffc0ce0fa400 (size 256):
> ...
>   backtrace:
>     [<ffffffc00034a9a8>] __save_stack_trace+0x48/0x6c
>     [<ffffffc00034b088>] create_object+0x138/0x254
>     [<ffffffc0009d5504>] kmemleak_alloc+0x58/0x8c
>     [<ffffffc000345f78>] __kmalloc+0x1d4/0x2a0
>     [<ffffffc0006765bc>] usb_alloc_urb+0x30/0x60
>     [<ffffffbffc128598>] alloc_ctrl_urb+0x38/0x120 [btusb]
>     [<ffffffbffc129e7c>] btusb_send_frame+0x64/0xf8 [btusb]
> 
> Put those urbs in tx_anchor to avoid the leak, and also fix the error
> handling.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5:
> Fix compile warning reported by "kbuild test robot":
> drivers/bluetooth/btusb.c:3288:3: warning: 'err' may be used uninitialized in this function [-Wmaybe-uninitialized]
> This 'err' would be set in the send loop, and would be used in the
> cleanup rest urb code outside the loop.
> 
> Changes in v4:
> Drop the rest deferred urbs when error happens.
> 
> Changes in v3:
> Put the deferred urbs in tx_anchor.
> 
> Changes in v2:
> Call usb_free_urb instead of reusing submit_tx_urb.
> 
>  drivers/bluetooth/btusb.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 0d533b2..91fdd60 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3263,16 +3263,33 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>  static void play_deferred(struct btusb_data *data)
>  {
>  	struct urb *urb;
> -	int err;
> +	int err = 0;
>  
>  	while ((urb = usb_get_from_anchor(&data->deferred))) {
> +		usb_anchor_urb(urb, &data->tx_anchor);
> +
>  		err = usb_submit_urb(urb, GFP_ATOMIC);
> -		if (err < 0)
> +		if (err < 0) {
> +			if (err != -EPERM && err != -ENODEV)
> +				BT_ERR("%s urb %p submission failed (%d)",
> +				       data->hdev->name, urb, -err);
> +			kfree(urb->setup_packet);
> +			usb_unanchor_urb(urb);
> +			usb_free_urb(urb);
>  			break;
> +		}
>  
>  		data->tx_in_flight++;
> +		usb_free_urb(urb);
> +	}
> +
> +	/* Cleanup the rest deferred urbs. */
> +	while ((urb = usb_get_from_anchor(&data->deferred))) {
> +		BT_ERR("%s urb %p submission failed (%d)",

This looks very good, except for this message, which is incorrect.

> +		       data->hdev->name, urb, -err);
> +		kfree(urb->setup_packet);
> +		usb_free_urb(urb);
>  	}
> -	usb_scuttle_anchored_urbs(&data->deferred);
>  }
>  
>  static int btusb_resume(struct usb_interface *intf)

	Regards
		Oliver
