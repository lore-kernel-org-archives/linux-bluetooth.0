Return-Path: <nacc@us.ibm.com>
Date: Fri, 21 Jan 2005 11:17:33 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   kernel-janitors@lists.osdl.org
Subject: [UPDATE PATCH 17/39] net/capi: use wait_event_interruptible_timeout()
Message-ID: <20050121191733.GE3340@us.ibm.com>
References: <20050120234754.GE2600@us.ibm.com> <1106267887.7955.40.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1106267887.7955.40.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, Jan 21, 2005 at 01:38:07AM +0100, Marcel Holtmann wrote:
> Hi Nishanth,
> 
> > Description: Use wait_event_interruptible_timeout() instead of custom
> > wait-queue code. The first replacement is the most complicated as the various
> > return conditions each indicate different things, apparently. The same effects
> > are made after wait_event_interruptible_timeout() returns.
> 
> the first one makes the code look ugly. Remove it and re-submit.

Thanks for the input. Fixed below.

-Nish

Description: Use wait_event_interruptible_timeout() instead of custom
wait-queue code. Remove the now unused variables in both functions.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.11-rc1-kj-v/net/bluetooth/cmtp/capi.c	2005-01-15 16:55:44.000000000 -0800
+++ 2.6.11-rc1-kj/net/bluetooth/cmtp/capi.c	2005-01-21 11:14:47.000000000 -0800
@@ -35,6 +35,7 @@
 #include <linux/socket.h>
 #include <linux/ioctl.h>
 #include <linux/file.h>
+#include <linux/wait.h>
 #include <net/sock.h>
 
 #include <linux/isdn/capilli.h>
@@ -442,10 +443,8 @@ static void cmtp_register_appl(struct ca
 
 static void cmtp_release_appl(struct capi_ctr *ctrl, __u16 appl)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct cmtp_session *session = ctrl->driverdata;
 	struct cmtp_application *application;
-	unsigned long timeo = CMTP_INTEROP_TIMEOUT;
 
 	BT_DBG("ctrl %p appl %d", ctrl, appl);
 
@@ -460,20 +459,8 @@ static void cmtp_release_appl(struct cap
 	cmtp_send_interopmsg(session, CAPI_REQ, application->mapping, application->msgnum,
 				CAPI_FUNCTION_RELEASE, NULL, 0);
 
-	add_wait_queue(&session->wait, &wait);
-	while (timeo) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (application->state == BT_CLOSED)
-			break;
-
-		if (signal_pending(current))
-			break;
-
-		timeo = schedule_timeout(timeo);
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&session->wait, &wait);
+	wait_event_interruptible_timeout(session->wait,
+			(application->state == BT_CLOSED), CMTP_INTEROP_TIMEOUT);
 
 	cmtp_application_del(session, application);
 }
@@ -543,8 +530,6 @@ static int cmtp_ctr_read_proc(char *page
 
 int cmtp_attach_device(struct cmtp_session *session)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	unsigned long timeo = CMTP_INTEROP_TIMEOUT;
 	unsigned char buf[4];
 
 	BT_DBG("session %p", session);
@@ -554,30 +539,17 @@ int cmtp_attach_device(struct cmtp_sessi
 	cmtp_send_interopmsg(session, CAPI_REQ, 0xffff, CMTP_INITIAL_MSGNUM,
 				CAPI_FUNCTION_GET_PROFILE, buf, 4);
 
-	add_wait_queue(&session->wait, &wait);
-	while (timeo) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (session->ncontroller)
-			break;
-
-		if (signal_pending(current))
-			break;
-
-		timeo = schedule_timeout(timeo);
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&session->wait, &wait);
-
+	ret = wait_event_interruptible_timeout(session->wait,
+			session->ncontroller, CMTP_INTEROP_TIMEOUT);
+	
 	BT_INFO("Found %d CAPI controller(s) on device %s", session->ncontroller, session->name);
 
-	if (!timeo)
+	if (!ret)
 		return -ETIMEDOUT;
 
 	if (!session->ncontroller)
 		return -ENODEV;
 
-
 	if (session->ncontroller > 1)
 		BT_INFO("Setting up only CAPI controller 1");
 
