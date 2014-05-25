Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 1/8] Bluetooth: Refactor l2cap_sock_sendmsg() to copy user buffer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400837248-12179-2-git-send-email-jukka.rissanen@linux.intel.com>
Date: Sat, 24 May 2014 21:48:02 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <98B7DE79-FFC6-435F-86DA-36F11C8F7C2B@holtmann.org>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com> <1400837248-12179-2-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> The l2cap_chan_send() is changed to use kernel memory directly,
> so this function must read the user buffer before sending the
> message.
> 
> The change is done as the 6LoWPAN also uses l2cap_chan_send()
> and in order to minimize the amount of code changes, we must
> copy the user buffer in sock handling code.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> include/net/bluetooth/l2cap.h |  4 +--
> net/bluetooth/a2mp.c          | 12 +------
> net/bluetooth/l2cap_core.c    | 76 ++++++++++++++++++++++++-------------------
> net/bluetooth/l2cap_sock.c    | 14 +++++++-
> 4 files changed, 58 insertions(+), 48 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 4abdcb2..3980b81 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -872,8 +872,8 @@ struct l2cap_chan *l2cap_chan_create(void);
> void l2cap_chan_close(struct l2cap_chan *chan, int reason);
> int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> 		       bdaddr_t *dst, u8 dst_type);
> -int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> -								u32 priority);
> +int l2cap_chan_send(struct l2cap_chan *chan, unsigned char *msg, size_t len,
> +		    u32 priority, unsigned int flags);

use buf instead of msg here. The only time we really use msg is when it is actually a msghdr struct. Might want to consider to make it void *buf.

> void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
> int l2cap_chan_check_security(struct l2cap_chan *chan);
> void l2cap_chan_set_defaults(struct l2cap_chan *chan);
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index 9514cc9..9efcda8 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -48,22 +48,12 @@ void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
> 	struct l2cap_chan *chan = mgr->a2mp_chan;
> 	struct a2mp_cmd *cmd;
> 	u16 total_len = len + sizeof(*cmd);
> -	struct kvec iv;
> -	struct msghdr msg;
> 
> 	cmd = __a2mp_build(code, ident, len, data);
> 	if (!cmd)
> 		return;
> 
> -	iv.iov_base = cmd;
> -	iv.iov_len = total_len;
> -
> -	memset(&msg, 0, sizeof(msg));
> -
> -	msg.msg_iov = (struct iovec *) &iv;
> -	msg.msg_iovlen = 1;
> -
> -	l2cap_chan_send(chan, &msg, total_len, 0);
> +	l2cap_chan_send(chan, (unsigned char *)cmd, total_len, 0, 0);

Why are we casting here? I do not like these casts at all.

> 	kfree(cmd);
> }
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index a1e5bb7..60433c4 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2098,19 +2098,20 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
> 	}
> }
> 
> -static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
> -					 struct msghdr *msg, int len,
> -					 int count, struct sk_buff *skb)
> +static inline int l2cap_skbuff(struct l2cap_chan *chan,
> +			       unsigned char *msg, int len,
> +			       unsigned int flags, int count,
> +			       struct sk_buff *skb)

Same here. void *buf seems a bit better. Also the function name might need a bit clearer name. It seems a bit too generic right now.

> {
> 	struct l2cap_conn *conn = chan->conn;
> 	struct sk_buff **frag;
> 	int sent = 0;
> 
> -	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
> -		return -EFAULT;
> +	memcpy(skb_put(skb, count), msg, count);
> 
> 	sent += count;
> 	len  -= count;
> +	msg  += count;
> 
> 	/* Continuation fragments (no L2CAP header) */
> 	frag = &skb_shinfo(skb)->frag_list;
> @@ -2120,19 +2121,19 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
> 		count = min_t(unsigned int, conn->mtu, len);
> 
> 		tmp = chan->ops->alloc_skb(chan, count,
> -					   msg->msg_flags & MSG_DONTWAIT);
> +					   flags & MSG_DONTWAIT);
> 		if (IS_ERR(tmp))
> 			return PTR_ERR(tmp);
> 
> 		*frag = tmp;
> 
> -		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
> -			return -EFAULT;
> +		memcpy(skb_put(*frag, count), msg, count);
> 
> 		(*frag)->priority = skb->priority;
> 
> 		sent += count;
> 		len  -= count;
> +		msg  += count;
> 
> 		skb->len += (*frag)->len;
> 		skb->data_len += (*frag)->len;
> @@ -2144,8 +2145,8 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
> }
> 
> static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
> -						 struct msghdr *msg, size_t len,
> -						 u32 priority)
> +						 unsigned char *msg, size_t len,
> +						 u32 priority, unsigned int flags)
> {
> 	struct l2cap_conn *conn = chan->conn;
> 	struct sk_buff *skb;
> @@ -2158,7 +2159,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
> 	count = min_t(unsigned int, (conn->mtu - hlen), len);
> 
> 	skb = chan->ops->alloc_skb(chan, count + hlen,
> -				   msg->msg_flags & MSG_DONTWAIT);
> +				   flags & MSG_DONTWAIT);
> 	if (IS_ERR(skb))
> 		return skb;
> 
> @@ -2170,7 +2171,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
> 	lh->len = cpu_to_le16(len + L2CAP_PSMLEN_SIZE);
> 	put_unaligned(chan->psm, (__le16 *) skb_put(skb, L2CAP_PSMLEN_SIZE));
> 
> -	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
> +	err = l2cap_skbuff(chan, msg, len, flags, count, skb);
> 	if (unlikely(err < 0)) {
> 		kfree_skb(skb);
> 		return ERR_PTR(err);
> @@ -2179,8 +2180,8 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
> }
> 
> static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
> -					      struct msghdr *msg, size_t len,
> -					      u32 priority)
> +					      unsigned char *msg, size_t len,
> +					      u32 priority, unsigned int flags)

