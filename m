Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 2/2] gdbus: Refactor filter_data_find()
Date: Tue, 25 Sep 2012 16:28:08 -0300
Message-Id: <1348601288-18975-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1348601288-18975-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1348601288-18975-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now this function is only used for searching the listeners of a
connection and the other parameters are not needed anymore.
---
 gdbus/watch.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 33c12ed..c4066c0 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -119,13 +119,7 @@ static struct filter_data *filter_data_find_nonnull(DBusConnection *connection,
 	return NULL;
 }
 
-static struct filter_data *filter_data_find(DBusConnection *connection,
-							const char *name,
-							const char *owner,
-							const char *path,
-							const char *interface,
-							const char *member,
-							const char *argument)
+static struct filter_data *filter_data_find(DBusConnection *connection)
 {
 	GSList *current;
 
@@ -136,30 +130,6 @@ static struct filter_data *filter_data_find(DBusConnection *connection,
 		if (connection != data->connection)
 			continue;
 
-		if (name && data->name &&
-				g_str_equal(name, data->name) == FALSE)
-			continue;
-
-		if (owner && data->owner &&
-				g_str_equal(owner, data->owner) == FALSE)
-			continue;
-
-		if (path && data->path &&
-				g_str_equal(path, data->path) == FALSE)
-			continue;
-
-		if (interface && data->interface &&
-				g_str_equal(interface, data->interface) == FALSE)
-			continue;
-
-		if (member && data->member &&
-				g_str_equal(member, data->member) == FALSE)
-			continue;
-
-		if (argument && data->argument &&
-				g_str_equal(argument, data->argument) == FALSE)
-			continue;
-
 		return data;
 	}
 
@@ -245,7 +215,7 @@ static struct filter_data *filter_data_get(DBusConnection *connection,
 	struct filter_data *data;
 	const char *name = NULL, *owner = NULL;
 
-	if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL, NULL) == NULL) {
+	if (filter_data_find(connection) == NULL) {
 		if (!dbus_connection_add_filter(connection,
 					message_filter, NULL, NULL)) {
 			error("dbus_connection_add_filter() failed");
@@ -419,8 +389,7 @@ static gboolean filter_data_remove_callback(struct filter_data *data,
 	listeners = g_slist_remove(listeners, data);
 
 	/* Remove filter if there are no listeners left for the connection */
-	if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
-								NULL) == NULL)
+	if (filter_data_find(connection) == NULL)
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);
 
@@ -613,8 +582,7 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 	g_slist_free(delete_listener);
 
 	/* Remove filter if there are no listeners left for the connection */
-	if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
-								NULL) == NULL)
+	if (filter_data_find(connection) == NULL)
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);
 
@@ -810,8 +778,7 @@ void g_dbus_remove_all_watches(DBusConnection *connection)
 {
 	struct filter_data *data;
 
-	while ((data = filter_data_find(connection, NULL, NULL, NULL, NULL,
-					NULL, NULL))) {
+	while ((data = filter_data_find(connection))) {
 		listeners = g_slist_remove(listeners, data);
 		filter_data_call_and_free(data);
 	}
-- 
1.7.12.1

