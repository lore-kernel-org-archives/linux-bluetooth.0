Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 14/25] Bluetooth: Send SREJ frames when packets go missing
Date: Thu, 17 May 2012 20:53:44 -0700
Message-Id: <1337313235-26535-15-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The ERTM specification lays out three scenarios for sending SREJ
frames to request retransmission of specific frames.  l2cap_send_srej
requests all frames up to a given txseq that are not already queued
for reassembly.  l2cap_send_srej_tail only requests the most recent
missing frame.  l2cap_send_srej_list resends SREJ frames for data that
was requested for resend but never received.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   56 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 090d489..4efab1b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2236,17 +2236,67 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 
 static void l2cap_send_srej(struct l2cap_chan *chan, u16 txseq)
 {
-	/* Placeholder */
+	struct l2cap_ctrl control;
+	u16 seq;
+
+	BT_DBG("chan %p, txseq %d", chan, txseq);
+
+	memset(&control, 0, sizeof(control));
+	control.sframe = 1;
+	control.super = L2CAP_SUPER_SREJ;
+
+	for (seq = chan->expected_tx_seq; seq != txseq;
+	     seq = __next_seq(chan, seq)) {
+		if (!l2cap_ertm_seq_in_queue(&chan->srej_q, seq)) {
+			control.reqseq = seq;
+			l2cap_send_sframe(chan, &control);
+			l2cap_seq_list_append(&chan->srej_list, seq);
+		}
+	}
+
+	chan->expected_tx_seq = __next_seq(chan, txseq);
 }
 
 static void l2cap_send_srej_tail(struct l2cap_chan *chan)
 {
-	/* Placeholder */
+	struct l2cap_ctrl control;
+
+	BT_DBG("chan %p", chan);
+
+	if (chan->srej_list.tail == L2CAP_SEQ_LIST_CLEAR)
+		return;
+
+	memset(&control, 0, sizeof(control));
+	control.sframe = 1;
+	control.super = L2CAP_SUPER_SREJ;
+	control.reqseq = chan->srej_list.tail;
+	l2cap_send_sframe(chan, &control);
 }
 
 static void l2cap_send_srej_list(struct l2cap_chan *chan, u16 txseq)
 {
-	/* Placeholder */
+	struct l2cap_ctrl control;
+	u16 initial_head;
+	u16 seq;
+
+	BT_DBG("chan %p, txseq %d", chan, txseq);
+
+	memset(&control, 0, sizeof(control));
+	control.sframe = 1;
+	control.super = L2CAP_SUPER_SREJ;
+
+	/* Capture initial list head to allow only one pass through the list. */
+	initial_head = chan->srej_list.head;
+
+	do {
+		seq = l2cap_seq_list_pop(&chan->srej_list);
+		if (seq == txseq || seq == L2CAP_SEQ_LIST_CLEAR)
+			break;
+
+		control.reqseq = seq;
+		l2cap_send_sframe(chan, &control);
+		l2cap_seq_list_append(&chan->srej_list, seq);
+	} while (chan->srej_list.head != initial_head);
 }
 
 static void l2cap_process_reqseq(struct l2cap_chan *chan, u16 reqseq)
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
