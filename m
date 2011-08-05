Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 5 Aug 2011 10:44:21 -0400
Subject: [PATCH] Bluetooth: cmtp: Fix deadlock in session deletion
Message-ID: <1312555461.2172.5.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit fada4ac339 introduced the usage of kthread API.
kthread_stop is a blocking function which returns only when
the thread exits. In this case, the thread can't exit because it's
waiting for the write lock, which is being held by cmtp_del_connection()
which is waiting for the thread to exit -- deadlock.

Revert cmtp_reset_ctr to its original behavior: non-blocking signalling
for the session to terminate.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/cmtp/capi.c |    3 ++-
 net/bluetooth/cmtp/cmtp.h |    1 +
 net/bluetooth/cmtp/core.c |    5 +++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index 744233c..e080b0d 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -387,7 +387,8 @@ static void cmtp_reset_ctr(struct capi_ctr *ctrl)
 
 	capi_ctr_down(ctrl);
 
-	kthread_stop(session->task);
+	atomic_inc(&session->terminate);
+	wake_up_process(session->task);
 }
 
 static void cmtp_register_appl(struct capi_ctr *ctrl, __u16 appl, capi_register_params *rp)
diff --git a/net/bluetooth/cmtp/cmtp.h b/net/bluetooth/cmtp/cmtp.h
index db43b54..c32638d 100644
--- a/net/bluetooth/cmtp/cmtp.h
+++ b/net/bluetooth/cmtp/cmtp.h
@@ -81,6 +81,7 @@ struct cmtp_session {
 
 	char name[BTNAMSIZ];
 
+	atomic_t terminate;
 	struct task_struct *task;
 
 	wait_queue_head_t wait;
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 2eb854a..42cb2f4 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -295,7 +295,7 @@ static int cmtp_session(void *arg)
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (kthread_should_stop())
+		if (atomic_read(&session->terminate))
 			break;
 		if (sk->sk_state != BT_CONNECTED)
 			break;
@@ -416,7 +416,8 @@ int cmtp_del_connection(struct cmtp_conndel_req *req)
 		skb_queue_purge(&session->transmit);
 
 		/* Stop session thread */
-		kthread_stop(session->task);
+		atomic_inc(&session->terminate);
+		wake_up_process(session->task);
 	} else
 		err = -ENOENT;
 
-- 
1.7.4.1

