Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Thu, 30 Jun 2011 13:53:53 -0400
Subject: [PATCH v2] Bluetooth: Fix hidp disconnect deadlocks and lost wakeup
Message-ID: <1309456433.2446.2.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Partial revert of commit aabf6f89. When the hidp session thread
was converted from kernel_thread to kthread, the atomic/wakeups
were replaced with kthread_stop. kthread_stop has blocking semantics
which are inappropriate for the hidp session kthread. In addition,
the kthread signals itself to terminate in hidp_process_hid_control()
- it cannot do this with kthread_stop().

Lastly, a wakeup can be lost if the wakeup happens between checking
for the loop exit condition and setting the current state to
TASK_INTERRUPTIBLE. (Without appropriate synchronization mechanisms,
the task state should not be changed between the condition test and
the yield - via schedule() - as this creates a race between the
wakeup and resetting the state back to interruptible.)
---
 net/bluetooth/hidp/core.c |   18 +++++++++++-------
 net/bluetooth/hidp/hidp.h |    1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index c405a95..3a74612 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -464,7 +464,8 @@ static void hidp_idle_timeout(unsigned long arg)
 {
 	struct hidp_session *session = (struct hidp_session *) arg;
 
-	kthread_stop(session->task);
+	atomic_inc(&session->terminate);
+	wake_up_process(session->task);
 }
 
 static void hidp_set_timer(struct hidp_session *session)
@@ -535,7 +536,8 @@ static void hidp_process_hid_control(struct hidp_session *session,
 		skb_queue_purge(&session->ctrl_transmit);
 		skb_queue_purge(&session->intr_transmit);
 
-		kthread_stop(session->task);
+		atomic_inc(&session->terminate);
+		wake_up_process(session->task);
 	}
 }
 
@@ -706,9 +708,8 @@ static int hidp_session(void *arg)
 	add_wait_queue(sk_sleep(intr_sk), &intr_wait);
 	session->waiting_for_startup = 0;
 	wake_up_interruptible(&session->startup_queue);
-	while (!kthread_should_stop()) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!atomic_read(&session->terminate)) {
 		if (ctrl_sk->sk_state != BT_CONNECTED ||
 				intr_sk->sk_state != BT_CONNECTED)
 			break;
@@ -726,6 +727,7 @@ static int hidp_session(void *arg)
 		hidp_process_transmit(session);
 
 		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(intr_sk), &intr_wait);
@@ -1060,7 +1062,8 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 err_add_device:
 	hid_destroy_device(session->hid);
 	session->hid = NULL;
-	kthread_stop(session->task);
+	atomic_inc(&session->terminate);
+	wake_up_process(session->task);
 
 unlink:
 	hidp_del_timer(session);
@@ -1111,7 +1114,8 @@ int hidp_del_connection(struct hidp_conndel_req *req)
 			skb_queue_purge(&session->ctrl_transmit);
 			skb_queue_purge(&session->intr_transmit);
 
-			kthread_stop(session->task);
+			atomic_inc(&session->terminate);
+			wake_up_process(session->task);
 		}
 	} else
 		err = -ENOENT;
diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
index 19e9500..af1bcc8 100644
--- a/net/bluetooth/hidp/hidp.h
+++ b/net/bluetooth/hidp/hidp.h
@@ -142,6 +142,7 @@ struct hidp_session {
 	uint ctrl_mtu;
 	uint intr_mtu;
 
+	atomic_t terminate;
 	struct task_struct *task;
 
 	unsigned char keys[8];
-- 
1.7.4.1

