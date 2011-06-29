Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 4/6] Bluetooth: Move code for ERTM local busy state to separate functions
Date: Wed, 29 Jun 2011 14:35:22 -0700
Message-Id: <1309383324-12002-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
References: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The local busy state is entered and exited based on buffer status in
the socket layer (or other upper layer).  This change is in
preparation for general buffer status reports from the socket layer,
which will then be used to change the local busy status.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   62 +++++++++++++++++++++++++++-----------------
 1 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index da6f532..4b764b1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3227,22 +3227,26 @@ disconnect:
 	return 0;
 }
 
-static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
+static void l2cap_ertm_enter_local_busy(struct l2cap_chan *chan)
 {
-	struct sk_buff *skb;
 	u16 control;
-	int err;
 
-	while ((skb = skb_dequeue(&chan->busy_q))) {
-		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
-		err = l2cap_ertm_reassembly_sdu(chan, skb, control);
-		if (err < 0) {
-			skb_queue_head(&chan->busy_q, skb);
-			return -EBUSY;
-		}
+	BT_DBG("chan %p, Enter local busy", chan);
 
-		chan->buffer_seq = (chan->buffer_seq + 1) % 64;
-	}
+	set_bit(CONN_LOCAL_BUSY, &chan->conn_state);
+
+	control = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= L2CAP_SUPER_RCV_NOT_READY;
+	l2cap_send_sframe(chan, control);
+
+	set_bit(CONN_RNR_SENT, &chan->conn_state);
+
+	__clear_ack_timer(chan);
+}
+
+static void l2cap_ertm_exit_local_busy(struct l2cap_chan *chan)
+{
+	u16 control;
 
 	if (!test_bit(CONN_RNR_SENT, &chan->conn_state))
 		goto done;
@@ -3262,6 +3266,26 @@ done:
 	clear_bit(CONN_RNR_SENT, &chan->conn_state);
 
 	BT_DBG("chan %p, Exit local busy", chan);
+}
+
+static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
+{
+	struct sk_buff *skb;
+	u16 control;
+	int err;
+
+	while ((skb = skb_dequeue(&chan->busy_q))) {
+		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
+		err = l2cap_ertm_reassembly_sdu(chan, skb, control);
+		if (err < 0) {
+			skb_queue_head(&chan->busy_q, skb);
+			return -EBUSY;
+		}
+
+		chan->buffer_seq = (chan->buffer_seq + 1) % 64;
+	}
+
+	l2cap_ertm_exit_local_busy(chan);
 
 	return 0;
 }
@@ -3315,7 +3339,7 @@ static void l2cap_busy_work(struct work_struct *work)
 
 static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
 {
-	int sctrl, err;
+	int err;
 
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
 		bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
@@ -3331,21 +3355,11 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 		return err;
 	}
 
-	/* Busy Condition */
-	BT_DBG("chan %p, Enter local busy", chan);
+	l2cap_ertm_enter_local_busy(chan);
 
-	set_bit(CONN_LOCAL_BUSY, &chan->conn_state);
 	bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
 	__skb_queue_tail(&chan->busy_q, skb);
 
-	sctrl = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-	sctrl |= L2CAP_SUPER_RCV_NOT_READY;
-	l2cap_send_sframe(chan, sctrl);
-
-	set_bit(CONN_RNR_SENT, &chan->conn_state);
-
-	__clear_ack_timer(chan);
-
 	queue_work(_busy_wq, &chan->busy_work);
 
 	return err;
-- 
1.7.5.4

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

