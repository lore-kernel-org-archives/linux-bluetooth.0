Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>, <johan.hedberg@gmail.com>,
	<Joshua_Frkuska@mentor.com>, Dean Jenkins <Dean_Jenkins@mentor.com>
Subject: [PATCH v2 8/8] Bluetooth: __l2cap_wait_ack() add defensive timeout
Date: Tue, 23 Jun 2015 17:59:39 +0100
Message-ID: <1435078779-4436-9-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Add a timeout to prevent the do while loop running in an
infinite loop. This ensures that the channel will be
instructed to close within 10 seconds so prevents
l2cap_sock_shutdown() getting stuck forever.

Returns -ENOLINK when the timeout is reached. The channel
will be subequently closed and not all data will be ACK'ed.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_sock.c    | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3dcad41..c98afc0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -56,6 +56,7 @@
 #define L2CAP_MOVE_TIMEOUT		msecs_to_jiffies(4000)
 #define L2CAP_MOVE_ERTX_TIMEOUT		msecs_to_jiffies(60000)
 #define L2CAP_WAIT_ACK_POLL_PERIOD	msecs_to_jiffies(200)
+#define L2CAP_WAIT_ACK_TIMEOUT		msecs_to_jiffies(10000)
 
 #define L2CAP_A2MP_DEFAULT_MTU		670
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 2c09ec1..f967749 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1059,11 +1059,16 @@ static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
 	int timeo = L2CAP_WAIT_ACK_POLL_PERIOD;
+	/* Timeout to prevent infinite loop */
+	unsigned long timeout = jiffies + L2CAP_WAIT_ACK_TIMEOUT;
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	do {
-		BT_DBG("Waiting for %d ACKs", chan->unacked_frames);
+		BT_DBG("Waiting for %d ACKs, timeout %04d ms",
+			chan->unacked_frames,
+			time_after(jiffies, timeout) ? 0 :
+			jiffies_to_msecs(timeout - jiffies));
 
 		if (!timeo)
 			timeo = L2CAP_WAIT_ACK_POLL_PERIOD;
@@ -1082,6 +1087,11 @@ static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
 		if (err)
 			break;
 
+		if (time_after(jiffies, timeout)) {
+			err = -ENOLINK;
+			break;
+		}
+
 	} while (chan->unacked_frames > 0 &&
 		 chan->state == BT_CONNECTED);
 
-- 
1.8.5.6
