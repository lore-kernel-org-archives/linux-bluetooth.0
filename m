Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Jul 2012 11:44:10 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/17] Bluetooth: Add basic packet parsing to Three-wire
 UART driver
Message-ID: <20120709144410.GD536@joana>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
 <1340796367-10321-5-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340796367-10321-5-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-27 14:25:54 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch adds basic packet parsing to the Three-wire UART HCI driver
> for packets received from the controller.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  drivers/bluetooth/hci_h5.c |  230 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 222 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 0f97b05..3b33f90 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -32,20 +32,37 @@
>  
>  #define H5_TXWINSIZE 4
>  
> +/*
> + * Maximum Three-wire packet:
> + *     4 byte header + max value for 12-bit length + 2 bytes for CRC
> + */
> +#define H5_MAX_LEN (4 + 0xfff + 2)
> +
> +#define SLIP_DELIMITER	0xc0
> +#define SLIP_ESC	0xdb
> +#define SLIP_ESC_DELIM	0xdc
> +#define SLIP_ESC_ESC	0xdd
> +
>  struct h5 {
> -	struct sk_buff_head unack;	/* Unack'ed packets queue */
> -	struct sk_buff_head rel;	/* Reliable packets queue */
> -	struct sk_buff_head unrel;	/* Unreliable packets queue */
> +	struct sk_buff_head	unack;		/* Unack'ed packets queue */
> +	struct sk_buff_head	rel;		/* Reliable packets queue */
> +	struct sk_buff_head	unrel;		/* Unreliable packets queue */
>  
> -	struct sk_buff *rx_skb;
> +	struct sk_buff		*rx_skb;	/* Receive buffer */
> +	size_t			rx_pending;	/* Expecting more bytes */
> +	bool			rx_esc;		/* SLIP escape mode */
>  
> -	struct timer_list timer;	/* Retransmission timer */
> +	int			(*rx_func) (struct hci_uart *hu, u8 c);
>  
> -	bool txack_req;
> +	struct timer_list	timer;		/* Retransmission timer */
>  
> -	u8 msgq_txseq;
> +	bool			txack_req;

Can we merge those bool items in a flags field?

> +
> +	u8			msgq_txseq;
>  };
>  
> +static void h5_reset_rx(struct h5 *h5);
> +
>  static void h5_timed_event(unsigned long arg)
>  {
>  	struct hci_uart *hu = (struct hci_uart *) arg;
> @@ -83,6 +100,8 @@ static int h5_open(struct hci_uart *hu)
>  	skb_queue_head_init(&h5->rel);
>  	skb_queue_head_init(&h5->unrel);
>  
> +	h5_reset_rx(h5);
> +
>  	init_timer(&h5->timer);
>  	h5->timer.function = h5_timed_event;
>  	h5->timer.data = (unsigned long) hu;
> @@ -105,9 +124,204 @@ static int h5_close(struct hci_uart *hu)
>  	return 0;
>  }
>  
> +static void h5_handle_internal_rx(struct hci_uart *hu)
> +{
> +	BT_DBG("%s", hu->hdev->name);
> +}
> +
> +static void h5_complete_rx_pkt(struct hci_uart *hu)
> +{
> +	struct h5 *h5 = hu->priv;
> +	u8 pkt_type;
> +
> +	BT_DBG("%s", hu->hdev->name);
> +
> +	pkt_type = h5->rx_skb->data[1] & 0x0f;
> +
> +	switch (pkt_type) {
> +	case HCI_EVENT_PKT:
> +	case HCI_ACLDATA_PKT:
> +	case HCI_SCODATA_PKT:
> +		bt_cb(h5->rx_skb)->pkt_type = pkt_type;
> +
> +		/* Remove Three-wire header */
> +		skb_pull(h5->rx_skb, 4);
> +
> +		hci_recv_frame(h5->rx_skb);
> +		h5->rx_skb = NULL;
> +
> +		break;
> +
> +	default:
> +		h5_handle_internal_rx(hu);
> +		break;
> +	}
> +
> +	h5_reset_rx(h5);
> +}
> +
> +static int h5_rx_crc(struct hci_uart *hu, unsigned char c)
> +{
> +	struct h5 *h5 = hu->priv;
> +
> +	BT_DBG("%s 0x%02hhx", hu->hdev->name, c);
> +
> +	h5_complete_rx_pkt(hu);
> +	h5_reset_rx(h5);
> +
> +	return 0;

There is no point in returning int here.

> +}
> +
> +static int h5_rx_payload(struct hci_uart *hu, unsigned char c)
> +{
> +	struct h5 *h5 = hu->priv;
> +	const unsigned char *hdr = h5->rx_skb->data;
> +
> +	BT_DBG("%s 0x%02hhx", hu->hdev->name, c);
> +
> +	if ((hdr[0] >> 4) & 0x01) {
> +		h5->rx_func = h5_rx_crc;
> +		h5->rx_pending = 2;
> +	} else {
> +		h5_complete_rx_pkt(hu);
> +		h5_reset_rx(h5);
> +	}
> +
> +	return 0;
> +}
> +
> +static int h5_rx_3wire_hdr(struct hci_uart *hu, unsigned char c)
> +{
> +	struct h5 *h5 = hu->priv;
> +	const unsigned char *hdr = h5->rx_skb->data;
> +
> +	BT_DBG("%s 0x%02hhx", hu->hdev->name, c);
> +
> +	if (((hdr[0] + hdr[1] + hdr[2] + hdr[3]) & 0xff) != 0xff) {
> +		BT_ERR("Invalid header checksum");
> +		h5_reset_rx(h5);
> +		return 0;
> +	}
> +
> +	h5->rx_func = h5_rx_payload;
> +	h5->rx_pending = ((hdr[1] >> 4) & 0xff) + (hdr[2] << 4);
> +
> +	return 0;
> +}
> +
> +static int h5_rx_pkt_start(struct hci_uart *hu, unsigned char c)
> +{
> +	struct h5 *h5 = hu->priv;
> +
> +	BT_DBG("%s 0x%02hhx", hu->hdev->name, c);
> +
> +	if (c == SLIP_DELIMITER)
> +		return 1;
> +
> +	h5->rx_func = h5_rx_3wire_hdr;
> +	h5->rx_pending = 4;
> +
> +	h5->rx_skb = bt_skb_alloc(H5_MAX_LEN, GFP_ATOMIC);
> +	if (!h5->rx_skb) {
> +		BT_ERR("Can't allocate mem for new packet");
> +		h5_reset_rx(h5);
> +		return -ENOMEM;
> +	}
> +
> +	h5->rx_skb->dev = (void *) hu->hdev;
> +
> +	return 0;
> +}
> +
> +static int h5_rx_delimiter(struct hci_uart *hu, unsigned char c)
> +{
> +	struct h5 *h5 = hu->priv;
> +
> +	BT_DBG("%s 0x%02hhx", hu->hdev->name, c);
> +
> +	if (c == SLIP_DELIMITER)
> +		h5->rx_func = h5_rx_pkt_start;
> +
> +	return 1;

Same here.

	Gustavo
