Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Jul 2012 11:34:44 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 03/17] Bluetooth: Add initial reliable packet support for
 Three-wire UART
Message-ID: <20120709143444.GC536@joana>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
 <1340796367-10321-4-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340796367-10321-4-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-27 14:25:53 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch adds initial support for reliable packets along with the
> necessary retransmission timer for the Three-wire UART HCI driver.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  drivers/bluetooth/hci_h5.c |   52 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index c610ba3..0f97b05 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -39,11 +39,34 @@ struct h5 {
>  
>  	struct sk_buff *rx_skb;
>  
> +	struct timer_list timer;	/* Retransmission timer */
> +
>  	bool txack_req;
>  
>  	u8 msgq_txseq;
>  };
>  
> +static void h5_timed_event(unsigned long arg)
> +{
> +	struct hci_uart *hu = (struct hci_uart *) arg;
> +	struct h5 *h5 = hu->priv;
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +
> +	BT_DBG("hu %p retransmitting %u pkts", hu, h5->unack.qlen);
> +
> +	spin_lock_irqsave_nested(&h5->unack.lock, flags, SINGLE_DEPTH_NESTING);
> +
> +	while ((skb = __skb_dequeue_tail(&h5->unack)) != NULL) {
> +		h5->msgq_txseq = (h5->msgq_txseq - 1) & 0x07;
> +		skb_queue_head(&h5->rel, skb);
> +	}
> +
> +	spin_unlock_irqrestore(&h5->unack.lock, flags);
> +
> +	hci_uart_tx_wakeup(hu);
> +}
> +
>  static int h5_open(struct hci_uart *hu)
>  {
>  	struct h5 *h5;
> @@ -60,6 +83,10 @@ static int h5_open(struct hci_uart *hu)
>  	skb_queue_head_init(&h5->rel);
>  	skb_queue_head_init(&h5->unrel);
>  
> +	init_timer(&h5->timer);
> +	h5->timer.function = h5_timed_event;
> +	h5->timer.data = (unsigned long) hu;
> +
>  	return 0;
>  }
>  
> @@ -71,6 +98,8 @@ static int h5_close(struct hci_uart *hu)
>  	skb_queue_purge(&h5->rel);
>  	skb_queue_purge(&h5->unrel);
>  
> +	del_timer(&h5->timer);
> +
>  	kfree(h5);
>  
>  	return 0;
> @@ -125,6 +154,7 @@ static struct sk_buff *h5_prepare_ack(struct h5 *h5)
>  static struct sk_buff *h5_dequeue(struct hci_uart *hu)
>  {
>  	struct h5 *h5 = hu->priv;
> +	unsigned long flags;
>  	struct sk_buff *skb, *nskb;
>  
>  	if ((skb = skb_dequeue(&h5->unrel)) != NULL) {
> @@ -138,6 +168,28 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
>  		BT_ERR("Could not dequeue pkt because alloc_skb failed");
>  	}
>  
> +	spin_lock_irqsave_nested(&h5->unack.lock, flags, SINGLE_DEPTH_NESTING);
> +
> +	if (h5->unack.qlen >= H5_TXWINSIZE)
> +	       goto unlock;
> +
> +	if ((skb = skb_dequeue(&h5->rel)) != NULL) {
> +		nskb = h5_prepare_pkt(h5, skb);
> +
> +		if (nskb) {
> +			__skb_queue_tail(&h5->unack, skb);
> +			mod_timer(&h5->timer, jiffies + HZ / 4);

Better use a milliseconds value here, and then turn it in jiffies. If
CONFIG_HZ is not set to 1000 we set the wrong value for the timer.

	Gustavo
