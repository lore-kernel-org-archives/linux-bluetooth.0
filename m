Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Make RemoteName D-BUS method non-blocking
Message-ID: <20051020112153.GA31872@localhost.localdomain>
References: <20051019140715.GA15123@localhost.localdomain> <1129762736.2241.18.camel@blade> <20051020070532.GA20546@localhost.localdomain> <1129794748.2241.26.camel@blade> <20051020083703.GA23553@localhost.localdomain> <1129798977.2241.35.camel@blade> <20051020095035.GA26910@localhost.localdomain> <1129803367.2241.56.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
In-Reply-To: <1129803367.2241.56.camel@blade>
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
Date: Thu, 20 Oct 2005 14:21:53 +0300


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 20, 2005, Marcel Holtmann wrote:
> > Ok. I'll create a new RemoteNameFailed signal which has one byte
> > parameter (the status code). Do you want yet another patch against the
> > current CVS HEAD, or should I wait for you to commit my previous patch
> > and then create a new patch against the new CVS revision?
> 
> I only applied the library patch and not your remote name patch. So
> please do it against CVS HEAD now.

Here you go (patch attached).

> Doesn't it make sense to use the general error method? We spent so many
> time talking about the error definition. Shouldn't we use it?

I'm not sure what you mean. Are you talking about the RemoteNameFailed
signal or the error return to the RemoteName method? I checked the
bluez_new_failure_msg function and it seems Claudio has only implemented
support for system errors (i.e. errno) and Bluez D-BUS errors. If I give
the status from command status event to that function it will return
NULL. I guess another patch from Claudio would be needed to create D-BUS
error messages from HCI error codes.

> I think about renaming the InquiryResult into something more meaningful
> like RemoteDevice or something. This signal should include the name from
> the extended inquiry or a cached name or an empty string. We might also
> include the list of UUIDs and some vendor information. The future is the
> extended inquiry and we should plan the D-Bus interface around it. Any
> comments?

I guess I'll actually need to read the extended inquiry response spec.
(just printed it) and think about this :-) I'll also have to investigate
how to use the name cache and maybe send a patch later which checks for
the name in it before sending the remote name request HCI command.
However, there *should* be a way for the user to force the remote name
HCI command to be sent (i.e. overriding the cache), either with the
boolean parameter I suggested or then a separate method call.

Johan

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="remote-name4.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.28
diff -u -r1.28 dbus.c
--- hcid/dbus.c	19 Oct 2005 10:52:45 -0000	1.28
+++ hcid/dbus.c	20 Oct 2005 11:04:36 -0000
@@ -513,6 +513,53 @@
 	return;
 }
 
+void hcid_dbus_remote_name_failed(bdaddr_t *local, uint8_t status, bdaddr_t *peer)
+{
+	DBusMessage *message = NULL;
+	char path[MAX_PATH_LENGTH];
+	char *local_addr, *peer_addr;
+	bdaddr_t tmp;
+	int id;
+
+	baswap(&tmp, local); local_addr = batostr(&tmp);
+	baswap(&tmp, peer); peer_addr = batostr(&tmp);
+
+	id = hci_devid(local_addr);
+	if (id < 0) {
+		syslog(LOG_ERR, "No matching device id for %s", local_addr);
+		goto failed;
+	}
+
+	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+
+	message = dbus_message_new_signal(path,
+				BLUEZ_HCI_INTERFACE, BLUEZ_HCI_REMOTE_NAME_FAILED);
+	if (message == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
+		goto failed;
+	}
+
+	dbus_message_append_args(message,
+				DBUS_TYPE_STRING, &peer_addr,
+				DBUS_TYPE_BYTE, &status,
+				DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send(connection, message, NULL) == FALSE) {
+		syslog(LOG_ERR, "Can't send D-BUS remote name message");
+		goto failed;
+	}
+
+	dbus_connection_flush(connection);
+
+failed:
+	dbus_message_unref(message);
+
+	bt_free(local_addr);
+	bt_free(peer_addr);
+
+	return;
+}
+
 void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer)
 {
 }
@@ -1207,6 +1254,7 @@
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	inquiry_cp cp;
+	evt_cmd_status rp;
 	struct hci_request rq;
 	struct hci_dbus_data *dbus_data = data;
 	int dev_id = -1, dd = -1;
@@ -1250,6 +1298,9 @@
 	rq.ocf = OCF_INQUIRY;
 	rq.cparam = &cp;
 	rq.clen = INQUIRY_CP_SIZE;
+	rq.rparam = &rp;
+	rq.rlen = EVT_CMD_STATUS_SIZE;
+	rq.event = EVT_CMD_STATUS;
 
 	if (hci_send_req(dd, &rq, 100) < 0) {
 		syslog(LOG_ERR, "Unable to start inquiry: %s", strerror(errno));
@@ -1257,6 +1308,12 @@
 		goto failed;
 	}
 
