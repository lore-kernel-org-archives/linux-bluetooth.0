Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 24 Jul 2011 00:11:07 -0400
Subject: [PATCH 6/7] Bluetooth: bnep: Fix lost wakeup of session thread
Message-ID: <1311480667.4106.31.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix race condition which can result in missing the wakeup intended
to stop the session thread.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/bnep/core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index ca39fcf..7e8ff3c 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -484,9 +484,11 @@ static int bnep_session(void *arg)
 
 	init_waitqueue_entry(&wait, current);
 	add_wait_queue(sk_sleep(sk), &wait);
-	while (!kthread_should_stop()) {
+	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
+		if (kthread_should_stop())
+			break;
 		/* RX */
 		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 			skb_orphan(skb);
@@ -504,7 +506,7 @@ static int bnep_session(void *arg)
 
 		schedule();
 	}
-	set_current_state(TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
 
 	/* Cleanup session */
-- 
1.7.4.1

