Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] Bluetooth: Use kthread API in hidp
Date: Tue, 5 Apr 2011 15:37:45 +0200
Message-ID: <1302010665-21997-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <201104050951.17932.szymon.janc@tieto.com>
References: <201104050951.17932.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

kernel_thread() is a low-level implementation detail and
EXPORT_SYMBOL(kernel_thread) is scheduled for removal.
Use the <linux/kthread.h> API instead.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hidp/core.c |   53 ++++++++++++++++++++------------------------
 net/bluetooth/hidp/hidp.h |    2 +-
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a1472b7..ae6ebc6 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <linux/mutex.h>
+#include <linux/kthread.h>
 #include <net/sock.h>
 
 #include <linux/input.h>
@@ -463,8 +464,7 @@ static void hidp_idle_timeout(unsigned long arg)
 {
 	struct hidp_session *session = (struct hidp_session *) arg;
 
-	atomic_inc(&session->terminate);
-	hidp_schedule(session);
+	kthread_stop(session->task);
 }
 
 static void hidp_set_timer(struct hidp_session *session)
@@ -535,9 +535,7 @@ static void hidp_process_hid_control(struct hidp_session *session,
 		skb_queue_purge(&session->ctrl_transmit);
 		skb_queue_purge(&session->intr_transmit);
 
-		/* Kill session thread */
-		atomic_inc(&session->terminate);
-		hidp_schedule(session);
+		kthread_stop(session->task);
 	}
 }
 
@@ -696,22 +694,10 @@ static int hidp_session(void *arg)
 	struct sock *ctrl_sk = session->ctrl_sock->sk;
 	struct sock *intr_sk = session->intr_sock->sk;
 	struct sk_buff *skb;
-	int vendor = 0x0000, product = 0x0000;
 	wait_queue_t ctrl_wait, intr_wait;
 
 	BT_DBG("session %p", session);
 
-	if (session->input) {
-		vendor  = session->input->id.vendor;
-		product = session->input->id.product;
-	}
-
-	if (session->hid) {
-		vendor  = session->hid->vendor;
-		product = session->hid->product;
-	}
-
-	daemonize("khidpd_%04x%04x", vendor, product);
 	set_user_nice(current, -15);
 
 	init_waitqueue_entry(&ctrl_wait, current);
@@ -720,7 +706,7 @@ static int hidp_session(void *arg)
 	add_wait_queue(sk_sleep(intr_sk), &intr_wait);
 	session->waiting_for_startup = 0;
 	wake_up_interruptible(&session->startup_queue);
-	while (!atomic_read(&session->terminate)) {
+	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		if (ctrl_sk->sk_state != BT_CONNECTED ||
@@ -968,6 +954,7 @@ fault:
 int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
 {
 	struct hidp_session *session, *s;
+	int vendor, product;
 	int err;
 
 	BT_DBG("");
@@ -1029,9 +1016,24 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 
 	hidp_set_timer(session);
 
-	err = kernel_thread(hidp_session, session, CLONE_KERNEL);
-	if (err < 0)
+	if (session->hid) {
+		vendor  = session->hid->vendor;
+		product = session->hid->product;
+	} else if (session->input) {
+		vendor  = session->input->id.vendor;
+		product = session->input->id.product;
+	} else {
+		vendor = 0x0000;
+		product = 0x0000;
+	}
+
+	session->task = kthread_run(hidp_session, session, "khidpd_%04x%04x",
+							vendor, product);
+	if (IS_ERR(session->task)) {
+		err = PTR_ERR(session->task);
 		goto unlink;
+	}
+
 	while (session->waiting_for_startup) {
 		wait_event_interruptible(session->startup_queue,
 			!session->waiting_for_startup);
@@ -1056,8 +1058,7 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 err_add_device:
 	hid_destroy_device(session->hid);
 	session->hid = NULL;
-	atomic_inc(&session->terminate);
-	hidp_schedule(session);
+	kthread_stop(session->task);
 
 unlink:
 	hidp_del_timer(session);
@@ -1108,13 +1109,7 @@ int hidp_del_connection(struct hidp_conndel_req *req)
 			skb_queue_purge(&session->ctrl_transmit);
 			skb_queue_purge(&session->intr_transmit);
 
-			/* Wakeup user-space polling for socket errors */
-			session->intr_sock->sk->sk_err = EUNATCH;
-			session->ctrl_sock->sk->sk_err = EUNATCH;
-
-			/* Kill session thread */
-			atomic_inc(&session->terminate);
-			hidp_schedule(session);
+			kthread_stop(session->task);
 		}
 	} else
 		err = -ENOENT;
diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
index b412e71..12822cd 100644
--- a/net/bluetooth/hidp/hidp.h
+++ b/net/bluetooth/hidp/hidp.h
@@ -142,7 +142,7 @@ struct hidp_session {
 	uint ctrl_mtu;
 	uint intr_mtu;
 
-	atomic_t terminate;
+	struct task_struct *task;
 
 	unsigned char keys[8];
 	unsigned char leds;
-- 
1.7.0.4

