Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] gdbus: Fix not maintaining message order for signals
Date: Mon, 19 Aug 2013 17:32:52 +0300
Message-Id: <1376922779-11802-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1376922779-11802-1-git-send-email-luiz.dentz@gmail.com>
References: <1376922779-11802-1-git-send-email-luiz.dentz@gmail.com>
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
 gdbus/object.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 2f8ef45..b2ca1c2 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1494,6 +1494,35 @@ DBusMessage *g_dbus_create_reply(DBusMessage *message, int type, ...)
 	return reply;
 }
 
+static void g_dbus_flush_object(struct generic_data *data)
+{
+	GSList *l;
+
+	if (data->process_id > 0) {
+		g_source_remove(data->process_id);
+		data->process_id = 0;
+	}
+
+	process_changes(data);
+
+	for (l = data->objects; l; l = l->next)
+		g_dbus_flush_object(l->data);
+}
+
+static void g_dbus_flush(DBusConnection *connection)
+{
+	static gboolean flushing = FALSE;
+
+	if (flushing || root == NULL || root->conn != connection)
+		return;
+
+	flushing = TRUE;
+
+	g_dbus_flush_object(root);
+
+	flushing = FALSE;
+}
+
 gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
 {
 	dbus_bool_t result = FALSE;
@@ -1510,6 +1539,9 @@ gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
 			goto out;
 	}
 
+	/* Flush pending signal to guarantee message order */
+	g_dbus_flush(connection);
+
 	result = dbus_connection_send(connection, message, NULL);
 
 out:
-- 
1.8.3.1

