Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Aug 2011 09:30:44 -0400
Subject: [PATCH] Bluetooth: hidp: Don't hid_add_device for non-hid device
Message-ID: <1314192644.2219.1.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When adding an HIDP connection, a proxy child device of the hci
connection is registered with one of two device subsystems:
hid or input. The subsystem in use for a given session is determined
by which device ptr member, hid or input, is non-zero.

Prevent a NULL device ptr parameter to hid_add_device. Also,
cleanup other code paths to reflect the either/or logic (rather
than evaluating both conditions).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/hidp/core.c |   38 +++++++++++++++-----------------------
 1 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index fb68f34..e02c6a2 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -129,9 +129,7 @@ static void __hidp_copy_session(struct hidp_session *session, struct hidp_connin
 			strncpy(ci->name, session->input->name, 128);
 		else
 			strncpy(ci->name, "HID Boot Device", 128);
-	}
-
-	if (session->hid) {
+	} else if (session->hid) {
 		ci->vendor  = session->hid->vendor;
 		ci->product = session->hid->product;
 		ci->version = session->hid->version;
@@ -554,8 +552,7 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 
 		if (session->input)
 			hidp_input_report(session, skb);
-
-		if (session->hid)
+		else if (session->hid)
 			hid_input_report(session->hid, HID_INPUT_REPORT, skb->data, skb->len, 0);
 		break;
 
@@ -634,10 +631,9 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
 	if (hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
 		hidp_set_timer(session);
 
-		if (session->input)
+		if (session->input) {
 			hidp_input_report(session, skb);
-
-		if (session->hid) {
+		} else if (session->hid) {
 			hid_input_report(session->hid, HID_INPUT_REPORT, skb->data, skb->len, 1);
 			BT_DBG("report len %d", skb->len);
 		}
@@ -740,9 +736,7 @@ static int hidp_session(void *arg)
 	if (session->input) {
 		input_unregister_device(session->input);
 		session->input = NULL;
-	}
-
-	if (session->hid) {
+	} else if (session->hid) {
 		hid_destroy_device(session->hid);
 		session->hid = NULL;
 	}
@@ -1045,15 +1039,15 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 			!session->waiting_for_startup);
 	}
 
-	err = hid_add_device(session->hid);
-	if (err < 0) {
-		atomic_inc(&session->terminate);
-		wake_up_process(session->task);
-		up_write(&hidp_session_sem);
-		return err;
-	}
-
-	if (session->input) {
+	if (session->hid) {
+		err = hid_add_device(session->hid);
+		if (err < 0) {
+			atomic_inc(&session->terminate);
+			wake_up_process(session->task);
+			up_write(&hidp_session_sem);
+			return err;
+		}
+	} else if (session->input) {
 		hidp_send_ctrl_message(session,
 			HIDP_TRANS_SET_PROTOCOL | HIDP_PROTO_BOOT, NULL, 0);
 		session->flags |= (1 << HIDP_BOOT_PROTOCOL_MODE);
@@ -1073,9 +1067,7 @@ unlink:
 	if (session->input) {
 		input_unregister_device(session->input);
 		session->input = NULL;
-	}
-
-	if (session->hid) {
+	} else if (session->hid) {
 		hid_destroy_device(session->hid);
 		session->hid = NULL;
 	}
-- 
1.7.4.1

