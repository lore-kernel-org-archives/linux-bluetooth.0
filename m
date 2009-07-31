Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 4/4] Bluetooth: Add support for Retransmission and Monitor Timers
Date: Fri, 31 Jul 2009 19:57:40 -0300
Message-Id: <1249081060-6844-4-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1249081060-6844-3-git-send-email-gustavo@las.ic.unicamp.br>
References: <1249081060-6844-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1249081060-6844-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1249081060-6844-3-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

L2CAP uses rentransmission and monitor timers to inquiry the other side
about unacked I-frames. After send each I-frame we (re)start the
retransmission timer, if it expires, we start a monitor timer that send a
S-frame with P bit set and wait for S-frame with F bit set.
If monitor timer expires, it try again, at a maximum of
L2CAP_DEFAULT_MAX_TX.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/bluetooth.h |    1 +
 include/net/bluetooth/l2cap.h     |   15 +++++-
 net/bluetooth/l2cap.c             |   81 +++++++++++++++++++++++++++++++++++--
 3 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 65a5cf8..b8b9a84 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -139,6 +139,7 @@ struct bt_skb_cb {
 	__u8 pkt_type;
 	__u8 incoming;
 	__u8 tx_seq;
+	__u8 retries;
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c54b72a..aeadd7d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -31,9 +31,9 @@
 #define L2CAP_DEFAULT_FLUSH_TO		0xffff
 #define L2CAP_DEFAULT_TX_WINDOW		63
 #define L2CAP_DEFAULT_NUM_TO_ACK        (L2CAP_DEFAULT_TX_WINDOW/5)
-#define L2CAP_DEFAULT_MAX_RECEIVE	1
-#define L2CAP_DEFAULT_RETRANS_TO	300    /* 300 milliseconds */
-#define L2CAP_DEFAULT_MONITOR_TO	1000   /* 1 second */
+#define L2CAP_DEFAULT_MAX_TX		3
+#define L2CAP_DEFAULT_RETRANS_TO	1000    /* 1 second */
+#define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	672
 
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
@@ -318,6 +318,7 @@ struct l2cap_pinfo {
 	__u8		req_seq;
 	__u8		expected_tx_seq;
 	__u8		unacked_frames;
+	__u8		retry_count;
 	__u8		num_to_ack;
 	__u16		sdu_len;
 	__u16		partial_sdu_len;
@@ -334,6 +335,8 @@ struct l2cap_pinfo {
 
 	__le16		sport;
 
+	struct timer_list	retrans_timer;
+	struct timer_list	monitor_timer;
 	struct sk_buff_head	tx_queue;
 	struct l2cap_conn	*conn;
 	struct sock		*next_c;
@@ -353,6 +356,12 @@ struct l2cap_pinfo {
 
 #define L2CAP_CONN_SAR_SDU         0x01
 #define L2CAP_CONN_UNDER_REJ       0x02
+#define L2CAP_CONN_WAIT_ACK        0x04
+
+#define __mod_retrans_timer() mod_timer(&l2cap_pi(sk)->retrans_timer, \
+		jiffies +  msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
+#define __mod_monitor_timer() mod_timer(&l2cap_pi(sk)->monitor_timer, \
+		jiffies + msecs_to_jiffies(L2CAP_DEFAULT_MONITOR_TO));
 
 static inline int l2cap_tx_window_full(struct sock *sk)
 {
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 918cc15..0ce89c3 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1179,6 +1179,37 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *l
 	return 0;
 }
 
+static void l2cap_monitor_timeout(unsigned long arg)
+{
+	struct sock *sk = (void *) arg;
+	u16 control;
+
+	if (l2cap_pi(sk)->retry_count >= l2cap_pi(sk)->remote_max_tx) {
+		l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk);
+		return;
+	}
+
+	l2cap_pi(sk)->retry_count++;
+	__mod_monitor_timer();
+
+	control = L2CAP_CTRL_POLL;
+	l2cap_send_sframe(l2cap_pi(sk), control);
+}
+
+static void l2cap_retrans_timeout(unsigned long arg)
+{
+	struct sock *sk = (void *) arg;
+	u16 control;
+
+	l2cap_pi(sk)->retry_count = 1;
+	__mod_monitor_timer();
+
+	l2cap_pi(sk)->conn_state |= L2CAP_CONN_WAIT_ACK;
+
+	control = L2CAP_CTRL_POLL;
+	l2cap_send_sframe(l2cap_pi(sk), control);
+}
+
 static void l2cap_drop_acked_frames(struct sock *sk)
 {
 	struct sk_buff *skb;
@@ -1193,6 +1224,9 @@ static void l2cap_drop_acked_frames(struct sock *sk)
 		l2cap_pi(sk)->unacked_frames--;
 	}
 
+	if (!l2cap_pi(sk)->unacked_frames)
+		del_timer(&l2cap_pi(sk)->retrans_timer);
+
 	return;
 }
 
@@ -1219,10 +1253,21 @@ static int l2cap_ertm_send(struct sock *sk)
 	u16 *control;
 	int err;
 
+	if (pi->conn_state & L2CAP_CONN_WAIT_ACK)
+		return 0;
+
 	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(sk))) {
 		tx_seq = pi->next_tx_seq;
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 
+		if (pi->remote_max_tx &&
+				bt_cb(skb)->retries == pi->remote_max_tx) {
+			l2cap_send_disconn_req(pi->conn, sk);
+			break;
+		}
+
+		bt_cb(skb)->retries++;
+
 		control = (u16 *)(skb->data + L2CAP_HDR_SIZE);
 		*control |= cpu_to_le16(
 				(pi->req_seq << L2CAP_CTRL_REQSEQ_SHIFT)
@@ -1234,6 +1279,8 @@ static int l2cap_ertm_send(struct sock *sk)
 			return err;
 		}
 
+		__mod_retrans_timer();
+
 		pi->next_tx_seq = (pi->next_tx_seq + 1) % 64;
 		bt_cb(skb)->tx_seq = tx_seq;
 
@@ -1370,6 +1417,8 @@ static struct sk_buff *l2cap_create_ertm_pdu(struct sock *sk, struct msghdr *msg
 		kfree_skb(skb);
 		return ERR_PTR(err);
 	}
+
+	bt_cb(skb)->retries = 0;
 	return skb;
 }
 
