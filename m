Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 5/7] Bluetooth: Move l2cap_wait_ack() to l2cap_sock.c
Date: Tue, 15 Oct 2013 19:24:49 -0300
Message-Id: <1381875891-27953-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
References: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

The wait_ack code has a heavy dependency on the socket data structures
and, as of now, it won't be worthless change it to use non-socket
structures as the only user of such feature is a socket.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |  1 -
 net/bluetooth/l2cap_core.c    | 32 --------------------------------
 net/bluetooth/l2cap_sock.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ae3a99b..377db2a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -813,7 +813,6 @@ void l2cap_cleanup_sockets(void);
 bool l2cap_is_socket(struct socket *sock);
 
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
-int __l2cap_wait_ack(struct sock *sk);
 
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 634781a..39f02c08 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1894,38 +1894,6 @@ done:
 	return err;
 }
 
-int __l2cap_wait_ack(struct sock *sk)
-{
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-	DECLARE_WAITQUEUE(wait, current);
-	int err = 0;
-	int timeo = HZ/5;
-
-	add_wait_queue(sk_sleep(sk), &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-	while (chan->unacked_frames > 0 && chan->conn) {
-		if (!timeo)
-			timeo = HZ/5;
-
-		if (signal_pending(current)) {
-			err = sock_intr_errno(timeo);
-			break;
-		}
-
-		release_sock(sk);
-		timeo = schedule_timeout(timeo);
-		lock_sock(sk);
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		err = sock_error(sk);
-		if (err)
-			break;
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(sk_sleep(sk), &wait);
-	return err;
-}
-
 static void l2cap_monitor_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 301f25b..68f486a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -879,6 +879,38 @@ static void l2cap_sock_kill(struct sock *sk)
 	sock_put(sk);
 }
 
+static int __l2cap_wait_ack(struct sock *sk)
+{
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	DECLARE_WAITQUEUE(wait, current);
+	int err = 0;
+	int timeo = HZ/5;
+
+	add_wait_queue(sk_sleep(sk), &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (chan->unacked_frames > 0 && chan->conn) {
+		if (!timeo)
+			timeo = HZ/5;
+
+		if (signal_pending(current)) {
+			err = sock_intr_errno(timeo);
+			break;
+		}
+
+		release_sock(sk);
+		timeo = schedule_timeout(timeo);
+		lock_sock(sk);
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		err = sock_error(sk);
+		if (err)
+			break;
+	}
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(sk_sleep(sk), &wait);
+	return err;
+}
+
 static int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
-- 
1.8.3.1

