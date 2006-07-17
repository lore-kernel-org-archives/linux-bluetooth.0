Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 17 Jul 2006 19:16:19 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060717181619.GA27519@srcf.ucam.org>
References: <20060711193859.GA3569@srcf.ucam.org>
	<1152747138.17416.10.camel@localhost>
Mime-Version: 1.0
In-Reply-To: <1152747138.17416.10.camel@localhost>
Subject: Re: [Bluez-devel] [Patch] Add dbus method for obtaining
	RFCOMM	channels
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

Ok. How about this? It doesn't deal with the caching problem, but with 
luck that's possible without breaking the API and this ought to deal 
with the most common case. I've also changed dbus-api.txt to match what 
the code appears to do. Only compile-tested - I want to check if people 
are happy with the basic approach before writing any code to do anything 
with this :)

Index: dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.39
diff -u -r1.39 dbus-api.txt
--- dbus-api.txt	26 Jun 2006 12:33:13 -0000	1.39
+++ dbus-api.txt	17 Jul 2006 18:13:26 -0000
@@ -887,11 +887,11 @@
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
@@ -899,11 +899,7 @@
 			If the application disconnects from the D-Bus this
 			connection will be terminated.
 
-			Valid service values: "vcp", "map", "pbap", "sap",
-			                      "ftp", "bpp", "bip", "synch",
-			                      "dun", "opp", "fax", "spp"
-
-		void CancelConnect(string address, string service)
+		void CancelConnect(string address, int service)
 
 			This method cancels a previous Connect method call.
 
@@ -963,13 +959,13 @@
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
+++ dbus-rfcomm.c	17 Jul 2006 18:13:27 -0000
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
+	rec = find_record (service);
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
+	rec = find_record (service);
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
Index: dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.94
diff -u -r1.94 dbus.h
--- dbus.h	10 Jul 2006 19:23:14 -0000	1.94
+++ dbus.h	17 Jul 2006 18:13:27 -0000
@@ -199,4 +199,6 @@
 
 int discoverable_timeout_handler(void *data);
 
+sdp_record_t *find_record(uint32_t identifier);
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
