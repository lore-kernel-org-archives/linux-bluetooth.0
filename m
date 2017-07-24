Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v6] Bluetooth: btusb: Fix memory leak in play_deferred
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1500548030-20556-1-git-send-email-jeffy.chen@rock-chips.com>
Date: Mon, 24 Jul 2017 18:56:50 +0200
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>, xiyou.wangcong@gmail.com,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        linux-bluetooth@vger.kernel.org
Message-Id: <E78D1D13-F84A-40A2-9296-A360619E780C@holtmann.org>
References: <1500548030-20556-1-git-send-email-jeffy.chen@rock-chips.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeffy,

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
> Changes in v6:
> Don't print error msg when dropping urbs, since we already log it when
> failed to submit.
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
> drivers/bluetooth/btusb.c | 19 +++++++++++++++++--
> 1 file changed, 17 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

