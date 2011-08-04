Return-Path: <cyrus@holtmann.org>
From: Jaikumar Ganesh <jaikumar@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaikumar Ganesh <jaikumar@google.com>
Subject: [PATCH] Bluetooth: bnep: Fix deadlock in session deletion.
Date: Wed,  3 Aug 2011 18:59:06 -0700
Message-Id: <1312423146-99276-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit f4d7cd4a4c25cb4a5c30a675d4cc0052c93b925a introduced
usage of <linux/kthread.h> API. kthread_stop is a blocking
function which returns only when the thread exits. In this
case, the thread couldn't exit because it was waiting to get
a write semaphore. bnep_del_connection function which calls
kthread_stop also held the read semaphore.

Signed-off-by: Jaikumar Ganesh <jaikumar@google.com>
---
 net/bluetooth/bnep/core.c |   47 ++++++++++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index eb8486f..f587b81 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -470,6 +470,31 @@ send:
 	return len;
 }
 
+static int cleanup_bnep_session(struct bnep_session *s)
+{
+	struct net_device *dev = s->dev;
+
+	/* Cleanup session */
+	down_write(&bnep_session_sem);
+
+	/* Delete network device */
+	unregister_netdev(dev);
+
+	/* Wakeup user-space polling for socket errors */
+	s->sock->sk->sk_err = EUNATCH;
+
+	wake_up_interruptible(sk_sleep(s->sock->sk));
+
+	/* Release the socket */
+	fput(s->sock->file);
+
+	__bnep_unlink_session(s);
+
+	up_write(&bnep_session_sem);
+	free_netdev(dev);
+	return 0;
+}
+
 static int bnep_session(void *arg)
 {
 	struct bnep_session *s = arg;
@@ -511,25 +536,6 @@ static int bnep_session(void *arg)
 	}
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
-
-	/* Cleanup session */
-	down_write(&bnep_session_sem);
-
-	/* Delete network device */
-	unregister_netdev(dev);
-
-	/* Wakeup user-space polling for socket errors */
-	s->sock->sk->sk_err = EUNATCH;
-
-	wake_up_interruptible(sk_sleep(s->sock->sk));
-
-	/* Release the socket */
-	fput(s->sock->file);
-
-	__bnep_unlink_session(s);
-
-	up_write(&bnep_session_sem);
-	free_netdev(dev);
 	return 0;
 }
 
@@ -651,6 +657,9 @@ int bnep_del_connection(struct bnep_conndel_req *req)
 		err = -ENOENT;
 
 	up_read(&bnep_session_sem);
+
+	if (!err)
+		cleanup_bnep_session(s);
 	return err;
 }
 
-- 
1.7.3.1

