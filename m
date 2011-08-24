Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 16:37:08 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 2/5 v2] Bluetooth: set skbuffer priority based on L2CAP
 socket priority
Message-ID: <20110824193708.GC2662@joana>
References: <1313587384-2653-1-git-send-email-luiz.dentz@gmail.com>
 <1313587384-2653-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313587384-2653-3-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-17 16:23:01 +0300]:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This uses SO_PRIORITY to set the skbuffer priority field
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    3 ++
>  include/net/bluetooth/l2cap.h    |    3 +-
>  net/bluetooth/l2cap_core.c       |   45 +++++++++++++++++++++++++++-----------
>  net/bluetooth/l2cap_sock.c       |    2 +-
>  4 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e2ba4d6..0742828 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -32,6 +32,9 @@
>  #define HCI_PROTO_L2CAP	0
>  #define HCI_PROTO_SCO	1
>  
> +/* HCI priority */
> +#define HCI_PRIO_MAX	7
> +
>  /* HCI Core structures */
>  struct inquiry_data {
>  	bdaddr_t	bdaddr;
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 4f34ad2..f018e5d 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -511,7 +511,8 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk);
>  void l2cap_chan_close(struct l2cap_chan *chan, int reason);
>  void l2cap_chan_destroy(struct l2cap_chan *chan);
>  int l2cap_chan_connect(struct l2cap_chan *chan);
> -int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
> +int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> +								u32 priority);

I think priority could be part of struct l2cap_chan, so we avoid an extra
parameter in some calls here. Priority is also accessible from chan->sk, but I
would like to avoid more references to sk in l2cap core.

>  void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
>  
>  #endif /* __L2CAP_H */
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 3204ba8..3af0569 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1245,7 +1245,8 @@ void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
>  	struct hci_conn *hcon = chan->conn->hcon;
>  	u16 flags;
>  
> -	BT_DBG("chan %p, skb %p len %d", chan, skb, skb->len);
> +	BT_DBG("chan %p, skb %p len %d priority %u", chan, skb, skb->len,
> +							skb->priority);
>  
>  	if (!chan->flushable && lmp_no_flush_capable(hcon->hdev))
>  		flags = ACL_START_NO_FLUSH;
> @@ -1451,6 +1452,8 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
>  		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
>  			return -EFAULT;
>  
> +		(*frag)->priority = skb->priority;
> +
>  		sent += count;
>  		len  -= count;
>  
> @@ -1460,7 +1463,9 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
>  	return sent;
>  }
>  
> -struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
> +static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
> +						struct msghdr *msg, size_t len,
> +						u32 priority)
>  {
>  	struct sock *sk = chan->sk;
>  	struct l2cap_conn *conn = chan->conn;
> @@ -1468,7 +1473,7 @@ struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr
>  	int err, count, hlen = L2CAP_HDR_SIZE + 2;
>  	struct l2cap_hdr *lh;
>  
> -	BT_DBG("sk %p len %d", sk, (int)len);
> +	BT_DBG("sk %p len %d priority %u", sk, (int)len, priority);
>  
>  	count = min_t(unsigned int, (conn->mtu - hlen), len);
>  	skb = bt_skb_send_alloc(sk, count + hlen,
> @@ -1476,6 +1481,8 @@ struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr
>  	if (!skb)
>  		return ERR_PTR(err);
>  
> +	skb->priority = priority;
> +
>  	/* Create L2CAP header */
>  	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
>  	lh->cid = cpu_to_le16(chan->dcid);
> @@ -1490,7 +1497,9 @@ struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr
>  	return skb;
>  }
>  
> -struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
> +static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
> +						struct msghdr *msg, size_t len,
> +						u32 priority)
>  {
>  	struct sock *sk = chan->sk;
>  	struct l2cap_conn *conn = chan->conn;
> @@ -1506,6 +1515,8 @@ struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *m
>  	if (!skb)
>  		return ERR_PTR(err);
>  
> +	skb->priority = priority;
> +
>  	/* Create L2CAP header */
>  	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
>  	lh->cid = cpu_to_le16(chan->dcid);
> @@ -1519,7 +1530,10 @@ struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *m
>  	return skb;
>  }
>  
> -struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
> +static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
> +						struct msghdr *msg, size_t len,
> +						u32 priority, u16 control,
> +						u16 sdulen)
>  {
>  	struct sock *sk = chan->sk;
>  	struct l2cap_conn *conn = chan->conn;
> @@ -1527,7 +1541,7 @@ struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *
>  	int err, count, hlen = L2CAP_HDR_SIZE + 2;
>  	struct l2cap_hdr *lh;
>  
> -	BT_DBG("sk %p len %d", sk, (int)len);
> +	BT_DBG("sk %p len %d priority %u", sk, (int)len, priority);
>  
>  	if (!conn)
>  		return ERR_PTR(-ENOTCONN);
> @@ -1544,6 +1558,8 @@ struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *
>  	if (!skb)
>  		return ERR_PTR(err);
>  
> +	skb->priority = priority;
> +
>  	/* Create L2CAP header */
>  	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
>  	lh->cid = cpu_to_le16(chan->dcid);
> @@ -1574,7 +1590,8 @@ int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t le
>  
>  	skb_queue_head_init(&sar_queue);
>  	control = L2CAP_SDU_START;
> -	skb = l2cap_create_iframe_pdu(chan, msg, chan->remote_mps, control, len);
> +	skb = l2cap_create_iframe_pdu(chan, msg, chan->remote_mps,
> +						HCI_PRIO_MAX, control, len);


HCI_PRIO_MAX, why?


>  	if (IS_ERR(skb))
>  		return PTR_ERR(skb);
>  
> @@ -1593,7 +1610,8 @@ int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t le
>  			buflen = len;
>  		}
>  
> -		skb = l2cap_create_iframe_pdu(chan, msg, buflen, control, 0);
> +		skb = l2cap_create_iframe_pdu(chan, msg, buflen, HCI_PRIO_MAX,
> +								control, 0);

same here.

	Gustavo
