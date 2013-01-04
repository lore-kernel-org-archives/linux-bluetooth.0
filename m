Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ] gdbus: Don't include just added interfaces in GetManagedObjects
Date: Fri,  4 Jan 2013 01:33:44 -0200
Message-Id: <1357270424-24036-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we received a call to ObjectManager.GetManagedObject we should not
include in the response the interfaces in data->added. This is because
it's not guaranteed that those interfaces will trigger an
InterfacesAdded signal, which is the case if the interface is removed in
the same mainloop iteration.
---
 gdbus/object.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 2b6ae31..e569acb 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1064,6 +1064,7 @@ static const GDBusMethodTable introspect_methods[] = {
 static void append_interfaces(struct generic_data *data, DBusMessageIter *iter)
 {
 	DBusMessageIter array;
+	GSList *l;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -1075,7 +1076,12 @@ static void append_interfaces(struct generic_data *data, DBusMessageIter *iter)
 				DBUS_DICT_ENTRY_END_CHAR_AS_STRING
 				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
 
-	g_slist_foreach(data->interfaces, append_interface, &array);
+	for (l = data->interfaces; l != NULL; l = l->next) {
+		if (g_slist_find(data->added, l->data))
+			continue;
+
+		append_interface(l->data, &array);
+	}
 
 	dbus_message_iter_close_container(iter, &array);
 }
-- 
1.8.1

