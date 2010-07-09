Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 1/3] Implements hci_reassembly to reassemble Rx
 packets
From: Marcel Holtmann <marcel@holtmann.org>
To: suraj <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Luis.Rodriguez@Atheros.com,
	Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1278672569.4048.15.camel@atheros013-desktop>
References: <1278672569.4048.15.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Jul 2010 10:16:06 -0300
Message-ID: <1278681366.10421.112.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

you do need to fix your email or at least add a From: line. Otherwise
when I apply the patch this gets screwed up.

> Implements feature to reassemble HCI frames received from an input stream.
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  net/bluetooth/hci_core.c |  115 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 115 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5e83f8e..3eb4c1b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1030,6 +1030,121 @@ int hci_recv_frame(struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL(hci_recv_frame);
>  
> +static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
> +			  int count, struct sk_buff **skb_ptr, int *remain)

Why are we not not just return remain and err combined. Negative's are
errors positives are remains.

> +{
> +	int len = 0;
> +	int header_len = 0;
> +	struct sk_buff *skb = *skb_ptr;
> +	struct { struct bt_skb_cb cb_info; int expect; } *scb;
> +
> +	*remain = count;
> +
> +	if (type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT)
> +		return -EILSEQ;
> +
> +	if (!skb) {
> +
> +		switch (type) {

Remove this empty line here.

> +		case HCI_ACLDATA_PKT:
> +			len = HCI_MAX_FRAME_SIZE;
> +			header_len = HCI_ACL_HDR_SIZE;
> +		break;

The break needs to be on the same line as the code.

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

Remove the empty line here.

Do we always need GFP_ATOMIC here. I would prefer that we make that an
option of the function caller.

> +			return -ENOMEM;
> +
> +		scb = (void *) skb->cb;
> +		scb->expect = header_len;
> +		scb->cb_info.pkt_type = (__u8)type;

It is "(__u8) type" when casting.

> +
> +		skb->dev = (void *) hdev;
> +		*skb_ptr = skb;
> +
> +	}
> +
> +	while (count) {
> +
> +		scb = (void *) skb->cb;

Remove empty line here.

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

Remove this empty line.

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

Same here.

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

And here.

> +				}
> +			}
> +			break;
> +		}
> +
> +		if (scb->expect == 0) {
> +
> +			/* Complete frame */

Remove the empty line here.

> +			bt_cb(skb)->pkt_type = type;
> +			hci_recv_frame(skb);
> +
> +			*skb_ptr = NULL;
> +
> +			return 0;

And here.

> +		}
> +
> +	}

What is this empty line for. Please remove.

> +
> +	return 0;
> +}
>  /* Receive packet type fragment */

And here we need an extra empty line.

>  #define __reassembly(hdev, type)  ((hdev)->reassembly[(type) - 2])

Regards

Marcel


