Return-Path: <hch@lst.de>
Date: Sat, 8 Jul 2006 20:58:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcel@holtmann.org, maxk@qualcomm.com
Cc: bluez-devel@lists.sourceforge.net
Subject: [PATCH] bluetooth: use kthread_ API
Message-ID: <20060708185833.GA7917@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/net/bluetooth/bnep/bnep.h
===================================================================
--- linux-2.6.orig/net/bluetooth/bnep/bnep.h	2006-02-16 12:37:32.000000000 +0100
+++ linux-2.6/net/bluetooth/bnep/bnep.h	2006-07-08 20:20:08.000000000 +0200
@@ -159,7 +159,7 @@
 	unsigned int  role;
         unsigned long state;
         unsigned long flags;
-	atomic_t      killed;
+	struct task_struct *thread;
 
 	struct ethhdr eh;
 	struct msghdr msg;
Index: linux-2.6/net/bluetooth/bnep/core.c
===================================================================
--- linux-2.6.orig/net/bluetooth/bnep/core.c	2006-07-08 17:44:37.000000000 +0200
+++ linux-2.6/net/bluetooth/bnep/core.c	2006-07-08 20:20:08.000000000 +0200
@@ -39,6 +39,7 @@
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
 #include <linux/net.h>
+#include <linux/kthread.h>
 #include <net/sock.h>
 
 #include <linux/socket.h>
@@ -470,13 +471,12 @@
 
 	BT_DBG("");
 
-        daemonize("kbnepd %s", dev->name);
 	set_user_nice(current, -15);
 	current->flags |= PF_NOFREEZE;
 
 	init_waitqueue_entry(&wait, current);
 	add_wait_queue(sk->sk_sleep, &wait);
