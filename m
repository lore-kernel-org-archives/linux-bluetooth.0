Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv6 07/14] Bluetooth: Use chan lock in timers
Date: Mon, 20 Feb 2012 16:21:18 +0200
Message-Id: <1329747685-4163-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change locking in delayed works to chan lock instead of sk lock.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index db1640c..727a1dd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -238,13 +238,12 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							chan_timer.work);
 	struct l2cap_conn *conn = chan->conn;
-	struct sock *sk = chan->sk;
 	int reason;
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
 	mutex_lock(&conn->chan_lock);
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
 
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
@@ -256,7 +255,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	l2cap_chan_close(chan, reason);
 
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 
 	chan->ops->close(chan->data);
 	mutex_unlock(&conn->chan_lock);
@@ -1277,14 +1276,14 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							monitor_timer.work);
-	struct sock *sk = chan->sk;
 
 	BT_DBG("chan %p", chan);
 
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
+
 	if (chan->retry_count >= chan->remote_max_tx) {
 		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
-		release_sock(sk);
+		l2cap_chan_unlock(chan);
 		return;
 	}
 
@@ -1292,25 +1291,26 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 	__set_monitor_timer(chan);
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 }
 
 static void l2cap_retrans_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							retrans_timer.work);
-	struct sock *sk = chan->sk;
 
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
@@ -2001,9 +2001,11 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
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
1.7.9

