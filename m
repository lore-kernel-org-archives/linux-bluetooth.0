Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC -v2 13/16] Bluetooth: Move l2cap_wait_ack() to l2cap_sock.c
Date: Fri, 21 Dec 2012 16:10:56 -0200
Message-Id: <1356113459-7932-14-git-send-email-gustavo@padovan.org>
In-Reply-To: <1356113459-7932-1-git-send-email-gustavo@padovan.org>
References: <1356113459-7932-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

The wait_ack code has a heavy dependency on the socket data structures
and, as of now, it won't be worthless change it to use non-socket
structures as the only user of such feature is a socket.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |  3 ++-
 net/bluetooth/l2cap_core.c    | 32 --------------------------------
 net/bluetooth/l2cap_sock.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 6986140..574b3ae 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -757,6 +757,8 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
 		msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO));
 #define __clear_ack_timer(c) l2cap_clear_timer(c, &c->ack_timer)
 
+#define __missing_ack(c) (c->unacked_frames > 0 && c->conn)
+
 static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)
 {
 	if (seq1 >= seq2)
@@ -793,7 +795,6 @@ int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
 
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
-int __l2cap_wait_ack(struct sock *sk);
 
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 935534c..f151775 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1706,38 +1706,6 @@ done:
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
index 3d76de8..58b4a5d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -853,6 +853,38 @@ static void l2cap_sock_kill(struct sock *sk)
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
+	while (__missing_ack(chan)) {
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
1.8.0.2

