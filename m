Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] gdbus/watch: Fix aborting when removing D-Bus filter
Date: Mon,  9 Sep 2013 17:49:35 +0300
Message-Id: <1378738179-21047-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
References: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case of filter_data having a watch to a service name it may call
dbus_connection_remove_filter twice causing libdbus to abort:

process 24723: Attempt to remove filter function 0x4063e0 user data (nil), but no such filter has been added

To fix this the code will now only attempt to call
dbus_connection_remove_filter once in filter_data_free which is the
counterpart of filter_data_get where dbus_connection_add_filter is called.
---
 gdbus/watch.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index d334580..a918535 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -281,6 +281,11 @@ static void filter_data_free(struct filter_data *data)
 {
 	GSList *l;
 
+	/* Remove filter if there are no listeners left for the connection */
+	if (filter_data_find(data->connection) == NULL)
+		dbus_connection_remove_filter(data->connection, message_filter,
+									NULL);
+
 	for (l = data->callbacks; l != NULL; l = l->next)
 		g_free(l->data);
 
@@ -360,8 +365,6 @@ static void service_data_free(struct service_data *data)
 static gboolean filter_data_remove_callback(struct filter_data *data,
 						struct filter_callback *cb)
 {
-	DBusConnection *connection;
-
 	data->callbacks = g_slist_remove(data->callbacks, cb);
 	data->processed = g_slist_remove(data->processed, cb);
 
@@ -385,16 +388,8 @@ static gboolean filter_data_remove_callback(struct filter_data *data,
 	if (data->registered && !remove_match(data))
 		return FALSE;
 
-	connection = dbus_connection_ref(data->connection);
 	listeners = g_slist_remove(listeners, data);
-
-	/* Remove filter if there are no listeners left for the connection */
-	if (filter_data_find(connection) == NULL)
-		dbus_connection_remove_filter(connection, message_filter,
-						NULL);
-
 	filter_data_free(data);
-	dbus_connection_unref(connection);
 
 	return TRUE;
 }
@@ -563,6 +558,9 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 								current);
 	}
 
+	if (delete_listener == NULL)
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
 	for (current = delete_listener; current != NULL;
 					current = delete_listener->next) {
 		GSList *l = current->data;
@@ -581,11 +579,6 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 
 	g_slist_free(delete_listener);
 
-	/* Remove filter if there are no listeners left for the connection */
-	if (filter_data_find(connection) == NULL)
-		dbus_connection_remove_filter(connection, message_filter,
-						NULL);
-
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
@@ -814,6 +807,4 @@ void g_dbus_remove_all_watches(DBusConnection *connection)
 		listeners = g_slist_remove(listeners, data);
 		filter_data_call_and_free(data);
 	}
-
-	dbus_connection_remove_filter(connection, message_filter, NULL);
 }
-- 
1.8.3.1

