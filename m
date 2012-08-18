Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v3 05/15] gdbus: Implement DBus.Properties.GetAll method
Date: Sat, 18 Aug 2012 03:50:52 -0300
Message-Id: <1345272662-2850-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 2ad32c0..50b6dc2 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -576,7 +576,61 @@ static DBusMessage *properties_get(DBusConnection *connection,
 static DBusMessage *properties_get_all(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	return NULL;
+	struct generic_data *data = user_data;
+	struct interface_data *iface;
+	const GDBusPropertyTable *p;
+	const char *interface;
+	DBusMessageIter iter, dict;
+	DBusMessage *reply;
+
+	if (!dbus_message_get_args(message, NULL,
+					DBUS_TYPE_STRING, &interface,
+					DBUS_TYPE_INVALID))
+		return NULL;
+
+	iface = find_interface(data->interfaces, interface);
+	if (iface == NULL)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"No such interface '%s'", interface);
+
+	reply = dbus_message_new_method_return(message);
+	if (reply == NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	for (p = iface->properties; p && p->name; p++) {
+		DBusMessageIter entry, value;
+
+		if (p->get == NULL)
+			continue;
+
+		if (p->exists != NULL && !p->exists(p, iface->user_data))
+			continue;
+
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
+								NULL, &entry);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+								p->name);
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+							p->type, &value);
+
+		if (!p->get(p, &value, iface->user_data)) {
+			dbus_message_unref(reply);
+			return NULL;
+		}
+
+		dbus_message_iter_close_container(&entry, &value);
+		dbus_message_iter_close_container(&dict, &entry);
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
 }
 
 static DBusMessage *properties_set(DBusConnection *connection,
-- 
1.7.11.5

