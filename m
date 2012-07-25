Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 16/21] Bluetooth: Do not send data during channel move
Date: Wed, 25 Jul 2012 16:51:08 -0700
Message-Id: <1343260274-11953-17-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 113ea8e..17b5bee 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -919,6 +919,10 @@ static void l2cap_send_sframe(struct l2cap_chan *chan,
 	if (!control->sframe)
 		return;
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return;
+
 	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state) &&
 	    !control->poll)
 		control->final = 1;
@@ -1757,6 +1761,10 @@ static void l2cap_streaming_send(struct l2cap_chan *chan,
 
 	BT_DBG("chan %p, skbs %p", chan, skbs);
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return;
+
 	skb_queue_splice_tail_init(skbs, &chan->tx_q);
 
 	while (!skb_queue_empty(&chan->tx_q)) {
@@ -1799,6 +1807,10 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 	if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state))
 		return 0;
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return 0;
+
 	while (chan->tx_send_head &&
 	       chan->unacked_frames < chan->remote_tx_win &&
 	       chan->tx_state == L2CAP_TX_STATE_XMIT) {
@@ -1864,6 +1876,10 @@ static void l2cap_ertm_resend(struct l2cap_chan *chan)
 	if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state))
 		return;
 
+	if (chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE)
+		return;
+
 	while (chan->retrans_list.head != L2CAP_SEQ_LIST_CLEAR) {
 		seq = l2cap_seq_list_pop(&chan->retrans_list);
 
-- 
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
