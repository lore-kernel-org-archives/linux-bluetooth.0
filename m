Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4] Bluetooth: btusb: Fix memory leak in play_deferred
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1500371617-5460-1-git-send-email-jeffy.chen@rock-chips.com>
Date: Tue, 18 Jul 2017 11:58:43 +0200
Cc: LKML <linux-kernel@vger.kernel.org>, xiyou.wangcong@gmail.com,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        linux-bluetooth@vger.kernel.org
Message-Id: <1D20F27F-CCF1-46DA-8D94-A76CE1C9748F@holtmann.org>
References: <1500371617-5460-1-git-send-email-jeffy.chen@rock-chips.com>
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
> Put those urbs in tx_anchor to avoid the leak, and also fix the error
> handling.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
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
> drivers/bluetooth/btusb.c | 21 +++++++++++++++++++--
> 1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 0d533b2..dbf4a05 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3266,13 +3266,30 @@ static void play_deferred(struct btusb_data *data)
> 	int err;
> 
> 	while ((urb = usb_get_from_anchor(&data->deferred))) {
> +		usb_anchor_urb(urb, &data->tx_anchor);
> +
> 		err = usb_submit_urb(urb, GFP_ATOMIC);
> -		if (err < 0)
> +		if (err < 0) {
> +			if (err != -EPERM && err != -ENODEV)
> +				BT_ERR("%s urb %p submission failed (%d)",
> +				       data->hdev->name, urb, -err);
> +			kfree(urb->setup_packet);
> +			usb_unanchor_urb(urb);
> +			usb_free_urb(urb);
> 			break;
> +		}
> 
> 		data->tx_in_flight++;
> +		usb_free_urb(urb);
> +	}
> +
> +	/* Cleanup the rest deferred urbs. */
> +	while ((urb = usb_get_from_anchor(&data->deferred))) {
> +		BT_ERR("%s urb %p submission failed (%d)",
> +		       data->hdev->name, urb, -err);
> +		kfree(urb->setup_packet);
> +		usb_free_urb(urb);
> 	}
> -	usb_scuttle_anchored_urbs(&data->deferred);
> }

if you think this is a valid approach, please provide an ack.

Regards

Marcel