+	if (rp.status) {
+		syslog(LOG_ERR, "Inquiry command failed with status 0x%02X", rp.status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + EIO);
+		goto failed;
+	}
+
 	reply = dbus_message_new_method_return(msg);
 
 failed:
@@ -1322,8 +1379,6 @@
 
 static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data)
 {
-	char name[64];
-	const char *pname = name;
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
@@ -1331,6 +1386,9 @@
 	int dd = -1;
 	const char *str_bdaddr;
 	bdaddr_t bdaddr;
+	struct hci_request rq;
+	remote_name_req_cp cp;
+	evt_cmd_status rp;
 
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_get_basic(&iter, &str_bdaddr);
@@ -1343,27 +1401,47 @@
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 			goto failed;
 		}
-	} else {
+	} else
 		dev_id = dbus_data->id;
-	}
 
 	dd = hci_open_dev(dev_id);
-	if (dd >= 0) {
-		if (hci_read_remote_name(dd, &bdaddr, sizeof(name), name, READ_REMOTE_NAME_TIMEOUT) ==0) {
-			reply = dbus_message_new_method_return(msg);
-			dbus_message_iter_init_append(reply, &iter);
-			dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &pname);
-		} else {
-			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		}
-	} else {
+	if (dd < 0) {
+		syslog(LOG_ERR, "Unable to open device %d: %s", dev_id, strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
 	}
 
-	if (dd > 0)
-		close(dd);
+	memset(&cp, 0, sizeof(cp));
+	cp.bdaddr = bdaddr;
+	cp.pscan_rep_mode = 0x01;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LINK_CTL;
+	rq.ocf = OCF_REMOTE_NAME_REQ;
+	rq.cparam = &cp;
+	rq.clen = REMOTE_NAME_REQ_CP_SIZE;
+	rq.rparam = &rp;
+	rq.rlen = EVT_CMD_STATUS_SIZE;
+	rq.event = EVT_CMD_STATUS;
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Unable to send remote name request: %s", strerror(errno));
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	if (rp.status) {
+		syslog(LOG_ERR, "Remote name command failed with status 0x%02X", rp.status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + EIO);
+		goto failed;
+	}
+
+	reply = dbus_message_new_method_return(msg);
 
 failed:
+	if (dd >= 0)
+		hci_close_dev(dd);
+
 	return reply;
 }
 
Index: hcid/dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.4
diff -u -r1.4 dbus.h
--- hcid/dbus.h	18 Oct 2005 17:31:32 -0000	1.4
+++ hcid/dbus.h	20 Oct 2005 11:04:36 -0000
@@ -116,6 +116,7 @@
 #define BLUEZ_HCI_INQ_COMPLETE		"InquiryComplete"
 #define BLUEZ_HCI_INQ_RESULT		"InquiryResult"
 #define BLUEZ_HCI_REMOTE_NAME		"RemoteName"
+#define BLUEZ_HCI_REMOTE_NAME_FAILED	"RemoteNameFailed"
 
 //HCI signals sent in the BLUEZ_HCI_PATH
 #define BLUEZ_HCI_DEV_ADDED		"DeviceAdded"
Index: hcid/hcid.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/hcid.h,v
retrieving revision 1.25
diff -u -r1.25 hcid.h
--- hcid/hcid.h	9 Oct 2005 22:15:22 -0000	1.25
+++ hcid/hcid.h	20 Oct 2005 11:04:36 -0000
@@ -132,6 +132,7 @@
 void hcid_dbus_inquiry_complete(bdaddr_t *local);
 void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi);
 void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
+void hcid_dbus_remote_name_failed(bdaddr_t *local, uint8_t status, bdaddr_t *peer);
 void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer);
 void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason);
 #else
Index: hcid/security.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/security.c,v
retrieving revision 1.40
diff -u -r1.40 security.c
--- hcid/security.c	6 Sep 2005 22:01:30 -0000	1.40
+++ hcid/security.c	20 Oct 2005 11:04:37 -0000
@@ -496,20 +496,19 @@
 static inline void remote_name_information(int dev, bdaddr_t *sba, void *ptr)
 {
 	evt_remote_name_req_complete *evt = ptr;
-	char name[249];
 	bdaddr_t dba;
 
-	if (evt->status)
-		return;
-
-	memset(name, 0, sizeof(name));
-	memcpy(name, evt->name, 248);
-
 	bacpy(&dba, &evt->bdaddr);
 
-	hcid_dbus_remote_name(sba, &dba, name);
-
-	write_device_name(sba, &dba, name);
+	if (evt->status == 0) {
+		char name[249];
+		memset(name, 0, sizeof(name));
+		memcpy(name, evt->name, 248);
+		write_device_name(sba, &dba, name);
+		hcid_dbus_remote_name(sba, &dba, name);
+	}
+	else
+		hcid_dbus_remote_name_failed(sba, evt->status, &dba);
 }
 
 static inline void remote_version_information(int dev, bdaddr_t *sba, void *ptr)

--2oS5YaxWCcQjTEyO--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
