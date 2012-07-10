Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 15:51:07 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 08/17] Bluetooth: Add support for Three-wire Link Control
 packets
Message-ID: <20120710185107.GF13847@joana>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
 <1340796367-10321-9-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340796367-10321-9-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-27 14:25:58 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch adds basic support for parsing and sending Three-wire UART
> Link Controll packets.

typo here, it is Control.

> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  drivers/bluetooth/hci_h5.c |   93 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 77 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index e27dce7..d602cc4 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -63,7 +63,6 @@ struct h5 {
>  	size_t			rx_pending;	/* Expecting more bytes */
>  	bool			rx_esc;		/* SLIP escape mode */
>  	u8			rx_ack;		/* Last ack number received */
> -	u8			rx_seq;		/* Last seq number received */
>  
>  	int			(*rx_func) (struct hci_uart *hu, u8 c);
>  
> @@ -71,6 +70,7 @@ struct h5 {
>  
>  	bool			tx_ack_req;	/* Pending ack to send */
>  	u8			tx_seq;		/* Next seq number to send */
> +	u8			tx_ack;		/* Next ack number to send */
>  };
>  
>  static void h5_reset_rx(struct h5 *h5);
> @@ -96,9 +96,26 @@ static void h5_timed_event(unsigned long arg)
>  	hci_uart_tx_wakeup(hu);
>  }
>  
> +static void h5_link_control(struct hci_uart *hu, const void *data, size_t len)
> +{
> +	struct h5 *h5 = hu->priv;
> +	struct sk_buff *nskb;
> +
> +	nskb = alloc_skb(3, GFP_ATOMIC);
> +	if (!nskb)
> +		return;
> +
> +	bt_cb(nskb)->pkt_type = HCI_3WIRE_LINK_PKT;
> +
> +	memcpy(skb_put(nskb, len), data, len);
> +
> +	skb_queue_tail(&h5->unrel, nskb);
> +}
> +
>  static int h5_open(struct hci_uart *hu)
>  {
>  	struct h5 *h5;
> +	const unsigned char sync[] = { 0x01, 0x7e };
>  
>  	BT_DBG("hu %p", hu);
>  
> @@ -118,6 +135,10 @@ static int h5_open(struct hci_uart *hu)
>  	h5->timer.function = h5_timed_event;
>  	h5->timer.data = (unsigned long) hu;
>  
> +	/* Send initial sync request */
> +	h5_link_control(hu, sync, sizeof(sync));
> +	mod_timer(&h5->timer, jiffies + HZ / 10);

remove this HZ usage please.

> +
>  	return 0;
>  }
>  
> @@ -146,6 +167,8 @@ static void h5_pkt_cull(struct h5 *h5)
>  	spin_lock_irqsave(&h5->unack.lock, flags);
>  
>  	to_remove = skb_queue_len(&h5->unack);
> +	if (to_remove == 0)
> +		goto unlock;
>  
>  	seq = h5->tx_seq;
>  
> @@ -172,12 +195,44 @@ static void h5_pkt_cull(struct h5 *h5)
>  	if (skb_queue_empty(&h5->unack))
>  		del_timer(&h5->timer);
>  
> +unlock:
>  	spin_unlock_irqrestore(&h5->unack.lock, flags);
>  }
>  
>  static void h5_handle_internal_rx(struct hci_uart *hu)
>  {
> +	struct h5 *h5 = hu->priv;
> +	const unsigned char sync_req[] = { 0x01, 0x7e };
> +	const unsigned char sync_rsp[] = { 0x02, 0x7d };
> +	const unsigned char conf_req[] = { 0x03, 0xfc, 0x01 };
> +	const unsigned char conf_rsp[] = { 0x04, 0x7b, 0x01 };
> +	const unsigned char *hdr = h5->rx_skb->data;
> +	const unsigned char *data = &h5->rx_skb->data[4];
> +
>  	BT_DBG("%s", hu->hdev->name);
> +
> +	if (H5_HDR_PKT_TYPE(hdr) != HCI_3WIRE_LINK_PKT)
> +		return;
> +
> +	if (H5_HDR_LEN(hdr) < 2)
> +		return;
> +
> +	if (memcmp(data, sync_req, 2) == 0)
> +		h5_link_control(hu, sync_rsp, 2);
> +	else if (memcmp(data, sync_rsp, 2) == 0)
> +		h5_link_control(hu, conf_req, 3);
> +	else if (memcmp(data, conf_req, 2) == 0) {
> +		h5_link_control(hu, conf_rsp, 2);
> +		h5_link_control(hu, conf_req, 3);
> +	} else if (memcmp(data, conf_rsp, 2) == 0) {
> +		BT_DBG("Three-wire init sequence complete");
> +		return;
> +	} else {
> +		BT_DBG("Link Control: 0x%02hhx 0x%02hhx", data[0], data[1]);
> +		return;
> +	}


There are missing braces here, some of them have but some of them not.

	Gustavo
