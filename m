Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] bluetooth: btusb: Replace GFP_ATOMIC with GFP_KERNEL in
 inject_cmd_complete()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180723033851.8141-1-baijiaju1990@gmail.com>
Date: Mon, 23 Jul 2018 18:05:55 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <F636E201-BDBC-4D4E-9930-974C40831F03@holtmann.org>
References: <20180723033851.8141-1-baijiaju1990@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jia-Ju,

> inject_cmd_complete() is only called by btusb_send_frame_intel(), 
> which is set to hdev->send, and hdev->send() is never 
> called in atomic context.
> 
> inject_cmd_complete() calls bt_skb_alloc() with GFP_ATOMIC, 
> which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> I also manually check the kernel code before reporting it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

