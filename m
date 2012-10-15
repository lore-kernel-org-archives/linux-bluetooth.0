Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org
Subject: [PATCH 14/19] Bluetooth: Do not send data during channel move
Date: Mon, 15 Oct 2012 08:34:03 -0700
Message-Id: <1350315248-7690-15-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Outgoing ERTM data is queued during a channel move.  The ERTM state
machine is partially reset at the start of a move, and must be
resynchronized with the remote state machine at the end of the move.
Data is not sent so that there are no state transitions between the
partial reset and the resync.

Streaming mode frames are dropped during a move.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d7b1bf3..cf1dc4e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -927,6 +927,10 @@ static void l2cap_send_sframe(struct l2cap_chan *chan,
 	if (!control->sframe)
 		return;
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return;
+
 	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state) &&
 	    !control->poll)
 		control->final = 1;
@@ -1805,6 +1809,10 @@ static void l2cap_streaming_send(struct l2cap_chan *chan,
 
 	BT_DBG("chan %p, skbs %p", chan, skbs);
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return;
+
 	skb_queue_splice_tail_init(skbs, &chan->tx_q);
 
 	while (!skb_queue_empty(&chan->tx_q)) {
@@ -1847,6 +1855,10 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 	if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state))
 		return 0;
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return 0;
+
 	while (chan->tx_send_head &&
 	       chan->unacked_frames < chan->remote_tx_win &&
 	       chan->tx_state == L2CAP_TX_STATE_XMIT) {
@@ -1912,6 +1924,10 @@ static void l2cap_ertm_resend(struct l2cap_chan *chan)
 	if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state))
 		return;
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return;
+
 	while (chan->retrans_list.head != L2CAP_SEQ_LIST_CLEAR) {
 		seq = l2cap_seq_list_pop(&chan->retrans_list);
 
-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
