Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] bluecard: Fix a possible sleep-in-atomic bug in
 bluecard_write_wakeup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1513157284-13659-1-git-send-email-baijiaju1990@gmail.com>
Date: Wed, 13 Dec 2017 14:39:42 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <3DCF07A0-0080-46AD-8514-D67919A48BE2@holtmann.org>
References: <1513157284-13659-1-git-send-email-baijiaju1990@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jia-Ju,

> The driver may sleep in the interrupt handler.
> The function call path is:
> bluecard_interrupt (interrupt handler)
>  bluecard_write_wakeup
>    schedule_timeout --> may sleep
> 
> To fix it, schedule_timeout is replaced with mdelay.
> 
> This bug is found by my static analysis tool(DSAC) and checked by my code review.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> drivers/bluetooth/bluecard_cs.c |    8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
