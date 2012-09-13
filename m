Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v4 15/17] heartrate: Add GetProperties method
Date: Thu, 13 Sep 2012 14:13:19 +0200
Message-ID: <1347538401-6417-16-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

Change-Id: I56d9fd06aeb9a37451f31257380e0f6d0ed409f2
---
 profiles/heartrate/heartrate.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 8fec7e7..0e9c80f 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -433,6 +433,34 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+
+static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct heartrate_device *hrdev = data;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *reply;
+
+	reply = dbus_message_new_method_return(msg);
+	if (reply == NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "ResetSupported", DBUS_TYPE_BOOLEAN,
+							&hrdev->has_cp_reset);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
 static gint process_att_reset(struct heartrate_device *hrdev)
 {
 	struct characteristic *ch;
@@ -481,6 +509,9 @@ static const GDBusMethodTable heartrate_manager_methods[] = {
 };
 
 static const GDBusMethodTable heartrate_device_methods[] = {
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
 	{ GDBUS_METHOD("Reset", NULL, NULL,
 			control_point_reset) },
 	{ }
-- 
1.7.11.3

