Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 17 Aug 2006 11:06:04 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: bluez-devel@lists.sf.net
Message-ID: <20060817100604.GA3350@srcf.ucam.org>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] implement RFCOMM Connect and Disconnect
	methods
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I sent this a couple of weeks ago, but didn't get any feedback. This 
patch implements the Connect and Disconnect methods in the 
org.bluez.RFCOMM namespace. I've changed it to use integers for services 
rather than the string identifiers for a couple of reasons:

1) Nothing else seems to actually use the strings right now, even when 
the docs suggest they do
2) The service values don't appear to be complete and don't deal with 
the case of having multiple services of the same general type on a 
device

Based on previous discussion with Marcel, this patch may not be ideal 
since it doesn't deal with the case of the whether or not cached values 
are valid. However, if the API is considered correct, then it would be 
nice to add it with a note that it may not work under certain 
circumstances and then fix that at some later stage.

? .deps
? Makefile
? Makefile.in
Index: dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.40
diff -u -r1.40 dbus-api.txt
--- dbus-api.txt	9 Aug 2006 20:10:50 -0000	1.40
+++ dbus-api.txt	17 Aug 2006 09:55:18 -0000
@@ -895,11 +895,11 @@
 Interface	org.bluez.RFCOMM
 Object path	/org/bluez/{hci0,hci1,...}
 
-Methods		string Connect(string address, string service)
+Methods		string Connect(string address, int service)
 
 			This creates a connection to a remote RFCOMM based
-			service. The service string can either be a UUID-16,
-			a UUID-32, a UUID-128 or a service abbreviation.
+			service. The service should be a serviceid as 
+			provided by the org.bluez.SDP methods.
 
 			The return value will be the path of the newly
 			created RFCOMM TTY device (for example /dev/rfcomm0).
@@ -907,11 +907,7 @@
 			If the application disconnects from the D-Bus this
 			connection will be terminated.
 
-			Valid service values: "vcp", "map", "pbap", "sap",
-			                      "ftp", "bpp", "bip", "synch",
-			                      "dun", "opp", "fax", "spp"
-
-		void CancelConnect(string address, string service)
+		void CancelConnect(string address, int service)
 
 			This method cancels a previous Connect method call.
 
@@ -971,13 +967,13 @@
 Interface	org.bluez.SDP
 Object path	/org/bluez/{hci0,hci1,...}
 
-Methods		array{string} GetIdentifiers(string address)
+Methods		array{int} GetIdentifiers(string address)
 
-		array{string} GetIdentifiersByService(string address, string service)
+		array{int} GetIdentifiersByService(string address, string service)
 
-		string GetUUID(string identifier)
+		string GetUUID(int identifier)
 
-		string GetName(string identifier)
+		string GetName(int identifier)
 
 		string RegisterRFCOMM(string service, byte channel)
 
Index: dbus-rfcomm.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-rfcomm.c,v
retrieving revision 1.9
diff -u -r1.9 dbus-rfcomm.c
--- dbus-rfcomm.c	2 Jun 2006 10:27:57 -0000	1.9
+++ dbus-rfcomm.c	17 Aug 2006 09:55:19 -0000
@@ -38,6 +38,8 @@
 #include <bluetooth/rfcomm.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
 
 #include <dbus/dbus.h>
 
@@ -452,18 +454,87 @@
 	return node;
 }
 
-static DBusHandlerResult rfcomm_connect_req(DBusConnection *conn,
-						DBusMessage *msg, void *data)
+static DBusHandlerResult rfcomm_cancel_connect_req(DBusConnection *conn,
+						   DBusMessage *msg, void *data)
 {
-	error("RFCOMM.Connect not implemented");
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	const char *dst;
+	int ch = -1;
+	uint32_t service;
+	DBusMessage *reply;
+	struct pending_connect *pending;
+	sdp_record_t *rec;
+	sdp_list_t *protos;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_STRING, &dst,
+				DBUS_TYPE_UINT32, &service,
+				DBUS_TYPE_INVALID))
+		return error_invalid_arguments(conn, msg);
+
+	/* Now we need to find a channel */
+
+	rec = find_record (dst, service);
+	if (!rec)
+		return error_record_does_not_exist (conn, msg);
+
+	if (sdp_get_access_protos(rec, &protos) == 0)
+		ch = sdp_get_proto_port (protos, RFCOMM_UUID);
+
+	if (ch == -1)
+		return error_record_does_not_exist (conn, msg);
+
+	pending = find_pending_connect(dst, ch);
+	if (!pending)
+		return error_connect_not_in_progress(conn, msg);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	pending->canceled = 1;
+
+	return send_reply_and_unref(conn, reply);
 }
 
