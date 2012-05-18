Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 16/25] Bluetooth: Handle SREJ requests to resend unacked frames
Date: Thu, 17 May 2012 20:53:46 -0700
Message-Id: <1337313235-26535-17-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

When a remote device sends an SREJ, retransmit the frame with the
corresponding sequence number (subject to special cases with poll and
final flags).  An SREJ is also an implicit indication the the remote
device is not in a busy state.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   70 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7091f64..cd32aa2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1833,6 +1833,15 @@ static void l2cap_ertm_resend(struct l2cap_chan *chan)
 	}
 }
 
+static void l2cap_retransmit(struct l2cap_chan *chan,
+			     struct l2cap_ctrl *control)
+{
+	BT_DBG("chan %p, control %p", chan, control);
+
+	l2cap_seq_list_append(&chan->retrans_list, control->reqseq);
+	l2cap_ertm_resend(chan);
+}
+
 static void l2cap_retransmit_all(struct l2cap_chan *chan,
 				 struct l2cap_ctrl *control)
 {
@@ -2529,6 +2538,13 @@ static void l2cap_pass_to_tx(struct l2cap_chan *chan,
 	l2cap_tx(chan, control, 0, L2CAP_EV_RECV_REQSEQ_AND_FBIT);
 }
 
+static void l2cap_pass_to_tx_fbit(struct l2cap_chan *chan,
+				  struct l2cap_ctrl *control)
+{
+	BT_DBG("chan %p, control %p", chan, control);
+	l2cap_tx(chan, control, 0, L2CAP_EV_RECV_FBIT);
+}
+
 /* Copy frame to all raw sockets on that connection */
 static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 {
@@ -4536,7 +4552,59 @@ static int l2cap_rx_queued_iframes(struct l2cap_chan *chan)
 static void l2cap_handle_srej(struct l2cap_chan *chan,
 			      struct l2cap_ctrl *control)
 {
-	/* Placeholder */
+	struct sk_buff *skb;
+
+	BT_DBG("chan %p, control %p", chan, control);
+
+	if (control->reqseq == chan->next_tx_seq) {
+		BT_DBG("Invalid reqseq %d, disconnecting", control->reqseq);
+		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		return;
+	}
+
+	skb = l2cap_ertm_seq_in_queue(&chan->tx_q, control->reqseq);
+
+	if (skb == NULL) {
+		BT_DBG("Seq %d not available for retransmission",
+		       control->reqseq);
+		return;
+	}
+
+	if (chan->max_tx != 0 && bt_cb(skb)->control.retries >= chan->max_tx) {
+		BT_DBG("Retry limit exceeded (%d)", chan->max_tx);
+		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		return;
+	}
+
+	clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
+
+	if (control->poll) {
+		l2cap_pass_to_tx(chan, control);
+
+		set_bit(CONN_SEND_FBIT, &chan->conn_state);
+		l2cap_retransmit(chan, control);
+		l2cap_ertm_send(chan);
+
+		if (chan->tx_state == L2CAP_TX_STATE_WAIT_F) {
+			set_bit(CONN_SREJ_ACT, &chan->conn_state);
+			chan->srej_save_reqseq = control->reqseq;
+		}
+	} else {
+		l2cap_pass_to_tx_fbit(chan, control);
+
+		if (control->final) {
+			if (chan->srej_save_reqseq != control->reqseq ||
+			    !test_and_clear_bit(CONN_SREJ_ACT,
+						&chan->conn_state))
+				l2cap_retransmit(chan, control);
+		} else {
+			l2cap_retransmit(chan, control);
+			if (chan->tx_state == L2CAP_TX_STATE_WAIT_F) {
+				set_bit(CONN_SREJ_ACT, &chan->conn_state);
+				chan->srej_save_reqseq = control->reqseq;
+			}
+		}
+	}
 }
 
 static void l2cap_handle_rej(struct l2cap_chan *chan,
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
