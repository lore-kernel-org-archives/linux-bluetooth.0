Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] frame reassembly implementation for data stream
From: Marcel Holtmann <marcel@holtmann.org>
To: suraj <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Luis.Rodriguez@Atheros.com,
	Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1275467080.13946.3.camel@atheros013-desktop>
References: <1275467080.13946.3.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 08:02:35 -0700
Message-ID: <1275490955.2182.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Implemented hci_recv_stream_fragment to reassemble HCI packets received from a data stream.
> 
> Signed-off-by: suraj <suraj@Atheros.com>

please fix your signed-off-by line. This is not proper.

> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |   98 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e42f6ed..6f33f11 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -428,6 +428,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
>  
>  int hci_recv_frame(struct sk_buff *skb);
>  int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
> +int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
>  
>  int hci_register_sysfs(struct hci_dev *hdev);
>  void hci_unregister_sysfs(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5e83f8e..ac9ccf7 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1033,6 +1033,104 @@ EXPORT_SYMBOL(hci_recv_frame);
>  /* Receive packet type fragment */
>  #define __reassembly(hdev, type)  ((hdev)->reassembly[(type) - 2])
>  
> +#define __get_max_rx_size(type)					\
> +		(((type) == HCI_ACLDATA_PKT) ?			\
> +		HCI_MAX_FRAME_SIZE :				\
> +		((type) == HCI_EVENT_PKT) ? HCI_MAX_EVENT_SIZE :\
> +		HCI_MAX_SCO_SIZE)
> +
> +#define __get_header_len(type)					\
> +		(((type) == HCI_ACLDATA_PKT) ?			\
> +		HCI_ACL_HDR_SIZE :				\
> +		((type) == HCI_EVENT_PKT) ? HCI_EVENT_HDR_SIZE :\
> +		HCI_SCO_HDR_SIZE)

This is total hackish code. Who do you think is able to read this?

> +int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
> +{
> +	int type;
> +
> +	while (count) {
> +		struct sk_buff *skb = __reassembly(hdev, HCI_ACLDATA_PKT);
> +
> +		struct { int expect; int pkt_type; } *scb;
> +		int len = 0;
> +
> +		if (!skb) {
> +			struct { char type; } *pkt;
> +
> +			/* Start of the frame */
> +			pkt = data;
> +			type = pkt->type;
> +
> +			if (type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT)
> +				return -EILSEQ;
> +
> +			len = __get_max_rx_size(type);
> +
> +			skb = bt_skb_alloc(len, GFP_ATOMIC);
> +			if (!skb)
> +				return -ENOMEM;
> +
> +			scb = (void *) skb->cb;
> +			scb->expect = __get_header_len(type);
> +			scb->pkt_type = type;
> +
> +			skb->dev = (void *) hdev;
> +			__reassembly(hdev, HCI_ACLDATA_PKT) = skb;
> +
> +			data++;
> +			count--;
> +
> +			continue;
> +		} else {
> +			scb = (void *) skb->cb;
> +			len = min(scb->expect, count);
> +			type = scb->pkt_type;
> +
> +			memcpy(skb_put(skb, len), data, len);
> +
> +			count -= len;
> +			data += len;
> +			scb->expect -= len;
> +		}
> +
> +		switch (type) {
> +		case HCI_EVENT_PKT:
> +			if (skb->len == HCI_EVENT_HDR_SIZE) {
> +				struct hci_event_hdr *h = hci_event_hdr(skb);
> +				scb->expect = h->plen;
> +			}
> +			break;
> +
> +		case HCI_ACLDATA_PKT:
> +			if (skb->len  == HCI_ACL_HDR_SIZE) {
> +				struct hci_acl_hdr *h = hci_acl_hdr(skb);
> +				scb->expect = __le16_to_cpu(h->dlen);
> +			}
> +			break;
> +
> +		case HCI_SCODATA_PKT:
> +			if (skb->len == HCI_SCO_HDR_SIZE) {
> +				struct hci_sco_hdr *h = hci_sco_hdr(skb);
> +				scb->expect = h->dlen;
> +			}
> +			break;
> +		}
> +
> +		if (scb->expect == 0) {
> +			/* Complete frame */
> +
> +			__reassembly(hdev, HCI_ACLDATA_PKT) = NULL;
> +
> +			bt_cb(skb)->pkt_type = type;
> +			hci_recv_frame(skb);
> +		}
> +
> +	}
> +	return 0;
> +}

I don't like this implementation at all. The biggest problem is that you
are misusing __reassembly(hdev, HCI_ACLDATA_PKT) for getting your SKB. I
don't wanna intermix this. I am also missing checks for the packet
length matching or when packets are too big or the header size is not
matching up.

So in theory both functions do exactly the same. Only minor exception is
that one knows the packet type up-front, the other has to read it from
the stream as a 1-byte header. I don't wanna maintain two functions that
do exactly the same.

Creating an internal helper function that can maintain the current state
of the reassembly sounds a lot better. Then re-use that function and
ensure that the reassembly logic is inside the helper.

Regards

Marcel