-static DBusHandlerResult rfcomm_cancel_connect_req(DBusConnection *conn,
-						DBusMessage *msg, void *data)
+static DBusHandlerResult rfcomm_connect_req(DBusConnection *conn,
+					    DBusMessage *msg, void *data)
 {
-	error("RFCOMM.CancelConnect not implemented");
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	bdaddr_t bdaddr;
+	const char *dst;
+	uint32_t service;
+	int ch = -1;
+	int err;
+	struct hci_dbus_data *dbus_data = data;
+	sdp_record_t *rec;
+	sdp_list_t *protos;
+
+	hci_devba(dbus_data->dev_id, &bdaddr);
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_STRING, &dst,
+				DBUS_TYPE_UINT32, &service,
+				DBUS_TYPE_INVALID))
+		return error_invalid_arguments(conn, msg);
+
+	/* Now we need to find a channel */
+
+	rec = find_record (dst, service);
+	if (!rec)
+		return error_record_does_not_exist (conn, msg);
+
+	if (sdp_get_access_protos(rec, &protos) == 0)
+		ch = sdp_get_proto_port (protos, RFCOMM_UUID);
+
+	if (ch == -1)
+		return error_record_does_not_exist (conn, msg);
+
+	if (find_pending_connect(dst, ch))
+		return error_connect_in_progress(conn, msg);
+
+	if (rfcomm_connect(conn, msg, &bdaddr, dst, NULL, ch, &err) < 0)
+		return error_failed(conn, msg, err);
+
+	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
 static DBusHandlerResult rfcomm_connect_by_ch_req(DBusConnection *conn,
Index: dbus-sdp.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-sdp.c,v
retrieving revision 1.8
diff -u -r1.8 dbus-sdp.c
--- dbus-sdp.c	1 Aug 2006 18:14:36 -0000	1.8
+++ dbus-sdp.c	17 Aug 2006 09:55:19 -0000
@@ -855,7 +855,7 @@
 
 }
 
-static sdp_record_t *find_record(const char *address, int id)
+sdp_record_t *find_record(const char *address, int id)
 {
 	struct slist *lp, *lr;
 	struct service_provider *p;
Index: dbus-test
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-test,v
retrieving revision 1.22
diff -u -r1.22 dbus-test
--- dbus-test	9 Aug 2006 20:10:50 -0000	1.22
+++ dbus-test	17 Aug 2006 09:55:19 -0000
@@ -45,6 +45,7 @@
              "ClearRemoteAlias",
              "LastSeen",
              "LastUsed",
+	     "ConnectRemoteDevice",
              "DisconnectRemoteDevice",
              "CreateBonding",
              "CancelBondingProcess",
@@ -343,9 +344,14 @@
                    print self.device.LastUsed(self.cmd_args[0])
                else:
                    print 'Usage: %s -i <dev> LastUsed address' % self.name
+           elif self.cmd == 'ConnectRemoteDevice':
+               if len(self.cmd_args) == 1:
+                   print self.device.ConnectRemoteDevice(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> ConnectRemoteDevice address' % self.name
            elif self.cmd == 'DisconnectRemoteDevice':
                if len(self.cmd_args) == 1:
-                   print self.device.LastUsed(self.cmd_args[0])
+                   print self.device.DisconnectRemoteDevice(self.cmd_args[0])
                else:
                    print 'Usage: %s -i <dev> DisconnectRemoteDevice address' % self.name
            elif self.cmd == 'CreateBonding':
Index: dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.96
diff -u -r1.96 dbus.h
--- dbus.h	16 Aug 2006 18:43:50 -0000	1.96
+++ dbus.h	17 Aug 2006 09:55:19 -0000
@@ -200,4 +200,6 @@
 
 int discoverable_timeout_handler(void *data);
 
+sdp_record_t *find_record(const char *address, int identifier);
+
 #endif /* __H_BLUEZ_DBUS_H__ */

-- 
Matthew Garrett | mjg59@srcf.ucam.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
