Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH 11/13] heartrate: Add GetProperties method handle
Date: Thu, 9 Aug 2012 09:20:14 +0200
Message-ID: <1344496816-4641-12-git-send-email-rafal.garbat@tieto.com>
In-Reply-To: <1344496816-4641-1-git-send-email-rafal.garbat@tieto.com>
References: <1344496816-4641-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add method to return Heart Rate Service properties.

---
 profiles/heartrate/heartrate.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index a11733c..cfc2ee0 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -239,6 +239,33 @@ static struct descriptor *get_descriptor(struct characteristic *ch,
 	return l->data;
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
+	dict_append_entry(&dict, "ResetSupported", DBUS_TYPE_BOOLEAN,
+							&hr->cp_reset);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
 static void measurement_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
@@ -414,6 +441,9 @@ static DBusMessage *control_point_reset(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable heartrate_methods[] = {
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
 	{ GDBUS_METHOD("RegisterWatcher",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			watcher_register) },
-- 
1.7.9.5

