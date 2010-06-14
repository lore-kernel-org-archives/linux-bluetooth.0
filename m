Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3 1/3] Implements hci_reassembly to reassemble Rx
 packets
From: suraj <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <Luis.Rodriguez@Atheros.com>,
	<Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <1276088748.31226.6.camel@atheros013-desktop>
References: <1276088748.31226.6.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Jun 2010 12:37:36 +0530
Message-ID: <1276499256.15628.0.camel@atheros013-desktop>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, 2010-06-09 at 18:35 +0530, suraj wrote:
> Implements feature to reassemble received HCI frames from any input stream.
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  net/bluetooth/hci_core.c |  115 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 115 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5e83f8e..631a185 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1030,6 +1030,121 @@ int hci_recv_frame(struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL(hci_recv_frame);
>  
> +static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
> +			  int count, struct sk_buff **skb_ptr, int *remain)
> +{
> +	int len = 0;
> +	int header_len = 0;
> +	struct sk_buff *skb = *skb_ptr;
> +	struct { __u8 pkt_type; int expect; } *scb;
> +
> +	*remain = count;
> +
> +	if (type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT)
> +		return -EILSEQ;
> +
> +	if (!skb) {
> +
> +		switch (type) {
> +		case HCI_ACLDATA_PKT:
> +			len = HCI_MAX_FRAME_SIZE;
> +			header_len = HCI_ACL_HDR_SIZE;
> +		break;
> +		case HCI_EVENT_PKT:
> +			len = HCI_MAX_EVENT_SIZE;
> +			header_len = HCI_EVENT_HDR_SIZE;
> +		break;
> +		case HCI_SCODATA_PKT:
> +			len = HCI_MAX_SCO_SIZE;
> +			header_len = HCI_SCO_HDR_SIZE;
> +		break;
> +		}
> +
> +		skb = bt_skb_alloc(len, GFP_ATOMIC);
> +
> +		if (!skb)
> +			return -ENOMEM;
> +
> +		scb = (void *) skb->cb;
> +		scb->expect = header_len;
> +		scb->pkt_type = (__u8)type;
> +
> +		skb->dev = (void *) hdev;
> +		*skb_ptr = skb;
> +
> +	}
> +
> +	while (count) {
> +
> +		scb = (void *) skb->cb;
> +		len = min(scb->expect, count);
> +
> +		memcpy(skb_put(skb, len), data, len);
> +
> +		count -= len;
> +		data += len;
> +		scb->expect -= len;
> +		*remain = count;
> +
> +		switch (type) {
> +		case HCI_EVENT_PKT:
> +			if (skb->len == HCI_EVENT_HDR_SIZE) {
> +				struct hci_event_hdr *h = hci_event_hdr(skb);
> +				scb->expect = h->plen;
> +
> +				if (skb_tailroom(skb) < scb->expect) {
> +					kfree_skb(skb);
> +					*skb_ptr = NULL;
> +
> +					return -ENOMEM;
> +				}
> +			}
> +			break;
> +
> +		case HCI_ACLDATA_PKT:
> +			if (skb->len  == HCI_ACL_HDR_SIZE) {
> +				struct hci_acl_hdr *h = hci_acl_hdr(skb);
> +				scb->expect = __le16_to_cpu(h->dlen);
> +
> +				if (skb_tailroom(skb) < scb->expect) {
> +					kfree_skb(skb);
> +					*skb_ptr = NULL;
> +
> +					return -ENOMEM;
> +				}
> +			}
> +			break;
> +
> +		case HCI_SCODATA_PKT:
> +			if (skb->len == HCI_SCO_HDR_SIZE) {
> +				struct hci_sco_hdr *h = hci_sco_hdr(skb);
> +				scb->expect = h->dlen;
> +
> +				if (skb_tailroom(skb) < scb->expect) {
> +					kfree_skb(skb);
> +					*skb_ptr = NULL;
> +
> +					return -ENOMEM;
> +				}
> +			}
> +			break;
> +		}
> +
> +		if (scb->expect == 0) {
> +
> +			/* Complete frame */
> +			bt_cb(skb)->pkt_type = type;
> +			hci_recv_frame(skb);
> +
> +			*skb_ptr = NULL;
> +
> +			return 0;
> +		}
> +
> +	}
> +
> +	return 0;
> +}
>  /* Receive packet type fragment */
>  #define __reassembly(hdev, type)  ((hdev)->reassembly[(type) - 2])
>  

Do let me know your comments on the patch.

Regards
Suraj
