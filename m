Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 8/8] Bluetooth: Full support to receive SREJ frames
Date: Thu, 20 Aug 2009 22:26:04 -0300
Message-Id: <1250817964-11533-8-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1250817964-11533-7-git-send-email-gustavo@las.ic.unicamp.br>
References: <1250817964-11533-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1250817964-11533-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1250817964-11533-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1250817964-11533-4-git-send-email-gustavo@las.ic.unicamp.br>
 <1250817964-11533-5-git-send-email-gustavo@las.ic.unicamp.br>
 <1250817964-11533-6-git-send-email-gustavo@las.ic.unicamp.br>
 <1250817964-11533-7-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support receive of SREJ frames as specified by the state table.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |    3 +++
 net/bluetooth/l2cap.c         |   30 +++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9f2126a..7ca614a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -328,6 +328,7 @@ struct l2cap_pinfo {
 	__u8		expected_tx_seq;
 	__u8		buffer_seq;
 	__u8		buffer_seq_srej;
+	__u8		srej_save_reqseq;
 	__u8		unacked_frames;
 	__u8		retry_count;
 	__u8		num_to_ack;
@@ -370,6 +371,8 @@ struct l2cap_pinfo {
 #define L2CAP_CONN_SAR_SDU         0x01
 #define L2CAP_CONN_SREJ_SENT       0x02
 #define L2CAP_CONN_WAIT_F          0x04
+#define L2CAP_CONN_SREJ_ACT        0x08
+#define L2CAP_CONN_SEND_PBIT       0x10
 
 #define __mod_retrans_timer() mod_timer(&l2cap_pi(sk)->retrans_timer, \
 		jiffies +  msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index fbe71ec..505c12f 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3241,6 +3241,10 @@ static void l2cap_send_srejframe(struct sock *sk, u8 tx_seq)
 	while (tx_seq != pi->expected_tx_seq) {
 		control = L2CAP_SUPER_SELECT_REJECT;
 		control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+		if (pi->conn_state & L2CAP_CONN_SEND_PBIT) {
+			control |= L2CAP_CTRL_POLL;
+			pi->conn_state &= ~L2CAP_CONN_SEND_PBIT;
+		}
 		l2cap_send_sframe(pi, control);
 
 		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
@@ -3300,6 +3304,8 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 		__skb_queue_head_init(SREJ_QUEUE(sk));
 		l2cap_add_to_srej_queue(sk, skb, tx_seq, sar);
 
+		pi->conn_state |= L2CAP_CONN_SEND_PBIT;
+
 		l2cap_send_srejframe(sk, tx_seq);
 	}
 	return 0;
@@ -3370,7 +3376,29 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 		break;
 
 	case L2CAP_SUPER_SELECT_REJECT:
-		l2cap_retransmit_frame(sk, tx_seq);
+		if (rx_control & L2CAP_CTRL_POLL) {
+			l2cap_retransmit_frame(sk, tx_seq);
+			pi->expected_ack_seq = tx_seq;
+			l2cap_drop_acked_frames(sk);
+			l2cap_ertm_send(sk);
+			if (pi->conn_state & L2CAP_CONN_WAIT_F) {
+				pi->srej_save_reqseq = tx_seq;
+				pi->conn_state |= L2CAP_CONN_SREJ_ACT;
+			}
+		} else if (rx_control & L2CAP_CTRL_FINAL) {
+			if ((pi->conn_state & L2CAP_CONN_SREJ_ACT) &&
+					pi->srej_save_reqseq == tx_seq)
+				pi->srej_save_reqseq &= ~L2CAP_CONN_SREJ_ACT;
+			else
+				l2cap_retransmit_frame(sk, tx_seq);
+		}
+		else {
+			l2cap_retransmit_frame(sk, tx_seq);
+			if (pi->conn_state & L2CAP_CONN_WAIT_F) {
+				pi->srej_save_reqseq = tx_seq;
+				pi->conn_state |= L2CAP_CONN_SREJ_ACT;
+			}
+		}
 		break;
 
 	case L2CAP_SUPER_RCV_NOT_READY:
-- 
1.6.3.3

