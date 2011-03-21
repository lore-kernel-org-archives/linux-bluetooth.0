Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/10] Bluetooth: Use kthread API in bnep
Date: Mon, 21 Mar 2011 14:20:00 +0100
Message-ID: <1300713606-23523-5-git-send-email-szymon.janc@tieto.com>
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
 net/bluetooth/bnep/bnep.h |    2 +-
 net/bluetooth/bnep/core.c |   21 ++++++++-------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
index d768e04..8e6c061 100644
--- a/net/bluetooth/bnep/bnep.h
+++ b/net/bluetooth/bnep/bnep.h
@@ -155,7 +155,7 @@ struct bnep_session {
 	unsigned int  role;
 	unsigned long state;
 	unsigned long flags;
-	atomic_t      killed;
+	struct task_struct *task;
 
 	struct ethhdr eh;
 	struct msghdr msg;
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 0a2e76b..ca39fcf 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -36,6 +36,7 @@
 #include <linux/errno.h>
 #include <linux/net.h>
 #include <linux/slab.h>
+#include <linux/kthread.h>
 #include <net/sock.h>
 
 #include <linux/socket.h>
@@ -479,12 +480,11 @@ static int bnep_session(void *arg)
 
 	BT_DBG("");
 
-	daemonize("kbnepd %s", dev->name);
 	set_user_nice(current, -15);
 
 	init_waitqueue_entry(&wait, current);
 	add_wait_queue(sk_sleep(sk), &wait);
-	while (!atomic_read(&s->killed)) {
+	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		/* RX */
@@ -611,11 +611,12 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 
 	__bnep_link_session(s);
 
-	err = kernel_thread(bnep_session, s, CLONE_KERNEL);
-	if (err < 0) {
+	s->task = kthread_run(bnep_session, s, "kbnepd %s", dev->name);
+	if (IS_ERR(s->task)) {
 		/* Session thread start failed, gotta cleanup. */
 		unregister_netdev(dev);
 		__bnep_unlink_session(s);
+		err = PTR_ERR(s->task);
 		goto failed;
 	}
 
@@ -639,15 +640,9 @@ int bnep_del_connection(struct bnep_conndel_req *req)
 	down_read(&bnep_session_sem);
 
 	s = __bnep_get_session(req->dst);
-	if (s) {
-		/* Wakeup user-space which is polling for socket errors.
-		 * This is temporary hack until we have shutdown in L2CAP */
-		s->sock->sk->sk_err = EUNATCH;
-
-		/* Kill session thread */
-		atomic_inc(&s->killed);
-		wake_up_interruptible(sk_sleep(s->sock->sk));
-	} else
+	if (s)
+		kthread_stop(s->task);
+	else
 		err = -ENOENT;
 
 	up_read(&bnep_session_sem);
-- 
1.7.0.4

