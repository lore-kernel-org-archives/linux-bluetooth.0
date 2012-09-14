Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v0 4/4] cups: Free D-Bus error
Date: Fri, 14 Sep 2012 21:40:11 +0530
Message-id: <1347639011-22924-4-git-send-email-s.syam@samsung.com>
In-reply-to: <1347639011-22924-1-git-send-email-s.syam@samsung.com>
References: <1347639011-22924-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If D-Bus error is set we should free it.
---
 profiles/cups/main.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index a884c6e..5aa927f 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -446,8 +446,10 @@ static gboolean list_known_printers(const char *adapter)
 
 	dbus_message_unref(message);
 
-	if (dbus_error_is_set(&error))
+	if (dbus_error_is_set(&error)) {
+		dbus_error_free(&error);
 		return FALSE;
+	}
 
 	dbus_message_iter_init(reply, &reply_iter);
 	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_ARRAY) {
@@ -549,8 +551,10 @@ static gboolean list_printers(void)
 
 	dbus_error_init(&error);
 	hcid_exists = dbus_bus_name_has_owner(conn, "org.bluez", &error);
-	if (dbus_error_is_set(&error))
+	if (dbus_error_is_set(&error)) {
+		dbus_error_free(&error);
 		return TRUE;
+	}
 
 	if (!hcid_exists)
 		return TRUE;
@@ -570,6 +574,7 @@ static gboolean list_printers(void)
 	dbus_message_unref(message);
 
 	if (dbus_error_is_set(&error)) {
+		dbus_error_free(&error);
 		dbus_connection_unref(conn);
 		/* No adapter */
 		return TRUE;
-- 
1.7.4.1

