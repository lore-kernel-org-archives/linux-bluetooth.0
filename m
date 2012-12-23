Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] gdbus: Introduce GDBusInterfaceFlags
Date: Sun, 23 Dec 2012 17:24:55 +0200
Message-Id: <1356276298-13795-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
References: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The flags should be passed in g_dbus_register_interface_with_flags,
currently there only one flag which is G_DBUS_INTERFACE_FLAG_EXPERIMENTAL
which works similarly to G_DBUS_METHOD_FLAG_EXPERIMENTAL but for the
whole interface.
---
 gdbus/gdbus.h  | 13 +++++++++++++
 gdbus/object.c | 20 ++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 64f5d62..f49d9f0 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -31,6 +31,7 @@ extern "C" {
 #include <dbus/dbus.h>
 #include <glib.h>
 
+typedef enum GDBusInterfaceFlags GDBusInterfaceFlags;
 typedef enum GDBusMethodFlags GDBusMethodFlags;
 typedef enum GDBusSignalFlags GDBusSignalFlags;
 typedef enum GDBusPropertyFlags GDBusPropertyFlags;
@@ -88,6 +89,10 @@ typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
 						gboolean interaction,
 						GDBusPendingReply pending);
 
+enum GDBusInterfaceFlags {
+	G_DBUS_INTERFACE_FLAG_EXPERIMENTAL = (1 << 0),
+};
+
 enum GDBusMethodFlags {
 	G_DBUS_METHOD_FLAG_DEPRECATED	= (1 << 0),
 	G_DBUS_METHOD_FLAG_NOREPLY	= (1 << 1),
@@ -211,6 +216,14 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 					const GDBusPropertyTable *properties,
 					void *user_data,
 					GDBusDestroyFunction destroy);
+gboolean g_dbus_register_interface_with_flags(DBusConnection *connection,
+					const char *path, const char *name,
+					GDBusInterfaceFlags flags,
+					const GDBusMethodTable *methods,
+					const GDBusSignalTable *signals,
+					const GDBusPropertyTable *properties,
+					void *user_data,
+					GDBusDestroyFunction destroy);
 gboolean g_dbus_unregister_interface(DBusConnection *connection,
 					const char *path, const char *name);
 
diff --git a/gdbus/object.c b/gdbus/object.c
index 180d48c..510763a 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1350,6 +1350,26 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 	return TRUE;
 }
 
+gboolean g_dbus_register_interface_with_flags(DBusConnection *connection,
+					const char *path, const char *name,
+					GDBusInterfaceFlags flags,
+					const GDBusMethodTable *methods,
+					const GDBusSignalTable *signals,
+					const GDBusPropertyTable *properties,
+					void *user_data,
+					GDBusDestroyFunction destroy)
+{
+	if (flags & G_DBUS_INTERFACE_FLAG_EXPERIMENTAL) {
+		const char *env = g_getenv("GDBUS_EXPERIMENTAL");
+		if (g_strcmp0(env, "1") != 0)
+			return FALSE;
+	}
+
+	return g_dbus_register_interface(connection, path, name, methods,
+						signals, properties, user_data,
+						destroy);
+}
+
 gboolean g_dbus_unregister_interface(DBusConnection *connection,
 					const char *path, const char *name)
 {
-- 
1.7.11.7

