Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051017195943.GA5200@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Subject: [Bluez-devel] [PATCH] Changes to Inquiry D-BUS method
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
Date: Mon, 17 Oct 2005 22:59:43 +0300


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

A major problem with the current Inquiry D-BUS method implementation is
that it blocks while the inquiry is in progress. What this means is that
e.g. InquiryResult signals aren't sent until the inquiry process
finishes.

I think that the easiest and cleanest way to solve this is to not return
the inquiry results in the D-BUS method return, but have the user listen
to the InquiryResult signals that hcid already emmits. The attached
patch does this change. I have also updated the pygtk testing program to
work with this new interface:
http://www.iki.fi/~jhedberg/bluez-python/bluez-python-0.3.tar.gz

Johan

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inquiry.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.25
diff -u -r1.25 dbus.c
--- hcid/dbus.c	17 Oct 2005 09:29:44 -0000	1.25
+++ hcid/dbus.c	17 Oct 2005 19:44:22 -0000
@@ -1144,20 +1144,12 @@
 
 static DBusMessage* handle_inq_req(DBusMessage *msg, void *data)
 {
-	char addr[18];
-	const char array_sig[] = HCI_INQ_REPLY_SIGNATURE;
 	DBusMessageIter iter;
-	DBusMessageIter array_iter;
-	DBusMessageIter  struct_iter;
 	DBusMessage *reply = NULL;
-	inquiry_info *info = NULL;
+	inquiry_cp cp;
+	struct hci_request rq;
 	struct hci_dbus_data *dbus_data = data;
-	const char *paddr = addr;
-	int dev_id = -1;
-	int i;
-	uint32_t class = 0;
-	uint16_t clock_offset;
-	uint16_t flags;
+	int dev_id = -1, dd = -1;
 	int8_t length;
 	int8_t num_rsp;
 
@@ -1174,45 +1166,44 @@
 	dbus_message_iter_get_basic(&iter, &length);
 	dbus_message_iter_next(&iter);
 	dbus_message_iter_get_basic(&iter, &num_rsp);
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_get_basic(&iter, &flags);
 
 	if ((length <= 0) || (num_rsp <= 0)) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
 		goto failed;
 	}
 
-	num_rsp = hci_inquiry(dev_id, length, num_rsp, NULL, &info, flags);
-
-	if (num_rsp < 0) {
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "Unable to open device %d: %s", dev_id, strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-	} else {
-		reply = dbus_message_new_method_return(msg);
-		dbus_message_iter_init_append(reply, &iter);
-		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, array_sig, &array_iter);
-
-		for (i = 0; i < num_rsp; i++) {
-			ba2str(&(info+i)->bdaddr, addr);
-
-			clock_offset = btohs((info+i)->clock_offset);
-			/* only 3 bytes are used */
-			memcpy(&class, (info+i)->dev_class, 3);
-
-			dbus_message_iter_open_container(&array_iter, DBUS_TYPE_STRUCT, NULL, &struct_iter);
-			dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING , &paddr);
-			dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_UINT32 , &class);
-			dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_UINT16 , &clock_offset);
-			dbus_message_iter_close_container(&array_iter, &struct_iter);
-		}
+		goto failed;
+	}
 
-		dbus_message_iter_close_container(&iter, &array_iter);
+	cp.lap[0] = 0x33;
+	cp.lap[1] = 0x8b;
+	cp.lap[2] = 0x9e;
+	cp.length = length;
+	cp.num_rsp = num_rsp;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LINK_CTL;
+	rq.ocf = OCF_INQUIRY;
+	rq.cparam = &cp;
+	rq.clen = INQUIRY_CP_SIZE;
+	
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Unable to start inquiry: %s", strerror(errno));
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
 	}
+	
+	reply = dbus_message_new_method_return(msg);
 
 failed:
-	if(info)
-		bt_free(info);
+	if (dd >= 0)
+		hci_close_dev(dd);
 
-	return NULL;
+	return reply;
 }
 
 static DBusMessage* handle_role_switch_req(DBusMessage *msg, void *data)
Index: hcid/dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.2
diff -u -r1.2 dbus.h
--- hcid/dbus.h	13 Oct 2005 09:36:00 -0000	1.2
+++ hcid/dbus.h	17 Oct 2005 19:44:22 -0000
@@ -135,7 +135,6 @@
 
 #define HCI_INQ_SIGNATURE				DBUS_TYPE_BYTE_AS_STRING\
 							DBUS_TYPE_BYTE_AS_STRING\
-							DBUS_TYPE_UINT16_AS_STRING\
 							__END_SIG__
 
 #define HCI_ROLE_SWITCH_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\

--ReaqsoxgOBHFXBhH--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
