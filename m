Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Revert "gdbus: Don't include just added interfaces in GetManagedObjects"
Date: Mon, 11 Aug 2014 17:58:37 +0300
Message-Id: <1407769117-21353-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This actually creates a problem since the code now does flush any pending
message on the queue any signal will be send right away before the
actual reply to GetManagedObjects which will not contain those interfaces.
---
 gdbus/object.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 13cf9a9..4d5a64c 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1088,7 +1088,6 @@ static const GDBusMethodTable introspect_methods[] = {
 static void append_interfaces(struct generic_data *data, DBusMessageIter *iter)
 {
 	DBusMessageIter array;
-	GSList *l;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -1100,12 +1099,7 @@ static void append_interfaces(struct generic_data *data, DBusMessageIter *iter)
 				DBUS_DICT_ENTRY_END_CHAR_AS_STRING
 				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
 
-	for (l = data->interfaces; l != NULL; l = l->next) {
-		if (g_slist_find(data->added, l->data))
-			continue;
-
-		append_interface(l->data, &array);
-	}
+	g_slist_foreach(data->interfaces, append_interface, &array);
 
 	dbus_message_iter_close_container(iter, &array);
 }
-- 
1.9.3

