Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v3 3/3] Bluetooth: Wrong style spin lock used
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414509409-11970-4-git-send-email-jukka.rissanen@linux.intel.com>
Date: Tue, 28 Oct 2014 09:02:37 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E21832E9-79BA-499D-B9B0-E380D1AC0E21@holtmann.org>
References: <1414509409-11970-1-git-send-email-jukka.rissanen@linux.intel.com> <1414509409-11970-4-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Use spin_lock_bh() as the code is called from softirq in networking subsystem.
> This is needed to prevent deadlocks when 6lowpan link is in use.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> net/bluetooth/hci_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index cb05d7f..0242e01 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4662,7 +4662,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
> 		skb_shinfo(skb)->frag_list = NULL;
> 
> 		/* Queue all fragments atomically */
> -		spin_lock(&queue->lock);
> +		spin_lock_bh(&queue->lock);

so I would actually prefer that we add a comment here why we need this. Since it is not obvious in this context that we might have a hci_send_acl from softirq. It really only happens with 6LoWPAN sending network packets since other L2CAP sockets will actually not trigger this.

Regards

Marcel

