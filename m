Return-Path: <nacc@us.ibm.com>
Date: Thu, 20 Jan 2005 15:47:54 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: marcel@holtmann.org, maxk@qualcomm.com
Cc: bluez-devel@lists.sourceforge.net, kernel-janitors@lists.osdl.org
Subject: [PATCH 17/39] net/capi: use wait_event_interruptible_timeout()
Message-ID: <20050120234754.GE2600@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

Please consider applying.

Description: Use wait_event_interruptible_timeout() instead of custom
wait-queue code. The first replacement is the most complicated as the various
return conditions each indicate different things, apparently. The same effects
are made after wait_event_interruptible_timeout() returns.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc1-kj-v/net/bluetooth/cmtp/capi.c	2005-01-15 16:55:44.000000000 -0800
+++ 2.6.11-rc1-kj/net/bluetooth/cmtp/capi.c	2005-01-18 11:47:16.000000000 -0800
@@ -35,6 +35,7 @@
 #include <linux/socket.h>
 #include <linux/ioctl.h>
 #include <linux/file.h>
+#include <linux/wait.h>
 #include <net/sock.h>
 
 #include <linux/isdn/capilli.h>
@@ -373,12 +374,11 @@ static void cmtp_reset_ctr(struct capi_c
 
 static void cmtp_register_appl(struct capi_ctr *ctrl, __u16 appl, capi_register_params *rp)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct cmtp_session *session = ctrl->driverdata;
 	struct cmtp_application *application;
-	unsigned long timeo = CMTP_INTEROP_TIMEOUT;
 	unsigned char buf[8];
 	int err = 0, nconn, want = rp->level3cnt;
+	long ret;
 
 	BT_DBG("ctrl %p appl %d level3cnt %d datablkcnt %d datablklen %d",
 		ctrl, appl, rp->level3cnt, rp->datablkcnt, rp->datablklen);
@@ -407,33 +407,15 @@ static void cmtp_register_appl(struct ca
 	cmtp_send_interopmsg(session, CAPI_REQ, 0x0000, application->msgnum,
 				CAPI_FUNCTION_REGISTER, buf, 6);
 
-	add_wait_queue(&session->wait, &wait);
-	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (!timeo) {
-			err = -EAGAIN;
-			break;
-		}
-
-		if (application->state == BT_CLOSED) {
-			err = -application->err;
-			break;
-		}
-
-		if (application->state == BT_CONNECTED)
-			break;
-
-		if (signal_pending(current)) {
-			err = -EINTR;
-			break;
-		}
-
-		timeo = schedule_timeout(timeo);
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&session->wait, &wait);
-
+	ret = wait_event_interruptible_timeout(session->wait,
+		((application->state == BT_CLOSED) || (application->state == BT_CONNECTED)),
+		CMTP_INTEROP_TIMEOUT);
+	if (!ret)
+		err = -EAGAIN;
+	else if (application->state == BT_CLOSED)
+		err = -application->err;
+	else if (signal_pending(current))
+		err = -EINTR;
 	if (err) {
 		cmtp_application_del(session, application);
 		return;
@@ -442,10 +424,8 @@ static void cmtp_register_appl(struct ca
 
 static void cmtp_release_appl(struct capi_ctr *ctrl, __u16 appl)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct cmtp_session *session = ctrl->driverdata;
 	struct cmtp_application *application;
-	unsigned long timeo = CMTP_INTEROP_TIMEOUT;
 
 	BT_DBG("ctrl %p appl %d", ctrl, appl);
 
@@ -460,20 +440,8 @@ static void cmtp_release_appl(struct cap
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
+	wait_event_interruptible_timeout(session->wait, (application->state == BT_CLOSED),
+			CMTP_INTEROP_TIMEOUT);
 
 	cmtp_application_del(session, application);
 }
@@ -543,8 +511,7 @@ static int cmtp_ctr_read_proc(char *page
 
 int cmtp_attach_device(struct cmtp_session *session)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	unsigned long timeo = CMTP_INTEROP_TIMEOUT;
+	long ret;
 	unsigned char buf[4];
 
 	BT_DBG("session %p", session);
@@ -554,30 +521,17 @@ int cmtp_attach_device(struct cmtp_sessi
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
+	ret = wait_event_interruptible_timeout(session->wait, session->ncontroller,
+			CMTP_INTEROP_TIMEOUT);
 
 	BT_INFO("Found %d CAPI controller(s) on device %s", session->ncontroller, session->name);
 
-	if (!timeo)
+	if (!ret)
 		return -ETIMEDOUT;
 
 	if (!session->ncontroller)
 		return -ENODEV;
 
-
 	if (session->ncontroller > 1)
 		BT_INFO("Setting up only CAPI controller 1");
 
