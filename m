Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 08/16] Bluetooth: Use chan lock in timers
Date: Fri, 10 Feb 2012 15:55:05 +0200
Message-Id: <1328882113-19810-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change locking in delayed works to use chan locks instead of sk lock.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 632cb2d..c8cac0e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -263,12 +263,14 @@ static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							chan_timer.work);
-	struct sock *sk = chan->sk;
+	struct l2cap_conn *conn = chan->conn;
+
 	int reason;
 
 	BT_DBG("chan %p state %d", chan, chan->state);
 
-	lock_sock(sk);
+	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
@@ -280,7 +282,8 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	l2cap_chan_close(chan, reason);
 
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	l2cap_chan_put(chan);
@@ -1298,40 +1301,39 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							monitor_timer.work);
-	struct sock *sk = chan->sk;
-
 	BT_DBG("chan %p", chan);
 
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
+
 	if (chan->retry_count >= chan->remote_max_tx) {
 		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
-		release_sock(sk);
-		return;
+		goto done;
 	}
 
 	chan->retry_count++;
 	__set_monitor_timer(chan);
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
-	release_sock(sk);
+done:
+	l2cap_chan_unlock(chan);
 }
 
 static void l2cap_retrans_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							retrans_timer.work);
-	struct sock *sk = chan->sk;
-
 	BT_DBG("chan %p", chan);
 
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
+
 	chan->retry_count = 1;
 	__set_monitor_timer(chan);
 
 	set_bit(CONN_WAIT_F, &chan->conn_state);
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
-	release_sock(sk);
+
+	l2cap_chan_unlock(chan);
 }
 
 static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
@@ -2020,9 +2022,11 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p", chan);
 
-	lock_sock(chan->sk);
+	l2cap_chan_lock(chan);
+
 	__l2cap_send_ack(chan);
-	release_sock(chan->sk);
+
+	l2cap_chan_unlock(chan);
 
 	l2cap_chan_put(chan);
 }
-- 
1.7.8.3

