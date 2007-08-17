Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C5897A.9030806@suse.de>
Date: Fri, 17 Aug 2007 13:41:46 +0200
From: Tom Patzig <tpatzig@suse.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------060805060709040503080707"
Subject: [Bluez-devel] Service.ListTrusts()
Reply-To: tpatzig@suse.de,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060805060709040503080707
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

updated version of the patch.
    * removed ListUsers()
    * removed RemoveUser()
    * removed remove_user()
    * removed RemoveUser from dbus-api.txt
   
Tom

-- 
--------------------------------------------
Tom Patzig <tpatzig@suse.de>
Novell /  SUSE
SUSE LINUX Products GmbH - Nürnberg - AG Nürnberg - HRB 16746 - GF: Markus Rex


--------------060805060709040503080707
Content-Type: text/x-patch;
 name="service_listTrusted.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="service_listTrusted.diff"

--- hcid/dbus-api.txt
+++ hcid/dbus-api.txt
@@ -1193,15 +1193,10 @@
 			file. The Start and Stop methods are not applicable to
 			external services and will return an error.
 
-		array{string} ListUsers() [experimental]
+		array{string} ListTrusts()
 
-			Returns list of current users (device addresses)
-			of the service.
-
-		void RemoveUser(string address) [experimental]
-
-			Removes a user of the service. The address parameter
-			must match one of the current users of the service.
+			Returns a list of remote devices that are trusted
+			for the service.
 
 		void SetTrusted(string address) [experimental]
 
--- hcid/dbus-service.c
+++ hcid/dbus-service.c
@@ -525,18 +525,6 @@
 	return send_message_and_unref(conn, reply);
 }
 
-static DBusHandlerResult list_users(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-}
-
-static DBusHandlerResult remove_user(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-}
-
 static DBusHandlerResult set_trusted(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -566,6 +554,37 @@
 	return send_message_and_unref(conn, reply);
 }
 
+static DBusHandlerResult list_trusted(DBusConnection *conn,
+                                        DBusMessage *msg, void *data)
+{
+        struct service *service = data;
+        DBusMessage *reply;
+        GSList *trusts, *l;
+        char **addrs;
+        int len;
+
+        reply = dbus_message_new_method_return(msg);
+        if (!reply)
+                return DBUS_HANDLER_RESULT_NEED_MEMORY;
+        trusts = list_trusts(BDADDR_ANY, service->ident);
+
+        addrs = g_new(char *, g_slist_length(trusts));
+
+        for (l = trusts, len = 0; l; l = l->next, len++)
+                addrs[len] = l->data;
+
+        dbus_message_append_args(reply,
+                        DBUS_TYPE_ARRAY, DBUS_TYPE_STRING,
+                        &addrs, len,
+                        DBUS_TYPE_INVALID);
+
+        g_free(addrs);
+        g_slist_foreach(trusts, (GFunc) g_free, NULL);
+        g_slist_free(trusts);
+
+        return send_message_and_unref(conn, reply);
+}
+
 static DBusHandlerResult is_trusted(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -634,11 +653,10 @@
 	{ "Stop",		stop,			"",	""	},
 	{ "IsRunning",		is_running,		"",	"b"	},
 	{ "IsExternal",		is_external,		"",	"b"	},
-	{ "ListUsers",		list_users,		"",	"as"	},
-	{ "RemoveUser",		remove_user,		"s",	""	},
 	{ "SetTrusted",		set_trusted,		"s",	""	},
 	{ "IsTrusted",		is_trusted,		"s",	"b"	},
 	{ "RemoveTrust",	remove_trust,		"s",	""	},
+	{ "ListTrusts",		list_trusted,		"",	"as"	},
 	{ NULL, NULL, NULL, NULL }
 };
 

--------------060805060709040503080707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--------------060805060709040503080707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------060805060709040503080707--
