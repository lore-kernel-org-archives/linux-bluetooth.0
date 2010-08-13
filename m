Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Fri, 13 Aug 2010 12:41:32 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: Re: [RFC 3/7] Bluetooth: Add FCS awareness to L2CAP HCI
 fragmentation.
Message-ID: <20100813154132.GA3323@vigoh>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
 <1281467704-5378-4-git-send-email-mathewm@codeaurora.org>
 <20100811033540.GA9151@vigoh>
 <20100811035654.GA9293@vigoh>
 <alpine.DEB.2.00.1008121626340.8460@linux-sea-02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.00.1008121626340.8460@linux-sea-02>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-08-12 16:36:57 -0700]:

> 
> 
> On Wed, 11 Aug 2010, Gustavo F. Padovan wrote:
> 
> >Hi Mat,
> >
> >* Gustavo F. Padovan <gustavo@padovan.org> [2010-08-11 00:35:41 -0300]:
> >
> >>* Mat Martineau <mathewm@codeaurora.org> [2010-08-10 12:15:00 -0700]:
> >>
> >>>In order to not limit ERTM and streaming mode PDUs to the HCI MTU
> >>>size, L2CAP must be able to split PDUs in to multple HCI fragments.
> >>>This is done by allocating space for the FCS in the last fragment.
> >>>
> >>>Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> >>>---
> >>> net/bluetooth/l2cap.c |   39 ++++++++++++++++++++++++++++++++++-----
> >>> 1 files changed, 34 insertions(+), 5 deletions(-)
> >>>
> >>>diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> >>>index aa69c84..b485c4a 100644
> >>>--- a/net/bluetooth/l2cap.c
> >>>+++ b/net/bluetooth/l2cap.c
> >>>@@ -1664,31 +1664,63 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
> >>> {
> >>> 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
> >>> 	struct sk_buff **frag;
> >>>+	struct sk_buff *final;
> >>> 	int err, sent = 0;
> >>>
> >>>+	BT_DBG("sk %p, msg %p, len %d, count %d, skb %p", sk,
> >>>+		msg, (int)len, (int)count, skb);
> >>>+
> >>> 	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
> >>> 		return -EFAULT;
> >>>
> >>> 	sent += count;
> >>> 	len  -= count;
> >>>+	final = skb;
> >>>
> >>> 	/* Continuation fragments (no L2CAP header) */
> >>> 	frag = &skb_shinfo(skb)->frag_list;
> >>> 	while (len) {
> >>>+		int skblen;
> >>> 		count = min_t(unsigned int, conn->mtu, len);
> >>>
> >>>-		*frag = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err);
> >>>+		/* Add room for the FCS if it fits */
> >>>+		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16 &&
> >>>+		    len + L2CAP_FCS_SIZE <= conn->mtu)
> >>
> >>You don't need to check for (len + L2CAP_FCS_SIZE <= conn=mtu) here.
> >>Section 5.1 point that:
> >>
> >>"Unlike the B-Frame length field, the I-frame length field may be greater
> >>than the configured MTU because it includes the octet lengths of the
> >>Control, L2CAP SDU Length (when present), and frame check sequence
> >>fields as well as the Information octets."
> >>
> >>From that I understand "len <=" and not "len + L2CAP_FCS_SIZE <="
> >
> >So here you might want to the check if we support FCS, and then add 2 to
> >skblen.
> 
> That's what the code does, without violating the HCI MTU.

Yes, you are right!

> 
> >>>+			skblen = count + L2CAP_FCS_SIZE;
> >>>+		else
> >>>+			skblen = count;
> >>>+
> >>>+		*frag = bt_skb_send_alloc(sk, skblen,
> >>>+					msg->msg_flags & MSG_DONTWAIT, &err);
> >>> 		if (!*frag)
> >>> 			return -EFAULT;
> >>>-		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
> >>>+
> >>>+		if (memcpy_fromiovec(skb_put(*frag, count),
> >>>+				msg->msg_iov, count))
> >>> 			return -EFAULT;
> >>>
> >>> 		sent += count;
> >>> 		len  -= count;
> >>>
> >>>+		final = *frag;
> >>>+
> >>> 		frag = &(*frag)->next;
> >>> 	}
> >>>
> >>>+	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
> >>>+		if (skb_tailroom(final) < L2CAP_FCS_SIZE) {
> >>>+			*frag = bt_skb_send_alloc(sk, L2CAP_FCS_SIZE,
> >>>+						msg->msg_flags & MSG_DONTWAIT,
> >>>+						&err);
> >
> >Why do we need to check for FCS again? We already added it required
> >space to the last fragment.
> >
> 
> If there was room in the HCI fragment, count+2 bytes were allocated
> with bt_skb_send_alloc.  However, only count bytes were used by
> skb_put.
> 
> This final block of code is doing two things:
> 
>  1. Allocating a final HCI fragment for the FCS if there was not
> room for the FCS in the last data fragment.
> 
>  2. Doing the skb_put for the FCS bytes.
> 
> I will add some comments to this code to help clarify what's going on.

Ok, and do the other way around in the if:

	if (l2cap_pi(sk)->fcs != L2CAP_FCS_CRC16)
		return sent;

	if (skb_tailroom(...
	
-- 
Gustavo F. Padovan
http://padovan.org
