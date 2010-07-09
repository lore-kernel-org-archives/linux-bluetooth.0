Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Fri, 9 Jul 2010 09:59:12 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: suraj <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	Luis.Rodriguez@Atheros.com, Jothikumar.Mothilal@Atheros.com
Subject: Re: [PATCH v4 3/3] Implemented HCI frame reassembly for Rx from
 stream
Message-ID: <20100709125912.GA22985@vigoh>
References: <1278672569.4048.15.camel@atheros013-desktop>
 <1278672702.4048.19.camel@atheros013-desktop>
 <1278672821.4048.24.camel@atheros013-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1278672821.4048.24.camel@atheros013-desktop>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

* suraj <suraj@atheros.com> [2010-07-09 16:23:41 +0530]:

> Implemented frame reassembly implementation for reassembling fragments
> received from stream.
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +
>  net/bluetooth/hci_core.c         |   43
> ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h
> b/include/net/bluetooth/hci_core.h
> index e42f6ed..cd89d66 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -119,6 +119,7 @@ struct hci_dev {
>  
>  	struct sk_buff		*sent_cmd;
>  	struct sk_buff		*reassembly[3];
> +	struct sk_buff		*stream_reassembly;
>  
>  	struct mutex		req_lock;
>  	wait_queue_head_t	req_wait_q;
> @@ -428,6 +429,7 @@ void hci_event_packet(struct hci_dev *hdev, struct
> sk_buff *skb);
>  
>  int hci_recv_frame(struct sk_buff *skb);
>  int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int
> count);
> +int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int
> count);
>  
>  int hci_register_sysfs(struct hci_dev *hdev);
>  void hci_unregister_sysfs(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index db6ca71..ee75c42 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -916,6 +916,8 @@ int hci_register_dev(struct hci_dev *hdev)
>  	for (i = 0; i < 3; i++)
>  		hdev->reassembly[i] = NULL;
>  
> +	hdev->stream_reassembly = NULL;
> +
>  	init_waitqueue_head(&hdev->req_wait_q);
>  	mutex_init(&hdev->req_lock);
>  
> @@ -973,6 +975,8 @@ int hci_unregister_dev(struct hci_dev *hdev)
>  	for (i = 0; i < 3; i++)
>  		kfree_skb(hdev->reassembly[i]);
>  
> +	kfree_skb(hdev->stream_reassembly);
> +
>  	hci_notify(hdev, HCI_DEV_UNREG);
>  
>  	if (hdev->rfkill) {
> @@ -1145,6 +1149,45 @@ static int hci_reassembly(struct hci_dev *hdev,
> int type, void *data,
>  
>  	return 0;
>  }
> +
> +#define __stream_reassembly(hdev)  ((hdev)->stream_reassembly)

That's pointless. Your macro has about the same length of
hdev->stream_reassembly.

> +
> +int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int
> count)
> +{
> +	int type;
> +	int remaining = 0;
> +	int err = 0;
> +
> +	do {
> +		struct sk_buff *skb = __stream_reassembly(hdev);
> +		if (!skb) {
> +			struct { char type; } *pkt;
> +
> +			/* Start of the frame */
> +			pkt = data;
> +			type = pkt->type;
> +
> +			data++;
> +			count--;
> +		} else
> +			type = bt_cb(skb)->pkt_type;
> +
> +		err = hci_reassembly(hdev, type, data, count, &skb, &remaining);
> +
> +		if (err < 0)
> +			return err;
> +
> +		__stream_reassembly(hdev) = skb;
> +
> +		data += (count - remaining);
> +		count = remaining;
> +
> +	} while (count);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(hci_recv_stream_fragment);
> +
>  /* Receive packet type fragment */
>  #define __reassembly(hdev, type)  ((hdev)->reassembly[(type) - 2])
>  
> -- 
> 1.7.0.4
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org
