Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/2] hci_bcsp: Add LE protocol on kernel side
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418368478-13956-2-git-send-email-tristan@lelong.xyz>
Date: Fri, 12 Dec 2014 14:58:33 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <0E818206-73C3-476C-BB9D-7CC686ED7FEC@holtmann.org>
References: <1418368478-13956-1-git-send-email-tristan@lelong.xyz> <1418368478-13956-2-git-send-email-tristan@lelong.xyz>
To: Tristan Lelong <tristan@lelong.xyz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tristan,

> Add the link establishment protocol handling in the kernel:
> - le_state enum to handle state machine
> - bcsp_timed_event to send LE messages
> - bcsp_handle_le_pkt to answer endpoint LE messages
> - various tests to muzzle BCSP link before GARULOUS
> 
> The patch exports some HCI functions that are required whitin BCSP to properly handle the connection reset.
> - hci_dev_reset_stat
> - hci_notify
> 
> Signed-off-by: Tristan Lelong <tristan@lelong.xyz>
> ---
> drivers/bluetooth/hci_bcsp.c     | 202 +++++++++++++++++++++++++++++++--------
> include/net/bluetooth/hci_core.h |   2 +
> net/bluetooth/hci_core.c         |   6 +-
> 3 files changed, 171 insertions(+), 39 deletions(-)

patch for drivers and net should always be separate. You need to split this.

