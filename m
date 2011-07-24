Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 24 Jul 2011 00:11:01 -0400
Subject: [PATCH 5/7] Bluetooth: sco: Fix lost wakeups waiting to accept
 socket
Message-ID: <1311480661.4106.30.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix race conditions which can cause lost wakeups (or missed signals)
while waiting to accept a sco socket connection.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/sco.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index cb4fb78..35420ff 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -564,30 +564,26 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock, int flag
 
 	lock_sock(sk);
 
-	if (sk->sk_state != BT_LISTEN) {
-		err = -EBADFD;
-		goto done;
-	}
-
 	timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
 
 	BT_DBG("sk %p timeo %ld", sk, timeo);
 
 	/* Wait for an incoming connection. (wake-one). */
 	add_wait_queue_exclusive(sk_sleep(sk), &wait);
-	while (!(ch = bt_accept_dequeue(sk, newsock))) {
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
-		lock_sock(sk);
+		ch = bt_accept_dequeue(sk, newsock);
+		if (ch)
+			break;
 
-		if (sk->sk_state != BT_LISTEN) {
-			err = -EBADFD;
+		if (!timeo) {
+			err = -EAGAIN;
 			break;
 		}
 
@@ -595,8 +591,12 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock, int flag
 			err = sock_intr_errno(timeo);
 			break;
 		}
+
+		release_sock(sk);
+		timeo = schedule_timeout(timeo);
+		lock_sock(sk);
 	}
-	set_current_state(TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
 
 	if (err)
-- 
1.7.4.1

