Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] bluetooth: btmrvl_main: Replace GFP_ATOMIC with
 GFP_KERNEL in btmrvl_send_sync_cmd
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1516982221-8524-1-git-send-email-baijiaju1990@gmail.com>
Date: Wed, 7 Feb 2018 09:55:44 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <C39D859D-E8B7-4805-94F7-28FEFCACEEEC@holtmann.org>
References: <1516982221-8524-1-git-send-email-baijiaju1990@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jia-Ju,

> After checking all possible call chains to btmrvl_send_sync_cmd(), 
> my tool finds that this function is never called in atomic context, 
> namely never in an interrupt handler or holding a spinlock. 
> And it calls wait_event_interruptible_timeout() after bt_skb_alloc(), 
> so it indicates that btmrvl_send_sync_cmd() 
> can call function which can sleep.
> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> drivers/bluetooth/btmrvl_main.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
