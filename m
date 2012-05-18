Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 May 2012 10:15:42 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH -v2] Bluetooth: Add MSG_MORE support to L2CAP sockets
In-Reply-To: <1337140435-12338-1-git-send-email-gustavo@padovan.org>
Message-ID: <alpine.DEB.2.02.1205180943290.2131@mathewm-linux>
References: <1337140435-12338-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Gustavo -

On Wed, 16 May 2012, Gustavo Padovan wrote:

> MSG_MORE enables us to save buffer space in userspace, the packet are
> built directly in the kernel and sent only when a msg with the MSG_MORE
> flag not set arrives. If a send() tries to add more chan->omtu bytes
> -EMSGSIZE is returned.
>
> Only MSG_MORE for Basic Mode is supported right now. chan->skb_more keeps
> a pointer to the L2CAP packet that is being build through many calls to
> send().
>
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
> include/net/bluetooth/l2cap.h |    2 +
> net/bluetooth/l2cap_core.c    |  112 ++++++++++++++++++++++++++++++++++++++---
> 2 files changed, 106 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 1c7d1cd..5f2845d 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -520,6 +520,8 @@ struct l2cap_chan {
> 	struct list_head	list;
> 	struct list_head	global_l;
>
> +	struct sk_buff		*skb_more;
> +
> 	void			*data;
> 	struct l2cap_ops	*ops;
> 	struct mutex		lock;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index e5a4fd9..d42cc11 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -508,6 +508,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> 			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
> 		return;
>
> +	kfree_skb(chan->skb_more);
> +

Since l2cap_chan_del doesn't actually free the l2cap_chan struct, 
there might still be valid pointers to chan after l2cap_chan_del runs. 
I'd suggest setting chan->skb_more to NULL just to be safe.

> 	skb_queue_purge(&chan->tx_q);
>
> 	if (chan->mode == L2CAP_MODE_ERTM) {
> @@ -1827,6 +1829,8 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
> 	struct sk_buff **frag;
> 	int sent = 0;
>
> +	count = min_t(unsigned int, count, len);
> +
> 	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
> 		return -EFAULT;
>
> @@ -1903,9 +1907,13 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
> 	int err, count;
> 	struct l2cap_hdr *lh;
>
> -	BT_DBG("chan %p len %d", chan, (int)len);
> +	BT_DBG("chan %p len %d aclmtu %d" , chan, (int)len, conn->mtu);
>
> -	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
> +	if (msg->msg_flags & MSG_MORE)
> +		count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE),
> +			      chan->omtu);
> +	else
> +		count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
>
> 	skb = chan->ops->alloc_skb(chan, count + L2CAP_HDR_SIZE,
> 				   msg->msg_flags & MSG_DONTWAIT);
> @@ -2048,11 +2056,76 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
> 	return err;
> }
>
> +static int l2cap_append_pdu(struct l2cap_chan *chan, struct msghdr *msg,
> +			    size_t len)
> +{
> +	struct l2cap_conn *conn = chan->conn;
> +	struct sk_buff **frag, *skb = chan->skb_more;
> +	int sent = 0;
> +	unsigned int count;
> +	struct l2cap_hdr *lh;
> +
> +	BT_DBG("chan %p len %ld", chan, len);
> +
> +	frag = &skb_shinfo(skb)->frag_list;
> +	if (*frag)
> +		goto frags;
> +
> +	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE),
> +		      chan->omtu);
> +	count = count - skb->len + L2CAP_HDR_SIZE;
> +	count = min_t(unsigned int, count, len);
> +
> +	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
> +		return -EFAULT;
> +
> +	sent += count;
> +	len  -= count;
> +
> +frags:
> +	while (*frag)
> +		frag = &(*frag)->next;
> +
> +	while (len) {
> +		struct sk_buff *tmp;
> +
> +		count = chan->omtu - skb->len + L2CAP_HDR_SIZE;
> +		count = min_t(unsigned int, count, len);

I don't think you want to use 'len' as a limit.  The fragment should 
be as big as possible (conn->mtu).  Only if it is the last fragment 
(based on chan->omtu) should it be shorter than conn->mtu.

> +		count = min_t(unsigned int, conn->mtu, count);
> +
> +		tmp = chan->ops->alloc_skb(chan, count,
> +					   msg->msg_flags & MSG_DONTWAIT);


It looks like the code skipped by the goto will fill up the first skb 
each time you get a MSG_MORE call, but once you have fragments, you 
allocate a new skb for every MSG_MORE call rather than fill up the 
last fragment in the list.  Think of the pathological case where 
someone writes a single byte on each call (which would make a pretty 
good test case, by the way).

What if you moved the "while (*frag)" up where your goto is, and got 
rid of the goto?  That way you would always append to the final skb 
(whether it is the first one or a fragment), then allocate and 
populate additional skbs only when needed.

> +		if (IS_ERR(tmp))
> +			return PTR_ERR(tmp);
> +
> +		*frag = tmp;
> +
> +		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov,
> +				     count))
> +			return -EFAULT;
> +
> +		(*frag)->priority = skb->priority;
> +
> +		sent += count;
> +		len  -= count;
> +
> +		skb->len += (*frag)->len;
> +		skb->data_len += (*frag)->len;
> +
> +		frag = &(*frag)->next;
> +	}
> +
> +	lh = (struct l2cap_hdr *) skb->data;
> +	lh->len = cpu_to_le16(skb->len - L2CAP_HDR_SIZE);
> +
> +	return sent;
> +}
> +
> int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> 								u32 priority)
> {
> 	struct sk_buff *skb;
> -	int err;
> +	int err, rem;
> 	struct sk_buff_head seg_queue;
>
> 	/* Connectionless channel */
> @@ -2067,16 +2140,39 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
>
> 	switch (chan->mode) {
> 	case L2CAP_MODE_BASIC:
> +		skb = chan->skb_more;
> +
> 		/* Check outgoing MTU */
> -		if (len > chan->omtu)
> +		if (skb)
> +			rem = chan->omtu - skb->len + L2CAP_HDR_SIZE;
> +		else
> +			rem = chan->omtu;
> +
> +		if (len > rem)
> 			return -EMSGSIZE;
>
> -		/* Create a basic PDU */
> -		skb = l2cap_create_basic_pdu(chan, msg, len, priority);
> -		if (IS_ERR(skb))
> -			return PTR_ERR(skb);
> +		if (chan->skb_more) {
> +			err = l2cap_append_pdu(chan, msg, len);
> +			if (err < 0) {
> +				kfree_skb(chan->skb_more);
> +				chan->skb_more = NULL;
> +				return err;
> +			}
> +		} else {
> +			skb = l2cap_create_basic_pdu(chan, msg, len, priority);
> +			if (IS_ERR(skb))
> +				return PTR_ERR(skb);
> +		}
> +
> +		if (msg->msg_flags & MSG_MORE) {
> +			chan->skb_more = skb;
> +			return len;
> +		}
>
> 		l2cap_do_send(chan, skb);
> +
> +		chan->skb_more = NULL;
> +
> 		err = len;
> 		break;
>
> -- 
> 1.7.10.1

I find this version much easier to follow!  Thanks,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