Same here as well. void *buf.

> {
> 	struct l2cap_conn *conn = chan->conn;
> 	struct sk_buff *skb;
> @@ -2192,7 +2193,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
> 	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
> 
> 	skb = chan->ops->alloc_skb(chan, count + L2CAP_HDR_SIZE,
> -				   msg->msg_flags & MSG_DONTWAIT);
> +				   flags & MSG_DONTWAIT);
> 	if (IS_ERR(skb))
> 		return skb;
> 
> @@ -2203,7 +2204,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
> 	lh->cid = cpu_to_le16(chan->dcid);
> 	lh->len = cpu_to_le16(len);
> 
> -	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
> +	err = l2cap_skbuff(chan, msg, len, flags, count, skb);
> 	if (unlikely(err < 0)) {
> 		kfree_skb(skb);
> 		return ERR_PTR(err);
> @@ -2212,8 +2213,8 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
> }
> 
> static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
> -					       struct msghdr *msg, size_t len,
> -					       u16 sdulen)
> +					       unsigned char *msg, size_t len,
> +					       u16 sdulen, unsigned int flags)

And here. And so on ;)

> {
> 	struct l2cap_conn *conn = chan->conn;
> 	struct sk_buff *skb;
> @@ -2236,7 +2237,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
> 	count = min_t(unsigned int, (conn->mtu - hlen), len);
> 
> 	skb = chan->ops->alloc_skb(chan, count + hlen,
> -				   msg->msg_flags & MSG_DONTWAIT);
> +				   flags & MSG_DONTWAIT);
> 	if (IS_ERR(skb))
> 		return skb;
> 
> @@ -2254,7 +2255,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
> 	if (sdulen)
> 		put_unaligned_le16(sdulen, skb_put(skb, L2CAP_SDULEN_SIZE));
> 
> -	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
> +	err = l2cap_skbuff(chan, msg, len, flags, count, skb);
> 	if (unlikely(err < 0)) {
> 		kfree_skb(skb);
> 		return ERR_PTR(err);
> @@ -2267,7 +2268,8 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
> 
> static int l2cap_segment_sdu(struct l2cap_chan *chan,
> 			     struct sk_buff_head *seg_queue,
> -			     struct msghdr *msg, size_t len)
> +			     unsigned char *msg, size_t len,
> +			     unsigned int flags)
> {
> 	struct sk_buff *skb;
> 	u16 sdu_len;
> @@ -2308,7 +2310,8 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
> 	}
> 
> 	while (len > 0) {
> -		skb = l2cap_create_iframe_pdu(chan, msg, pdu_len, sdu_len);
> +		skb = l2cap_create_iframe_pdu(chan, msg, pdu_len, sdu_len,
> +					      flags);
> 
> 		if (IS_ERR(skb)) {
> 			__skb_queue_purge(seg_queue);
> @@ -2336,8 +2339,9 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
> }
> 
> static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
> -						   struct msghdr *msg,
> -						   size_t len, u16 sdulen)
> +						   unsigned char *msg,
> +						   size_t len, u16 sdulen,
> +						   unsigned int flags)
> {
> 	struct l2cap_conn *conn = chan->conn;
> 	struct sk_buff *skb;
> @@ -2357,7 +2361,7 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
> 	count = min_t(unsigned int, (conn->mtu - hlen), len);
> 
> 	skb = chan->ops->alloc_skb(chan, count + hlen,
> -				   msg->msg_flags & MSG_DONTWAIT);
> +				   flags & MSG_DONTWAIT);
> 	if (IS_ERR(skb))
> 		return skb;
> 
> @@ -2369,7 +2373,7 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
> 	if (sdulen)
> 		put_unaligned_le16(sdulen, skb_put(skb, L2CAP_SDULEN_SIZE));
> 
> -	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
> +	err = l2cap_skbuff(chan, msg, len, flags, count, skb);
> 	if (unlikely(err < 0)) {
> 		kfree_skb(skb);
> 		return ERR_PTR(err);
> @@ -2380,7 +2384,8 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
> 
> static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
> 				struct sk_buff_head *seg_queue,
> -				struct msghdr *msg, size_t len)
> +				unsigned char *msg, size_t len,
> +				unsigned int flags)
> {
> 	struct sk_buff *skb;
> 	size_t pdu_len;
> @@ -2399,7 +2404,8 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
> 		if (len <= pdu_len)
> 			pdu_len = len;
> 
> -		skb = l2cap_create_le_flowctl_pdu(chan, msg, pdu_len, sdu_len);
> +		skb = l2cap_create_le_flowctl_pdu(chan, msg, pdu_len, sdu_len,
> +						  flags);
> 		if (IS_ERR(skb)) {
> 			__skb_queue_purge(seg_queue);
> 			return PTR_ERR(skb);
> @@ -2408,6 +2414,7 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
> 		__skb_queue_tail(seg_queue, skb);
> 
> 		len -= pdu_len;
> +		msg += pdu_len;
> 
> 		if (sdu_len) {
> 			sdu_len = 0;
> @@ -2418,8 +2425,8 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
> 	return 0;
> }
> 
> -int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> -		    u32 priority)
> +int l2cap_chan_send(struct l2cap_chan *chan, unsigned char *msg, size_t len,
> +		    u32 priority, unsigned int flags)
> {
> 	struct sk_buff *skb;
> 	int err;
> @@ -2430,7 +2437,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> 
> 	/* Connectionless channel */
> 	if (chan->chan_type == L2CAP_CHAN_CONN_LESS) {
> -		skb = l2cap_create_connless_pdu(chan, msg, len, priority);
> +		skb = l2cap_create_connless_pdu(chan, msg, len, priority,
> +						flags);
> 		if (IS_ERR(skb))
> 			return PTR_ERR(skb);
> 
> @@ -2457,7 +2465,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> 
> 		__skb_queue_head_init(&seg_queue);
> 
> -		err = l2cap_segment_le_sdu(chan, &seg_queue, msg, len);
> +		err = l2cap_segment_le_sdu(chan, &seg_queue, msg, len, flags);
> 
> 		if (chan->state != BT_CONNECTED) {
> 			__skb_queue_purge(&seg_queue);
> @@ -2487,7 +2495,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> 			return -EMSGSIZE;
> 
> 		/* Create a basic PDU */
> -		skb = l2cap_create_basic_pdu(chan, msg, len, priority);
> +		skb = l2cap_create_basic_pdu(chan, msg, len, priority, flags);
> 		if (IS_ERR(skb))
> 			return PTR_ERR(skb);
> 
> @@ -2517,7 +2525,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> 		 * since it's possible to block while waiting for memory
> 		 * allocation.
> 		 */
> -		err = l2cap_segment_sdu(chan, &seg_queue, msg, len);
> +		err = l2cap_segment_sdu(chan, &seg_queue, msg, len, flags);
> 
> 		/* The channel could have been closed while segmenting,
> 		 * check that it is still connected.
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index f59e00c..7e7b28a 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -948,6 +948,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> {
> 	struct sock *sk = sock->sk;
> 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> +	unsigned char *buf;
> 	int err;
> 
> 	BT_DBG("sock %p, sk %p", sock, sk);
> @@ -968,10 +969,21 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> 	if (err)
> 		return err;
> 
> +	buf = kmalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (memcpy_fromiovec(buf, msg->msg_iov, len)) {
> +		err = -EFAULT;
> +		goto done;
> +	}
> +
> 	l2cap_chan_lock(chan);
> -	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
> +	err = l2cap_chan_send(chan, buf, len, sk->sk_priority, msg->msg_flags);
> 	l2cap_chan_unlock(chan);
> 
> +done:
> +	kfree(buf);
> 	return err;
> }

We don’t have to use chan->ops->alloc_skb here? Has this become obsolete now?

Regards

Marcel

