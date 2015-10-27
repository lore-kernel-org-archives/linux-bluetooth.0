Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH bluetooth-next] bluetooth: 6lowpan: fix NOHZ: local_softirq_pending
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1445931324-1524-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 27 Oct 2015 17:56:04 +0900
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	kernel@pengutronix.de,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>
Message-Id: <F0CD9753-B40A-49F6-B427-98201859FA4B@holtmann.org>
References: <1445931324-1524-1-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> Jukka reported about the following warning:
> 
> "NOHZ: local_softirq_pending 08"
> 
> I remember this warning and we had a similar issue when using workqueues
> and calling netif_rx. See commit 5ff3fec ("mac802154: fix NOHZ
> local_softirq_pending 08 warning").
> 
> This warning occurs when calling "netif_rx" inside the wrong context
> (non softirq context). The net core api offers "netif_rx_ni" to call
> netif_rx inside the correct softirq context.
> 
> Reported-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/bluetooth/6lowpan.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

