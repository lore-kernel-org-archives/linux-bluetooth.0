Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v5] Add support for the Atheros AR300x Bluetooth Chip
From: Marcel Holtmann <marcel@holtmann.org>
To: suraj <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Luis.Rodriguez@Atheros.com,
	Jothikumar.Mothilal@Atheros.com, gfpadovan@gmail.com
In-Reply-To: <1271927414.1409.3.camel@atheros013-desktop>
References: <1268629296.21425.23.camel@atheros013-desktop>
	 <1271758832.6585.33.camel@atheros013-desktop>
	 <1271845337.15010.1.camel@atheros013-desktop>
	 <1271927414.1409.3.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 20 May 2010 18:09:11 +0200
Message-ID: <1274371751.27220.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

for every new patch version, please start a new thread. If you re-use an
old thread, I will most likely ignore it.

> +static struct sk_buff *ath_dequeue(struct hci_uart *hu)
> +{
> +	struct ath_struct *ath = hu->priv;
> +	struct sk_buff *skbuf;
> +
> +	skbuf = skb_dequeue(&ath->txq);
> +
> +	if (!skbuf)
> +		return NULL;
> +
> +	/*
> +	 * Check if the HCI command is  HCI sleep enable and
> +	 * update the sleep enable flag with command parameter.
> +	 *
> +	 * Value of sleep enable flag will be used later
> +	 * to verify if controller has to be woken up before
> +	 * sending any packet.
> +	 */
> +	if (skbuf->data[0] == 0x01 &&
> +	    skbuf->data[1] == 0x04 &&
> +	    skbuf->data[2] == 0xFC)
> +		ath->cur_sleep = skbuf->data[4];
> +
> +	return skbuf;
> +}

I don't really like this. I know we don't have any infrastructure to
forward vendor commands back to the driver. And we might need to change
that actually.

However at least for now use the headers and constants and not magic
numbers here.

> +static void ath_check_data_len(struct ath_struct *ath, int len)
> +{
> +	int room = skb_tailroom(ath->rx_skb);
> +
> +	BT_DBG("len %d room %d", len, room);
> +
> +	if (len > room) {
> +		BT_ERR("Data length is too large");
> +		kfree_skb(ath->rx_skb);
> +		ath->rx_state = HCIATH_W4_PACKET_TYPE;
> +		ath->rx_skb = NULL;
> +		ath->rx_count = 0;
> +	} else {
> +		ath->rx_state = HCIATH_W4_DATA;
> +		ath->rx_count = len;
> +	}
> +}
> +
> +/* Recv data */
> +static int ath_recv(struct hci_uart *hu, void *data, int count)
> +{
> +	struct ath_struct *ath = hu->priv;
> +	char *ptr = data;
> +	struct hci_event_hdr *eh;
> +	struct hci_acl_hdr *ah;
> +	struct hci_sco_hdr *sh;
> +	int len, type, dlen;
> +
> +	BT_DBG("hu %p count %d rx_state %d rx_count %d", hu, count,
> +	       ath->rx_state, ath->rx_count);
> +
> +	while (count) {
> +		if (ath->rx_count) {
> +
> +			len = min_t(unsigned int, ath->rx_count, count);
> +			memcpy(skb_put(ath->rx_skb, len), ptr, len);
> +			ath->rx_count -= len;
> +			count -= len;
> +			ptr += len;
> +
> +			if (ath->rx_count)
> +				continue;
> +			switch (ath->rx_state) {
> +			case HCIATH_W4_DATA:
> +				hci_recv_frame(ath->rx_skb);
> +				ath->rx_state = HCIATH_W4_PACKET_TYPE;
> +				ath->rx_skb = NULL;
> +				ath->rx_count = 0;
> +				continue;
> +
> +			case HCIATH_W4_EVENT_HDR:
> +				eh = hci_event_hdr(ath->rx_skb);
> +
> +				BT_DBG("Event header: evt 0x%2.2x plen %d",
> +				       eh->evt, eh->plen);
> +
> +				ath_check_data_len(ath, eh->plen);
> +				continue;
> +
> +			case HCIATH_W4_ACL_HDR:
> +				ah = hci_acl_hdr(ath->rx_skb);
> +				dlen = __le16_to_cpu(ah->dlen);
> +
> +				BT_DBG("ACL header: dlen %d", dlen);
> +
> +				ath_check_data_len(ath, dlen);
> +				continue;
> +
> +			case HCIATH_W4_SCO_HDR:
> +				sh = hci_sco_hdr(ath->rx_skb);
> +
> +				BT_DBG("SCO header: dlen %d", sh->dlen);
> +
> +				ath_check_data_len(ath, sh->dlen);
> +				continue;
> +
> +			}
> +		}
> +
> +		/* HCIATH_W4_PACKET_TYPE */
> +		switch (*ptr) {
> +		case HCI_EVENT_PKT:
> +			BT_DBG("Event packet");
> +			ath->rx_state = HCIATH_W4_EVENT_HDR;
> +			ath->rx_count = HCI_EVENT_HDR_SIZE;
> +			type = HCI_EVENT_PKT;
> +			break;
> +
> +		case HCI_ACLDATA_PKT:
> +			BT_DBG("ACL packet");
> +			ath->rx_state = HCIATH_W4_ACL_HDR;
> +			ath->rx_count = HCI_ACL_HDR_SIZE;
> +			type = HCI_ACLDATA_PKT;
> +			break;
> +
> +		case HCI_SCODATA_PKT:
> +			BT_DBG("SCO packet");
> +			ath->rx_state = HCIATH_W4_SCO_HDR;
> +			ath->rx_count = HCI_SCO_HDR_SIZE;
> +			type = HCI_SCODATA_PKT;
> +			break;
> +
> +		default:
> +			BT_ERR("Unknown HCI packet type %2.2x", (__u8) *ptr);
> +			hu->hdev->stat.err_rx++;
> +			ptr++;
> +			count--;
> +			continue;
> +
> +		};
> +		ptr++;
> +		count--;
> +
> +		/* Allocate packet */
> +		ath->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
> +		if (!ath->rx_skb) {
> +			BT_ERR("Can't allocate mem for new packet");
> +			ath->rx_state = HCIATH_W4_PACKET_TYPE;
> +			ath->rx_count = 0;
> +
> +			return -ENOMEM;
> +		}
> +		ath->rx_skb->dev = (void *)hu->hdev;
> +		bt_cb(ath->rx_skb)->pkt_type = type;
> +	}
> +
> +	return count;
> +}

What was the reason that hci_recv_fragment is not good enough here and
can not made work for this case. I really wanna avoid have multiple
implementation of this reassembly support all over the places.

Regards

Marcel