-	while (!atomic_read(&s->killed)) {
+	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		// RX
@@ -575,8 +575,9 @@
 
 	__bnep_link_session(s);
 	
-	err = kernel_thread(bnep_session, s, CLONE_KERNEL);
-	if (err < 0) {
+	s->thread = kthread_run(bnep_session, s, "kbnepd %s", dev->name);
+	if (IS_ERR(s->thread)) {
+		err = PTR_ERR(s->thread);
 		/* Session thread start failed, gotta cleanup. */
 		unregister_netdev(dev);
 		__bnep_unlink_session(s);
@@ -609,8 +610,7 @@
 		s->sock->sk->sk_err = EUNATCH;
 		
 		/* Kill session thread */
-		atomic_inc(&s->killed);
-		wake_up_interruptible(s->sock->sk->sk_sleep);
+		kthread_stop(s->thread);
 	} else
 		err = -ENOENT;
 
Index: linux-2.6/net/bluetooth/cmtp/capi.c
===================================================================
--- linux-2.6.orig/net/bluetooth/cmtp/capi.c	2006-07-08 17:44:37.000000000 +0200
+++ linux-2.6/net/bluetooth/cmtp/capi.c	2006-07-08 20:20:13.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/ioctl.h>
 #include <linux/file.h>
 #include <linux/wait.h>
+#include <linux/kthread.h>
 #include <net/sock.h>
 
 #include <linux/isdn/capilli.h>
@@ -364,8 +365,7 @@
 
 	capi_ctr_reseted(ctrl);
 
-	atomic_inc(&session->terminate);
-	cmtp_schedule(session);
+	kthread_stop(session->thread);
 }
 
 static void cmtp_register_appl(struct capi_ctr *ctrl, __u16 appl, capi_register_params *rp)
Index: linux-2.6/net/bluetooth/cmtp/cmtp.h
===================================================================
--- linux-2.6.orig/net/bluetooth/cmtp/cmtp.h	2006-02-16 12:37:32.000000000 +0100
+++ linux-2.6/net/bluetooth/cmtp/cmtp.h	2006-07-08 20:20:13.000000000 +0200
@@ -81,7 +81,7 @@
 
 	char name[BTNAMSIZ];
 
-	atomic_t terminate;
+	struct task_struct *thread;
 
 	wait_queue_head_t wait;
 
Index: linux-2.6/net/bluetooth/cmtp/core.c
===================================================================
--- linux-2.6.orig/net/bluetooth/cmtp/core.c	2006-07-08 17:44:37.000000000 +0200
+++ linux-2.6/net/bluetooth/cmtp/core.c	2006-07-08 20:20:13.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/ioctl.h>
 #include <linux/file.h>
 #include <linux/init.h>
+#include <linux/kthread.h>
 #include <net/sock.h>
 
 #include <linux/isdn/capilli.h>
@@ -285,13 +286,12 @@
 
 	BT_DBG("session %p", session);
 
-	daemonize("kcmtpd_ctr_%d", session->num);
 	set_user_nice(current, -15);
 	current->flags |= PF_NOFREEZE;
 
 	init_waitqueue_entry(&wait, current);
 	add_wait_queue(sk->sk_sleep, &wait);
-	while (!atomic_read(&session->terminate)) {
+	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		if (sk->sk_state != BT_CONNECTED)
@@ -374,9 +374,12 @@
 
 	__cmtp_link_session(session);
 
-	err = kernel_thread(cmtp_session, session, CLONE_KERNEL);
-	if (err < 0)
+	session->thread = kthread_run(cmtp_session, session,
+			"kcmtpd_ctr_%d", session->num);
+	if (IS_ERR(session->thread)) {
+		err = PTR_ERR(session->thread);
 		goto unlink;
+	}
 
 	if (!(session->flags & (1 << CMTP_LOOPBACK))) {
 		err = cmtp_attach_device(session);
@@ -414,8 +417,7 @@
 		skb_queue_purge(&session->transmit);
 
 		/* Kill session thread */
-		atomic_inc(&session->terminate);
-		cmtp_schedule(session);
+		kthread_stop(session->thread);
 	} else
 		err = -ENOENT;
 
Index: linux-2.6/net/bluetooth/hidp/core.c
===================================================================
--- linux-2.6.orig/net/bluetooth/hidp/core.c	2006-07-08 17:44:37.000000000 +0200
+++ linux-2.6/net/bluetooth/hidp/core.c	2006-07-08 20:20:17.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/file.h>
 #include <linux/init.h>
 #include <linux/wait.h>
+#include <linux/kthread.h>
 #include <net/sock.h>
 
 #include <linux/input.h>
@@ -222,8 +223,7 @@
 {
 	struct hidp_session *session = (struct hidp_session *) arg;
 
-	atomic_inc(&session->terminate);
-	hidp_schedule(session);
+	kthread_stop(session->thread);
 }
 
 static inline void hidp_set_timer(struct hidp_session *session)
@@ -318,7 +318,7 @@
 		skb_queue_purge(&session->intr_transmit);
 
 		/* Kill session thread */
-		atomic_inc(&session->terminate);
+		kthread_stop(session->thread);
 		break;
 
 	case HIDP_CTRL_HARD_RESET:
@@ -460,17 +460,10 @@
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
-	daemonize("khidpd_%04x%04x", vendor, product);
 	set_user_nice(current, -15);
 	current->flags |= PF_NOFREEZE;
 
@@ -478,7 +471,7 @@
 	init_waitqueue_entry(&intr_wait, current);
 	add_wait_queue(ctrl_sk->sk_sleep, &ctrl_wait);
 	add_wait_queue(intr_sk->sk_sleep, &intr_wait);
-	while (!atomic_read(&session->terminate)) {
+	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		if (ctrl_sk->sk_state != BT_CONNECTED || intr_sk->sk_state != BT_CONNECTED)
@@ -574,6 +567,7 @@
 int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
 {
 	struct hidp_session *session, *s;
+	int vendor = 0x0000, product = 0x0000;
 	int err;
 
 	BT_DBG("");
@@ -630,9 +624,17 @@
 
 	hidp_set_timer(session);
 
-	err = kernel_thread(hidp_session, session, CLONE_KERNEL);
-	if (err < 0)
+	if (session->input) {
+		vendor  = session->input->id.vendor;
+		product = session->input->id.product;
+	}
+
+	session->thread = kthread_run(hidp_session, session,
+			"khidpd_%04x%04x", vendor, product);
+	if (IS_ERR(session->thread)) {
+		err = PTR_ERR(session->thread);
 		goto unlink;
+	}
 
 	if (session->input) {
 		hidp_send_ctrl_message(session,
@@ -684,8 +686,7 @@
 			skb_queue_purge(&session->intr_transmit);
 
 			/* Kill session thread */
-			atomic_inc(&session->terminate);
-			hidp_schedule(session);
+			kthread_stop(session->thread);
 		}
 	} else
 		err = -ENOENT;
Index: linux-2.6/net/bluetooth/hidp/hidp.h
===================================================================
--- linux-2.6.orig/net/bluetooth/hidp/hidp.h	2006-02-16 12:37:31.000000000 +0100
+++ linux-2.6/net/bluetooth/hidp/hidp.h	2006-07-08 20:20:17.000000000 +0200
@@ -138,7 +138,7 @@
 	uint ctrl_mtu;
 	uint intr_mtu;
 
-	atomic_t terminate;
+	struct task_struct *thread;
 
 	unsigned char keys[8];
 	unsigned char leds;