> 
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index 21cc45b..142b42b 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -1,6 +1,5 @@
> /*
>  *
> - *  Bluetooth HCI UART driver

No idea why you are removing this line.

>  *
>  *  Copyright (C) 2002-2003  Fabrizio Gennari <fabrizio.gennari@philips.com>
>  *  Copyright (C) 2004-2005  Marcel Holtmann <marcel@holtmann.org>
> @@ -47,13 +46,25 @@
> 
> #include "hci_uart.h"
> 
> -#define VERSION "0.3"
> +#define VERSION "0.4"
> +
> +#define LE_POLLING	(HZ/10)
> +#define TX_POLLING	(HZ/4)
> 
> static bool txcrc = 1;
> static bool hciextn = 1;
> 
> +static u8 conf_pkt[4]     = { 0xad, 0xef, 0xac, 0xed };
> +static u8 conf_rsp_pkt[4] = { 0xde, 0xad, 0xd0, 0xd0 };
> +static u8 sync_pkt[4]     = { 0xda, 0xdc, 0xed, 0xed };
> +static u8 sync_rsp_pkt[4] = { 0xac, 0xaf, 0xef, 0xee };

This should be const actually.

> +
> +

And we do not do double empty lines. If that is in the code, then it is a leftover.

> #define BCSP_TXWINSIZE	4
> 
> +#define BCSP_PKT_LEN(data)	((data[1] >> 4) + (data[2]))
> +#define BCSP_LE_PKT_LEN	0x04
> +
> #define BCSP_ACK_PKT	0x05
> #define BCSP_LE_PKT	0x06
> 
> @@ -69,6 +80,12 @@ struct bcsp_struct {
> 	struct	timer_list tbcsp;
> 
> 	enum {
> +		BCSP_SHY = 0,
> +		BCSP_CURIOUS,
> +		BCSP_GARULOUS
> +	} le_state;
> +
> +	enum {
> 		BCSP_W4_PKT_DELIMITER,
> 		BCSP_W4_PKT_START,
> 		BCSP_W4_BCSP_HDR,
> @@ -184,6 +201,9 @@ static struct sk_buff *bcsp_prepare_pkt(struct bcsp_struct *bcsp, u8 *data,
> 	u16 BCSP_CRC_INIT(bcsp_txmsg_crc);
> 	int rel, i;
> 
> +	if (bcsp->le_state != BCSP_GARULOUS && pkt_type != BCSP_LE_PKT)
> +		return NULL;
> +
> 	switch (pkt_type) {
> 	case HCI_ACLDATA_PKT:
> 		chan = 6;	/* BCSP ACL channel */
> @@ -299,6 +319,8 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
> 			return nskb;
> 		} else {
> 			skb_queue_head(&bcsp->unrel, skb);
> +			if (bcsp->le_state == BCSP_GARULOUS)
> +				return NULL;
> 			BT_ERR("Could not dequeue pkt because alloc_skb failed");
> 		}
> 	}
> @@ -316,11 +338,18 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
> 								bt_cb(skb)->pkt_type);
> 			if (nskb) {
> 				__skb_queue_tail(&bcsp->unack, skb);
> -				mod_timer(&bcsp->tbcsp, jiffies + HZ / 4);
> +
> +				if (bcsp->le_state == BCSP_GARULOUS)
> +					/* only re-arm retransmit timer
> +					 * if the BCSP link is connected */
> +					mod_timer(&bcsp->tbcsp,
> +						jiffies + HZ / 4);
> 				spin_unlock_irqrestore(&bcsp->unack.lock, flags);
> 				return nskb;
> 			} else {
> 				skb_queue_head(&bcsp->rel, skb);
> +				if (bcsp->le_state != BCSP_GARULOUS)
> +					return NULL;
> 				BT_ERR("Could not dequeue pkt because alloc_skb failed");
> 			}
> 		}
> @@ -386,7 +415,7 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
> 		kfree_skb(skb);
> 	}
> 
> -	if (skb_queue_empty(&bcsp->unack))
> +	if (skb_queue_empty(&bcsp->unack) && bcsp->le_state == BCSP_GARULOUS)
> 		del_timer(&bcsp->tbcsp);
> 
> 	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
> @@ -395,34 +424,100 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
> 		BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
> }
> 
> -/* Handle BCSP link-establishment packets. When we
> -   detect a "sync" packet, symptom that the BT module has reset,
> -   we do nothing :) (yet) */
> +static void bcsp_internal_reset(struct hci_uart *hu)
> +{
> +	struct bcsp_struct *bcsp = hu->priv;
> +
> +	/* reset the bcsp stack counters */
> +	bcsp->rxseq_txack = 0;
> +	bcsp->rxack = 0;
> +	bcsp->message_crc = 0;
> +	bcsp->txack_req = 0;
> +	bcsp->msgq_txseq = 0;
> +
> +	/* reset state machine */
> +	bcsp->le_state = BCSP_SHY;
> +	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
> +	bcsp->rx_esc_state = BCSP_ESCSTATE_NOESC;
> +
> +	/* empty all the queues */
> +	skb_queue_purge(&bcsp->unack);
> +	skb_queue_purge(&bcsp->rel);
> +	skb_queue_purge(&bcsp->unrel);
> +
> +	/* tell upper layer about the reset */
> +	hci_dev_reset_stat(hu->hdev->id);
> +
> +	hci_notify(hu->hdev, HCI_DEV_UNREG);

We introduced hci_reset_dev for the H:5 protocol. And I think that is the same that should be used here. The core only injects are hardware error event at the moment, but that is a core bug and we should fix that to handle proper stack reset when that happens. The driver should not hack around this.

> +
> +	bcsp->tbcsp.expires  = jiffies + LE_POLLING;
> +	add_timer(&bcsp->tbcsp);
> +}
> +
> +/* Handle BCSP link-establishment packets.
> + */
> static void bcsp_handle_le_pkt(struct hci_uart *hu)
> {
> +	struct sk_buff *nskb;
> 	struct bcsp_struct *bcsp = hu->priv;
> -	u8 conf_pkt[4]     = { 0xad, 0xef, 0xac, 0xed };
> -	u8 conf_rsp_pkt[4] = { 0xde, 0xad, 0xd0, 0xd0 };
> -	u8 sync_pkt[4]     = { 0xda, 0xdc, 0xed, 0xed };
> -
> -	/* spot "conf" pkts and reply with a "conf rsp" pkt */
> -	if (bcsp->rx_skb->data[1] >> 4 == 4 && bcsp->rx_skb->data[2] == 0 &&
> -			!memcmp(&bcsp->rx_skb->data[4], conf_pkt, 4)) {
> -		struct sk_buff *nskb = alloc_skb(4, GFP_ATOMIC);
> -
> -		BT_DBG("Found a LE conf pkt");
> -		if (!nskb)
> -			return;
> -		memcpy(skb_put(nskb, 4), conf_rsp_pkt, 4);
> -		bt_cb(nskb)->pkt_type = BCSP_LE_PKT;
> -
> -		skb_queue_head(&bcsp->unrel, nskb);
> -		hci_uart_tx_wakeup(hu);
> -	}
> -	/* Spot "sync" pkts. If we find one...disaster! */
> -	else if (bcsp->rx_skb->data[1] >> 4 == 4 && bcsp->rx_skb->data[2] == 0 &&
> -			!memcmp(&bcsp->rx_skb->data[4], sync_pkt, 4)) {
> -		BT_ERR("Found a LE sync pkt, card has reset");
> +
> +	if (BCSP_PKT_LEN(bcsp->rx_skb->data) == BCSP_LE_PKT_LEN) {
> +		/* spot "conf" pkts and reply with a "conf rsp" pkt */
> +		if (!memcmp(&bcsp->rx_skb->data[4], conf_pkt, 4)) {
> +			if (bcsp->le_state == BCSP_SHY)
> +				return;
> +
> +			BT_DBG("Found a LE conf pkt");
> +			nskb = alloc_skb(4, GFP_ATOMIC);
> +			if (!nskb)
> +				return;
> +			memcpy(skb_put(nskb, 4), conf_rsp_pkt, 4);
> +			bt_cb(nskb)->pkt_type = BCSP_LE_PKT;
> +
> +			skb_queue_head(&bcsp->unrel, nskb);
> +			hci_uart_tx_wakeup(hu);
> +		}
> +		/* Spot "sync" pkts and reply with a "sync rsp" pkt */
> +		else if (!memcmp(&bcsp->rx_skb->data[4], sync_pkt, 4)) {
> +			if (bcsp->le_state == BCSP_GARULOUS)
> +				/* we force the connection state to reset */
> +				bcsp_internal_reset(hu);

These needs { }. If you end up having a comment include it in { } even if the compiler does not care. That is for our reading sake.

> +
> +			BT_INFO("BCSP: hci%d LE sync pkt, performing reset",
> +					hu->hdev->id);

Align the second line properly according to the coding style. Even if previous code might actually violate it.

> +
> +			nskb = alloc_skb(4, GFP_ATOMIC);
> +			if (!nskb)
> +				return;
> +			memcpy(skb_put(nskb, 4), sync_rsp_pkt, 4);
> +			bt_cb(nskb)->pkt_type = BCSP_LE_PKT;
> +
> +			skb_queue_head(&bcsp->unrel, nskb);
> +			hci_uart_tx_wakeup(hu);
> +		}
> +		/* Spot "conf rsp" pkts and update state machine */
> +		else if (!memcmp(&bcsp->rx_skb->data[4], conf_rsp_pkt, 4)) {

It should be } else if

> +			if (bcsp->le_state != BCSP_CURIOUS) {
> +				BT_DBG("BCSP: hci%d ingoring conf_resp packet",
> +						hu->hdev->id);

Same here. Proper alignment.

> +				return;
> +			}
> +
> +			BT_INFO("BCSP: hci%d connected", hu->hdev->id);
> +			bcsp->le_state = BCSP_GARULOUS;
> +		}
> +		/* Spot "sync rsp" pkts and update state machine */

Same here. } else if

> +		else if (!memcmp(&bcsp->rx_skb->data[4], sync_rsp_pkt, 4)) {
> +			if (bcsp->le_state != BCSP_SHY) {
> +				BT_DBG("BCSP: hci%d ignoring sync_resp packet",
> +						hu->hdev->id);

And alignment adjustment here.

> +				return;
> +			}
> +
> +			BT_DBG("Found a LE sync rsp pkt");
> +			bcsp->le_state = BCSP_CURIOUS;
> +		}
> +
> 	}
> }
> 
> @@ -537,12 +632,13 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
> 			}
> 		} else
> 			kfree_skb(bcsp->rx_skb);
> -	} else {
> +	} else if (bcsp->le_state == BCSP_GARULOUS) {
> 		/* Pull out BCSP hdr */
> 		skb_pull(bcsp->rx_skb, 4);
> 
> 		hci_recv_frame(hu->hdev, bcsp->rx_skb);
> -	}
> +	} else
> +		kfree_skb(bcsp->rx_skb);

