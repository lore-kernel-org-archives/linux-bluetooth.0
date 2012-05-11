Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 May 2012 16:15:02 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Bluetooth: Add MSG_MORE support to L2CAP sockets
Message-ID: <20120511191502.GB7620@joana>
References: <1336752974-7747-1-git-send-email-gustavo@padovan.org>
 <1336752974-7747-2-git-send-email-gustavo@padovan.org>
 <1336752974-7747-3-git-send-email-gustavo@padovan.org>
 <alpine.DEB.2.02.1205111126420.17554@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1205111126420.17554@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat.

* Mat Martineau <mathewm@codeaurora.org> [2012-05-11 11:31:50 -0700]:

> 
> Hi Gustavo -
> 
> On Fri, 11 May 2012, Gustavo Padovan wrote:
> 
> >MSG_MORE enables us to save buffer space in userspace, the packet are
> >built directly in the kernel and sent when their size reaches the Output
> >MTU value.
> >
> >Only MSG_MORE for Basic Mode is supported right now. chan->skb_more keeps
> >a pointer to the L2CAP packet that is being build through many calls to
> >send().
> 
> Could you explain more about how you expect it to work?
> 
> I would assume the application would do a series of sends:
> 
> send(fd, buf, len, MSG_MORE);
> ...
> send(fd, buf, len, MSG_MORE);
> ...
> send(fd, buf, len, MSG_MORE);
> ...
> send(fd, buf, len, 0);
> 
> and the SDU would be sent the first time there is no MSG_MORE flag.
> If the MTU is exceeded, the SDU is not sent and an error is
> returned.

No, a PDU is sent every time the buffered data achieves the size of the
channel MTU, then skb_more starts to buffer the next pdu to be sent.
A send with the MSG_MORE flag unset would tell to send everything that is
queued.

> What should happen if a send() with MSG_MORE completely fills an SDU
> (length of data sent is equal to MTU)?  Does it make sense to treat
> it like a normal send, or return an error so that application knows
> that later calls with MSG_MORE will not append?  Or does the full
> SDU not get sent, and a zero-length send() with no MSG_MORE would
> trigger the transmission?

It get sent right away. Also I don't think the application needs to know such
kind of information. It deliveries the data to the kernel and the kernel
decides when to send the data.

> >
> >Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> >---
> >include/net/bluetooth/l2cap.h |    2 +
> >net/bluetooth/l2cap_core.c    |  116 ++++++++++++++++++++++++++++++++++++++---
> >2 files changed, 110 insertions(+), 8 deletions(-)
> >
> >diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> >index 1c7d1cd..5f2845d 100644
> >--- a/include/net/bluetooth/l2cap.h
> >+++ b/include/net/bluetooth/l2cap.h
> >@@ -520,6 +520,8 @@ struct l2cap_chan {
> >	struct list_head	list;
> >	struct list_head	global_l;
> >
> >+	struct sk_buff		*skb_more;
> >+
> >	void			*data;
> >	struct l2cap_ops	*ops;
> >	struct mutex		lock;
> >diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >index e5a4fd9..73bf8a8 100644
> >--- a/net/bluetooth/l2cap_core.c
> >+++ b/net/bluetooth/l2cap_core.c
> >@@ -1827,6 +1827,8 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
> >	struct sk_buff **frag;
> >	int sent = 0;
> >
> >+	count = min_t(unsigned int, count, len);
> >+
> >	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
> >		return -EFAULT;
> >
> >@@ -1903,9 +1905,13 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
> >	int err, count;
> >	struct l2cap_hdr *lh;
> >
> >-	BT_DBG("chan %p len %d", chan, (int)len);
> >+	BT_DBG("chan %p len %d aclmtu %d" , chan, (int)len, conn->mtu);
> >
> >-	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
> >+	if (msg->msg_flags & MSG_MORE)
> >+		count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE),
> >+			      chan->omtu);
> >+	else
> >+		count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
> >
> >	skb = chan->ops->alloc_skb(chan, count + L2CAP_HDR_SIZE,
> >				   msg->msg_flags & MSG_DONTWAIT);
> >@@ -2048,6 +2054,75 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
> >	return err;
> >}
> >
> >+static int l2cap_append_pdu(struct l2cap_chan *chan, struct msghdr *msg,
> >+			    size_t len)
> >+{
> >+	struct l2cap_conn *conn = chan->conn;
> >+	struct sk_buff **frag, *skb = chan->skb_more;
> >+	int sent = 0;
> >+	unsigned int count;
> >+	struct l2cap_hdr *lh;
> >+
> >+	BT_DBG("chan %p len %ld", chan, len);
> >+
> >+	frag = &skb_shinfo(skb)->frag_list;
> >+	if (*frag)
> >+		goto frags;
> 
> I think this would be more readable without the goto - just use a
> normal if statement with a code block.  There's only one nested if
> statement.
> 
> >+
> >+	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE),
> >+		      chan->omtu);
> >+	count = count - skb->len + L2CAP_HDR_SIZE;
> >+	count = min_t(unsigned int, count, len);
> >+
> >+	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
> >+		return -EFAULT;
> >+
> >+	sent += count;
> >+	len  -= count;
> >+
> >+frags:
> >+	while (*frag)
> >+		frag = &(*frag)->next;
> >+
> >+	while (len) {
> >+		count = chan->omtu - skb->len + L2CAP_HDR_SIZE;
> >+		count = min_t(unsigned int, count, len);
> >+		count = min_t(unsigned int, conn->mtu, count);
> >+
> >+		*frag = chan->ops->alloc_skb(chan, count,
> >+					     msg->msg_flags & MSG_DONTWAIT);
> >+		if (IS_ERR(*frag))
> >+			return PTR_ERR(*frag);
> >+
> >+		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov,
> >+				     count))
> >+			return -EFAULT;
> >+
> >+		(*frag)->priority = skb->priority;
> >+
> >+		sent += count;
> >+		len  -= count;
> >+
> >+		skb->len += (*frag)->len;
> >+		skb->data_len += (*frag)->len;
> >+
> >+		frag = &(*frag)->next;
> >+
> >+		if (skb->len == chan->omtu + L2CAP_HDR_SIZE)
> >+			break;
> 
> Don't you want to return -EMSGSIZE if the data doesn't fit in one SDU?

