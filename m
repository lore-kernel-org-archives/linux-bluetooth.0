Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 2/3] Bluetooth: Treat case when the remote receiver is busy
Date: Wed, 26 Aug 2009 04:04:02 -0300
Message-Id: <1251270243-28832-2-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1251270243-28832-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1251270243-28832-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement all issues related to RemoteBusy in the RECV state table.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/l2cap.c         |   25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7ca614a..9516f4b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -373,6 +373,8 @@ struct l2cap_pinfo {
 #define L2CAP_CONN_WAIT_F          0x04
 #define L2CAP_CONN_SREJ_ACT        0x08
 #define L2CAP_CONN_SEND_PBIT       0x10
+#define L2CAP_CONN_REMOTE_BUSY     0x20
+#define L2CAP_CONN_LOCAL_BUSY      0x40
 
 #define __mod_retrans_timer() mod_timer(&l2cap_pi(sk)->retrans_timer, \
 		jiffies +  msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 0a36c61..40fbf5c 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1350,7 +1350,8 @@ static int l2cap_ertm_send(struct sock *sk)
 	if (pi->conn_state & L2CAP_CONN_WAIT_F)
 		return 0;
 
-	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(sk))) {
+	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(sk))
+			&& !(pi->conn_state & L2CAP_CONN_REMOTE_BUSY)) {
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 
 		if (pi->remote_max_tx &&
@@ -3351,7 +3352,10 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 			control |= L2CAP_SUPER_RCV_READY |
 				(pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT);
 			l2cap_send_sframe(l2cap_pi(sk), control);
+			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+
 		} else if (rx_control & L2CAP_CTRL_FINAL) {
+			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 			pi->expected_ack_seq = tx_seq;
 			l2cap_drop_acked_frames(sk);
 
@@ -3366,13 +3370,19 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 		} else {
 			pi->expected_ack_seq = tx_seq;
 			l2cap_drop_acked_frames(sk);
-			if (pi->unacked_frames > 0)
+
+			if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY)
+					&& (pi->unacked_frames > 0))
 				__mod_retrans_timer();
+
 			l2cap_ertm_send(sk);
+			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 		}
 		break;
 
 	case L2CAP_SUPER_REJECT:
+		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+
 		pi->expected_ack_seq = __get_reqseq(rx_control);
 		l2cap_drop_acked_frames(sk);
 
@@ -3384,6 +3394,8 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 		break;
 
 	case L2CAP_SUPER_SELECT_REJECT:
+		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+
 		if (rx_control & L2CAP_CTRL_POLL) {
 			l2cap_retransmit_frame(sk, tx_seq);
 			pi->expected_ack_seq = tx_seq;
@@ -3410,6 +3422,15 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 		break;
 
 	case L2CAP_SUPER_RCV_NOT_READY:
+		pi->conn_state |= L2CAP_CONN_REMOTE_BUSY;
+		pi->expected_ack_seq = tx_seq;
+		l2cap_drop_acked_frames(sk);
+
+		del_timer(&l2cap_pi(sk)->retrans_timer);
+		if (rx_control & L2CAP_CTRL_POLL) {
+			u16 control = L2CAP_CTRL_FINAL | L2CAP_SUPER_RCV_READY;
+			l2cap_send_sframe(l2cap_pi(sk), control);
+		}
 		break;
 	}
 
-- 
1.6.3.3

