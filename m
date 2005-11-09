Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051109121639.GA19566@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Subject: [Bluez-devel] [PATCH] dbus.c: use hci_send_req for periodic inquiry commands
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 9 Nov 2005 14:16:39 +0200


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's a patch for the following changes:

1. Remove setting inquiry mode inte period inquiry mode function
This should be done at device initialization and when the appropriate
SetProperty method is called.

2. Use hci_send_req instead of hci_send_cmd for periodic inquiry and
exit periodic inquiry commands. This way a failure status in command
complete event can be catched and the apropriate error code returned.

Johan

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="periodic-inq.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.52
diff -u -r1.52 dbus.c
--- hcid/dbus.c	8 Nov 2005 14:54:58 -0000	1.52
+++ hcid/dbus.c	9 Nov 2005 12:08:18 -0000
@@ -1310,8 +1310,9 @@
 
 static DBusMessage* handle_periodic_inq_req(DBusMessage *msg, void *data)
 {
-	write_inquiry_mode_cp inq_mode;
 	periodic_inquiry_cp inq_param;
+	struct hci_request rq;
+	uint8_t status;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
 	uint8_t length, num_rsp = 0;
@@ -1359,19 +1360,23 @@
 	inq_param.lap[1] = (lap >> 8) & 0xff;
 	inq_param.lap[2] = (lap >> 16) & 0xff;
 
-	inq_mode.mode = 1;	// INQUIRY_WITH_RSSI
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LINK_CTL;
+	rq.ocf = OCF_PERIODIC_INQUIRY;
+	rq.cparam = &inq_param;
+	rq.clen = PERIODIC_INQUIRY_CP_SIZE;
+	rq.rparam = &status;
+	rq.rlen = sizeof(status);
 
-	if (hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE,
-				WRITE_INQUIRY_MODE_CP_SIZE, &inq_mode) < 0) {
-		syslog(LOG_ERR, "Can't set inquiry mode: %s", strerror(errno));
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Sending periodic inquiry command failed: %s", strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
 
-	if (hci_send_cmd(dd, OGF_LINK_CTL, OCF_PERIODIC_INQUIRY,
-				PERIODIC_INQUIRY_CP_SIZE, &inq_param) < 0) {
-		syslog(LOG_ERR, "Can't send HCI commands: %s", strerror(errno));
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+	if (status) {
+		syslog(LOG_ERR, "Periodic inquiry failed with status %02X", status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + status);
 		goto failed;
 	}
 
@@ -1387,7 +1392,9 @@
 static DBusMessage* handle_cancel_periodic_inq_req(DBusMessage *msg, void *data)
 {
 	DBusMessage *reply = NULL;
+	struct hci_request rq;
 	struct hci_dbus_data *dbus_data = data;
+	uint8_t status;
 	int dd = -1;
 
 	dd = hci_open_dev(dbus_data->dev_id);
@@ -1397,12 +1404,25 @@
 		goto failed;
 	}
 
-	if (hci_send_cmd(dd, OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY, 0 , NULL) < 0) {
-		syslog(LOG_ERR, "Send HCI command failed");
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LINK_CTL;
+	rq.ocf = OCF_EXIT_PERIODIC_INQUIRY;
+	rq.rparam = &status;
+	rq.rlen = sizeof(status);
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Sending exit periodic inquiry command failed: %s",
+				strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
 
+	if (status) {
+		syslog(LOG_ERR, "Exit periodic inquiry failed with status %02X", status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + status);
+		goto failed;
+	}
+
 	reply = dbus_message_new_method_return(msg);
 
 failed:
@@ -1479,6 +1499,7 @@
 	DBusMessage *reply = NULL;
 	struct hci_request rq;
 	struct hci_dbus_data *dbus_data = data;
+	uint8_t status;
 	int dd = -1;
 
 	dd = hci_open_dev(dbus_data->dev_id);
@@ -1492,13 +1513,21 @@
 	memset(&rq, 0, sizeof(rq));
 	rq.ogf = OGF_LINK_CTL;
 	rq.ocf = OCF_INQUIRY_CANCEL;
+	rq.rparam = &status;
+	rq.rlen = sizeof(status);
 
 	if (hci_send_req(dd, &rq, 100) < 0) {
-		syslog(LOG_ERR, "Unable to cancel inquiry: %s", strerror(errno));
+		syslog(LOG_ERR, "Sending cancel inquiry failed: %s", strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
 
+	if (status) {
+		syslog(LOG_ERR, "Cancel inquiry failed with status %02X", status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + status);
+		goto failed;
+	}
+
 	reply = dbus_message_new_method_return(msg);
 
 failed:

--VbJkn9YxBvnuCH5J--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
