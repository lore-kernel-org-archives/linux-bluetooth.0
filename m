Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Make RemoteName D-BUS method non-blocking
Message-ID: <20051020083703.GA23553@localhost.localdomain>
References: <20051019140715.GA15123@localhost.localdomain> <1129762736.2241.18.camel@blade> <20051020070532.GA20546@localhost.localdomain> <1129794748.2241.26.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
In-Reply-To: <1129794748.2241.26.camel@blade>
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
Date: Thu, 20 Oct 2005 11:37:03 +0300


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 20, 2005, Marcel Holtmann wrote:
> > > Why don't you set rq.event to EVT_CMD_STATUS?
> > 
> > Because hci_send_req has a switch statement which handles the
> > EVT_CMD_STATUS case separately and would never reach the case where it
> > tests for hdr->evt == r->event.
> 
> This looks like a bug to me. We should check r->event == EVT_CMD_STATUS
> and then exit nicely.

Yeah, that sounds like the best solution to me. Attached is a patch to
fix it, as well as a new patch for hcid which sets rq.event to
EVT_CMD_STATUS.

> > Attached is a new patch which should apply cleanly to CVS.
> 
> Do you think the status parameter is needed? Is it not better to send
> two different responses? One for the success case and one for the
> failure case.

I'm not sure whether the status parameter is needed, perhaps if someone
wants to make an UI which shows an accurate error message why the name
request failed? Anyway, I don't have a strong opinion about it, so if
you want to I can remove the status parameter and split the signal to
RemoteName and RemoteNameFailed signals.

Johan

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="send-req.patch"

Index: src/hci.c
===================================================================
RCS file: /cvsroot/bluez/libs/src/hci.c,v
retrieving revision 1.81
diff -u -r1.81 hci.c
--- src/hci.c	22 Sep 2005 23:10:48 -0000	1.81
+++ src/hci.c	20 Oct 2005 08:13:12 -0000
@@ -972,6 +972,12 @@
 			if (cs->opcode != opcode)
 				continue;
 
+			if (hdr->evt == r->event) {
+				r->rlen = MIN(len, r->rlen);
+				memcpy(r->rparam, ptr, r->rlen);
+				goto done;
+			}
+
 			if (cs->status) {
 				errno = EIO;
 				goto failed;

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="remote-name3.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.28
diff -u -r1.28 dbus.c
--- hcid/dbus.c	19 Oct 2005 10:52:45 -0000	1.28
+++ hcid/dbus.c	20 Oct 2005 08:32:59 -0000
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
@@ -1207,6 +1208,7 @@
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	inquiry_cp cp;
+	evt_cmd_status rp;
 	struct hci_request rq;
 	struct hci_dbus_data *dbus_data = data;
 	int dev_id = -1, dd = -1;
@@ -1250,6 +1252,9 @@
 	rq.ocf = OCF_INQUIRY;
 	rq.cparam = &cp;
 	rq.clen = INQUIRY_CP_SIZE;
+	rq.rparam = &rp;
+	rq.rlen = EVT_CMD_STATUS_SIZE;
+	rq.event = EVT_CMD_STATUS;
 
 	if (hci_send_req(dd, &rq, 100) < 0) {
 		syslog(LOG_ERR, "Unable to start inquiry: %s", strerror(errno));
@@ -1257,6 +1262,12 @@
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
@@ -1322,8 +1333,6 @@
 
 static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data)
 {
-	char name[64];
-	const char *pname = name;
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
@@ -1331,6 +1340,9 @@
 	int dd = -1;
 	const char *str_bdaddr;
 	bdaddr_t bdaddr;
+	struct hci_request rq;
+	remote_name_req_cp cp;
+	evt_cmd_status rp;
 
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_get_basic(&iter, &str_bdaddr);
@@ -1343,27 +1355,47 @@
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
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
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
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
 	}
 
-	if (dd > 0)
-		close(dd);
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
 
Index: hcid/hcid.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/hcid.h,v
retrieving revision 1.25
diff -u -r1.25 hcid.h
--- hcid/hcid.h	9 Oct 2005 22:15:22 -0000	1.25
+++ hcid/hcid.h	20 Oct 2005 08:33:00 -0000
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
+++ hcid/security.c	20 Oct 2005 08:33:00 -0000
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

--SUOF0GtieIMvvwua--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
