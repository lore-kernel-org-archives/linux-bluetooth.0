Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org
Subject: [RFCv1 15/20] Bluetooth: Do not send data during channel move
Date: Tue, 11 Sep 2012 11:21:26 -0700
Message-Id: <1347387691-5285-16-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
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
index 4a5c42b..0a7df20 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -921,6 +921,10 @@ static void l2cap_send_sframe(struct l2cap_chan *chan,
 	if (!control->sframe)
 		return;
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return;
+
 	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state) &&
 	    !control->poll)
 		control->final = 1;
@@ -1765,6 +1769,10 @@ static void l2cap_streaming_send(struct l2cap_chan *chan,
 
 	BT_DBG("chan %p, skbs %p", chan, skbs);
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return;
+
 	skb_queue_splice_tail_init(skbs, &chan->tx_q);
 
 	while (!skb_queue_empty(&chan->tx_q)) {
@@ -1807,6 +1815,10 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 	if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state))
 		return 0;
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return 0;
+
 	while (chan->tx_send_head &&
 	       chan->unacked_frames < chan->remote_tx_win &&
 	       chan->tx_state == L2CAP_TX_STATE_XMIT) {
@@ -1872,6 +1884,10 @@ static void l2cap_ertm_resend(struct l2cap_chan *chan)
 	if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state))
 		return;
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return;
+
 	while (chan->retrans_list.head != L2CAP_SEQ_LIST_CLEAR) {
 		seq = l2cap_seq_list_pop(&chan->retrans_list);
 
-- 
1.7.12

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