You are reading it wrong. This checks if the buffered achieve the OMTU size,
if yes we break and send the data. Later l2cap_create_basic_pdu() is called to
deal with the remaining data.

> 
> >+	}
> >+
> >+	lh = (struct l2cap_hdr *) skb->data;
> >+	lh->len = cpu_to_le16(skb->len - L2CAP_HDR_SIZE);
> >+
> >+	if (skb->len == chan->omtu + L2CAP_HDR_SIZE) {
> >+		l2cap_do_send(chan, skb);
> 
> I don't think it's good to put a send in here.  Let the calling
> function do the send, so it's in one place.

This make the logic much more simple, otherwise extra checks will be needed in
l2cap_chan_send()

> 
> >+		chan->skb_more = NULL;
> >+	}
> >+
> >+	return sent;
> >+}
> >+
> >int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> >								u32 priority)
> >{
> >@@ -2068,16 +2143,41 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> >	switch (chan->mode) {
> >	case L2CAP_MODE_BASIC:
> >		/* Check outgoing MTU */
> >-		if (len > chan->omtu)
> >+		if (len > chan->omtu) {
> >+			kfree_skb(chan->skb_more);
> 
> Set skb_more to NULL after freeing.

Yes.

> 
> >			return -EMSGSIZE;
> >+		}
> >
> >-		/* Create a basic PDU */
> >-		skb = l2cap_create_basic_pdu(chan, msg, len, priority);
> >-		if (IS_ERR(skb))
> >+		err = len;
> >+		if (chan->skb_more) {
> >+			int sent = l2cap_append_pdu(chan, msg, len);
> >+
> >+			if (sent < 0) {
> >+				kfree_skb(chan->skb_more);
> >+				return sent;
> >+			}
> >+
> >+			len -= sent;
> >+		}
> >+
> >+		if (len)
> >+			skb = l2cap_create_basic_pdu(chan, msg, len, priority);
> 
> Shouldn't this be the 'else' clause for the above if statement?  You
> should either call l2cap_append_pdu or l2cap_create_basic_pdu, but
> never both.  Better to structure the logic so that they are
> obviously mutually exclusive.

No, that is the continuation of what I send above, if we call
l2cap_append_pdu(), completely fill a pdu and send it we would new a call to
l2cap_create_basic_pdu() if there is more data to queue (len > 0)

> 
> >+		else
> >+			skb = chan->skb_more;
> >+
> >+		if (IS_ERR(skb)) {
> >+			kfree_skb(chan->skb_more);
> 
> Set skb_more to NULL after freeing.

Yes.

> 
> >			return PTR_ERR(skb);
> >+		}
> >+
> >+		if (!skb)
> >+			return err;
> >+
> >+		if (msg->msg_flags & MSG_MORE && skb->len < chan->omtu)
> >+			chan->skb_more = skb;
> >+		else
> >+			l2cap_do_send(chan, skb);
> 
> I think l2cap_do_send() should be called if and only if MSG_MORE is
> not set, unless there is an MTU problem.

If the queued data equals the omtu then we send it.

> 
> Also, do you need to account for L2CAP_HDR_SIZE when checking
> skb->len?

I think so.

	Gustavo
