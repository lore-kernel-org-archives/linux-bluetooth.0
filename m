Return-Path: <cyrus@holtmann.org>
Subject: [PATCHes] CUPS fixes
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-vAP+n9vEwQJUqCYygNFO"
Date: Tue, 11 Aug 2009 12:27:29 +0100
Message-Id: <1249990049.2022.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-vAP+n9vEwQJUqCYygNFO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The CUPS backend would be aborting when scanning for a printer that's
not in bluetoothd known devices. Fixes both bugs I found in my testing.

Cheers

--=-vAP+n9vEwQJUqCYygNFO
Content-Disposition: attachment; filename="0001-Don-t-abort-cups-backend-on-property-change.patch"
Content-Type: text/x-patch; name="0001-Don-t-abort-cups-backend-on-property-change.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 35ffd5a6dafd7e38c7d8c9502608314a44919302 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 11 Aug 2009 12:23:39 +0100
Subject: [PATCH 1/2] Don't abort cups backend on property change

Make sure the cups backend doesn't abort when trying to
access a property that's not Discovering.
---
 cups/main.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/cups/main.c b/cups/main.c
index 2fbfe7e..9c24734 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -506,6 +506,9 @@ static DBusHandlerResult filter_func(DBusConnection *connection, DBusMessage *me
 
 		dbus_message_iter_init(message, &iter);
 		dbus_message_iter_get_basic(&iter, &name);
+		if (name == NULL ||
+		    strcmp(name, "Discovering") != 0)
+		    	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 		dbus_message_iter_next(&iter);
 		dbus_message_iter_recurse(&iter, &value_iter);
 		dbus_message_iter_get_basic(&value_iter, &discovering);
-- 
1.6.2.5


--=-vAP+n9vEwQJUqCYygNFO
Content-Disposition: attachment; filename="0002-Actually-read-the-CreateDevice-reply.patch"
Content-Type: text/x-patch; name="0002-Actually-read-the-CreateDevice-reply.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From b29e1cb433454391da92720c3ff87373d9d60500 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 11 Aug 2009 12:24:58 +0100
Subject: [PATCH 2/2] Actually read the CreateDevice reply

Fixes aborts when the printer isn't a known device.
---
 cups/main.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cups/main.c b/cups/main.c
index 9c24734..ba9864f 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -371,9 +371,9 @@ static void remote_device_found(const char *adapter, const char *bdaddr, const c
 
 		if (!reply)
 			return;
-	} else {
-		if (dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &object_path, DBUS_TYPE_INVALID) == FALSE)
-			return;
+	}
+	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &object_path, DBUS_TYPE_INVALID) == FALSE) {
+		return;
 	}
 
 	id = device_get_ieee1284_id(adapter, object_path);
-- 
1.6.2.5


--=-vAP+n9vEwQJUqCYygNFO--

