Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] test: Convert mpris-player to use DBus properties interface
Date: Tue, 27 Nov 2012 14:51:24 +0200
Message-Id: <1354020685-17028-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
References: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/mpris-player.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/test/mpris-player.c b/test/mpris-player.c
index 13f5c85..7985cdd 100644
--- a/test/mpris-player.c
+++ b/test/mpris-player.c
@@ -114,17 +114,18 @@ static void dict_append_entry(DBusMessageIter *dict, const char *key, int type,
 	dbus_message_iter_close_container(dict, &entry);
 }
 
-static dbus_bool_t emit_property_changed(DBusConnection *conn,
+static dbus_bool_t emit_properties_changed(DBusConnection *conn,
 					const char *path,
 					const char *interface,
 					const char *name,
 					int type, void *value)
 {
 	DBusMessage *signal;
-	DBusMessageIter iter;
+	DBusMessageIter iter, dict, entry, array;
 	dbus_bool_t result;
 
-	signal = dbus_message_new_signal(path, interface, "PropertyChanged");
+	signal = dbus_message_new_signal(path, DBUS_INTERFACE_PROPERTIES,
+							"PropertiesChanged");
 
 	if (!signal) {
 		fprintf(stderr, "Unable to allocate new %s.PropertyChanged"
@@ -133,10 +134,23 @@ static dbus_bool_t emit_property_changed(DBusConnection *conn,
 	}
 
 	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &interface);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY, NULL,
+								&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &name);
+	append_variant(&entry, type, value);
+	dbus_message_iter_close_container(&dict, &entry);
 
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+	dbus_message_iter_close_container(&iter, &dict);
 
-	append_variant(&iter, type, value);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &array);
+	dbus_message_iter_close_container(&iter, &array);
 
 	result = dbus_connection_send(conn, signal, NULL);
 	dbus_message_unref(signal);
@@ -171,7 +185,7 @@ static int parse_property(DBusConnection *conn, const char *path,
 			dict_append_entry(properties, "Status",
 						DBUS_TYPE_STRING, &value);
 		else
-			emit_property_changed(sys, path,
+			emit_properties_changed(sys, path,
 					"org.bluez.MediaPlayer", "Status",
 					DBUS_TYPE_STRING, &value);
 	} else if (strcasecmp(key, "Position") == 0) {
@@ -188,7 +202,7 @@ static int parse_property(DBusConnection *conn, const char *path,
 			dict_append_entry(properties, "Position",
 						DBUS_TYPE_UINT32, &msec);
 		else
-			emit_property_changed(sys, path,
+			emit_properties_changed(sys, path,
 					"org.bluez.MediaPlayer", "Position",
 					DBUS_TYPE_UINT32, &msec);
 	} else if (strcasecmp(key, "Shuffle") == 0) {
@@ -206,9 +220,9 @@ static int parse_property(DBusConnection *conn, const char *path,
 			dict_append_entry(properties, "Shuffle",
 						DBUS_TYPE_STRING, &str);
 		else
-			emit_property_changed(sys, path,
+			emit_properties_changed(sys, path,
 					"org.bluez.MediaPlayer", "Shuffle",
-					DBUS_TYPE_UINT32, &str);
+					DBUS_TYPE_STRING, &str);
 	}
 
 	return 0;
-- 
1.7.11.7

