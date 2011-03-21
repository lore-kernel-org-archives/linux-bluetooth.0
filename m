Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/10] Bluetooth: Use kthread API in cmtp
Date: Mon, 21 Mar 2011 14:20:06 +0100
Message-ID: <1300713606-23523-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
References: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

kernel_thread() is a low-level implementation detail and
EXPORT_SYMBOL(kernel_thread) is scheduled for removal.
Use the <linux/kthread.h> API instead.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/cmtp/capi.c |    6 +++---
 net/bluetooth/cmtp/cmtp.h |    9 +--------
 net/bluetooth/cmtp/core.c |   16 +++++++++-------
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index 67cff81..744233c 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -35,6 +35,7 @@
 #include <linux/ioctl.h>
 #include <linux/file.h>
 #include <linux/wait.h>
+#include <linux/kthread.h>
 #include <net/sock.h>
 
 #include <linux/isdn/capilli.h>
@@ -143,7 +144,7 @@ static void cmtp_send_capimsg(struct cmtp_session *session, struct sk_buff *skb)
 
 	skb_queue_tail(&session->transmit, skb);
 
-	cmtp_schedule(session);
+	wake_up_interruptible(sk_sleep(session->sock->sk));
 }
 
 static void cmtp_send_interopmsg(struct cmtp_session *session,
@@ -386,8 +387,7 @@ static void cmtp_reset_ctr(struct capi_ctr *ctrl)
 
 	capi_ctr_down(ctrl);
 
-	atomic_inc(&session->terminate);
-	cmtp_schedule(session);
+	kthread_stop(session->task);
 }
 
 static void cmtp_register_appl(struct capi_ctr *ctrl, __u16 appl, capi_register_params *rp)
diff --git a/net/bluetooth/cmtp/cmtp.h b/net/bluetooth/cmtp/cmtp.h
index c6f78f8..db43b54 100644
--- a/net/bluetooth/cmtp/cmtp.h
+++ b/net/bluetooth/cmtp/cmtp.h
@@ -81,7 +81,7 @@ struct cmtp_session {
 
 	char name[BTNAMSIZ];
 
-	atomic_t terminate;
+	struct task_struct *task;
 
 	wait_queue_head_t wait;
 
@@ -121,13 +121,6 @@ void cmtp_detach_device(struct cmtp_session *session);
 
 void cmtp_recv_capimsg(struct cmtp_session *session, struct sk_buff *skb);
 
-static inline void cmtp_schedule(struct cmtp_session *session)
-{
-	struct sock *sk = session->sock->sk;
-
-	wake_up_interruptible(sk_sleep(sk));
-}
-
 /* CMTP init defines */
 int cmtp_init_sockets(void);
 void cmtp_cleanup_sockets(void);
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 16aa6bd..cce99b0 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -35,6 +35,7 @@
 #include <linux/ioctl.h>
 #include <linux/file.h>
 #include <linux/init.h>
+#include <linux/kthread.h>
 #include <net/sock.h>
 
 #include <linux/isdn/capilli.h>
@@ -287,12 +288,11 @@ static int cmtp_session(void *arg)
 
 	BT_DBG("session %p", session);
 
-	daemonize("kcmtpd_ctr_%d", session->num);
 	set_user_nice(current, -15);
 
 	init_waitqueue_entry(&wait, current);
 	add_wait_queue(sk_sleep(sk), &wait);
-	while (!atomic_read(&session->terminate)) {
+	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		if (sk->sk_state != BT_CONNECTED)
@@ -370,9 +370,12 @@ int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 
 	__cmtp_link_session(session);
 
-	err = kernel_thread(cmtp_session, session, CLONE_KERNEL);
-	if (err < 0)
+	session->task = kthread_run(cmtp_session, session, "kcmtpd_ctr_%d",
+								session->num);
+	if (IS_ERR(session->task)) {
+		err = PTR_ERR(session->task);
 		goto unlink;
+	}
 
 	if (!(session->flags & (1 << CMTP_LOOPBACK))) {
 		err = cmtp_attach_device(session);
@@ -409,9 +412,8 @@ int cmtp_del_connection(struct cmtp_conndel_req *req)
 		/* Flush the transmit queue */
 		skb_queue_purge(&session->transmit);
 
-		/* Kill session thread */
-		atomic_inc(&session->terminate);
-		cmtp_schedule(session);
+		/* Stop session thread */
+		kthread_stop(session->task);
 	} else
 		err = -ENOENT;
 
-- 
1.7.0.4

