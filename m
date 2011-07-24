Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 24 Jul 2011 00:10:46 -0400
Subject: [PATCH 3/7] Bluetooth: Fix lost wakeups waiting for sock state
 change
Message-ID: <1311480646.4106.28.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix race conditions which can cause lost wakeups while waiting
for sock state to change.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/af_bluetooth.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 8add9b4..117e0d1 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -494,9 +494,8 @@ int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
 	BT_DBG("sk %p", sk);
 
 	add_wait_queue(sk_sleep(sk), &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
 	while (sk->sk_state != state) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (!timeo) {
 			err = -EINPROGRESS;
 			break;
@@ -510,12 +509,13 @@ int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
 		release_sock(sk);
 		timeo = schedule_timeout(timeo);
 		lock_sock(sk);
+		set_current_state(TASK_INTERRUPTIBLE);
 
 		err = sock_error(sk);
 		if (err)
 			break;
 	}
-	set_current_state(TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
 	return err;
 }
-- 
1.7.4.1

