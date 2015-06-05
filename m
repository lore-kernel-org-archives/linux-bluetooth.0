Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>,
	<johan.hedberg@gmail.com>, <Joshua_Frkuska@mentor.com>,
	Dean Jenkins <Dean_Jenkins@mentor.com>
Subject: [PATCH v1 2/7] Bluetooth: Make __l2cap_wait_ack more efficient
Date: Sat, 6 Jun 2015 00:11:11 +0100
Message-ID: <1433545876-15800-3-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1433545876-15800-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1433545876-15800-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use chan->state instead of chan->conn because waiting
for ACK's is only possible in the BT_CONNECTED state.
Also avoids reference to the conn structure so makes
locking easier.

Only call __l2cap_wait_ack() when the needed condition
of chan->unacked_frames > 0 && chan->state == BT_CONNECTED
is true and convert the while loop to a do while loop.

__l2cap_wait_ack() change the function prototype to
pass in the chan variable as chan is already available
in the calling function l2cap_sock_shutdown(). Avoids
locking issues.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/l2cap_sock.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 8321685..c909f45 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1054,16 +1054,15 @@ static void l2cap_sock_kill(struct sock *sk)
 	sock_put(sk);
 }
 
-static int __l2cap_wait_ack(struct sock *sk)
+static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
 {
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
 	int timeo = HZ/5;
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
-	while (chan->unacked_frames > 0 && chan->conn) {
+	do {
 		if (!timeo)
 			timeo = HZ/5;
 
@@ -1080,7 +1079,9 @@ static int __l2cap_wait_ack(struct sock *sk)
 		err = sock_error(sk);
 		if (err)
 			break;
-	}
+	} while (chan->unacked_frames > 0 &&
+		 chan->state == BT_CONNECTED);
+
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
 	return err;
@@ -1115,8 +1116,10 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	lock_sock(sk);
 
 	if (!sk->sk_shutdown) {
-		if (chan->mode == L2CAP_MODE_ERTM)
-			err = __l2cap_wait_ack(sk);
+		if (chan->mode == L2CAP_MODE_ERTM &&
+		    chan->unacked_frames > 0 &&
+		    chan->state == BT_CONNECTED)
+			err = __l2cap_wait_ack(sk, chan);
 
 		sk->sk_shutdown = SHUTDOWN_MASK;
 
-- 
1.8.5.6

