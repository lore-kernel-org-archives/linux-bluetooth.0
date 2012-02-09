Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 08/16] Bluetooth: Use chan lock in timers
Date: Thu,  9 Feb 2012 16:17:29 +0200
Message-Id: <1328797057-26331-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change locking in delayed works to use chan locks instead of sk lock.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 21f9f5d..bcc1c1c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -263,13 +263,12 @@ static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							chan_timer.work);
-	struct sock *sk = chan->sk;
 	int reason;
 
 	BT_DBG("chan %p state %d", chan, chan->state);
 
 	mutex_lock(&chan->conn->chan_lock);
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
 
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
@@ -281,7 +280,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	l2cap_chan_close(chan, reason);
 
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	mutex_unlock(&chan->conn->chan_lock);
 
 	chan->ops->close(chan->data);
@@ -1300,40 +1299,39 @@ static void l2cap_monitor_timeout(struct work_struct *work)
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
@@ -2022,9 +2020,11 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
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

