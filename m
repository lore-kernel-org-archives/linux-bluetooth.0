Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v7 11/13] heartrate: Add GetProperties method
Date: Fri, 21 Sep 2012 17:16:08 +0200
Message-ID: <1348240570-7532-12-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348240570-7532-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348240570-7532-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

---
 profiles/heartrate/heartrate.c | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index add34b8..81dd5cc 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -94,6 +94,25 @@ struct measurement {
 
 static GSList *heartrate_adapters = NULL;
 
+static const char * const location_enum[] = {
+	"Other",
+	"Chest",
+	"Wrist",
+	"Finger",
+	"Hand",
+	"Earlobe",
+	"Foot",
+};
+
+static const gchar *location2str(uint8_t value)
+{
+	 if (value < G_N_ELEMENTS(location_enum))
+		return location_enum[value];
+
+	error("Body Sensor Location [%d] is RFU", value);
+	return NULL;
+}
+
 static gint cmp_adapter(gconstpointer a, gconstpointer b)
 {
 	const struct heartrate_adapter *hradapter = a;
@@ -629,6 +648,45 @@ static const GDBusMethodTable heartrate_manager_methods[] = {
 	{ }
 };
 
+static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct heartrate *hr = data;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *reply;
+	gboolean has_reset;
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
+		if (loc) {
+			dict_append_entry(&dict, "Location",
+						DBUS_TYPE_STRING, &loc);
+			g_free(loc);
+		}
+	}
+
+	has_reset = !!hr->hrcp_val_handle;
+	dict_append_entry(&dict, "ResetSupported", DBUS_TYPE_BOOLEAN,
+								&has_reset);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
 static DBusMessage *hrcp_reset(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -653,6 +711,9 @@ static DBusMessage *hrcp_reset(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable heartrate_device_methods[] = {
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
 	{ GDBUS_METHOD("Reset", NULL, NULL,
 			hrcp_reset) },
 	{ }
-- 
1.7.11.3

