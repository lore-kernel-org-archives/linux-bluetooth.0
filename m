Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [RFC 6/7] Bluetooth: Reassemble enhanced L2CAP PDUs using skb fragments.
Date: Tue, 10 Aug 2010 12:15:03 -0700
Message-Id: <1281467704-5378-7-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

As enhanced L2CAP PDUs arrive, it is not necessary to copy them
in to a separate skbuff.  Instead, the skbuffs can be linked
together as fragments, only being copied in to a linear buffer
when the data is copied to userspace.  This avoids the need
to allocate additional buffers for incoming data, and
eliminates copying of data payloads during SDU reassembly.
This is of greater concern with high-speed AMP links than
with BR/EDR.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap.c         |   66 +++++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2f3222f..9384e87 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -357,6 +357,7 @@ struct l2cap_pinfo {
 	__u16		sdu_len;
 	__u16		partial_sdu_len;
 	struct sk_buff	*sdu;
+	struct sk_buff	*sdu_last_frag;
 
 	__u8		ident;
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index b485c4a..0212035 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -290,6 +290,9 @@ static void l2cap_chan_del(struct sock *sk, int err)
 		skb_queue_purge(SREJ_QUEUE(sk));
 		skb_queue_purge(BUSY_QUEUE(sk));
 
+		if (l2cap_pi(sk)->sdu)
+			kfree_skb(l2cap_pi(sk)->sdu);
+
 		list_for_each_entry_safe(l, tmp, SREJ_LIST(sk), list) {
 			list_del(&l->list);
 			kfree(l);
@@ -3635,6 +3638,27 @@ static int l2cap_add_to_srej_queue(struct sock *sk, struct sk_buff *skb, u8 tx_s
 	return 0;
 }
 
+static inline void append_skb_frag(struct sk_buff *skb,
+			struct sk_buff *new_frag, struct sk_buff **last_frag)
+{
+	/* skb->len reflects data in skb as well as all fragments
+	   skb->data_len reflects only data in fragments
+	 */
+	BT_DBG("skb %p, new_frag %p, *last_frag %p", skb, new_frag, *last_frag);
+
+	if (!skb_has_frags(skb))
+		skb_shinfo(skb)->frag_list = new_frag;
+
+	new_frag->next = NULL;
+
+	(*last_frag)->next = new_frag;
+	*last_frag = new_frag;
+
+	skb->len += new_frag->len;
+	skb->data_len += new_frag->len;
+	skb->truesize += new_frag->truesize;
+}
+
 static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -3643,7 +3667,7 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
 
 	switch (control & L2CAP_CTRL_SAR) {
 	case L2CAP_SDU_UNSEGMENTED:
-		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
+		if (pi->sdu)
 			goto drop;
 
 		err = sock_queue_rcv_skb(sk, skb);
@@ -3653,61 +3677,42 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
 		break;
 
 	case L2CAP_SDU_START:
-		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
+		if (pi->sdu)
 			goto drop;
 
 		pi->sdu_len = get_unaligned_le16(skb->data);
+		skb_pull(skb, 2);
 
 		if (pi->sdu_len > pi->imtu)
 			goto disconnect;
 
-		pi->sdu = bt_skb_alloc(pi->sdu_len, GFP_ATOMIC);
-		if (!pi->sdu)
-			return -ENOMEM;
-
-		/* pull sdu_len bytes only after alloc, because of Local Busy
-		 * condition we have to be sure that this will be executed
-		 * only once, i.e., when alloc does not fail */
-		skb_pull(skb, 2);
-
-		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
-
-		pi->conn_state |= L2CAP_CONN_SAR_SDU;
-		pi->partial_sdu_len = skb->len;
+		pi->sdu = skb;
+		pi->sdu_last_frag = skb;
 		break;
 
 	case L2CAP_SDU_CONTINUE:
-		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
-			goto disconnect;
-
 		if (!pi->sdu)
 			goto disconnect;
 
-		pi->partial_sdu_len += skb->len;
-		if (pi->partial_sdu_len > pi->sdu_len)
-			goto drop;
+		append_skb_frag(pi->sdu, skb, &pi->sdu_last_frag);
 
-		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+		if (pi->sdu->len > pi->sdu_len)
+			goto drop;
 
 		break;
 
 	case L2CAP_SDU_END:
-		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
-			goto disconnect;
-
 		if (!pi->sdu)
 			goto disconnect;
 
 		if (!(pi->conn_state & L2CAP_CONN_SAR_RETRY)) {
-			pi->partial_sdu_len += skb->len;
+			append_skb_frag(pi->sdu, skb, &pi->sdu_last_frag);
 
-			if (pi->partial_sdu_len > pi->imtu)
+			if (pi->sdu->len > pi->sdu_len)
 				goto drop;
 
-			if (pi->partial_sdu_len != pi->sdu_len)
+			if (pi->sdu->len != pi->sdu_len)
 				goto drop;
-
-			memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
 		}
 
 		_skb = skb_clone(pi->sdu, GFP_ATOMIC);
@@ -3724,7 +3729,6 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
 		}
 
 		pi->conn_state &= ~L2CAP_CONN_SAR_RETRY;
-		pi->conn_state &= ~L2CAP_CONN_SAR_SDU;
 
 		kfree_skb(pi->sdu);
 		break;
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
