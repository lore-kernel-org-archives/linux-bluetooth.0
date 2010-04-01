Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 01/34] Bluetooth: Implement 'Send IorRRorRNR' event
Date: Thu,  1 Apr 2010 17:23:19 -0300
Message-Id: <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

After receive a RR with P bit set ERTM shall use this funcion to choose
what type of frame to reply with F bit = 1.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   20 ++++++++++--------
 net/bluetooth/l2cap.c         |   44 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 17a689f..d9c20c3 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -320,7 +320,7 @@ struct l2cap_pinfo {
 	__u8		conf_req[64];
 	__u8		conf_len;
 	__u8		conf_state;
-	__u8		conn_state;
+	__u16		conn_state;
 
 	__u8		next_tx_seq;
 	__u8		expected_ack_seq;
@@ -328,6 +328,7 @@ struct l2cap_pinfo {
 	__u8		buffer_seq;
 	__u8		buffer_seq_srej;
 	__u8		srej_save_reqseq;
+	__u8		frames_sent;
 	__u8		unacked_frames;
 	__u8		retry_count;
 	__u8		num_to_ack;
@@ -367,14 +368,15 @@ struct l2cap_pinfo {
 #define L2CAP_CONF_MAX_CONF_REQ 2
 #define L2CAP_CONF_MAX_CONF_RSP 2
 
-#define L2CAP_CONN_SAR_SDU         0x01
-#define L2CAP_CONN_SREJ_SENT       0x02
-#define L2CAP_CONN_WAIT_F          0x04
-#define L2CAP_CONN_SREJ_ACT        0x08
-#define L2CAP_CONN_SEND_PBIT       0x10
-#define L2CAP_CONN_REMOTE_BUSY     0x20
-#define L2CAP_CONN_LOCAL_BUSY      0x40
-#define L2CAP_CONN_REJ_ACT         0x80
+#define L2CAP_CONN_SAR_SDU         0x0001
+#define L2CAP_CONN_SREJ_SENT       0x0002
+#define L2CAP_CONN_WAIT_F          0x0004
+#define L2CAP_CONN_SREJ_ACT        0x0008
+#define L2CAP_CONN_SEND_PBIT       0x0010
+#define L2CAP_CONN_REMOTE_BUSY     0x0020
+#define L2CAP_CONN_LOCAL_BUSY      0x0040
+#define L2CAP_CONN_REJ_ACT         0x0080
+#define L2CAP_CONN_SEND_FBIT       0x0100
 
 #define __mod_retrans_timer() mod_timer(&l2cap_pi(sk)->retrans_timer, \
 		jiffies +  msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 7794a2e..18328a4 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1382,6 +1382,10 @@ static int l2cap_ertm_send(struct sock *sk)
 		bt_cb(skb)->retries++;
 
 		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
+		if (pi->conn_state & L2CAP_CONN_SEND_FBIT) {
+			control |= L2CAP_CTRL_FINAL;
+			pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
+		}
 		control |= (pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
 				| (pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
@@ -1403,6 +1407,7 @@ static int l2cap_ertm_send(struct sock *sk)
 		pi->next_tx_seq = (pi->next_tx_seq + 1) % 64;
 
 		pi->unacked_frames++;
+		pi->frames_sent++;
 
 		if (skb_queue_is_last(TX_QUEUE(sk), skb))
 			sk->sk_send_head = NULL;
@@ -2186,6 +2191,7 @@ static inline void l2cap_ertm_init(struct sock *sk)
 	l2cap_pi(sk)->unacked_frames = 0;
 	l2cap_pi(sk)->buffer_seq = 0;
 	l2cap_pi(sk)->num_to_ack = 0;
+	l2cap_pi(sk)->frames_sent = 0;
 
 	setup_timer(&l2cap_pi(sk)->retrans_timer,
 			l2cap_retrans_timeout, (unsigned long) sk);
@@ -3139,6 +3145,39 @@ static int l2cap_check_fcs(struct l2cap_pinfo *pi,  struct sk_buff *skb)
 	return 0;
 }
 
+static inline void l2cap_send_i_or_rr_or_rnr(struct sock *sk)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u16 control = 0;
+
+	pi->frames_sent = 0;
+	pi->conn_state |= L2CAP_CONN_SEND_FBIT;
+
+	control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+
+	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
+		control |= L2CAP_SUPER_RCV_NOT_READY | L2CAP_CTRL_FINAL;
+		l2cap_send_sframe(pi, control);
+		pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
+
+	}
+
+	if (pi->conn_state & L2CAP_CONN_REMOTE_BUSY && pi->unacked_frames > 0)
+		__mod_retrans_timer();
+
+	l2cap_ertm_send(sk);
+
+	if (!(pi->conn_state & L2CAP_CONN_LOCAL_BUSY) &&
+			pi->frames_sent == 0) {
+		control |= L2CAP_SUPER_RCV_READY;
+		if (pi->conn_state & L2CAP_CONN_SEND_FBIT) {
+			control |= L2CAP_CTRL_FINAL;
+			pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
+		}
+		l2cap_send_sframe(pi, control);
+	}
+}
+
 static void l2cap_add_to_srej_queue(struct sock *sk, struct sk_buff *skb, u8 tx_seq, u8 sar)
 {
 	struct sk_buff *next_skb;
@@ -3409,10 +3448,7 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 	switch (rx_control & L2CAP_CTRL_SUPERVISE) {
 	case L2CAP_SUPER_RCV_READY:
 		if (rx_control & L2CAP_CTRL_POLL) {
-			u16 control = L2CAP_CTRL_FINAL;
-			control |= L2CAP_SUPER_RCV_READY |
-				(pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT);
-			l2cap_send_sframe(l2cap_pi(sk), control);
+			l2cap_send_i_or_rr_or_rnr(sk);
 			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
 		} else if (rx_control & L2CAP_CTRL_FINAL) {
-- 
1.6.4.4
