Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH 1/2] gdbus: add method for immediate property update
Date: Thu, 17 Sep 2015 21:39:56 -0700
Message-Id: <1442551197-5374-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_dbus_emit_property_changed doesn't send dbus signal immediately. Instead
it stores changed properties, and schedule signal to be send at
g_iddle_add. Additionally, if this method is called few times for some
property, only last value will be sent in property changed signal.

If remote device sends lots of notifications, they're all scheduled to be
notified using this method. This might result in some notifications being
lost.

This patch adds new method, that immediately sends property changed
signal, instead of sheduling it for nearest iddle moment.
---
 gdbus/gdbus.h  |  3 +++
 gdbus/object.c | 46 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index d99c254..b31246a 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -300,6 +300,9 @@ void g_dbus_pending_property_error(GDBusPendingReply id, const char *name,
 void g_dbus_emit_property_changed(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name);
+void g_dbus_emit_property_changed_immediate(DBusConnection *connection,
+				const char *path, const char *interface,
+				const char *name);
 gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
 				const char *interface, DBusMessageIter *iter);
 
diff --git a/gdbus/object.c b/gdbus/object.c
index 96db516..fff9e0d 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1720,21 +1720,12 @@ static void process_property_changes(struct generic_data *data)
 	}
 }
 
-void g_dbus_emit_property_changed(DBusConnection *connection,
-				const char *path, const char *interface,
-				const char *name)
+static void prepare_property_changed(const char *interface, const char *name,
+						struct generic_data *data)
 {
 	const GDBusPropertyTable *property;
-	struct generic_data *data;
 	struct interface_data *iface;
 
-	if (path == NULL)
-		return;
-
-	if (!dbus_connection_get_object_path_data(connection, path,
-					(void **) &data) || data == NULL)
-		return;
-
 	iface = find_interface(data->interfaces, interface);
 	if (iface == NULL)
 		return;
@@ -1759,10 +1750,43 @@ void g_dbus_emit_property_changed(DBusConnection *connection,
 	data->pending_prop = TRUE;
 	iface->pending_prop = g_slist_prepend(iface->pending_prop,
 						(void *) property);
+}
+
+void g_dbus_emit_property_changed(DBusConnection *connection, const char *path,
+				const char *interface, const char *name)
+{
+	struct generic_data *data;
+
+	if (path == NULL)
+		return;
+
+	if (!dbus_connection_get_object_path_data(connection, path,
+					(void **) &data) || data == NULL)
+		return;
+
+	prepare_property_changed(interface, name, data);
 
 	add_pending(data);
 }
 
+void g_dbus_emit_property_changed_immediate(DBusConnection *connection,
+				const char *path, const char *interface,
+							const char *name)
+{
+	struct generic_data *data;
+
+	if (path == NULL)
+		return;
+
+	if (!dbus_connection_get_object_path_data(connection, path,
+					(void **) &data) || data == NULL)
+		return;
+
+	prepare_property_changed(interface, name, data);
+
+	process_property_changes(data);
+}
+
 gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
 				const char *interface, DBusMessageIter *iter)
 {
-- 
2.5.0

