Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 07/19] Bluetooth: Implement SendAck() Action on ERTM.
Date: Tue, 23 Mar 2010 16:48:34 -0300
Message-Id: <1269373726-13209-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-7-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-1-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-2-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-3-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-4-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-5-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-6-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-7-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Shall be used to ack received frames, It must decide type of
acknowledgment between a RR frame, a RNR frame or transmission of
pending I-frames.
It also modifies l2cap_ertm_send() to report the number of frames sent.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   41 +++++++++++++++++++++++++++++------------
 1 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 03caa2c..6368cb2 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -352,6 +352,11 @@ static inline int l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 	count = min_t(unsigned int, conn->mtu, hlen);
 	control |= L2CAP_CTRL_FRAME_TYPE;
 
+	if (pi->conn_state & L2CAP_CONN_SEND_FBIT) {
+		control |= L2CAP_CTRL_FINAL;
+		pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
+	}
+
 	skb = bt_skb_alloc(count, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
@@ -1363,7 +1368,7 @@ static int l2cap_ertm_send(struct sock *sk)
 	struct sk_buff *skb, *tx_skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u16 control, fcs;
-	int err;
+	int err, nsent = 0;
 
 	if (pi->conn_state & L2CAP_CONN_WAIT_F)
 		return 0;
@@ -1413,8 +1418,27 @@ static int l2cap_ertm_send(struct sock *sk)
 			sk->sk_send_head = NULL;
 		else
 			sk->sk_send_head = skb_queue_next(TX_QUEUE(sk), skb);
+
+		nsent++;
 	}
 
+	return nsent;
+}
+
+static int l2cap_send_ack(struct l2cap_pinfo *pi)
+{
+	struct sock *sk = (struct sock *)pi;
+	u16 control = 0;
+
+	control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+
+	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
+		control |= L2CAP_SUPER_RCV_NOT_READY;
+		return l2cap_send_sframe(pi, control);
+	} else if (l2cap_ertm_send(sk) == 0) {
+		control |= L2CAP_SUPER_RCV_READY;
+		return l2cap_send_sframe(pi, control);
+	}
 	return 0;
 }
 
@@ -1673,7 +1697,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		else
 			err = l2cap_ertm_send(sk);
 
-		if (!err)
+		if (err >= 0)
 			err = len;
 		break;
 
@@ -3170,10 +3194,6 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct sock *sk)
 	if (!(pi->conn_state & L2CAP_CONN_LOCAL_BUSY) &&
 			pi->frames_sent == 0) {
 		control |= L2CAP_SUPER_RCV_READY;
-		if (pi->conn_state & L2CAP_CONN_SEND_FBIT) {
-			control |= L2CAP_CTRL_FINAL;
-			pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
-		}
 		l2cap_send_sframe(pi, control);
 	}
 }
@@ -3354,7 +3374,6 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u8 tx_seq = __get_txseq(rx_control);
 	u8 req_seq = __get_reqseq(rx_control);
-	u16 tx_control = 0;
 	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
 	int err = 0;
 
@@ -3441,11 +3460,9 @@ expected:
 		return err;
 
 	pi->num_to_ack = (pi->num_to_ack + 1) % L2CAP_DEFAULT_NUM_TO_ACK;
-	if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1) {
-		tx_control |= L2CAP_SUPER_RCV_READY;
-		tx_control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-		l2cap_send_sframe(pi, tx_control);
-	}
+	if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1)
+		l2cap_send_ack(pi);
+
 	return 0;
 }
 
-- 
1.6.4.4
