Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>, <johan.hedberg@gmail.com>,
	<Joshua_Frkuska@mentor.com>, Dean Jenkins <Dean_Jenkins@mentor.com>
Subject: [PATCH v2 6/8] Bluetooth: Add BT_DBG to l2cap_sock_shutdown()
Date: Tue, 23 Jun 2015 17:59:37 +0100
Message-ID: <1435078779-4436-7-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Add helpful BT_DBG debug to l2cap_sock_shutdown()
and __l2cap_wait_ack() so that the code flow can
be analysed.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/l2cap_sock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index bdf8f4c..fdc140e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1063,6 +1063,8 @@ static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
 	add_wait_queue(sk_sleep(sk), &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	do {
+		BT_DBG("Waiting for %d ACKs", chan->unacked_frames);
+
 		if (!timeo)
 			timeo = HZ/5;
 
@@ -1140,6 +1142,8 @@ shutdown_already:
 
 	release_sock(sk);
 
+	BT_DBG("err: %d", err);
+
 	return err;
 }
 
-- 
1.8.5.6
