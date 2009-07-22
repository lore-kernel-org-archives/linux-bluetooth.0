Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: [PATCH 3/3] Bluetooth: add support for Segmentation and Reassembly of SDUs
Date: Wed, 22 Jul 2009 06:29:36 -0300
Message-Id: <1248254976-12090-4-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1248254976-12090-3-git-send-email-gustavo@las.ic.unicamp.br>
References: <1248254976-12090-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1248254976-12090-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1248254976-12090-3-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ERTM should use Segmentation and Reassembly to break down a SDU in many
PDUs on sending data to the other side.
On sending packets we queue all 'segments' until end of segmentation and
just the add them to the queue for sending.
On receiving we create a new skb with the SDU reassembled.

Based on a patch from Nathan Holstein <nathan@lampreynetworks.com>

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |   18 ++++
 net/bluetooth/l2cap.c         |  184 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 182 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 95d6963..0cd7822 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -326,6 +326,10 @@ struct l2cap_pinfo {
 	__u8		req_seq;
 	__u8		expected_tx_seq;
 	__u8		num_to_ack;
+	__u16		sdu_len;
+	__u16		partial_sdu_len;
+	__u8		start_txseq;
+	struct sk_buff	*sdu;
 
 	__u8		ident;
 
@@ -355,6 +359,7 @@ struct l2cap_pinfo {
 #define L2CAP_CONF_MAX_CONF_RSP 2
 
 #define L2CAP_CONN_TRANSMITTER     0x01
+#define L2CAP_CONN_SAR_SDU         0x02
 
 static inline void l2cap_init_send_head(struct sock *sk)
 {
@@ -414,6 +419,14 @@ static inline void l2cap_advance_send_head(struct sock *sk, struct sk_buff *skb)
 		sk->sk_send_head = l2cap_write_queue_next(sk, skb);
 }
 
+static inline void l2cap_add_sar_queue(struct sock *sk, struct sk_buff_head *list, struct sk_buff_head *sar_queue)
+{
+	if (sk->sk_send_head == NULL)
+		sk->sk_send_head = sar_queue->next;
+
+	skb_queue_splice_tail(sar_queue, list);
+}
+
 static inline int l2cap_tx_window_full(struct sock *sk)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -456,6 +469,11 @@ static inline int l2cap_is_S_frame(u16 control)
 	return (control & L2CAP_CONTROL_FRAME_TYPE);
 }
 
+static inline int l2cap_sar_sdu_start(u16 control)
+{
+	return (control & L2CAP_CONTROL_SAR) == L2CAP_SAR_SDU_START;
+}
+
 void l2cap_load(void);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 5d10277..9558561 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1267,7 +1267,7 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
 	return sent;
 }
 
