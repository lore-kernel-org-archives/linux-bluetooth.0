Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 06/13] media: Add Properties stubs to Media interface
Date: Wed, 6 Jun 2012 18:06:04 +0200
Message-ID: <1338998771-18683-6-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add Properties stubs to Media interface.
---
 audio/media.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/audio/media.c b/audio/media.c
index cc8ac37..5010ea5 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1821,6 +1821,55 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct media_adapter *adapter = data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	GSList *l;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct media_adapter *adapter = data;
+	DBusMessageIter iter;
+	DBusMessageIter sub;
+	const char *property;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return btd_error_invalid_args(msg);
+	dbus_message_iter_recurse(&iter, &sub);
+
+	return btd_error_invalid_args(msg);
+}
+
 static const GDBusMethodTable media_methods[] = {
 	{ GDBUS_METHOD("RegisterEndpoint",
 		GDBUS_ARGS({ "endpoint", "o" }, { "properties", "a{sv}" }),
@@ -1833,6 +1882,11 @@ static const GDBusMethodTable media_methods[] = {
 		NULL, register_player) },
 	{ GDBUS_METHOD("UnregisterPlayer",
 		GDBUS_ARGS({ "player", "o" }), NULL, unregister_player) },
+	{ GDBUS_METHOD("GetProperties",
+		NULL, GDBUS_ARGS({ "properties", "a{sv}" }), get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+		GDBUS_ARGS({ "name", "s" }, { "value", "v" }),
+		NULL, set_property) },
 	{ },
 };
 
-- 
on behalf of ST-Ericsson

