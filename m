Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Mon, 25 Jul 2011 18:36:26 -0400
Subject: [PATCH] Bluetooth: l2cap: Fix lost wakeup waiting for ERTM acks
Message-ID: <1311633386.4311.79.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix race condition which can result in missing wakeup during
l2cap socket shutdown.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/l2cap_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7705e26..2969ef0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -997,9 +997,8 @@ int __l2cap_wait_ack(struct sock *sk)
 	int timeo = HZ/5;
 
 	add_wait_queue(sk_sleep(sk), &wait);
-	while ((chan->unacked_frames > 0 && chan->conn)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (chan->unacked_frames > 0 && chan->conn) {
 		if (!timeo)
 			timeo = HZ/5;
 
@@ -1011,6 +1010,7 @@ int __l2cap_wait_ack(struct sock *sk)
 		release_sock(sk);
 		timeo = schedule_timeout(timeo);
 		lock_sock(sk);
+		set_current_state(TASK_INTERRUPTIBLE);
 
 		err = sock_error(sk);
 		if (err)
-- 
1.7.4.1

