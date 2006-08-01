Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 1 Aug 2006 13:29:02 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/pszE2Hw5V2Fehv"
Message-Id: <200608011329.03106.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] Patch: GetRemoteClass
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_/pszE2Hw5V2Fehv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All,

Attached is a patch to get remote class of device information as a uint32.  
This introduces a new method with signature:
uint32 GetRemoteClass(string address), which returns the class of device 
information encoded as a 32 bit integer.

The reasoning is that some applications might want to rely on their own 
conversion routines for the Major, Minor and Service class attributes, and 
thus the DBUS GetRemoteMajorClass, GetRemoteMinorClass, etc methods that 
return strings are not useful.

Thoughts?

-Denis



--Boundary-00=_/pszE2Hw5V2Fehv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bluez.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez.patch"

Index: dbus-adapter.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-adapter.c,v
retrieving revision 1.67
diff -u -r1.67 dbus-adapter.c
--- dbus-adapter.c	26 Jul 2006 13:57:50 -0000	1.67
+++ dbus-adapter.c	1 Aug 2006 03:24:10 -0000
@@ -1276,6 +1276,26 @@
 	return send_reply_and_unref(conn, reply);
 }
 
+static DBusHandlerResult handle_dev_get_remote_class_req(DBusConnection *conn,
+								DBusMessage *msg,
+								void *data)
+{
+	DBusMessage *reply;
+	uint32_t class;
+
+	if (get_remote_class(conn, msg, data, &class) < 0)
+		return DBUS_HANDLER_RESULT_HANDLED;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	dbus_message_append_args(reply, DBUS_TYPE_UINT32, &class,
+					DBUS_TYPE_INVALID);
+
+	return send_reply_and_unref(conn, reply);
+}
+
 static DBusHandlerResult handle_dev_get_remote_name_req(DBusConnection *conn, DBusMessage *msg, void *data)
 {
 	char filename[PATH_MAX + 1];
@@ -2333,6 +2353,7 @@
 	{ "GetRemoteMajorClass",			handle_dev_get_remote_major_class_req	},
 	{ "GetRemoteMinorClass",			handle_dev_get_remote_minor_class_req	},
 	{ "GetRemoteServiceClasses",			handle_dev_get_remote_service_cls_req	},
+	{ "GetRemoteClass",				handle_dev_get_remote_class_req		},
 	{ "GetRemoteName",				handle_dev_get_remote_name_req		},
 	{ "GetRemoteAlias",				handle_dev_get_remote_alias_req		},
 	{ "SetRemoteAlias",				handle_dev_set_remote_alias_req		},
Index: dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.39
diff -u -r1.39 dbus-api.txt
--- dbus-api.txt	26 Jun 2006 12:33:13 -0000	1.39
+++ dbus-api.txt	1 Aug 2006 03:24:10 -0000
@@ -461,6 +461,14 @@
 			Possible errors: org.bluez.Error.InvalidArguments
 			                 org.bluez.Error.NotAvailable
 
+		uint32 GetRemoteClass(string address)
+
+			Get the remote major, minor, and service classes 
+			encoded as 32 bit integer.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotAvailable
+
 		string GetRemoteName(string address)
 
 			Get adapter name for a remote device. This request

--Boundary-00=_/pszE2Hw5V2Fehv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_/pszE2Hw5V2Fehv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_/pszE2Hw5V2Fehv--
