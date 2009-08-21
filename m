Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 7/8] Bluetooth: Add support for SREJ exception
Date: Thu, 20 Aug 2009 22:26:03 -0300
Message-Id: <1250817964-11533-7-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1250817964-11533-6-git-send-email-gustavo@las.ic.unicamp.br>
References: <1250817964-11533-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1250817964-11533-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1250817964-11533-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1250817964-11533-4-git-send-email-gustavo@las.ic.unicamp.br>
 <1250817964-11533-5-git-send-email-gustavo@las.ic.unicamp.br>
 <1250817964-11533-6-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When L2CAP lose a I-frame we send a SREJ frame to the transmitter side
requesting the lost packet. This patch implement all Recv I-frame events
on SREJ_SENT state table, but the ones that deal with SendRej == TRUE (We
don't implement REJ exception at receiver side).

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/bluetooth.h |    1 +
 include/net/bluetooth/l2cap.h     |   14 ++-
 net/bluetooth/l2cap.c             |  220 +++++++++++++++++++++++++++++++++----
 3 files changed, 210 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b8b9a84..718394e 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -140,6 +140,7 @@ struct bt_skb_cb {
 	__u8 incoming;
 	__u8 tx_seq;
 	__u8 retries;
+	__u8 sar;
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 59b26bf..9f2126a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -108,6 +108,7 @@ struct l2cap_conninfo {
 
 #define L2CAP_CTRL_TXSEQ_SHIFT      1
 #define L2CAP_CTRL_REQSEQ_SHIFT     8
+#define L2CAP_CTRL_SAR_SHIFT       14
 
 /* L2CAP Supervisory Function */
 #define L2CAP_SUPER_RCV_READY           0x0000
@@ -290,6 +291,13 @@ struct l2cap_conn {
 /* ----- L2CAP channel and socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
 #define TX_QUEUE(sk) (&l2cap_pi(sk)->tx_queue)
+#define SREJ_QUEUE(sk) (&l2cap_pi(sk)->srej_queue)
+#define SREJ_LIST(sk) (&l2cap_pi(sk)->srej_l.list)
+
+struct srej_list {
+	__u8	tx_seq;
+	struct list_head list;
+};
 
 struct l2cap_pinfo {
 	struct bt_sock	bt;
@@ -318,6 +326,8 @@ struct l2cap_pinfo {
 	__u8		expected_ack_seq;
 	__u8		req_seq;
 	__u8		expected_tx_seq;
+	__u8		buffer_seq;
+	__u8		buffer_seq_srej;
 	__u8		unacked_frames;
 	__u8		retry_count;
 	__u8		num_to_ack;
@@ -338,6 +348,8 @@ struct l2cap_pinfo {
 	struct timer_list	retrans_timer;
 	struct timer_list	monitor_timer;
 	struct sk_buff_head	tx_queue;
+	struct sk_buff_head	srej_queue;
+	struct srej_list	srej_l;
 	struct l2cap_conn	*conn;
 	struct sock		*next_c;
 	struct sock		*prev_c;
@@ -356,7 +368,7 @@ struct l2cap_pinfo {
 #define L2CAP_CONF_MAX_CONF_RSP 2
 
 #define L2CAP_CONN_SAR_SDU         0x01
-#define L2CAP_CONN_UNDER_REJ       0x02
+#define L2CAP_CONN_SREJ_SENT       0x02
 #define L2CAP_CONN_WAIT_F          0x04
 
 #define __mod_retrans_timer() mod_timer(&l2cap_pi(sk)->retrans_timer, \
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 23c708f..fbe71ec 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1292,6 +1292,50 @@ static int l2cap_streaming_send(struct sock *sk)
 	return 0;
 }
 
+static int l2cap_retransmit_frame(struct sock *sk, u8 tx_seq)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sk_buff *skb, *tx_skb;
+	u16 control, fcs;
+	int err;
+
+	skb = skb_peek(TX_QUEUE(sk));
+	do {
+		if (bt_cb(skb)->tx_seq != tx_seq) {
+			if (skb_queue_is_last(TX_QUEUE(sk), skb))
+				break;
+			skb = skb_queue_next(TX_QUEUE(sk), skb);
+			continue;
+		}
+
+		if (pi->remote_max_tx &&
+				bt_cb(skb)->retries == pi->remote_max_tx) {
+			l2cap_send_disconn_req(pi->conn, sk);
+			break;
+		}
+
+		tx_skb = skb_clone(skb, GFP_ATOMIC);
+		bt_cb(skb)->retries++;
+		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
+		control |= (pi->req_seq << L2CAP_CTRL_REQSEQ_SHIFT)
+				| (tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
+		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
+
+		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
+			fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
+			put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
+		}
+
+		err = l2cap_do_send(sk, tx_skb);
+		if (err < 0) {
+			l2cap_send_disconn_req(pi->conn, sk);
+			return err;
+		}
+		break;
+	} while(1);
+	return 0;
+}
+
 static int l2cap_ertm_send(struct sock *sk)
 {
 	struct sk_buff *skb, *tx_skb;
@@ -2705,6 +2749,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 				l2cap_monitor_timeout, (unsigned long) sk);
 
 		__skb_queue_head_init(TX_QUEUE(sk));
+		__skb_queue_head_init(SREJ_QUEUE(sk));
 		l2cap_chan_ready(sk);
 		goto unlock;
 	}
@@ -2784,8 +2829,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 		sk->sk_state = BT_CONNECTED;
 		l2cap_pi(sk)->expected_tx_seq = 0;
+		l2cap_pi(sk)->buffer_seq = 0;
 		l2cap_pi(sk)->num_to_ack = 0;
 		__skb_queue_head_init(TX_QUEUE(sk));
+		__skb_queue_head_init(SREJ_QUEUE(sk));
 		l2cap_chan_ready(sk);
 	}
 
@@ -2817,6 +2864,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	skb_queue_purge(TX_QUEUE(sk));
+	skb_queue_purge(SREJ_QUEUE(sk));
 	del_timer(&l2cap_pi(sk)->retrans_timer);
 	del_timer(&l2cap_pi(sk)->monitor_timer);
 
@@ -2843,6 +2891,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 		return 0;
 
 	skb_queue_purge(TX_QUEUE(sk));
+	skb_queue_purge(SREJ_QUEUE(sk));
 	del_timer(&l2cap_pi(sk)->retrans_timer);
 	del_timer(&l2cap_pi(sk)->monitor_timer);
 
@@ -3038,6 +3087,33 @@ static int l2cap_check_fcs(struct l2cap_pinfo *pi,  struct sk_buff *skb)
 	return 0;
 }
 
+static void l2cap_add_to_srej_queue(struct sock *sk, struct sk_buff *skb, u8 tx_seq, u8 sar)
+{
+	struct sk_buff *next_skb;
+
+	bt_cb(skb)->tx_seq = tx_seq;
+	bt_cb(skb)->sar = sar;
+
+	next_skb = skb_peek(SREJ_QUEUE(sk));
+	if (!next_skb) {
+		__skb_queue_tail(SREJ_QUEUE(sk), skb);
+		return;
+	}
+
+	do {
+		if (bt_cb(next_skb)->tx_seq > tx_seq) {
+			__skb_queue_before(SREJ_QUEUE(sk), next_skb, skb);
+			return;
+		}
+
+		if (skb_queue_is_last(SREJ_QUEUE(sk), next_skb))
+			break;
+
+	} while((next_skb = skb_queue_next(SREJ_QUEUE(sk), next_skb)));
+
+	__skb_queue_tail(SREJ_QUEUE(sk), skb);
+}
+
 static int l2cap_sar_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -3118,50 +3194,143 @@ static int l2cap_sar_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 co
 	return err;
 }
 
+static void l2cap_check_srej_gap(struct sock *sk, u8 tx_seq)
+{
+	struct sk_buff *skb;
+	u16 control = 0;
+
+	while((skb = skb_peek(SREJ_QUEUE(sk)))) {
+		if (bt_cb(skb)->tx_seq != tx_seq)
+			break;
+
+		skb = skb_dequeue(SREJ_QUEUE(sk));
+		control |= bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
+		l2cap_sar_reassembly_sdu(sk, skb, control);
+		l2cap_pi(sk)->buffer_seq_srej =
+			(l2cap_pi(sk)->buffer_seq_srej + 1) % 64;
+		tx_seq++;
+	}
+}
+
+static void l2cap_resend_srejframe(struct sock *sk, u8 tx_seq)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct srej_list *l, *tmp;
+	u16 control;
+
+	list_for_each_entry_safe(l,tmp, SREJ_LIST(sk), list) {
+		if (l->tx_seq == tx_seq) {
+			list_del(&l->list);
+			kfree(l);
+			return;
+		}
+		control = L2CAP_SUPER_SELECT_REJECT;
+		control |= l->tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+		l2cap_send_sframe(pi, control);
+		list_del(&l->list);
+		list_add_tail(&l->list, SREJ_LIST(sk));
+	}
+}
+
+static void l2cap_send_srejframe(struct sock *sk, u8 tx_seq)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct srej_list *new;
+	u16 control;
+
+	while (tx_seq != pi->expected_tx_seq) {
+		control = L2CAP_SUPER_SELECT_REJECT;
+		control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+		l2cap_send_sframe(pi, control);
+
+		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
+		new->tx_seq = pi->expected_tx_seq++;
+		list_add_tail(&new->list, SREJ_LIST(sk));
+	}
+	pi->expected_tx_seq++;
+}
+
 static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u8 tx_seq = __get_txseq(rx_control);
 	u16 tx_control = 0;
+	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
 	int err = 0;
 
 	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
 
-	if (tx_seq == pi->expected_tx_seq) {
-		if (pi->conn_state & L2CAP_CONN_UNDER_REJ)
-			pi->conn_state &= ~L2CAP_CONN_UNDER_REJ;
+	if (tx_seq == pi->expected_tx_seq)
+		goto expected;
 
-		err = l2cap_sar_reassembly_sdu(sk, skb, rx_control);
-		if (err < 0)
-			return err;
+	if (pi->conn_state & L2CAP_CONN_SREJ_SENT) {
+		struct srej_list *first;
 
-		pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
-		pi->num_to_ack = (pi->num_to_ack + 1) % L2CAP_DEFAULT_NUM_TO_ACK;
-		if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1) {
-			tx_control |= L2CAP_SUPER_RCV_READY;
-			tx_control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-			goto send;
+		first = list_first_entry(SREJ_LIST(sk),
+				struct srej_list, list);
+		if (tx_seq == first->tx_seq) {
+			l2cap_add_to_srej_queue(sk, skb, tx_seq, sar);
+			l2cap_check_srej_gap(sk, tx_seq);
+
+			list_del(&first->list);
+			kfree(first);
+
+			if (list_empty(SREJ_LIST(sk))) {
+				pi->buffer_seq = pi->buffer_seq_srej;
+				pi->conn_state &= ~L2CAP_CONN_SREJ_SENT;
+			}
+		} else {
+			struct srej_list *l;
+			l2cap_add_to_srej_queue(sk, skb, tx_seq, sar);
+
+			list_for_each_entry(l, SREJ_LIST(sk), list) {
+				if (l->tx_seq == tx_seq) {
+					l2cap_resend_srejframe(sk, tx_seq);
+					return 0;
+				}
+			}
+			l2cap_send_srejframe(sk, tx_seq);
 		}
 	} else {
-		/* Unexpected txSeq. Send a REJ S-frame */
-		kfree_skb(skb);
-		if (!(pi->conn_state & L2CAP_CONN_UNDER_REJ)) {
-			tx_control |= L2CAP_SUPER_REJECT;
-			tx_control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-			pi->conn_state |= L2CAP_CONN_UNDER_REJ;
+		pi->conn_state |= L2CAP_CONN_SREJ_SENT;
 
-			goto send;
-		}
+		INIT_LIST_HEAD(SREJ_LIST(sk));
+		pi->buffer_seq_srej = pi->buffer_seq;
+
+		__skb_queue_head_init(SREJ_QUEUE(sk));
+		l2cap_add_to_srej_queue(sk, skb, tx_seq, sar);
+
+		l2cap_send_srejframe(sk, tx_seq);
 	}
 	return 0;
 
-send:
-	return l2cap_send_sframe(pi, tx_control);
+expected:
+	pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
+
+	if (pi->conn_state & L2CAP_CONN_SREJ_SENT) {
+		l2cap_add_to_srej_queue(sk, skb, tx_seq, sar);
+		return 0;
+	}
+
+	pi->buffer_seq = (pi->buffer_seq + 1) % 64;
+
+	err = l2cap_sar_reassembly_sdu(sk, skb, rx_control);
+	if (err < 0)
+		return err;
+
+	pi->num_to_ack = (pi->num_to_ack + 1) % L2CAP_DEFAULT_NUM_TO_ACK;
+	if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1) {
+		tx_control |= L2CAP_SUPER_RCV_READY;
+		tx_control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+		l2cap_send_sframe(pi, tx_control);
+	}
+	return 0;
 }
 
 static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u8 tx_seq = __get_reqseq(rx_control);
 
 	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
 
@@ -3181,7 +3350,7 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 			if (pi->unacked_frames > 0)
 				__mod_retrans_timer();
 		} else {
-			pi->expected_ack_seq = __get_reqseq(rx_control);
+			pi->expected_ack_seq = tx_seq;
 			l2cap_drop_acked_frames(sk);
 			if (pi->unacked_frames > 0)
 				__mod_retrans_timer();
@@ -3200,8 +3369,11 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 
 		break;
 
-	case L2CAP_SUPER_RCV_NOT_READY:
 	case L2CAP_SUPER_SELECT_REJECT:
+		l2cap_retransmit_frame(sk, tx_seq);
+		break;
+
+	case L2CAP_SUPER_RCV_NOT_READY:
 		break;
 	}
 
-- 
1.6.3.3

