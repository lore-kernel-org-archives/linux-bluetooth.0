Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/3] Add set Immediate Alert for Proximity Monitor
Date: Wed,  3 Aug 2011 10:46:06 -0300
Message-Id: <1312379168-14795-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312379168-14795-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312379168-14795-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Extends SetProperty of the Proximity Monitor adding ImmediateAlertLevel
property. The value will be written in the Alert level of the remote's
Immediate Alert Level service. Property shared between FindMe and Path
Loss.
---
 proximity/monitor.c |   44 ++++++++++++++++++++++++++++++++++++++------
 1 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index d068142..537e389 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -59,6 +59,7 @@ struct monitor {
 	GAttrib *attrib;
 	struct enabled enabled;
 	char *linklosslevel;		/* Link Loss Alert Level */
+	char *immediatelevel;		/* Immediate Alert Level */
 };
 
 static inline int create_filename(char *buf, size_t size,
@@ -211,6 +212,29 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *set_immediate_alert(DBusConnection *conn, DBusMessage *msg,
+						const char *level, void *data)
+{
+	struct monitor *monitor = data;
+	const gchar *path = device_get_path(monitor->device);
+
+	if (!g_str_equal("none", level) && !g_str_equal("mild", level) &&
+			!g_str_equal("high", level))
+		return btd_error_invalid_args(msg);
+
+	if (g_strcmp0(monitor->immediatelevel, level) == 0)
+		return dbus_message_new_method_return(msg);
+
+	g_free(monitor->immediatelevel);
+	monitor->immediatelevel = g_strdup(level);
+
+	emit_property_changed(conn, path, PROXIMITY_INTERFACE,
+					"ImmediateAlertLevel",
+					DBUS_TYPE_STRING, &level);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -259,16 +283,23 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
 		return btd_error_invalid_args(msg);
+
 	dbus_message_iter_recurse(&iter, &sub);
 
-	if (g_str_equal("LinkLossAlertLevel", property)) {
-		if (monitor->enabled.linkloss == FALSE)
-			return btd_error_not_available(msg);
+	if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&sub, &level);
 
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING)
-			return btd_error_invalid_args(msg);
+	if (g_str_equal("ImmediateAlertLevel", property)) {
+		if (monitor->enabled.findme == FALSE &&
+				monitor->enabled.pathloss == FALSE)
+			return btd_error_not_available(msg);
 
-		dbus_message_iter_get_basic(&sub, &level);
+		return set_immediate_alert(conn, msg, level, data);
+	} else if (g_str_equal("LinkLossAlertLevel", property)) {
+		if (monitor->enabled.linkloss == FALSE)
+			return btd_error_not_available(msg);
 
 		return set_link_loss_alert(conn, msg, level, data);
 	}
@@ -294,6 +325,7 @@ static void monitor_destroy(gpointer user_data)
 
 	btd_device_unref(monitor->device);
 	g_free(monitor->linklosslevel);
+	g_free(monitor->immediatelevel);
 	g_free(monitor);
 }
 
-- 
1.7.6

