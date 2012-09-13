Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v5 15/17] heartrate: Add GetProperties method
Date: Thu, 13 Sep 2012 16:31:49 +0200
Message-ID: <1347546711-19961-16-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347546711-19961-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347546711-19961-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

---
 profiles/heartrate/heartrate.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 48d3cd1..43f94c1 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -104,6 +104,25 @@ struct watcher {
 
 static GSList *heartrate_adapters = NULL;
 
+static const char * const location_type[] = {
+	"Other",
+	"Chest",
+	"Wrist",
+	"Finger",
+	"Hand",
+	"Earlobe",
+	"Foot"
+};
+
+static const gchar *location2str(uint8_t value)
+{
+	 if (value < G_N_ELEMENTS(location_type))
+		return location_type[value];
+
+	error("Location type %d reserved for future use", value);
+	return NULL;
+}
+
 static gint cmp_adapter(gconstpointer a, gconstpointer b)
 {
 	const struct heartrate_adapter *hra = a;
@@ -410,6 +429,41 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct heartrate *hr = data;
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
+	if (hr->has_location) {
+		char *loc = g_strdup(location2str(hr->location));
+
+		dict_append_entry(&dict, "Location", DBUS_TYPE_STRING, &loc);
+
+		g_free(loc);
+	}
+
+	dict_append_entry(&dict, "ResetSupported", DBUS_TYPE_BOOLEAN,
+							&hr->has_cp_reset);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
 static gint process_att_reset(struct heartrate *hr)
 {
 	struct characteristic *ch;
@@ -458,6 +512,9 @@ static const GDBusMethodTable heartrate_manager_methods[] = {
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

