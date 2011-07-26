Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH BlueZ 1/5] Add set Link Loss Alert Level
Date: Tue, 26 Jul 2011 13:53:12 -0300
Message-Id: <1311699196-16472-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sheldon Demario <sheldon.demario@openbossa.org>

Add LinkLossAlertLevel property for SetProperty method in Proximity
Monitor. Allowed values are: none, mild and high.
---
 proximity/monitor.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 4928c7a..50594f7 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -28,6 +28,7 @@
 
 #include <gdbus.h>
 
+#include "error.h"
 #include "log.h"
 
 #include "monitor.h"
@@ -35,6 +36,28 @@
 #define PROXIMITY_INTERFACE "org.bluez.Proximity"
 #define PROXIMITY_PATH "/org/bluez/proximity"
 
+struct monitor {
+	char *linklosslevel;		/* Link Loss Alert Level */
+};
+
+static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
+						const char *level, void *data)
+{
+	struct monitor *monitor = data;
+
+	if (!g_str_equal("none", level) && !g_str_equal("mild", level) &&
+			!g_str_equal("high", level))
+		return btd_error_invalid_args(msg);
+
+	if (g_strcmp0(monitor->linklosslevel, level) == 0)
+		return dbus_message_new_method_return(msg);
+
+	g_free(monitor->linklosslevel);
+	monitor->linklosslevel = g_strdup(level);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -44,7 +67,34 @@ static DBusMessage *get_properties(DBusConnection *conn,
 static DBusMessage *set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	return dbus_message_new_method_return(msg);
+	const char *property;
+	DBusMessageIter iter;
+	DBusMessageIter sub;
+	const char *level;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return btd_error_invalid_args(msg);
+	dbus_message_iter_recurse(&iter, &sub);
+
+	if (g_str_equal("LinkLossAlertLevel", property)) {
+		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&sub, &level);
+
+		return set_link_loss_alert(conn, msg, level, data);
+	}
+
+	return btd_error_invalid_args(msg);
 }
 
 static GDBusMethodTable monitor_methods[] = {
@@ -59,14 +109,24 @@ static GDBusSignalTable monitor_signals[] = {
 	{ }
 };
 
+static void monitor_destroy(gpointer user_data)
+{
+	struct monitor *monitor = user_data;
+
+	g_free(monitor->linklosslevel);
+	g_free(monitor);
+}
+
 int monitor_register(DBusConnection *conn)
 {
+	struct monitor *monitor;
 	int ret = -1;
 
+	monitor = g_new0(struct monitor, 1);
 	if (g_dbus_register_interface(conn, PROXIMITY_PATH,
-					PROXIMITY_INTERFACE,
-					monitor_methods, monitor_signals,
-					NULL, NULL, NULL) == TRUE) {
+				PROXIMITY_INTERFACE,
+				monitor_methods, monitor_signals,
+				NULL, monitor, monitor_destroy) == TRUE) {
 		DBG("Registered interface %s on path %s", PROXIMITY_INTERFACE,
 							PROXIMITY_PATH);
 		ret = 0;
-- 
1.7.6

