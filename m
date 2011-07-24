Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 24 Jul 2011 00:10:41 -0400
Subject: [PATCH 2/7] Bluetooth: rfcomm: Fix lost wakeups waiting to accept
 socket
Message-ID: <1311480641.4106.27.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix race conditions which can cause lost wakeups (or missed
signals) while waiting to accept an rfcomm socket connection.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/rfcomm/sock.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 1b10727..bda7402 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -485,11 +485,6 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int f
 
 	lock_sock(sk);
 
-	if (sk->sk_state != BT_LISTEN) {
-		err = -EBADFD;
-		goto done;
-	}
-
 	if (sk->sk_type != SOCK_STREAM) {
 		err = -EINVAL;
 		goto done;
@@ -501,19 +496,20 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int f
 
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
-		lock_sock(sk);
+		nsk = bt_accept_dequeue(sk, newsock);
+		if (nsk)
+			break;
 
-		if (sk->sk_state != BT_LISTEN) {
-			err = -EBADFD;
+		if (!timeo) {
+			err = -EAGAIN;
 			break;
 		}
 
@@ -521,8 +517,12 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int f
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

