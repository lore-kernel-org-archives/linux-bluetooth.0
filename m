Return-Path: <oneukum@suse.com>
Message-ID: <1500893441.16387.2.camel@suse.com>
Subject: Re: [PATCH v6] Bluetooth: btusb: Fix memory leak in play_deferred
From: Oliver Neukum <oneukum@suse.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
Cc: briannorris@chromium.org, dianders@chromium.org, Johan Hedberg
	 <johan.hedberg@gmail.com>, xiyou.wangcong@gmail.com, Marcel Holtmann
	 <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Date: Mon, 24 Jul 2017 12:50:41 +0200
In-Reply-To: <1500548030-20556-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1500548030-20556-1-git-send-email-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag, den 20.07.2017, 18:53 +0800 schrieb Jeffy Chen:
> Currently we are calling usb_submit_urb directly to submit deferred tx
> urbs after unanchor them.
> 
> So the usb_giveback_urb_bh would failed to unref it in usb_unanchor_urb
> and cause memory leak:
> unreferenced object 0xffffffc0ce0fa400 (size 256):
> ...
>   backtrace:
>     [<ffffffc00034a9a8>] __save_stack_trace+0x48/0x6c
>     [<ffffffc00034b088>] create_object+0x138/0x254
>     [<ffffffc0009d5504>] kmemleak_alloc+0x58/0x8c
>     [<ffffffc000345f78>] __kmalloc+0x1d4/0x2a0
>     [<ffffffc0006765bc>] usb_alloc_urb+0x30/0x60
>     [<ffffffbffc128598>] alloc_ctrl_urb+0x38/0x120 [btusb]
>     [<ffffffbffc129e7c>] btusb_send_frame+0x64/0xf8 [btusb]
> 
> Put those urbs in tx_anchor to avoid the leak, and also fix the error
> handling.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
