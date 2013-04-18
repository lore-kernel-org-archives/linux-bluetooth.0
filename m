Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 1/2] gdbus: Add g_dbus_flush_properties()
Date: Thu, 18 Apr 2013 14:50:23 -0300
Message-Id: <1366307424-19825-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some situations, it may be useful to be sure that all the
properties updates for a object are sent.
---
 gdbus/gdbus.h  |  2 ++
 gdbus/object.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 8b13393..ed280e4 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -299,6 +299,8 @@ void g_dbus_emit_property_changed(DBusConnection *connection,
 gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
 				const char *interface, DBusMessageIter *iter);
 
+gboolean g_dbus_flush_properties(DBusConnection *connection, const char *path);
+
 gboolean g_dbus_attach_object_manager(DBusConnection *connection);
 gboolean g_dbus_detach_object_manager(DBusConnection *connection);
 
diff --git a/gdbus/object.c b/gdbus/object.c
index 2f8ef45..14b6803 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1751,6 +1751,25 @@ gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
 	return TRUE;
 }
 
+gboolean g_dbus_flush_properties(DBusConnection *connection, const char *path)
+{
+	struct generic_data *data;
+
+	if (path == NULL)
+		return FALSE;
+
+	if (!dbus_connection_get_object_path_data(connection, path,
+					(void **) &data) || data == NULL)
+		return FALSE;
+
+	if (data->process_id)
+		g_source_remove(data->process_id);
+
+	process_changes(data);
+
+	return TRUE;
+}
+
 gboolean g_dbus_attach_object_manager(DBusConnection *connection)
 {
 	struct generic_data *data;
-- 
1.8.2.1

