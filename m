Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Fix deadlock when closing socket
Date: Mon, 27 Aug 2012 17:52:53 +0300
Message-Id: <1346079173-3284-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

If we have unacked frames when closing bluetooth socket we deadlock
since conn->chan_lock and chan->lock are taken.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bd13fb7..52baf1b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1692,10 +1692,14 @@ int __l2cap_wait_ack(struct sock *sk)
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
 	int timeo = HZ/5;
+	int tries = 5;
+
+	BT_DBG("chan %p conn %p unacked %d", chan, chan->conn,
+	       chan->unacked_frames);
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
-	while (chan->unacked_frames > 0 && chan->conn) {
+	while (chan->unacked_frames > 0 && chan->conn && tries--) {
 		if (!timeo)
 			timeo = HZ/5;
 
@@ -1712,6 +1716,8 @@ int __l2cap_wait_ack(struct sock *sk)
 		err = sock_error(sk);
 		if (err)
 			break;
+
+		BT_DBG("chan %p timeo %d tries %d", chan, timeo, tries);
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
-- 
1.7.9.5