@@ -2064,7 +2113,7 @@ done:
 	case L2CAP_MODE_ERTM:
 		rfc.mode            = L2CAP_MODE_ERTM;
 		rfc.txwin_size      = L2CAP_DEFAULT_TX_WINDOW;
-		rfc.max_transmit    = L2CAP_DEFAULT_MAX_RECEIVE;
+		rfc.max_transmit    = L2CAP_DEFAULT_MAX_TX;
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
@@ -2559,6 +2608,12 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		l2cap_pi(sk)->next_tx_seq = 0;
 		l2cap_pi(sk)->expected_ack_seq = 0;
 		l2cap_pi(sk)->unacked_frames = 0;
+
+		setup_timer(&l2cap_pi(sk)->retrans_timer,
+				l2cap_retrans_timeout, (unsigned long) sk);
+		setup_timer(&l2cap_pi(sk)->monitor_timer,
+				l2cap_monitor_timeout, (unsigned long) sk);
+
 		__skb_queue_head_init(TX_QUEUE(sk));
 		l2cap_chan_ready(sk);
 		goto unlock;
@@ -2668,6 +2723,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	skb_queue_purge(TX_QUEUE(sk));
+	del_timer(&l2cap_pi(sk)->retrans_timer);
+	del_timer(&l2cap_pi(sk)->monitor_timer);
 
 	l2cap_chan_del(sk, ECONNRESET);
 	bh_unlock_sock(sk);
@@ -2692,6 +2749,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 		return 0;
 
 	skb_queue_purge(TX_QUEUE(sk));
+	del_timer(&l2cap_pi(sk)->retrans_timer);
+	del_timer(&l2cap_pi(sk)->monitor_timer);
 
 	l2cap_chan_del(sk, 0);
 	bh_unlock_sock(sk);
@@ -2996,9 +3055,23 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 
 	switch (rx_control & L2CAP_CTRL_SUPERVISE) {
 	case L2CAP_SUPER_RCV_READY:
-		pi->expected_ack_seq = __get_reqseq(rx_control);
-		l2cap_drop_acked_frames(sk);
-		l2cap_ertm_send(sk);
+		if (rx_control & L2CAP_CTRL_POLL) {
+			u16 control = L2CAP_CTRL_FINAL;
+			l2cap_send_sframe(l2cap_pi(sk), control);
+		} else if (rx_control & L2CAP_CTRL_FINAL) {
+			if (pi->conn_state & L2CAP_CONN_WAIT_ACK)
+				break;
+
+			pi->conn_state &= !L2CAP_CONN_WAIT_ACK;
+			del_timer(&pi->monitor_timer);
+
+			if (pi->unacked_frames > 0)
+				__mod_retrans_timer();
+		} else {
+			pi->expected_ack_seq = __get_reqseq(rx_control);
+			l2cap_drop_acked_frames(sk);
+			l2cap_ertm_send(sk);
+		}
 		break;
 
 	case L2CAP_SUPER_REJECT:
-- 
1.6.3.3
