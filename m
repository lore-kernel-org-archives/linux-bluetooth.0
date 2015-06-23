Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>, <johan.hedberg@gmail.com>,
	<Joshua_Frkuska@mentor.com>, Dean Jenkins <Dean_Jenkins@mentor.com>
Subject: [PATCH v2 7/8] Bluetooth: __l2cap_wait_ack() use msecs_to_jiffies()
Date: Tue, 23 Jun 2015 17:59:38 +0100
Message-ID: <1435078779-4436-8-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Use msecs_to_jiffies() instead of using HZ so that it
is easier to specify the time in milliseconds.

Also add a #define L2CAP_WAIT_ACK_POLL_PERIOD to specify the 200ms
polling period so that it is defined in a single place.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_sock.c    | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2239a37..3dcad41 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -55,6 +55,7 @@
 #define L2CAP_INFO_TIMEOUT		msecs_to_jiffies(4000)
 #define L2CAP_MOVE_TIMEOUT		msecs_to_jiffies(4000)
 #define L2CAP_MOVE_ERTX_TIMEOUT		msecs_to_jiffies(60000)
+#define L2CAP_WAIT_ACK_POLL_PERIOD	msecs_to_jiffies(200)
 
 #define L2CAP_A2MP_DEFAULT_MTU		670
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index fdc140e..2c09ec1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1058,7 +1058,7 @@ static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
-	int timeo = HZ/5;
+	int timeo = L2CAP_WAIT_ACK_POLL_PERIOD;
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -1066,7 +1066,7 @@ static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
 		BT_DBG("Waiting for %d ACKs", chan->unacked_frames);
 
 		if (!timeo)
-			timeo = HZ/5;
+			timeo = L2CAP_WAIT_ACK_POLL_PERIOD;
 
 		if (signal_pending(current)) {
 			err = sock_intr_errno(timeo);
-- 
1.8.5.6
