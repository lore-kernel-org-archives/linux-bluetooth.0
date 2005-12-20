Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Filippo Giunchedi <filippo@esaurito.net>
Message-ID: <pan.2005.12.20.13.54.45.442703@esaurito.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] [PATCH]
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
Date: Tue, 20 Dec 2005 14:54:46 +0100

Hi,
dbus 0.60 has removed the DBUS_NAME_FLAG_PROHIBIT_REPLACEMENT flag for
dbus_bus_request_name and now that is the default behaviour, the following
patch should work:

--- dbus.c      (revision 116)
+++ dbus.c      (working copy)
@@ -874,7 +874,7 @@
        dbus_connection_set_exit_on_disconnect(connection, FALSE);

        dbus_bus_request_name(connection, BASE_INTERFACE,
-                               DBUS_NAME_FLAG_PROHIBIT_REPLACEMENT, &error);
+                               0, &error);

        if (dbus_error_is_set(&error)) {
                syslog(LOG_ERR, "Can't get system message bus name: %s",


unfortunately I can't find a DBUS_VERSION #define to be backward
compatible with dbus < 0.60


filippo



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
