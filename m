Return-Path: <cyrus@holtmann.org>
Message-ID: <543E7414.8090209@hurleysoftware.com>
Date: Wed, 15 Oct 2014 09:18:12 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Incorrect locking when sending data in softirq
References: <1413376985-25812-1-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1413376985-25812-1-git-send-email-jukka.rissanen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

On 10/15/2014 08:43 AM, Jukka Rissanen wrote:
> Use spin_lock_irqsave() when sending data to hci channel. Otherwise
> the lockdep gives inconsistent lock state warning when sending data
> to 6lowpan channel.
> 
>  [ INFO: inconsistent lock state ]
>  3.17.0-rc1-bt6lowpan #1 Not tainted
>  ---------------------------------
>  inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>  kworker/u3:0/321 [HC0[0]:SC0[0]:HE1:SE1] takes:
>   (&(&list->lock)->rlock#6){+.?...}, at: [<f845fdac>] hci_send_acl+0xac/0x290 [bluetooth]
>  {IN-SOFTIRQ-W} state was registered at:
>    [<c10915a3>] __lock_acquire+0x6d3/0x1d20
>    [<c109325d>] lock_acquire+0x9d/0x140
>    [<c1889c25>] _raw_spin_lock+0x45/0x80
>    [<f845fdac>] hci_send_acl+0xac/0x290 [bluetooth]
>    [<f8480c60>] l2cap_do_send+0x60/0x100 [bluetooth]
>    [<f8484830>] l2cap_chan_send+0x7f0/0x10e0 [bluetooth]
>    [<f873191e>] send_pkt+0x4e/0xa0 [bluetooth_6lowpan]
>    [<f8731d20>] bt_xmit+0x3b0/0x770 [bluetooth_6lowpan]
>    [<c17742f4>] dev_hard_start_xmit+0x344/0x670
>    [<c17749ad>] __dev_queue_xmit+0x38d/0x680
>    [<c1774caf>] dev_queue_xmit+0xf/0x20
>    [<c177b8b0>] neigh_connected_output+0x130/0x1a0
>    [<c1812a63>] ip6_finish_output2+0x173/0x8c0
>    [<c18182db>] ip6_finish_output+0x7b/0x1b0
>    [<c18184a7>] ip6_output+0x97/0x2a0
>    [<c183a46b>] mld_sendpack+0x5eb/0x650
>    [<c183acc1>] mld_ifc_timer_expire+0x191/0x2f0
>    [<c10ac385>] call_timer_fn+0x85/0x1c0
>    [<c10acb72>] run_timer_softirq+0x192/0x280
>    [<c104fd84>] __do_softirq+0xd4/0x300
>    [<c10049fc>] do_softirq_own_stack+0x2c/0x40
>    [<c1050136>] irq_exit+0x86/0xb0
>    [<c188bd98>] smp_apic_timer_interrupt+0x38/0x50
>    [<c188b6ce>] apic_timer_interrupt+0x32/0x38
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> Hi,
> 
> this patch fixes the locking issue when sending larger amount of
> data via 6lowpan link. After this patch the lockdep no longer warns
> about softirq issues. 
> 
> Cheers,
> Jukka
> 
> 
>  net/bluetooth/hci_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8aea4be..3e295ff 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4642,6 +4642,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
>  	struct hci_conn *conn = chan->conn;
>  	struct hci_dev *hdev = conn->hdev;
>  	struct sk_buff *list;
> +	unsigned long irq_flags;
>  
>  	skb->len = skb_headlen(skb);
>  	skb->data_len = 0;
> @@ -4673,7 +4674,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
>  		skb_shinfo(skb)->frag_list = NULL;
>  
>  		/* Queue all fragments atomically */
> -		spin_lock(&queue->lock);
> +		spin_lock_irqsave(&queue->lock, irq_flags);

spin_lock_bh(&queue->lock) will suffice.

Also, please consider submitting a patch to netdev to document the lock
requirement with the struct sk_buff_head definition.

Regards,
Peter Hurley

>  
>  		__skb_queue_tail(queue, skb);
>  
> @@ -4690,7 +4691,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
>  			__skb_queue_tail(queue, skb);
>  		} while (list);
>  
> -		spin_unlock(&queue->lock);
> +		spin_unlock_irqrestore(&queue->lock, irq_flags);
>  	}
>  }
>  
> 

