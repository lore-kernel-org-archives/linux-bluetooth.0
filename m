Return-Path: <cyrus@holtmann.org>
Message-ID: <1357654917.5641.7.camel@dellpc>
Subject: [PATCH hidp] Fix Kernel OOPS in hidp_session caused by orphaned
 sock structures
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 08 Jan 2013 14:21:57 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a proposed fix to the kernel OOPS reported in

https://bugzilla.kernel.org/show_bug.cgi?id=50541

hidp_session() is crashing the kernel typically on a resume from
suspend. My analysis concluded that the sock structure pointed to by
ctrl_sk was being orphaned at some point parallel to the execution of
hidp_session (sometimes even while hidp_session is still in its main
loop). This mean that calls to sk_sleep(ctrl_sk) would return NULL,
leading to ..._wait() or ..._wakeup() calls crashing.

The proposed fix is to store the waitqueue_head structure needed for the
waiting/waking in a local variable. rcu_dereference_raw() [normally
called via sk_sleep()] is still used and required to protect access, but
we ensure we have the proper handle onto the structure rather than
losing it by the sock being orphaned.

Signed-off-by: Karl Relton <karllinuxtest.relton@ntlworld.com>

--- linux-3.7.0.orig/net/bluetooth/hidp/core.c	2013-01-08 13:04:35.945237334 +0000
+++ linux-3.7.0/net/bluetooth/hidp/core.c	2013-01-08 13:06:11.313240959 +0000
@@ -680,16 +680,19 @@ static int hidp_session(void *arg)
 	struct sock *intr_sk = session->intr_sock->sk;
 	struct sk_buff *skb;
 	wait_queue_t ctrl_wait, intr_wait;
+	struct socket_wq *ctrl_wq, *intr_wq;
 
 	BT_DBG("session %p", session);
 
 	__module_get(THIS_MODULE);
 	set_user_nice(current, -15);
 
+	ctrl_wq = ctrl_sk->sk_wq;
+	intr_wq = intr_sk->sk_wq;
 	init_waitqueue_entry(&ctrl_wait, current);
 	init_waitqueue_entry(&intr_wait, current);
-	add_wait_queue(sk_sleep(ctrl_sk), &ctrl_wait);
-	add_wait_queue(sk_sleep(intr_sk), &intr_wait);
+	add_wait_queue(&rcu_dereference_raw(ctrl_wq)->wait, &ctrl_wait);
+	add_wait_queue(&rcu_dereference_raw(intr_wq)->wait, &intr_wait);
 	session->waiting_for_startup = 0;
 	wake_up_interruptible(&session->startup_queue);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -722,8 +725,8 @@ static int hidp_session(void *arg)
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	set_current_state(TASK_RUNNING);
-	remove_wait_queue(sk_sleep(intr_sk), &intr_wait);
-	remove_wait_queue(sk_sleep(ctrl_sk), &ctrl_wait);
+	remove_wait_queue(&rcu_dereference_raw(intr_wq)->wait, &intr_wait);
+	remove_wait_queue(&rcu_dereference_raw(ctrl_wq)->wait, &ctrl_wait);
 
 	clear_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags);
 	clear_bit(HIDP_WAITING_FOR_RETURN, &session->flags);
@@ -747,12 +750,15 @@ static int hidp_session(void *arg)
 	session->intr_sock->sk->sk_err = EUNATCH;
 	session->ctrl_sock->sk->sk_err = EUNATCH;
 
-	hidp_schedule(session);
+	wake_up_interruptible(&rcu_dereference_raw(ctrl_wq)->wait);
+	wake_up_interruptible(&rcu_dereference_raw(intr_wq)->wait);
 
 	fput(session->intr_sock->file);
 
-	wait_event_timeout(*(sk_sleep(ctrl_sk)),
-		(ctrl_sk->sk_state == BT_CLOSED), msecs_to_jiffies(500));
+	/* By now ctrl_sk might have been orphaned already */
+	if (ctrl_wq == ctrl_sk->sk_wq)
+		wait_event_timeout(rcu_dereference_raw(ctrl_wq)->wait,
+			(ctrl_sk->sk_state == BT_CLOSED), msecs_to_jiffies(500));
 
 	fput(session->ctrl_sock->file);
 


