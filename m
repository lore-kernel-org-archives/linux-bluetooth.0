Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C3552F.8000505@suse.de>
Date: Wed, 15 Aug 2007 21:34:07 +0200
From: Tom Patzig <tpatzig@suse.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------060304000800050803030701"
Subject: [Bluez-devel] ListTrust Method for org.bluez.Service
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
--------------060304000800050803030701
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

to not only get listed the global trusted devices, which also depends on 
your adapter (/var/lib/%mac/trusts), there is no method for the service 
interface to just list the trusted devices for this service 
(/var/lib/00::00::00::00::00::00/trusts).
Also, when you set trusts with the service interface to single services, 
then you won't see this trusts with the adapter ListTrusts.

I have written a method, according to the list_trusted method of the 
adapter interface.
So with this, u can do for example calls to only get the trusted input 
devices.
For the implemantation in the GUI frontend, it would be great to have 
this function within the next release.

What do you think?

-- 
--------------------------------------------
Tom Patzig <tpatzig@suse.de>
Novell /  SUSE
SUSE LINUX Products GmbH - Nürnberg - AG Nürnberg - HRB 16746 - GF: Markus Rex


--------------060304000800050803030701
Content-Type: text/x-patch;
 name="service_listTrusted.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="service_listTrusted.diff"

--- hcid/dbus-service.c
+++ hcid/dbus-service.c
@@ -566,6 +566,39 @@
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
+
+
+}
+
 static DBusHandlerResult is_trusted(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -639,6 +672,7 @@
 	{ "SetTrusted",		set_trusted,		"s",	""	},
 	{ "IsTrusted",		is_trusted,		"s",	"b"	},
 	{ "RemoveTrust",	remove_trust,		"s",	""	},
+	{ "ListTrust",		list_trusted,		"",	"as"	},
 	{ NULL, NULL, NULL, NULL }
 };
 

--------------060304000800050803030701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--------------060304000800050803030701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------060304000800050803030701--
