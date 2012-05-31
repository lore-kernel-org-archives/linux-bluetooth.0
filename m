Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 2/2] Bluetooth: Release all locks before sleep
Date: Thu, 31 May 2012 16:25:44 -0300
Message-Id: <1338492344-1474-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1338492344-1474-1-git-send-email-gustavo@padovan.org>
References: <1338492344-1474-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

To avoid deadlock we need to release locks while waiting for a ack to
arrive.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1cb3ca0..94273dc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1553,13 +1553,14 @@ done:
 int __l2cap_wait_ack(struct sock *sk)
 {
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct l2cap_conn *conn = chan->conn;
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
 	int timeo = HZ/5;
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
-	while (chan->unacked_frames > 0 && chan->conn) {
+	while (chan->unacked_frames > 0 && conn) {
 		if (!timeo)
 			timeo = HZ/5;
 
@@ -1570,7 +1571,9 @@ int __l2cap_wait_ack(struct sock *sk)
 
 		release_sock(sk);
 		l2cap_chan_unlock(chan);
+		mutex_unlock(&conn->chan_lock);
 		timeo = schedule_timeout(timeo);
+		mutex_lock(&conn->chan_lock);
 		l2cap_chan_lock(chan);
 		lock_sock(sk);
 		set_current_state(TASK_INTERRUPTIBLE);
-- 
1.7.10.2

