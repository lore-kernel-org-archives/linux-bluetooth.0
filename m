Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 10/25] Bluetooth: Use the transmit state machine for busy state changes
Date: Thu, 17 May 2012 20:53:40 -0700
Message-Id: <1337313235-26535-11-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This lets the transmit state machine handle local busy state changes,
since different actions are taken in the different transmit states.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   47 +++++++-------------------------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9c3f51c..0f130f7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4315,48 +4315,15 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb,
 	return err;
 }
 
-static void l2cap_ertm_enter_local_busy(struct l2cap_chan *chan)
-{
-	BT_DBG("chan %p, Enter local busy", chan);
-
-	set_bit(CONN_LOCAL_BUSY, &chan->conn_state);
-	l2cap_seq_list_clear(&chan->srej_list);
-
-	__set_ack_timer(chan);
-}
-
-static void l2cap_ertm_exit_local_busy(struct l2cap_chan *chan)
-{
-	u32 control;
-
-	if (!test_bit(CONN_RNR_SENT, &chan->conn_state))
-		goto done;
-
-	control = __set_reqseq(chan, chan->buffer_seq);
-	control |= __set_ctrl_poll(chan);
-	control |= __set_ctrl_super(chan, L2CAP_SUPER_RR);
-	chan->retry_count = 1;
-
-	__clear_retrans_timer(chan);
-	__set_monitor_timer(chan);
-
-	set_bit(CONN_WAIT_F, &chan->conn_state);
-
-done:
-	clear_bit(CONN_LOCAL_BUSY, &chan->conn_state);
-	clear_bit(CONN_RNR_SENT, &chan->conn_state);
-
-	BT_DBG("chan %p, Exit local busy", chan);
-}
-
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
 {
-	if (chan->mode == L2CAP_MODE_ERTM) {
-		if (busy)
-			l2cap_ertm_enter_local_busy(chan);
-		else
-			l2cap_ertm_exit_local_busy(chan);
-	}
+	u8 event;
+
+	if (chan->mode != L2CAP_MODE_ERTM)
+		return;
+
+	event = busy ? L2CAP_EV_LOCAL_BUSY_DETECTED : L2CAP_EV_LOCAL_BUSY_CLEAR;
+	l2cap_tx(chan, 0, 0, event);
 }
 
 static u8 l2cap_classify_txseq(struct l2cap_chan *chan, u16 txseq)
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
