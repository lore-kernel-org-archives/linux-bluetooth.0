Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 3/8] Bluetooth: Initial support for retransmission of packets with REJ frames
Date: Mon, 17 Aug 2009 23:53:45 -0300
Message-Id: <1250564030-13684-3-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1250564030-13684-2-git-send-email-gustavo@las.ic.unicamp.br>
References: <1250564030-13684-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1250564030-13684-2-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When receiving an I-frame with unexpected txSeq, receiver side start the
recovery procedure by sending a REJ S-frame to the transmitter side. So
the transmitter can re-send the lost I-frame.
This patch just adds a basic support for retransmission, it doesn't
mean that ERTM now has full support to packet retransmission.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap.c         |   57 +++++++++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0afde8d..a1d8ec4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -351,6 +351,7 @@ struct l2cap_pinfo {
 #define L2CAP_CONF_MAX_CONF_RSP 2
 
 #define L2CAP_CONN_SAR_SDU         0x01
+#define L2CAP_CONN_UNDER_REJ       0x02
 
 static inline int l2cap_tx_window_full(struct sock *sk)
 {
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 167e025..35e9f5b 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2951,22 +2951,36 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 
 	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
 
-	if (tx_seq != pi->expected_tx_seq)
-		return -EINVAL;
+	if (tx_seq == pi->expected_tx_seq) {
+		if (pi->conn_state & L2CAP_CONN_UNDER_REJ)
+			pi->conn_state &= ~L2CAP_CONN_UNDER_REJ;
 
-	err = l2cap_sar_reassembly_sdu(sk, skb, rx_control);
-	if (err < 0)
-		return err;
+		err = l2cap_sar_reassembly_sdu(sk, skb, rx_control);
+		if (err < 0)
+			return err;
+
+		pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
+		pi->num_to_ack = (pi->num_to_ack + 1) % L2CAP_DEFAULT_NUM_TO_ACK;
+		if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1) {
+			tx_control |= L2CAP_SUPER_RCV_READY;
+			tx_control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+			goto send;
+		}
+	} else {
+		/* Unexpected txSeq. Send a REJ S-frame */
+		kfree_skb(skb);
+		if (!(pi->conn_state & L2CAP_CONN_UNDER_REJ)) {
+			tx_control |= L2CAP_SUPER_REJECT;
+			tx_control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+			pi->conn_state |= L2CAP_CONN_UNDER_REJ;
 
-	pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
-	pi->num_to_ack = (pi->num_to_ack + 1) % L2CAP_DEFAULT_NUM_TO_ACK;
-	if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1) {
-		tx_control |= L2CAP_CTRL_FRAME_TYPE;
-		tx_control |= L2CAP_SUPER_RCV_READY;
-		tx_control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-		err = l2cap_send_sframe(pi, tx_control);
+			goto send;
+		}
 	}
-	return err;
+	return 0;
+
+send:
+	return l2cap_send_sframe(pi, tx_control);
 }
 
 static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
@@ -2982,8 +2996,18 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 		l2cap_ertm_send(sk);
 		break;
 
-	case L2CAP_SUPER_RCV_NOT_READY:
 	case L2CAP_SUPER_REJECT:
+		pi->expected_ack_seq = __get_reqseq(rx_control);
+		l2cap_drop_acked_frames(sk);
+
+		sk->sk_send_head = TX_QUEUE(sk)->next;
+		pi->next_tx_seq = pi->expected_ack_seq;
+
+		l2cap_ertm_send(sk);
+
+		break;
+
+	case L2CAP_SUPER_RCV_NOT_READY:
 	case L2CAP_SUPER_SELECT_REJECT:
 		break;
 	}
@@ -3030,6 +3054,11 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (__is_sar_start(control))
 			len -= 2;
 
+		/*
+		 * We can just drop the corrupted I-frame here.
+		 * Receiver will miss it and start proper recovery
+		 * procedures and ask retransmission.
+		 */
 		if (len > L2CAP_DEFAULT_MAX_PDU_SIZE)
 			goto drop;
 
-- 
1.6.3.3

