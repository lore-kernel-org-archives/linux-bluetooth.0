Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: [PATCH 2/2] Bluetooth: Add support for Segmentation and Reassembly of SDUs
Date: Sat, 25 Jul 2009 04:06:41 -0300
Message-Id: <1248505601-16069-2-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1248505601-16069-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1248505601-16069-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

ERTM should use Segmentation and Reassembly to break down a SDU in many
PDUs on sending data to the other side.
On sending packets we queue all 'segments' until end of segmentation and
just the add them to the queue for sending.
On receiving we create a new skb with the SDU reassembled.

Initially based on a patch from Nathan Holstein <nathan@lampreynetworks.com>

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |    8 ++
 net/bluetooth/l2cap.c         |  176 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 165 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9770f06..16488d1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -313,12 +313,17 @@ struct l2cap_pinfo {
 	__u8		conf_req[64];
 	__u8		conf_len;
 	__u8		conf_state;
+	__u8		conn_state;
 
 	__u8		next_tx_seq;
 	__u8		expected_ack_seq;
 	__u8		req_seq;
 	__u8		expected_tx_seq;
 	__u8		num_to_ack;
+	__u16		sdu_len;
+	__u16		partial_sdu_len;
+	__u8		start_txseq;
+	struct sk_buff	*sdu;
 
 	__u8		ident;
 
@@ -347,6 +352,8 @@ struct l2cap_pinfo {
 #define L2CAP_CONF_MAX_CONF_REQ 2
 #define L2CAP_CONF_MAX_CONF_RSP 2
 
+#define L2CAP_CONN_SAR_SDU         0x01
+
 static inline int l2cap_tx_window_full(struct sock *sk)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -364,6 +371,7 @@ static inline int l2cap_tx_window_full(struct sock *sk)
 #define __get_reqseq(ctrl) ((ctrl) & L2CAP_CTRL_REQSEQ) >> 8
 #define __is_iframe(ctrl) !((ctrl) & L2CAP_CTRL_FRAME_TYPE)
 #define __is_sframe(ctrl) (ctrl) & L2CAP_CTRL_FRAME_TYPE
+#define __is_sar_sdu_start(ctrl) ((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START
 
 void l2cap_load(void);
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index c88d0e9..3297fc4 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1279,7 +1279,7 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
 	return sent;
 }
 
-static struct sk_buff *l2cap_create_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 *control)
+static struct sk_buff *l2cap_create_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 *control, u16 sdulen)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb;
@@ -1288,8 +1288,11 @@ static struct sk_buff *l2cap_create_pdu(struct sock *sk, struct msghdr *msg, siz
 
 	BT_DBG("sk %p len %d", sk, (int)len);
 
-	if (control)
+	if (control) {
 		hlen += 2;
+		if (sdulen)
+			hlen +=2;
+	}
 	else if (sk->sk_type == SOCK_DGRAM)
 		hlen += 2;
 
@@ -1304,8 +1307,11 @@ static struct sk_buff *l2cap_create_pdu(struct sock *sk, struct msghdr *msg, siz
 	lh->cid = cpu_to_le16(l2cap_pi(sk)->dcid);
 	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
 
-	if (control)
+	if (control) {
 		put_unaligned_le16(*control, skb_put(skb, 2));
+		if (sdulen)
+			put_unaligned_le16(sdulen, skb_put(skb, 2));
+	}
 	else if (sk->sk_type == SOCK_DGRAM)
 		put_unaligned_le16(l2cap_pi(sk)->psm, skb_put(skb, 2));
 
@@ -1314,10 +1320,58 @@ static struct sk_buff *l2cap_create_pdu(struct sock *sk, struct msghdr *msg, siz
 		kfree_skb(skb);
 		return ERR_PTR(err);
 	}
-
 	return skb;
 }
 
+static inline int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sk_buff *skb;
+	struct sk_buff_head sar_queue;
+	u16 control;
+	size_t size = 0;
+
+	__skb_queue_head_init(&sar_queue);
+	control |= L2CAP_SDU_START;
+	skb = l2cap_create_pdu(sk, msg, pi->max_pdu_size, &control, len);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
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
+			control |= L2CAP_SDU_CONTINUE;
+			buflen = pi->max_pdu_size;
+		}
+		else {
+			control |= L2CAP_SDU_END;
+			buflen = len;
+		}
+
+		skb = l2cap_create_pdu(sk, msg, buflen ,&control, 0);
+		if (IS_ERR(skb)) {
+			skb_queue_purge(&sar_queue);
+			return PTR_ERR(skb);
+		}
+
+		__skb_queue_tail(&sar_queue, skb);
+		len -= buflen;
+		size += buflen;
+		control = 0;
+	}
+	skb_queue_splice_tail(&sar_queue, TX_QUEUE(sk));
+	if (sk->sk_send_head == NULL)
+		sk->sk_send_head = sar_queue.next;
+
+	return size;
+}
+
 static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
