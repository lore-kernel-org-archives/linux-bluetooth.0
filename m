Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [patch 13/16] bt: hci-bcsp: Use del_timer_sync() in teardown path
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140323150754.030657558@linutronix.de>
Date: Sun, 23 Mar 2014 10:30:42 -0700
Cc: LKML <linux-kernel@vger.kernel.org>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	bt <linux-bluetooth@vger.kernel.org>
Message-Id: <536E0DCB-B30E-45AF-A6F7-07FF4575A24A@holtmann.org>
References: <20140323150557.288925975@linutronix.de> <20140323150754.030657558@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

> Make sure no timer callback is running before freeing the
> datastructure which contains it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: bt <linux-bluetooth@vger.kernel.org>
> ---
> drivers/bluetooth/hci_bcsp.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

we already fixed something similar in bluetooth-next tree. I think your patch is no longer needed.

Regards

Marcel

