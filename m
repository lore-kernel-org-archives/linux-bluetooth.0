Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 20/25] Bluetooth: Use the ERTM transmit state machine from timeout handlers
Date: Thu, 17 May 2012 20:53:50 -0700
Message-Id: <1337313235-26535-21-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Different states have different actions for retransmit and monitor
timeouts, so remove the logic for those actions from the timer handlers.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7bacb01..7f3d7cb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1640,17 +1640,14 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	if (chan->retry_count >= chan->remote_max_tx) {
-		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
+	if (!chan->conn) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
 	}
 
-	chan->retry_count++;
-	__set_monitor_timer(chan);
+	l2cap_tx(chan, 0, 0, L2CAP_EV_MONITOR_TO);
 
-	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 }
@@ -1664,13 +1661,13 @@ static void l2cap_retrans_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	chan->retry_count = 1;
-	__set_monitor_timer(chan);
-
-	set_bit(CONN_WAIT_F, &chan->conn_state);
-
-	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
+	if (!chan->conn) {
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+		return;
+	}
 
+	l2cap_tx(chan, 0, 0, L2CAP_EV_RETRANS_TO);
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 }
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
