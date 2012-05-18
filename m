Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 18/25] Bluetooth: Use new header structures in l2cap_send_rr_or_rnr
Date: Thu, 17 May 2012 20:53:48 -0700
Message-Id: <1337313235-26535-19-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

struct l2cap_ctrl is now used, and the sframe is now sent directly
rather than depending on a separate call.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6e1200a..0c55403 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -918,15 +918,23 @@ static void l2cap_send_sframe(struct l2cap_chan *chan,
 		l2cap_do_send(chan, skb);
 }
 
-static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u32 control)
+static void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, bool poll)
 {
-	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
-		control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
-		set_bit(CONN_RNR_SENT, &chan->conn_state);
-	} else
-		control |= __set_ctrl_super(chan, L2CAP_SUPER_RR);
+	struct l2cap_ctrl control;
 
-	control |= __set_reqseq(chan, chan->buffer_seq);
+	BT_DBG("chan %p, poll %d", chan, poll);
+
+	memset(&control, 0, sizeof(control));
+	control.sframe = 1;
+	control.poll = poll;
+
+	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state))
+		control.super = L2CAP_SUPER_RNR;
+	else
+		control.super = L2CAP_SUPER_RR;
+
+	control.reqseq = chan->buffer_seq;
+	l2cap_send_sframe(chan, &control);
 }
 
 static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