@@ -1336,7 +1390,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		return -EOPNOTSUPP;
 
 	/* Check outgoing MTU */
-	if ((sk->sk_type != SOCK_RAW || pi->mode == L2CAP_MODE_BASIC)
+	if ((sk->sk_type != SOCK_RAW && pi->mode == L2CAP_MODE_BASIC)
 			&& len > pi->omtu)
 		return -EINVAL;
 
@@ -1350,7 +1404,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	switch (pi->mode) {
 	case L2CAP_MODE_BASIC:
 		/* Create a basic PDU */
-		skb = l2cap_create_pdu(sk, msg, len, NULL);
+		skb = l2cap_create_pdu(sk, msg, len, NULL, 0);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			goto done;
@@ -1363,22 +1417,23 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 	case L2CAP_MODE_ERTM:
 		/* Entire SDU fits into one PDU */
-		if (len <= pi->omtu) {
+		if (len <= pi->max_pdu_size) {
 			control = L2CAP_SDU_UNSEGMENTED;
-			skb = l2cap_create_pdu(sk, msg, len, &control);
+			skb = l2cap_create_pdu(sk, msg, len, &control, 0);
 			if (IS_ERR(skb)) {
 				err = PTR_ERR(skb);
 				goto done;
 			}
+			__skb_queue_tail(TX_QUEUE(sk), skb);
+			if (sk->sk_send_head == NULL)
+				sk->sk_send_head = skb;
 		}
+		/* Segment SDU into multiples PDUs */
 		else {
-			/* FIXME: Segmentation will be added later */
-			err = -EINVAL;
-			goto done;
+			err = l2cap_sar_segment_sdu(sk, msg, len);
+			if (unlikely(err < 0))
+				goto done;
 		}
-		__skb_queue_tail(TX_QUEUE(sk), skb);
-		if (sk->sk_send_head == NULL)
-			sk->sk_send_head = skb;
 
 		err = l2cap_ertm_send(sk);
 		if (!err)
@@ -2756,6 +2811,85 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn, struct sk_buff *sk
 	kfree_skb(skb);
 }
 
+static int l2cap_sar_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control, u8 txseq)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sk_buff *_skb;
+	int err = -EINVAL;
+
+	switch (control & L2CAP_CTRL_SAR) {
+	case L2CAP_SDU_UNSEGMENTED:
+		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
+			goto drop2;
+
+		err = sock_queue_rcv_skb(sk, skb);
+		if (unlikely(err < 0))
+			goto drop;
+		break;
+
+	case L2CAP_SDU_START:
+		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
+			goto drop2;
+
+		pi->sdu_len = get_unaligned_le16(skb->data);
+		skb_pull(skb, 2);
+
+		pi->sdu = bt_skb_alloc(pi->sdu_len, GFP_ATOMIC);
+		if (!pi->sdu)
+			goto drop;
+
+		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+
+		pi->conn_state |= L2CAP_CONN_SAR_SDU;
+		pi->partial_sdu_len = skb->len;
+		pi->start_txseq = txseq;
+		kfree_skb(skb);
+		break;
+
+	case L2CAP_SDU_CONTINUE:
+		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
+			goto drop;
+
+		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+
+		pi->partial_sdu_len += skb->len;
+		if (pi->partial_sdu_len > pi->sdu_len)
+			goto drop2;
+
+		kfree_skb(skb);
+		break;
+
+	case L2CAP_SDU_END:
+		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
+			goto drop;
+
+		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
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
 static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -2768,11 +2902,11 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 	if (tx_seq != pi->expected_tx_seq)
 		return -EINVAL;
 
-	L2CAP_SEQ_NUM_INC(pi->expected_tx_seq);
-	err = sock_queue_rcv_skb(sk, skb);
-	if (err)
+	err = l2cap_sar_reassembly_sdu(sk, skb, rx_control, tx_seq);
+	if (unlikely(err < 0))
 		return err;
 
+	L2CAP_SEQ_NUM_INC(pi->expected_tx_seq);
 	L2CAP_NUM_TO_ACK_INC(pi->num_to_ack);
 	if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1) {
 		tx_control |= L2CAP_CTRL_FRAME_TYPE;
@@ -2817,7 +2951,7 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
 {
 	struct sock *sk;
-	u16 control;
+	u16 control, len;
 	int err;
 
 	sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
@@ -2848,8 +2982,12 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	case L2CAP_MODE_ERTM:
 		control = get_unaligned_le16(skb->data);
 		skb_pull(skb, 2);
+		len = skb->len;
 
-		if (l2cap_pi(sk)->imtu < skb->len)
+		if (__is_sar_sdu_start(control))
+			len -= 2;
+
+		if (l2cap_pi(sk)->imtu < len)
 			goto drop;
 
 		if (__is_iframe(control))
-- 
1.6.3.3
