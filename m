Return-Path: <cyrus@holtmann.org>
From: "wu.zheng" <wu.zheng@intel.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: "wu.zheng" <wu.zheng@intel.com>
Subject: [PATCH] Modify the condition of removing filters of dbus at filter_data_remove_callback and message_filter in file gdbus/watch.c
Date: Fri, 29 Apr 2011 12:48:15 +0800
Message-Id: <1304052495-9650-1-git-send-email-wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Otherwise, removing filter will run twice when using g_dbus_add_signal_watch with sender and cause dbus remove filter error and crash.The result is that g_dbus_add_signal_watch will inovke g_dbus_add_service_watch if the param of sender of g_dbus_add_signal_watch is avaliable and add two callback and only add a dbus filter, which result in the func of g_dbus_remove_watch will remove dbus filter twice. When using telephony-ofono for telephony, add_watch will add signal watch with sender at telephony_init and remove_watch will be inovked at telephony_exit in file audio/telephony-ofono.c, which result in bluez crash when using telephony-ofono.c.
---
 gdbus/watch.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index fba58c3..1304083 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -266,15 +266,16 @@ static struct filter_callback *filter_data_find_callback(
 	return NULL;
 }
 
-static void filter_data_free(struct filter_data *data)
+static gboolean filter_data_free(struct filter_data *data)
 {
 	GSList *l;
+        gboolean watch_removed;
 
 	for (l = data->callbacks; l != NULL; l = l->next)
 		g_free(l->data);
 
 	g_slist_free(data->callbacks);
-	g_dbus_remove_watch(data->connection, data->name_watch);
+	watch_removed = g_dbus_remove_watch(data->connection, data->name_watch);
 	g_free(data->name);
 	g_free(data->owner);
 	g_free(data->path);
@@ -283,6 +284,8 @@ static void filter_data_free(struct filter_data *data)
 	g_free(data->argument);
 	dbus_connection_unref(data->connection);
 	g_free(data);
+
+        return watch_removed;
 }
 
 static void filter_data_call_and_free(struct filter_data *data)
@@ -350,6 +353,8 @@ static gboolean filter_data_remove_callback(struct filter_data *data,
 						struct filter_callback *cb)
 {
 	DBusConnection *connection;
+        guint name_watch;
+        gboolean watch_removed;
 
 	data->callbacks = g_slist_remove(data->callbacks, cb);
 	data->processed = g_slist_remove(data->processed, cb);
@@ -375,13 +380,14 @@ static gboolean filter_data_remove_callback(struct filter_data *data,
 		return FALSE;
 
 	connection = dbus_connection_ref(data->connection);
+        name_watch = data->name_watch;
 	listeners = g_slist_remove(listeners, data);
-	filter_data_free(data);
+	watch_removed = filter_data_free(data);
 
 	/* Remove filter if there are no listeners left for the connection */
 	data = filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
 					NULL);
-	if (data == NULL)
+	if (data == NULL && (name_watch == 0 || watch_removed == FALSE))
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);
 
@@ -502,6 +508,8 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 {
 	struct filter_data *data;
 	const char *sender, *path, *iface, *member, *arg = NULL;
+        guint name_watch;
+        gboolean watch_removed;
 
 	/* Only filter signals */
 	if (dbus_message_get_type(message) != DBUS_MESSAGE_TYPE_SIGNAL)
@@ -536,13 +544,14 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 
 	remove_match(data);
 
+        name_watch = data->name_watch;
 	listeners = g_slist_remove(listeners, data);
-	filter_data_free(data);
+	watch_removed = filter_data_free(data);
 
 	/* Remove filter if there no listener left for the connection */
 	data = filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
 					NULL);
-	if (data == NULL)
+	if (data == NULL && (name_watch == 0 || watch_removed == FALSE))
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);
 
-- 
1.7.3.4

