Return-Path: <nacc@us.ibm.com>
Date: Fri, 21 Jan 2005 11:09:09 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sourceforge.net,
   kernel-janitors@lists.osdl.org
Subject: [UPDATE PATCH 18/39] net/core: use wait_event_timeout()
Message-ID: <20050121190909.GD3340@us.ibm.com>
References: <20050120235123.GG2600@us.ibm.com> <1106267534.7955.36.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1106267534.7955.36.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, Jan 21, 2005 at 01:32:14AM +0100, Marcel Holtmann wrote:
> Hi Nishanth,
> 
> > Description: Use wait_event_timeout() instead of custom wait-queue code.
> > The current code uses TASK_INTERRUPTIBLE but only cares about timing out and the
> > wq event taking place (does not actively do anything in response to signals), so
> > wait_event_timeout() should be ok.
> 
> this one results in:
> 
>   CC [M]  net/bluetooth/hidp/core.o
> net/bluetooth/hidp/core.c: In function `hidp_session':
> net/bluetooth/hidp/core.c:547: warning: passing arg 1 of `prepare_to_wait' from incompatible pointer type
> net/bluetooth/hidp/core.c:547: warning: passing arg 1 of `finish_wait' from incompatible pointer type
> net/bluetooth/hidp/core.c:551: warning: passing arg 1 of `prepare_to_wait' from incompatible pointer type
> net/bluetooth/hidp/core.c:551: warning: passing arg 1 of `finish_wait' from incompatible pointer type

Sorry for that, Marcel. The calling case in that function is slightly different
than usual...fixed below.

Thanks,
Nish

Description: Use wait_event_timeout() instead of custom wait-queue code.
The current code uses TASK_INTERRUPTIBLE but only cares about timing out and the
wq event taking place (does not actively do anything in response to signals), so
wait_event_timeout() should be ok.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.11-rc1-kj-v/net/bluetooth/hidp/core.c	2005-01-15 16:55:44.000000000 -0800
+++ 2.6.11-rc1-kj/net/bluetooth/hidp/core.c	2005-01-21 11:07:11.000000000 -0800
@@ -36,6 +36,7 @@
 #include <linux/ioctl.h>
 #include <linux/file.h>
 #include <linux/init.h>
+#include <linux/wait.h>
 #include <net/sock.h>
 
 #include <linux/input.h>
@@ -325,7 +326,6 @@ static int hidp_session(void *arg)
 	struct sk_buff *skb;
 	int vendor = 0x0000, product = 0x0000;
 	wait_queue_t ctrl_wait, intr_wait;
-	unsigned long timeo = HZ;
 
 	BT_DBG("session %p", session);
 
@@ -370,28 +370,14 @@ static int hidp_session(void *arg)
 
 	hidp_del_timer(session);
 
-	if (intr_sk->sk_state != BT_CONNECTED) {
-		init_waitqueue_entry(&ctrl_wait, current);
-		add_wait_queue(ctrl_sk->sk_sleep, &ctrl_wait);
-		while (timeo && ctrl_sk->sk_state != BT_CLOSED) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			timeo = schedule_timeout(timeo);
-		}
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(ctrl_sk->sk_sleep, &ctrl_wait);
-		timeo = HZ;
-	}
+	if (intr_sk->sk_state != BT_CONNECTED)
+		wait_event_timeout(*(ctrl_sk->sk_sleep),
+				(ctrl_sk->sk_state == BT_CLOSED), HZ);
 
 	fput(session->ctrl_sock->file);
 
-	init_waitqueue_entry(&intr_wait, current);
-	add_wait_queue(intr_sk->sk_sleep, &intr_wait);
-	while (timeo && intr_sk->sk_state != BT_CLOSED) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		timeo = schedule_timeout(timeo);
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(intr_sk->sk_sleep, &intr_wait);
+	wait_event_timeout(*(ctrl_sk->sk_sleep),
+			(intr_sk->sk_state == BT_CLOSED), HZ);
 
 	fput(session->intr_sock->file);
 
