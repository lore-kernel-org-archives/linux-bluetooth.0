Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ v4 12/15] gdbus: Simplify code for appending properties
Date: Thu,  4 Oct 2012 04:26:36 -0300
Message-Id: <1349335599-12443-13-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reuse append_properties for GetAll and GetManagedObjects
---
 gdbus/object.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 066f1a6..bb0aa4d 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -784,9 +784,8 @@ static DBusMessage *properties_get_all(DBusConnection *connection,
 {
 	struct generic_data *data = user_data;
 	struct interface_data *iface;
-	const GDBusPropertyTable *p;
 	const char *interface;
-	DBusMessageIter iter, dict;
+	DBusMessageIter iter;
 	DBusMessage *reply;
 
 	if (!dbus_message_get_args(message, NULL,
@@ -804,37 +803,8 @@ static DBusMessage *properties_get_all(DBusConnection *connection,
 		return NULL;
 
 	dbus_message_iter_init_append(reply, &iter);
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	for (p = iface->properties; p && p->name; p++) {
-		DBusMessageIter entry, value;
-
-		if (p->get == NULL)
-			continue;
-
-		if (p->exists != NULL && !p->exists(p, iface->user_data))
-			continue;
-
-		dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
-								NULL, &entry);
-		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
-								p->name);
-		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
-							p->type, &value);
-
-		if (!p->get(p, &value, iface->user_data)) {
-			dbus_message_unref(reply);
-			return NULL;
-		}
-
-		dbus_message_iter_close_container(&entry, &value);
-		dbus_message_iter_close_container(&dict, &entry);
-	}
 
-	dbus_message_iter_close_container(&iter, &dict);
+	append_properties(iface, &iter);
 
 	return reply;
 }
-- 
1.7.12.2

