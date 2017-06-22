Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH] Bluetooth: btusb: Fix memory leak in play_deferred
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1498126243-4771-1-git-send-email-jeffy.chen@rock-chips.com>
Date: Thu, 22 Jun 2017 12:21:05 +0200
Cc: LKML <linux-kernel@vger.kernel.org>, xiyou.wangcong@gmail.com,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Oliver Neukum <oliver@neukum.org>
Message-Id: <65CF80EF-EA58-4126-889D-07A8FF9D52DB@holtmann.org>
References: <1498126243-4771-1-git-send-email-jeffy.chen@rock-chips.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeffy,

> Currently in play_deferred, we are calling usb_submit_urb directly to
> submit deferred tx urb after unanchor it.
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
> Use submit_tx_urb instead for better error handling and avoid the leak.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> drivers/bluetooth/btusb.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 278e811..b469f9b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3254,11 +3254,12 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
> 
> static void play_deferred(struct btusb_data *data)
> {
> +	struct hci_dev *hdev = data->hdev;
> 	struct urb *urb;
> 	int err;
> 
> 	while ((urb = usb_get_from_anchor(&data->deferred))) {
> -		err = usb_submit_urb(urb, GFP_ATOMIC);
> +		err = submit_tx_urb(hdev, urb);
> 		if (err < 0)
> 			break;

so why not just fix the memory leak here and instead call submit_tx_urb. I am not sure that is actually the right approach. Why anchor this URB now to the TX anchor now? Is that actually safe?

Regards

Marcel
