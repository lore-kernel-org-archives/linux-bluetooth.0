Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 15:58:44 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 14/17] Bluetooth: Add initialization tracking to HCI
 Three-wire driver
Message-ID: <20120710185844.GI13847@joana>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
 <1340796367-10321-15-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340796367-10321-15-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-27 14:26:04 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch adds tracking for the uninitialized, initialized and active
> states for Three-wire UART. This is needed so we can handle periodic
> sending of the Link Establishment messages before reaching active state
> and so that we do not try to do any higher level HCI data transmission
> before reaching active state.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  drivers/bluetooth/hci_h5.c |   70 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 52 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index d26f801..1e83118 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -72,18 +72,53 @@ struct h5 {
>  	u8			tx_seq;		/* Next seq number to send */
>  	u8			tx_ack;		/* Next ack number to send */
>  
> +	enum {
> +		H5_UNINITIALIZED,
> +		H5_INITIALIZED,
> +		H5_ACTIVE,
> +	} state;
> +
>  	bool			sleeping;
>  };
>  
>  static void h5_reset_rx(struct h5 *h5);
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
>  static void h5_timed_event(unsigned long arg)
>  {
> +	const unsigned char sync_req[] = { 0x01, 0x7e };
> +	const unsigned char conf_req[] = { 0x03, 0xfc, 0x01 };
>  	struct hci_uart *hu = (struct hci_uart *) arg;
>  	struct h5 *h5 = hu->priv;
>  	struct sk_buff *skb;
>  	unsigned long flags;
>  
> +	if (h5->state == H5_UNINITIALIZED)
> +		h5_link_control(hu, sync_req, sizeof(sync_req));
> +
> +	if (h5->state == H5_INITIALIZED)
> +		h5_link_control(hu, conf_req, sizeof(conf_req));
> +
> +	if (h5->state != H5_ACTIVE) {
> +		mod_timer(&h5->timer, jiffies + HZ / 10);
> +		goto wakeup;

Another HZ usage.

	Gustavo
