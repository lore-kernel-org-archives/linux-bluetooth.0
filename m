Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/10 v3] gdbus: Fix sending ObjectManager/Properties signals out of order
Date: Tue,  3 Sep 2013 14:21:12 +0300
Message-Id: <1378207279-14557-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
References: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In some cases the order of the messages is altered when a message is
sent without processing the pending signals first, currently this affect
client_check_order unit test:

/gdbus/client_check_order: **
ERROR:unit/test-gdbus-client.c:795:property_check_order: assertion failed: (g_strcmp0(string, "value1") == 0)

As can be observed the value of the property is not yet updated because the
signal it is still pending, once this fix is applied the test pass:

/gdbus/client_check_order: OK

Note that the flushing only works when g_dbus_send_message is used so
places where dbus_connection_send and other variants are called directly
may still change the order.
---
 gdbus/object.c | 69 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 2f8ef45..83fc4e6 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -86,6 +86,7 @@ struct property_data {
 
 static int global_flags = 0;
 static struct generic_data *root;
+static GSList *pending = NULL;
 
 static gboolean process_changes(gpointer user_data);
 static void process_properties_from_interface(struct generic_data *data,
@@ -599,7 +600,9 @@ static void emit_interfaces_added(struct generic_data *data)
 
 	dbus_message_iter_close_container(&iter, &array);
 
-	g_dbus_send_message(data->conn, signal);
+	/* Use dbus_connection_send to avoid recursive calls to g_dbus_flush */
+	dbus_connection_send(data->conn, signal, NULL);
+	dbus_message_unref(signal);
 }
 
 static struct interface_data *find_interface(GSList *interfaces,
@@ -640,6 +643,16 @@ static gboolean g_dbus_args_have_signature(const GDBusArgInfo *args,
 	return TRUE;
 }
 
+static void add_pending(struct generic_data *data)
+{
+	if (data->process_id > 0)
+		return;
+
+	data->process_id = g_idle_add(process_changes, data);
+
+	pending = g_slist_append(pending, data);
+}
+
 static gboolean remove_interface(struct generic_data *data, const char *name)
 {
 	struct interface_data *iface;
@@ -677,10 +690,7 @@ static gboolean remove_interface(struct generic_data *data, const char *name)
 	data->removed = g_slist_prepend(data->removed, iface->name);
 	g_free(iface);
 
-	if (data->process_id > 0)
-		return TRUE;
-
-	data->process_id = g_idle_add(process_changes, data);
+	add_pending(data);
 
 	return TRUE;
 }
@@ -976,14 +986,26 @@ static void emit_interfaces_removed(struct generic_data *data)
 
 	dbus_message_iter_close_container(&iter, &array);
 
-	g_dbus_send_message(data->conn, signal);
+	/* Use dbus_connection_send to avoid recursive calls to g_dbus_flush */
+	dbus_connection_send(data->conn, signal, NULL);
+	dbus_message_unref(signal);
+}
+
+static void remove_pending(struct generic_data *data)
+{
+	if (data->process_id > 0) {
+		g_source_remove(data->process_id);
+		data->process_id = 0;
+	}
+
+	pending = g_slist_remove(pending, data);
 }
 
 static gboolean process_changes(gpointer user_data)
 {
 	struct generic_data *data = user_data;
 
-	data->process_id = 0;
+	remove_pending(data);
 
 	if (data->added != NULL)
 		emit_interfaces_added(data);
@@ -1211,10 +1233,8 @@ done:
 		return TRUE;
 
 	data->added = g_slist_append(data->added, iface);
-	if (data->process_id > 0)
-		return TRUE;
 
-	data->process_id = g_idle_add(process_changes, data);
+	add_pending(data);
 
 	return TRUE;
 }
@@ -1494,6 +1514,21 @@ DBusMessage *g_dbus_create_reply(DBusMessage *message, int type, ...)
 	return reply;
 }
 
+static void g_dbus_flush(DBusConnection *connection)
+{
+	GSList *l;
+
+	for (l = pending; l;) {
+		struct generic_data *data = l->data;
+
+		l = l->next;
+		if (data->conn != connection)
+			continue;
+
+		process_changes(data);
+	}
+}
+
 gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
 {
 	dbus_bool_t result = FALSE;
@@ -1510,6 +1545,9 @@ gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
 			goto out;
 	}
 
+	/* Flush pending signal to guarantee message order */
+	g_dbus_flush(connection);
+
 	result = dbus_connection_send(connection, message, NULL);
 
 out:
@@ -1664,10 +1702,12 @@ static void process_properties_from_interface(struct generic_data *data,
 	g_slist_free(invalidated);
 	dbus_message_iter_close_container(&iter, &array);
 
-	g_dbus_send_message(data->conn, signal);
-
 	g_slist_free(iface->pending_prop);
 	iface->pending_prop = NULL;
+
+	/* Use dbus_connection_send to avoid recursive calls to g_dbus_flush */
+	dbus_connection_send(data->conn, signal, NULL);
+	dbus_message_unref(signal);
 }
 
 static void process_property_changes(struct generic_data *data)
@@ -1723,10 +1763,7 @@ void g_dbus_emit_property_changed(DBusConnection *connection,
 	iface->pending_prop = g_slist_prepend(iface->pending_prop,
 						(void *) property);
 
-	if (!data->process_id) {
-		data->process_id = g_idle_add(process_changes, data);
-		return;
-	}
+	add_pending(data);
 }
 
 gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
-- 
1.8.3.1

