Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 11/12] client: Replace parameter dict with conventional ones
Date: Mon, 21 May 2012 11:07:13 +0200
Message-Id: <1337591234-24919-12-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 client/manager.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index 94bcbdf..9bb1465 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -105,8 +105,7 @@ done:
 }
 
 static int parse_device_dict(DBusMessageIter *iter,
-		const char **source, const char **dest, const char **target,
-		uint8_t *channel)
+		const char **source, const char **target, uint8_t *channel)
 {
 	while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter entry, value;
@@ -122,8 +121,6 @@ static int parse_device_dict(DBusMessageIter *iter,
 		case DBUS_TYPE_STRING:
 			if (g_str_equal(key, "Source") == TRUE)
 				dbus_message_iter_get_basic(&value, source);
-			else if (g_str_equal(key, "Destination") == TRUE)
-				dbus_message_iter_get_basic(&value, dest);
 			else if (g_str_equal(key, "Target") == TRUE)
 				dbus_message_iter_get_basic(&value, target);
 			break;
@@ -163,9 +160,20 @@ static DBusMessage *create_session(DBusConnection *connection,
 	uint8_t channel = 0;
 
 	dbus_message_iter_init(message, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&iter, &dest);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
 	dbus_message_iter_recurse(&iter, &dict);
 
-	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	parse_device_dict(&dict, &source, &target, &channel);
 	if (dest == NULL || target == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -223,7 +231,7 @@ static DBusMessage *remove_session(DBusConnection *connection,
 
 static const GDBusMethodTable client_methods[] = {
 	{ GDBUS_ASYNC_METHOD("CreateSession",
-			GDBUS_ARGS({ "devices", "a{sv}" }),
+			GDBUS_ARGS({ "destination", "s" }, { "args", "a{sv}" }),
 			GDBUS_ARGS({ "session", "o" }), create_session) },
 	{ GDBUS_ASYNC_METHOD("RemoveSession",
 			GDBUS_ARGS({ "session", "o" }), NULL, remove_session) },
-- 
1.7.7.6

