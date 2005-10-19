Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051019140715.GA15123@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Subject: [Bluez-devel] [PATCH] Make RemoteName D-BUS method non-blocking
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
Date: Wed, 19 Oct 2005 17:07:15 +0300


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's a patch which does a similar change RemoteName as my previous
patch did to Inquiry. For the user to be able to know if the name
request fails because of e.g. page timeout I have added a status
paramer to the signal and forced the signal to be always sent (not just
when evt->status == 0).

I also updated the pygtk testing program to work with this change:
http://www.iki.fi/~jhedberg/bluez-python/bluez-python-0.4.tar.gz

There is one problem when using hci_send_req with the inquiry and remote
name HCI commands: they don't generate a command complete event, only a
command status event. This means that hci_send_req will fail with
ETIMEDOUT (I didn't notice it earlier since the UI status is immediately
updated by the InquiryStarted signal). Using hci_send_cmd is also not
(IMHO) an option since a failure status in the command status event
should be detected and handled properly.

I can think of a couple of possible solutions to this:
1. Change hci_send_req to detect the special cases that don't produce
command complete event.
2. Do the listening of command status event ourselves in dbus.c
3. Check for ETIMEDOUT error and treat it as success

I went with option 3 for now since it requires the least code changes,
but it should probably not be the final solution since it doesn't catch
the situation where command status event isn't received in time. Any
suggestions for how this should be best fixed?

Johan

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="remote-name.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.27
diff -u -r1.27 dbus.c
--- hcid/dbus.c	18 Oct 2005 17:31:32 -0000	1.27
+++ hcid/dbus.c	19 Oct 2005 13:43:30 -0000
@@ -466,7 +466,7 @@
 	return;
 }
 
-void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
+void hcid_dbus_remote_name(bdaddr_t *local, uint8_t status, bdaddr_t *peer, char *name)
 {
 	DBusMessage *message = NULL;
 	char path[MAX_PATH_LENGTH];
@@ -493,6 +493,7 @@
 	}
 
 	dbus_message_append_args(message,
+					DBUS_TYPE_BYTE, &status,
 					DBUS_TYPE_STRING, &peer_addr,
 					DBUS_TYPE_STRING, &name,
 					DBUS_TYPE_INVALID);
@@ -1253,7 +1254,7 @@
 	rq.cparam = &cp;
 	rq.clen = INQUIRY_CP_SIZE;
 	
-	if (hci_send_req(dd, &rq, 100) < 0) {
+	if (hci_send_req(dd, &rq, 100) < 0 && errno != ETIMEDOUT) {
 		syslog(LOG_ERR, "Unable to start inquiry: %s", strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
@@ -1325,8 +1326,6 @@
 
 static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data)
 {
-	char name[64];
-	const char *pname = name;
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
@@ -1334,6 +1333,8 @@
 	int dd = -1;
 	const char *str_bdaddr;
 	bdaddr_t bdaddr;
+	struct hci_request rq;
+	remote_name_req_cp cp;
 	
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_get_basic(&iter, &str_bdaddr);
@@ -1346,27 +1347,38 @@
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 			goto failed;
 		}
-	} else {
+	} else
 		dev_id = dbus_data->id;
+
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "Unable to open device %d: %s", dev_id, strerror(errno));
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
 	}
 
-	if ((dd = hci_open_dev(dev_id)) > 0) {
-	
-		if (hci_read_remote_name(dd, &bdaddr, sizeof(name), name, READ_REMOTE_NAME_TIMEOUT) ==0) {
-			reply = dbus_message_new_method_return(msg);
-			dbus_message_iter_init_append(reply, &iter);
-			dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &pname);
-		} else {
-			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		}
-	} else {
+	memset(&cp, 0, sizeof(cp));
+	cp.bdaddr = bdaddr;
+	cp.pscan_rep_mode = 0x01;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LINK_CTL;
+	rq.ocf = OCF_REMOTE_NAME_REQ;
+	rq.cparam = &cp;
+	rq.clen = REMOTE_NAME_REQ_CP_SIZE;
+
+	if (hci_send_req(dd, &rq, 100) < 0 && errno != ETIMEDOUT) {
+		syslog(LOG_ERR, "Unable to send remote name request: %s", strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
 	}
-	
-	if (dd > 0)
-		close (dd);
+
+	reply = dbus_message_new_method_return(msg);
 
 failed:
+	if (dd >= 0)
+		hci_close_dev(dd);
+
 	return reply;
 }
 
Index: hcid/hcid.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/hcid.h,v
retrieving revision 1.25
diff -u -r1.25 hcid.h
--- hcid/hcid.h	9 Oct 2005 22:15:22 -0000	1.25
+++ hcid/hcid.h	19 Oct 2005 13:43:31 -0000
@@ -131,7 +131,7 @@
 void hcid_dbus_inquiry_start(bdaddr_t *local);
 void hcid_dbus_inquiry_complete(bdaddr_t *local);
 void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi);
-void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
+void hcid_dbus_remote_name(bdaddr_t *local, uint8_t status, bdaddr_t *peer, char *name);
 void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer);
 void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason);
 #else
Index: hcid/security.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/security.c,v
retrieving revision 1.40
diff -u -r1.40 security.c
--- hcid/security.c	6 Sep 2005 22:01:30 -0000	1.40
+++ hcid/security.c	19 Oct 2005 13:43:32 -0000
@@ -499,17 +499,16 @@
 	char name[249];
 	bdaddr_t dba;
 
-	if (evt->status)
-		return;
+	bacpy(&dba, &evt->bdaddr);
 
 	memset(name, 0, sizeof(name));
-	memcpy(name, evt->name, 248);
 
-	bacpy(&dba, &evt->bdaddr);
-
-	hcid_dbus_remote_name(sba, &dba, name);
+	if (evt->status == 0) {
+		memcpy(name, evt->name, 248);
+		write_device_name(sba, &dba, name);
+	}
 
-	write_device_name(sba, &dba, name);
+	hcid_dbus_remote_name(sba, evt->status, &dba, name);
 }
 
 static inline void remote_version_information(int dev, bdaddr_t *sba, void *ptr)

--OgqxwSJOaUobr8KG--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
