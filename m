Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: BCSP fails to ACK re-transmitted frames from the peer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389544033-16974-1-git-send-email-Dean_Jenkins@mentor.com>
Date: Wed, 15 Jan 2014 22:20:03 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Message-Id: <0581BFF7-3183-48CA-8CB5-675F72737666@holtmann.org>
References: <1389544033-16974-1-git-send-email-Dean_Jenkins@mentor.com>
To: dean_jenkins@mentor.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

> Send an ACK frame with the current txack value in response to
> every received reliable frame unless a TX reliable frame is being
> sent. This modification allows re-transmitted frames from the remote
> peer to be acknowledged rather than ignored. It means that the remote
> peer knows which frame number to start re-transmitting from.
> 
> Without this modification, the recovery time to a missing frame
> from the remote peer was unnecessarily being extended because the
> headers of the out of order reliable frames were being discarded rather
> than being processed. The frame headers of received frames will
> indicate whether the local peer's transmissions have been
> acknowledged by the remote peer. Therefore, the local peer may
> unnecessarily re-transmit despite the remote peer already indicating
> that the frame had been acknowledged in out of order reliable frame.
> 
> Signed-off-by: Dean Jenkins <djenkins@mentor.com>
> ---
> drivers/bluetooth/hci_bcsp.c | 94 ++++++++++++++++++++++++++++----------------
> 1 file changed, 60 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index 0bc87f7..449de29 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -473,13 +473,30 @@ static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char
> static void bcsp_complete_rx_pkt(struct hci_uart *hu)
> {
> 	struct bcsp_struct *bcsp = hu->priv;
> -	int pass_up;
> +	int pass_up = 0;
> 
> 	if (bcsp->rx_skb->data[0] & 0x80) {	/* reliable pkt */
> 		BT_DBG("Received seqno %u from card", bcsp->rxseq_txack);
> -		bcsp->rxseq_txack++;
> -		bcsp->rxseq_txack %= 0x8;
> -		bcsp->txack_req    = 1;
> +
> +		/* check the rx sequence number is as expected */
> +		if ((bcsp->rx_skb->data[0] & 0x07) == bcsp->rxseq_txack) {
> +			bcsp->rxseq_txack++;
> +			bcsp->rxseq_txack %= 0x8;
> +		} else {
> +			/*
> +			 * handle re-transmitted packet or
> +			 * when packet was missed
> +			 */
> +			BT_ERR("Out-of-order packet arrived, got %u expected %u",
> +				bcsp->rx_skb->data[0] & 0x07,
> +				bcsp->rxseq_txack);

please make sure to use the coding style of the network subsystem.

> +
> +			/* do not process out-of-order packet payload */
> +			pass_up = 2;
> +		}
> +
> +		/* send current txack value to all recieved reliable packets */
> +		bcsp->txack_req = 1;
> 
> 		/* If needed, transmit an ack pkt */
> 		hci_uart_tx_wakeup(hu);
> @@ -488,26 +505,35 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
> 	bcsp->rxack = (bcsp->rx_skb->data[0] >> 3) & 0x07;
> 	BT_DBG("Request for pkt %u from card", bcsp->rxack);
> 
> +	/*
> +	 * handle recieved ACK indications,
> +	 * including those from out-of-order packets
> +	 */
> 	bcsp_pkt_cull(bcsp);
> -	if ((bcsp->rx_skb->data[1] & 0x0f) == 6 &&
> -			bcsp->rx_skb->data[0] & 0x80) {
> -		bt_cb(bcsp->rx_skb)->pkt_type = HCI_ACLDATA_PKT;
> -		pass_up = 1;
> -	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 5 &&
> -			bcsp->rx_skb->data[0] & 0x80) {
> -		bt_cb(bcsp->rx_skb)->pkt_type = HCI_EVENT_PKT;
> -		pass_up = 1;
> -	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 7) {
> -		bt_cb(bcsp->rx_skb)->pkt_type = HCI_SCODATA_PKT;
> -		pass_up = 1;
> -	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 1 &&
> -			!(bcsp->rx_skb->data[0] & 0x80)) {
> -		bcsp_handle_le_pkt(hu);
> -		pass_up = 0;
> -	} else
> -		pass_up = 0;
> -
> -	if (!pass_up) {
> +
> +	if (pass_up != 2) {
> +		if ((bcsp->rx_skb->data[1] & 0x0f) == 6 &&
> +				bcsp->rx_skb->data[0] & 0x80) {

Same here. Please use network subsystem indentation.

> +			bt_cb(bcsp->rx_skb)->pkt_type = HCI_ACLDATA_PKT;
> +			pass_up = 1;
> +		} else if ((bcsp->rx_skb->data[1] & 0x0f) == 5 &&
> +				bcsp->rx_skb->data[0] & 0x80) {
> +			bt_cb(bcsp->rx_skb)->pkt_type = HCI_EVENT_PKT;
> +			pass_up = 1;
> +		} else if ((bcsp->rx_skb->data[1] & 0x0f) == 7) {
> +			bt_cb(bcsp->rx_skb)->pkt_type = HCI_SCODATA_PKT;
> +			pass_up = 1;
> +		} else if ((bcsp->rx_skb->data[1] & 0x0f) == 1 &&
> +				!(bcsp->rx_skb->data[0] & 0x80)) {
> +			bcsp_handle_le_pkt(hu);
> +			pass_up = 0;
> +		} else
> +			pass_up = 0;

Network subsystem requires { } if any branch uses it.

> +	}
> +
> +	switch (pass_up) {
> +	case 0:
> +	{
> 		struct hci_event_hdr hdr;
> 		u8 desc = (bcsp->rx_skb->data[1] & 0x0f);
> 
> @@ -532,11 +558,21 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
> 			}
> 		} else
> 			kfree_skb(bcsp->rx_skb);
> -	} else {
> +		break;
> +	}
> +	case 1:
> 		/* Pull out BCSP hdr */
> 		skb_pull(bcsp->rx_skb, 4);
> 
> 		hci_recv_frame(hu->hdev, bcsp->rx_skb);
> +		break;
> +	default:
> +		/*
> +		 * ignore packet payload of already ACKed re-transmitted
> +		 * packets or when a packet was missed in the BCSP window
> +		 */
> +		kfree_skb(bcsp->rx_skb);
> +		break;
> 	}
> 
> 	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
> @@ -582,16 +618,6 @@ static int bcsp_recv(struct hci_uart *hu, void *data, int count)
> 				bcsp->rx_count = 0;
> 				continue;
> 			}
> -			if (bcsp->rx_skb->data[0] & 0x80	/* reliable pkt */
> -			    		&& (bcsp->rx_skb->data[0] & 0x07) != bcsp->rxseq_txack) {
> -				BT_ERR ("Out-of-order packet arrived, got %u expected %u",
> -					bcsp->rx_skb->data[0] & 0x07, bcsp->rxseq_txack);
> -
> -				kfree_skb(bcsp->rx_skb);
> -				bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
> -				bcsp->rx_count = 0;
> -				continue;
> -			}
> 			bcsp->rx_state = BCSP_W4_DATA;
> 			bcsp->rx_count = (bcsp->rx_skb->data[1] >> 4) + 
> 					(bcsp->rx_skb->data[2] << 4);	/* May be 0 */

Regards

Marcel

