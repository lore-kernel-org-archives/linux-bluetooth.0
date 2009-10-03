Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 4/5] Bluetooth: Implement RejActioned flag
Date: Sat,  3 Oct 2009 02:34:39 -0300
Message-Id: <1254548080-13478-4-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1254548080-13478-3-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254548080-13478-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1254548080-13478-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1254548080-13478-3-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

RejActioned is used to prevent retransmission when a entity is on the
WAIT_F state, i.e., waiting for a frame with F-bit set due local busy
condition or a expired retransmission timer. (When these two events raise
they send a frame with the Poll bit set and enters in the WAIT_F state to
wait for a frame with the Final bit set.)
The local entity doesn't send I-frames(the data frames) until the receipt
of a frame with F-bit set. When that happens it also set RejActioned to false.
RejActioned is a mandatory feature of ERTM spec.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap.c         |   38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 327eb57..17a689f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -374,6 +374,7 @@ struct l2cap_pinfo {
 #define L2CAP_CONN_SEND_PBIT       0x10
 #define L2CAP_CONN_REMOTE_BUSY     0x20
 #define L2CAP_CONN_LOCAL_BUSY      0x40
+#define L2CAP_CONN_REJ_ACT         0x80
 
 #define __mod_retrans_timer() mod_timer(&l2cap_pi(sk)->retrans_timer, \
 		jiffies +  msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9d6f3cf..0c4fdea 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3353,6 +3353,16 @@ expected:
 		return 0;
 	}
 
+	if (rx_control & L2CAP_CTRL_FINAL) {
+		if (pi->conn_state & L2CAP_CONN_REJ_ACT)
+			pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
+		else {
+			sk->sk_send_head = TX_QUEUE(sk)->next;
+			pi->next_tx_seq = pi->expected_ack_seq;
+			l2cap_ertm_send(sk);
+		}
+	}
+
 	pi->buffer_seq = (pi->buffer_seq + 1) % 64;
 
 	err = l2cap_sar_reassembly_sdu(sk, skb, rx_control);
@@ -3389,6 +3399,14 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 			pi->expected_ack_seq = tx_seq;
 			l2cap_drop_acked_frames(sk);
 
+			if (pi->conn_state & L2CAP_CONN_REJ_ACT)
+				pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
+			else {
+				sk->sk_send_head = TX_QUEUE(sk)->next;
+				pi->next_tx_seq = pi->expected_ack_seq;
+				l2cap_ertm_send(sk);
+			}
+
 			if (!(pi->conn_state & L2CAP_CONN_WAIT_F))
 				break;
 
@@ -3416,10 +3434,24 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 		pi->expected_ack_seq = __get_reqseq(rx_control);
 		l2cap_drop_acked_frames(sk);
 
-		sk->sk_send_head = TX_QUEUE(sk)->next;
-		pi->next_tx_seq = pi->expected_ack_seq;
+		if (rx_control & L2CAP_CTRL_FINAL) {
+			if (pi->conn_state & L2CAP_CONN_REJ_ACT)
+				pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
+			else {
+				sk->sk_send_head = TX_QUEUE(sk)->next;
+				pi->next_tx_seq = pi->expected_ack_seq;
+				l2cap_ertm_send(sk);
+			}
+		} else {
+			sk->sk_send_head = TX_QUEUE(sk)->next;
+			pi->next_tx_seq = pi->expected_ack_seq;
+			l2cap_ertm_send(sk);
 
-		l2cap_ertm_send(sk);
+			if (pi->conn_state & L2CAP_CONN_WAIT_F) {
+				pi->srej_save_reqseq = tx_seq;
+				pi->conn_state |= L2CAP_CONN_REJ_ACT;
+			}
+		}
 
 		break;
 
-- 
1.6.4.4

