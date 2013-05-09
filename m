Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 26/26] gdbus: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:56 -0300
Message-Id: <1368073016-28434-26-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate and prefer this one
over stdint.h.
---
 gdbus/gdbus.h    | 19 ++++++++++---------
 gdbus/mainloop.c |  5 +++--
 gdbus/object.c   |  3 ++-
 gdbus/watch.c    | 25 +++++++++++++------------
 4 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 8b13393..f2c6646 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -28,6 +28,7 @@
 extern "C" {
 #endif
 
+#include <inttypes.h>
 #include <dbus/dbus.h>
 #include <glib.h>
 
@@ -72,7 +73,7 @@ typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
 typedef gboolean (*GDBusPropertyGetter)(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data);
 
-typedef guint32 GDBusPendingPropertySet;
+typedef uint32_t GDBusPendingPropertySet;
 
 typedef void (*GDBusPropertySetter)(const GDBusPropertyTable *property,
 			DBusMessageIter *value, GDBusPendingPropertySet id,
@@ -81,7 +82,7 @@ typedef void (*GDBusPropertySetter)(const GDBusPropertyTable *property,
 typedef gboolean (*GDBusPropertyExists)(const GDBusPropertyTable *property,
 								void *data);
 
-typedef guint32 GDBusPendingReply;
+typedef uint32_t GDBusPendingReply;
 
 typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
 						const char *action,
@@ -268,24 +269,24 @@ gboolean g_dbus_emit_signal_valist(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name, int type, va_list args);
 
-guint g_dbus_add_service_watch(DBusConnection *connection, const char *name,
-				GDBusWatchFunction connect,
+unsigned int g_dbus_add_service_watch(DBusConnection *connection,
+				const char *name, GDBusWatchFunction connect,
 				GDBusWatchFunction disconnect,
 				void *user_data, GDBusDestroyFunction destroy);
-guint g_dbus_add_disconnect_watch(DBusConnection *connection, const char *name,
-				GDBusWatchFunction function,
+unsigned int g_dbus_add_disconnect_watch(DBusConnection *connection,
+				const char *name, GDBusWatchFunction function,
 				void *user_data, GDBusDestroyFunction destroy);
-guint g_dbus_add_signal_watch(DBusConnection *connection,
+unsigned int g_dbus_add_signal_watch(DBusConnection *connection,
 				const char *sender, const char *path,
 				const char *interface, const char *member,
 				GDBusSignalFunction function, void *user_data,
 				GDBusDestroyFunction destroy);
-guint g_dbus_add_properties_watch(DBusConnection *connection,
+unsigned int g_dbus_add_properties_watch(DBusConnection *connection,
 				const char *sender, const char *path,
 				const char *interface,
 				GDBusSignalFunction function, void *user_data,
 				GDBusDestroyFunction destroy);
-gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
+gboolean g_dbus_remove_watch(DBusConnection *connection, unsigned int tag);
 void g_dbus_remove_all_watches(DBusConnection *connection);
 
 void g_dbus_pending_property_success(GDBusPendingPropertySet id);
diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index 099b67f..7dfa9f0 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <glib.h>
 #include <dbus/dbus.h>
 
@@ -37,12 +38,12 @@
 #define debug(fmt...)
 
 struct timeout_handler {
-	guint id;
+	unsigned int id;
 	DBusTimeout *timeout;
 };
 
 struct watch_info {
-	guint id;
+	unsigned int id;
 	DBusWatch *watch;
 	DBusConnection *conn;
 };
diff --git a/gdbus/object.c b/gdbus/object.c
index 2f8ef45..7210177 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <string.h>
 
@@ -55,7 +56,7 @@ struct generic_data {
 	GSList *objects;
 	GSList *added;
 	GSList *removed;
-	guint process_id;
+	unsigned int process_id;
 	gboolean pending_prop;
 	char *introspect;
 	struct generic_data *parent;
diff --git a/gdbus/watch.c b/gdbus/watch.c
index 9e4f994..f086f0b 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <string.h>
 
@@ -40,7 +41,7 @@
 static DBusHandlerResult message_filter(DBusConnection *connection,
 					DBusMessage *message, void *user_data);
 
-static guint listener_id = 0;
+static unsigned int listener_id = 0;
 static GSList *listeners = NULL;
 
 struct service_data {
@@ -48,7 +49,7 @@ struct service_data {
 	DBusPendingCall *call;
 	char *name;
 	const char *owner;
-	guint id;
+	unsigned int id;
 	struct filter_callback *callback;
 };
 
@@ -59,7 +60,7 @@ struct filter_callback {
 	GDBusDestroyFunction destroy_func;
 	struct service_data *data;
 	void *user_data;
-	guint id;
+	unsigned int id;
 };
 
 struct filter_data {
@@ -73,7 +74,7 @@ struct filter_data {
 	char *argument;
 	GSList *callbacks;
 	GSList *processed;
-	guint name_watch;
+	unsigned int name_watch;
 	gboolean lock;
 	gboolean registered;
 };
@@ -259,7 +260,7 @@ proceed:
 
 static struct filter_callback *filter_data_find_callback(
 						struct filter_data *data,
-						guint id)
+						unsigned int id)
 {
 	GSList *l;
 
@@ -689,8 +690,8 @@ done:
 	dbus_message_unref(message);
 }
 
-guint g_dbus_add_service_watch(DBusConnection *connection, const char *name,
-				GDBusWatchFunction connect,
+unsigned int g_dbus_add_service_watch(DBusConnection *connection,
+				const char *name, GDBusWatchFunction connect,
 				GDBusWatchFunction disconnect,
 				void *user_data, GDBusDestroyFunction destroy)
 {
@@ -717,15 +718,15 @@ guint g_dbus_add_service_watch(DBusConnection *connection, const char *name,
 	return cb->id;
 }
 
-guint g_dbus_add_disconnect_watch(DBusConnection *connection, const char *name,
-				GDBusWatchFunction func,
+unsigned int g_dbus_add_disconnect_watch(DBusConnection *connection,
+				const char *name, GDBusWatchFunction func,
 				void *user_data, GDBusDestroyFunction destroy)
 {
 	return g_dbus_add_service_watch(connection, name, NULL, func,
 							user_data, destroy);
 }
 
-guint g_dbus_add_signal_watch(DBusConnection *connection,
+unsigned int g_dbus_add_signal_watch(DBusConnection *connection,
 				const char *sender, const char *path,
 				const char *interface, const char *member,
 				GDBusSignalFunction function, void *user_data,
@@ -752,7 +753,7 @@ guint g_dbus_add_signal_watch(DBusConnection *connection,
 	return cb->id;
 }
 
-guint g_dbus_add_properties_watch(DBusConnection *connection,
+unsigned int g_dbus_add_properties_watch(DBusConnection *connection,
 				const char *sender, const char *path,
 				const char *interface,
 				GDBusSignalFunction function, void *user_data,
@@ -780,7 +781,7 @@ guint g_dbus_add_properties_watch(DBusConnection *connection,
 	return cb->id;
 }
 
-gboolean g_dbus_remove_watch(DBusConnection *connection, guint id)
+gboolean g_dbus_remove_watch(DBusConnection *connection, unsigned int id)
 {
 	struct filter_data *data;
 	struct filter_callback *cb;
-- 
1.8.2.2

