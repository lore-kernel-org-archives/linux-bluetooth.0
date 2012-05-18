Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 21/25] Bluetooth: Simplify the ERTM ack timeout
Date: Thu, 17 May 2012 20:53:51 -0700
Message-Id: <1337313235-26535-22-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Since l2cap_send_ack can trigger extra actions like sending iframes,
don't call it.  Just send an RR or RNR frame if an ack needs sending.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7f3d7cb..afb7afc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2758,16 +2758,20 @@ static void l2cap_add_opt_efs(void **ptr, struct l2cap_chan *chan)
 static void l2cap_ack_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
-							ack_timer.work);
+					       ack_timer.work);
+	u16 frames_to_ack;
 
 	BT_DBG("chan %p", chan);
 
 	l2cap_chan_lock(chan);
 
-	l2cap_send_ack(chan);
+	frames_to_ack = __seq_offset(chan, chan->buffer_seq,
+				     chan->last_acked_seq);
+
+	if (frames_to_ack)
+		l2cap_send_rr_or_rnr(chan, 0);
 
 	l2cap_chan_unlock(chan);
-
 	l2cap_chan_put(chan);
 }
 
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
