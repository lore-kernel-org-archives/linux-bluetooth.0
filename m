Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 24 Jul 2011 00:10:52 -0400
Subject: [PATCH 4/7] Bluetooth: l2cap: Fix lost wakeups waiting to accept
 socket
Message-ID: <1311480652.4106.29.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix race conditions which can cause lost wakeups (or misssed signals)
while waiting to accept an l2cap socket connection.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/l2cap_sock.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 8248303..e13a5cc 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -274,30 +274,26 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock, int fl
 
 	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
-	if (sk->sk_state != BT_LISTEN) {
-		err = -EBADFD;
-		goto done;
-	}
-
 	timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
 
 	BT_DBG("sk %p timeo %ld", sk, timeo);
 
 	/* Wait for an incoming connection. (wake-one). */
 	add_wait_queue_exclusive(sk_sleep(sk), &wait);
-	while (!(nsk = bt_accept_dequeue(sk, newsock))) {
+	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (!timeo) {
-			err = -EAGAIN;
+
+		if (sk->sk_state != BT_LISTEN) {
+			err = -EBADFD;
 			break;
 		}
 
-		release_sock(sk);
-		timeo = schedule_timeout(timeo);
-		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+		nsk = bt_accept_dequeue(sk, newsock);
+		if (nsk)
+			break;
 
-		if (sk->sk_state != BT_LISTEN) {
-			err = -EBADFD;
+		if (!timeo) {
+			err = -EAGAIN;
 			break;
 		}
 
@@ -305,8 +301,12 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock, int fl
 			err = sock_intr_errno(timeo);
 			break;
 		}
+
+		release_sock(sk);
+		timeo = schedule_timeout(timeo);
+		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 	}
-	set_current_state(TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
 
 	if (err)
-- 
1.7.4.1

