Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 11 Jul 2006 20:39:00 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20060711193859.GA3569@srcf.ucam.org>
Mime-Version: 1.0
Subject: [Bluez-devel] [Patch] Add dbus method for obtaining RFCOMM channels
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

So, firstly, this is something that scratches an itch I have for hal 
integration. I'm entirely open to doing it in an entirely different way 
if people would prefer that.

This patch adds a GetRFCOMMChannel dbus method, allowing channels to be 
added to hal objects. An example use case would be a phone manager - 
having the channel means that it can simply call a few dbus methods and 
then have a serial device.

===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-sdp.c,v
retrieving revision 1.6
diff -u -r1.6 dbus-sdp.c
--- dbus-sdp.c	27 Jun 2006 07:33:37 -0000	1.6
+++ dbus-sdp.c	11 Jul 2006 19:30:50 -0000
@@ -929,6 +929,38 @@
 	return send_reply_and_unref(conn, reply);
 }
 
+
+static DBusHandlerResult get_rfcomm_channel(DBusConnection *conn,
+					    DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	sdp_record_t *rec;
+	uint32_t identifier;
+	sdp_list_t *protos;
+	int channel;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_UINT32, &identifier,
+				DBUS_TYPE_INVALID))
+		return error_invalid_arguments(conn, msg);
+
+	rec = find_record(identifier);
+	if (!rec)
+		return error_record_does_not_exist(conn, msg);
+
+	reply = dbus_message_new_method_return(msg);
+	
+	if (sdp_get_access_protos(rec, &protos) == 0) {
+		channel = sdp_get_proto_port(protos, RFCOMM_UUID);
+	}
+
+	dbus_message_append_args(reply,
+			DBUS_TYPE_UINT32, &channel,
+			DBUS_TYPE_INVALID);
+
+	return send_reply_and_unref(conn, reply);
+}
+
 static DBusHandlerResult get_name(DBusConnection *conn,
 		DBusMessage *msg, void *data)
 {
@@ -1058,6 +1090,7 @@
 	{ "GetIdentifiersByService",	get_identifiers_by_service	},
 	{ "GetUUID",			get_uuid			},
 	{ "GetName",			get_name			},
+	{ "GetRFCOMMChannel",		get_rfcomm_channel		},
 	{ "RegisterRFCOMM",		register_rfcomm			},
 	{ "UnregisterRFCOMM",		unregister_rfcomm		},
 	{ NULL, NULL }

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