-static int l2cap_create_sdu(struct sock *sk, struct msghdr *msg, size_t len, u16 *control, struct sk_buff **out_skb)
+static int l2cap_create_sdu(struct sock *sk, struct msghdr *msg, size_t len, u16 *control, u16 sdulen, struct sk_buff **out_skb)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb;
@@ -1276,6 +1276,9 @@ static int l2cap_create_sdu(struct sock *sk, struct msghdr *msg, size_t len, u16
 
 	hlen = (control) ? L2CAP_ERTM_HDR_SIZE : L2CAP_HDR_SIZE;
 
+	if (sdulen)
+		hlen +=2;
+
 	BT_DBG("sk %p len %d", sk, (int)len);
 
 	/* First fragment (with L2CAP header) */
@@ -1296,6 +1299,9 @@ static int l2cap_create_sdu(struct sock *sk, struct msghdr *msg, size_t len, u16
 	if (control)
 		put_unaligned(*control, (__le16 *) skb_put(skb, 2));
 
+	if (sdulen)
+		put_unaligned(sdulen, (__le16 *) skb_put(skb, 2));
+
 	if (sk->sk_type == SOCK_DGRAM)
 		put_unaligned(l2cap_pi(sk)->psm, (__le16 *) skb_put(skb, 2));
 
@@ -1310,7 +1316,58 @@ static int l2cap_create_sdu(struct sock *sk, struct msghdr *msg, size_t len, u16
 
 static inline int l2cap_create_basic_sdu(struct sock *sk, struct msghdr *msg, size_t len, struct sk_buff **out_skb)
 {
-	return l2cap_create_sdu(sk, msg, len, NULL, out_skb);
+	return l2cap_create_sdu(sk, msg, len, NULL, 0, out_skb);
+}
+
+
+static inline int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sk_buff *skb;
+	struct sk_buff_head sar_queue;
+	u16 control;
+	size_t size = 0;
+	int err;
+
+	__skb_queue_head_init(&sar_queue);
+	control |= L2CAP_SAR_SDU_START;
+	err = l2cap_create_sdu(sk, msg, pi->max_pdu_size, &control,
+			len, &skb);
+	if (unlikely(err < 0))
+		return err;
+
+	__skb_queue_tail(&sar_queue, skb);
+	len -= pi->max_pdu_size;
+	size +=pi->max_pdu_size;
+	control = 0;
+
+	while (len > 0) {
+		size_t buflen;
+
+		if (len > pi->max_pdu_size) {
+			control |= L2CAP_SAR_SDU_CONTINUE;
+			buflen = pi->max_pdu_size;
+		}
+		else {
+			control |= L2CAP_SAR_SDU_END;
+			buflen = len;
+		}
+
+		err = l2cap_create_sdu(sk, msg, buflen ,&control,
+				0, &skb);
+		if (unlikely(err < 0)) {
+			skb_queue_purge(&sar_queue);
+			return err;
+		}
+
+		__skb_queue_tail(&sar_queue, skb);
+		len -= buflen;
+		size += buflen;
+		control = 0;
+	}
+	l2cap_add_sar_queue(sk, &pi->tx_queue, &sar_queue);
+
+	return size;
 }
 
 static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
@@ -1331,7 +1388,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		return -EOPNOTSUPP;
 
 	/* Check outgoing MTU */
-	if ((sk->sk_type != SOCK_RAW || pi->mode == L2CAP_MODE_BASIC)
+	if ((sk->sk_type != SOCK_RAW && pi->mode == L2CAP_MODE_BASIC)
 		&& len > pi->omtu)
 		return -EINVAL;
 
@@ -1353,21 +1410,21 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		break;
 
 	case L2CAP_MODE_ERTM:
-
 		/* Entire SDU fits into one PDU */
-		if (len <= pi->omtu) {
+		if (len <= pi->max_pdu_size) {
 			control = L2CAP_SAR_UNSEGMENTED;
-			err = l2cap_create_sdu(sk, msg, len, &control, &skb);
+			err = l2cap_create_sdu(sk, msg, len, &control, 0, &skb);
+			if (err < 0)
+				goto done;
+
+			l2cap_add_tx_queue_tail(sk, skb);
 		}
+		/* Segment SDU into multiples PDUs */
 		else {
-			/* Segmentation will be added later */
-			err = -EINVAL;
-			goto done;
+			err = l2cap_sar_segment_sdu(sk, msg, len);
+			if (unlikely(err < 0))
+				goto done;
 		}
-		if (err < 0)
-			goto done;
-
-		l2cap_add_tx_queue_tail(sk, skb);
 
 		err = l2cap_ertm_send(sk);
 		if (!err)
@@ -1379,7 +1436,6 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		err = -EINVAL;
 	}
 
-
 done:
 	release_sock(sk);
 	return err;
@@ -2770,6 +2826,89 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn, struct sk_buff *sk
 	kfree_skb(skb);
 }
 
+static int l2cap_sar_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control, u8 txseq)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sk_buff *_skb;
+	unsigned char *to;
+	int err = -EINVAL;
+
+	switch (control & L2CAP_CONTROL_SAR) {
+	case L2CAP_SAR_UNSEGMENTED:
+		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
+			goto drop2;
+
+		err = sock_queue_rcv_skb(sk, skb);
+		if (unlikely(err < 0))
+			goto drop;
+		break;
+
+	case L2CAP_SAR_SDU_START:
+		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
+			goto drop2;
+
+		pi->sdu_len = get_unaligned((__le16 *) skb->data);
+		skb_pull(skb, 2);
+
+		pi->sdu = bt_skb_alloc(pi->sdu_len, GFP_ATOMIC);
+		if (!pi->sdu)
+			goto drop;
+
+		to = skb_put(pi->sdu, skb->len);
+		memcpy(to, skb->data, skb->len);
+
+		pi->conn_state |= L2CAP_CONN_SAR_SDU;
+		pi->partial_sdu_len = skb->len;
+		pi->start_txseq = txseq;
+		kfree_skb(skb);
+		break;
+
+	case L2CAP_SAR_SDU_CONTINUE:
+		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
+			goto drop;
+
+		to = skb_put(pi->sdu, skb->len);
+		memcpy(to, skb->data, skb->len);
+
+		pi->partial_sdu_len += skb->len;
+		if (pi->partial_sdu_len > pi->sdu_len)
+			goto drop2;
+
+		kfree_skb(skb);
+		break;
+
+	case L2CAP_SAR_SDU_END:
+		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
+			goto drop;
+
+		to = skb_put(pi->sdu, skb->len);
+		memcpy(to, skb->data, skb->len);
+
+		pi->conn_state &= !L2CAP_CONN_SAR_SDU;
+		pi->partial_sdu_len += skb->len;
+
+		if (pi->partial_sdu_len != pi->sdu_len)
+			goto drop2;
+
+		_skb = skb_clone(pi->sdu, GFP_ATOMIC);
+		err = sock_queue_rcv_skb(sk, _skb);
+		if (unlikely(err < 0))
+			kfree_skb(_skb);
+
+		kfree_skb(pi->sdu);
+		kfree_skb(skb);
+		break;
+	}
+	return 0;
+
+drop2:
+	kfree_skb(pi->sdu);
+
+drop:
+	kfree_skb(skb);
+	return err;
+}
+
 static inline int l2cap_data_channel_I_frame(struct sock *sk, u16 rx_control, struct sk_buff *skb)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -2782,11 +2921,11 @@ static inline int l2cap_data_channel_I_frame(struct sock *sk, u16 rx_control, st
 	if (tx_seq != pi->expected_tx_seq)
 		return -EINVAL;
 
-	L2CAP_SEQ_NUM_INC(pi->expected_tx_seq);
-	err = sock_queue_rcv_skb(sk, skb);
-	if (err)
+	err = l2cap_sar_reassembly_sdu(sk, skb, rx_control, tx_seq);
+	if (err < 0)
 		return err;
 
+	L2CAP_SEQ_NUM_INC(pi->expected_tx_seq);
 	L2CAP_NUM_TO_ACK_INC(pi->num_to_ack);
 	if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1) {
 		tx_control |= L2CAP_CONTROL_FRAME_TYPE;
@@ -2830,16 +2969,21 @@ static inline int l2cap_data_channel_S_frame(struct sock *sk, u16 rx_control, st
 
 static inline int l2cap_ertm_data_channel(struct sock *sk, struct l2cap_hdr *lh, struct sk_buff *skb)
 {
-	u16 control, len = skb->len;
+	u16 control, len;
 
 	BT_DBG("sk %p skb %p", sk, skb);
 
 	control = get_unaligned((__le16 *) skb->data);
 	skb_pull(skb, 2);
-	len -=2;
+
+	len = skb->len;
+
 	BT_DBG("control 0x%4.4x", control);
 
-	if (l2cap_pi(sk)->imtu < skb->len)
+	if (l2cap_sar_sdu_start(control))
+		len -=2;
+
+	if (l2cap_pi(sk)->imtu < len)
 		goto drop;
 
 	if (l2cap_is_I_frame(control))
-- 
1.6.3.3