If one part uses { }, then all of them have to use it.

> 
> 	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
> 	bcsp->rx_skb = NULL;
> @@ -676,16 +772,42 @@ static void bcsp_timed_event(unsigned long arg)
> 	struct sk_buff *skb;
> 	unsigned long flags;
> 
> -	BT_DBG("hu %p retransmitting %u pkts", hu, bcsp->unack.qlen);
> +	switch (bcsp->le_state) {
> +	case BCSP_GARULOUS:
> +		BT_DBG("hu %p retransmitting %u pkts", hu, bcsp->unack.qlen);
> 
> -	spin_lock_irqsave_nested(&bcsp->unack.lock, flags, SINGLE_DEPTH_NESTING);
> +		spin_lock_irqsave_nested(&bcsp->unack.lock, flags,
> +				SINGLE_DEPTH_NESTING);

Alignment with &bcsp-> please.

> 
> -	while ((skb = __skb_dequeue_tail(&bcsp->unack)) != NULL) {
> -		bcsp->msgq_txseq = (bcsp->msgq_txseq - 1) & 0x07;
> -		skb_queue_head(&bcsp->rel, skb);
> -	}
> +		while ((skb = __skb_dequeue_tail(&bcsp->unack)) != NULL) {
> +			bcsp->msgq_txseq = (bcsp->msgq_txseq - 1) & 0x07;
> +			skb_queue_head(&bcsp->rel, skb);
> +		}
> 
> -	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
> +		spin_unlock_irqrestore(&bcsp->unack.lock, flags);
> +		break;
> +	case BCSP_CURIOUS:
> +		skb = alloc_skb(4, GFP_ATOMIC);
> +		memcpy(skb_put(skb, 4), conf_pkt, 4);
> +		bt_cb(skb)->pkt_type = BCSP_LE_PKT;
> +		skb_queue_head(&bcsp->unrel, skb);
> +
> +		bcsp->tbcsp.expires += LE_POLLING;
> +		add_timer(&bcsp->tbcsp);
> +		break;
> +	default:
> +		BT_INFO("Internal state unknown. Assuming not connected.");
> +		bcsp->le_state = BCSP_SHY;
> +	case BCSP_SHY:
> +		skb = alloc_skb(4, GFP_ATOMIC);
> +		memcpy(skb_put(skb, 4), sync_pkt, 4);
> +		bt_cb(skb)->pkt_type = BCSP_LE_PKT;
> +		skb_queue_head(&bcsp->unrel, skb);
> +
> +		bcsp->tbcsp.expires += LE_POLLING;
> +		add_timer(&bcsp->tbcsp);
> +		break;
> +	}
> 
> 	hci_uart_tx_wakeup(hu);
> }
> @@ -708,12 +830,16 @@ static int bcsp_open(struct hci_uart *hu)
> 	init_timer(&bcsp->tbcsp);
> 	bcsp->tbcsp.function = bcsp_timed_event;
> 	bcsp->tbcsp.data     = (u_long) hu;
> +	bcsp->tbcsp.expires  = jiffies + LE_POLLING;
> 
> 	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
> +	bcsp->le_state = BCSP_SHY;
> 
> 	if (txcrc)
> 		bcsp->use_crc = 1;
> 
> +	add_timer(&bcsp->tbcsp);
> +
> 	return 0;
> }
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 1dae700..6fd8356 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -735,6 +735,8 @@ int hci_disconnect(struct hci_conn *conn, __u8 reason);
> bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
> void hci_sco_setup(struct hci_conn *conn, __u8 status);
> 
> +void hci_notify(struct hci_dev *hdev, int event);
> +
> struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
> 			      u8 role);
> int hci_conn_del(struct hci_conn *conn);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index f001856..2c5130a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -65,10 +65,12 @@ static DEFINE_IDA(hci_index_ida);
> 
> /* ---- HCI notifications ---- */
> 
> -static void hci_notify(struct hci_dev *hdev, int event)
> +void hci_notify(struct hci_dev *hdev, int event)
> {
> 	hci_sock_dev_event(hdev, event);
> }
> +EXPORT_SYMBOL(hci_notify);
> +

We will never export this internal detail to drivers. Use hci_reset_dev and lets get a proper stack reset handling implemented.

> 
> /* ---- HCI debugfs entries ---- */
> 
> @@ -2783,6 +2785,8 @@ done:
> 	hci_dev_put(hdev);
> 	return ret;
> }
> +EXPORT_SYMBOL(hci_dev_reset_stat);
> +

I have no idea why I would ever allow a driver to reset these. Even in case of errors it is fine to keep counting.

Regards

Marcel

