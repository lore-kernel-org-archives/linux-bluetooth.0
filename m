Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>, <johan.hedberg@gmail.com>,
	<Joshua_Frkuska@mentor.com>, Dean Jenkins <Dean_Jenkins@mentor.com>
Subject: [PATCH v1 7/7] Bluetooth: __l2cap_wait_ack() limit max waiting time
Date: Sat, 6 Jun 2015 00:11:16 +0100
Message-ID: <1433545876-15800-8-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1433545876-15800-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1433545876-15800-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Add a limiter counter to prevent the do while loop
running in an infinite loop. This ensures that the
channel will be instructed to close within 10 seconds
so prevents l2cap_sock_shutdown() getting stuck forever.

Returns -ENOLINK when the limit is reached as the channel
will be subequently closed and not all data was ACK'ed.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/l2cap_sock.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 369ad0e..ee6531e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1059,11 +1059,13 @@ static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
 	int timeo = HZ/5;
+	int limiter = 10 * 5;	/* 10 seconds limit */
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	do {
-		BT_DBG("Waiting for %d ACKs", chan->unacked_frames);
+		BT_DBG("Waiting for %d ACKs, limiter %d",
+			chan->unacked_frames, limiter);
 
 		if (!timeo)
 			timeo = HZ/5;
@@ -1081,6 +1083,13 @@ static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
 		err = sock_error(sk);
 		if (err)
 			break;
+
+		limiter--;
+		if (!limiter) {
+			err = -ENOLINK;
+			break;
+		}
+
 	} while (chan->unacked_frames > 0 &&
 		 chan->state == BT_CONNECTED);
 
-- 
1.8.5.6
