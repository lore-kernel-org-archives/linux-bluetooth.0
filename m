Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ v4 11/15] gdbus: Integrates ObjectManager with Properties interface
Date: Thu,  4 Oct 2012 04:26:35 -0300
Message-Id: <1349335599-12443-12-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This appends the properties and its values when using ObjectManager.
---
 gdbus/object.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index e96a2bf..066f1a6 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -496,10 +496,28 @@ static void reset_parent(gpointer data, gpointer user_data)
 	child->parent = parent;
 }
 
+static void append_property(struct interface_data *iface,
+			const GDBusPropertyTable *p, DBusMessageIter *dict)
+{
+	DBusMessageIter entry, value;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+								&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &p->name);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, p->type,
+								&value);
+
+	p->get(p, &value, iface->user_data);
+
+	dbus_message_iter_close_container(&entry, &value);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
 static void append_properties(struct interface_data *data,
 							DBusMessageIter *iter)
 {
 	DBusMessageIter dict;
+	const GDBusPropertyTable *p;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -507,7 +525,15 @@ static void append_properties(struct interface_data *data,
 				DBUS_TYPE_VARIANT_AS_STRING
 				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	/* TODO: list properties */
+	for (p = data->properties; p && p->name; p++) {
+		if (p->get == NULL)
+			continue;
+
+		if (p->exists != NULL && !p->exists(p, data->user_data))
+			continue;
+
+		append_property(data, p, &dict);
+	}
 
 	dbus_message_iter_close_container(iter, &dict);
 }
-- 
1.7.12.2

