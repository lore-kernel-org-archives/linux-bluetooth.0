Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 17/25] Bluetooth: Handle incoming REJ frames
Date: Thu, 17 May 2012 20:53:47 -0700
Message-Id: <1337313235-26535-18-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

REJ frames are sent by the remote device to request that all frames
after a given sequence number be retransmitted.  These are also an
implicit indication that the remote device is not in a busy state and
can receive new iframes.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cd32aa2..6e1200a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4610,7 +4610,38 @@ static void l2cap_handle_srej(struct l2cap_chan *chan,
 static void l2cap_handle_rej(struct l2cap_chan *chan,
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
+	if (chan->max_tx && skb &&
+	    bt_cb(skb)->control.retries >= chan->max_tx) {
+		BT_DBG("Retry limit exceeded (%d)", chan->max_tx);
+		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		return;
+	}
+
+	clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
+
+	l2cap_pass_to_tx(chan, control);
+
+	if (control->final) {
+		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
+			l2cap_retransmit_all(chan, control);
+	} else {
+		l2cap_retransmit_all(chan, control);
+		l2cap_ertm_send(chan);
+		if (chan->tx_state == L2CAP_TX_STATE_WAIT_F)
+			set_bit(CONN_REJ_ACT, &chan->conn_state);
+	}
 }
 
 static u8 l2cap_classify_txseq(struct l2cap_chan *chan, u16 txseq)
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
