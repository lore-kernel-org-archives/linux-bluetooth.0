Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 24 Jul 2011 00:11:10 -0400
Subject: [PATCH 7/7] Bluetooth: cmtp: Fix lost wakeup of session thread
Message-ID: <1311480670.4106.32.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix race condition which can result in missing the wakeup intended
to stop the session thread.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/cmtp/core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index c5b11af..2eb854a 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -292,9 +292,11 @@ static int cmtp_session(void *arg)
 
 	init_waitqueue_entry(&wait, current);
 	add_wait_queue(sk_sleep(sk), &wait);
-	while (!kthread_should_stop()) {
+	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
+		if (kthread_should_stop())
+			break;
 		if (sk->sk_state != BT_CONNECTED)
 			break;
 
@@ -307,7 +309,7 @@ static int cmtp_session(void *arg)
 
 		schedule();
 	}
-	set_current_state(TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
 
 	down_write(&cmtp_session_sem);
-- 
1.7.4.1

