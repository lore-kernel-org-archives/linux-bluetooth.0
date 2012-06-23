Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ] gdbus: Fix removal of filter after last filter_data
Date: Sat, 23 Jun 2012 11:02:17 -0300
Message-Id: <1340460137-4279-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there's a signal watch that's also watching for name
(data->name_watch) currently we are trying to remove the message_filter
twice since we may have the following call chain:

filter_data_remove_callback()
  filter_data_free()
    g_dbus_remove_watch()
      filter_data_remove_callback()
	filter_data_free()
        dbus_connection_remove_filter()
  dbus_connection_remove_filter()

Because of this we can't currently watch for signals passing the bus
name. After this patch we don't have this issue anymore.

We fix this by checking if we are the last filter_data before calling
filter_data_free and thus not calling dbus_connection_remove_filter()
twice.
---
 gdbus/watch.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 9a716b0..6fed264 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -350,6 +350,7 @@ static gboolean filter_data_remove_callback(struct filter_data *data,
 						struct filter_callback *cb)
 {
 	DBusConnection *connection;
+	struct filter_data *data_next;
 
 	data->callbacks = g_slist_remove(data->callbacks, cb);
 	data->processed = g_slist_remove(data->processed, cb);
@@ -376,12 +377,17 @@ static gboolean filter_data_remove_callback(struct filter_data *data,
 
 	connection = dbus_connection_ref(data->connection);
 	listeners = g_slist_remove(listeners, data);
+
+	/*
+	 * filter_data_free() may remove the latest data - we need to check
+	 * before it runs if it's our duty to remove the filter
+	 */
+	data_next = filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
+									NULL);
 	filter_data_free(data);
 
 	/* Remove filter if there are no listeners left for the connection */
-	data = filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
-					NULL);
-	if (data == NULL)
+	if (data_next == NULL)
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);
 
-- 
1.7.11

