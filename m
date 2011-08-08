Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 04/11] Emit PropertyChanged after writting alert
Date: Mon,  8 Aug 2011 15:46:43 -0300
Message-Id: <1312829210-6781-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Wait sending write characteristic value for Immediate Alert before
sending a PropertyChanged signal in the Proximity Monitor. Applied
to FindMe Profile and Path Loss service when the threshold is reached.
---
 proximity/monitor.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 824a87c..2d405be 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -63,6 +63,7 @@ enum {
 struct monitor {
 	struct btd_device *device;
 	GAttrib *attrib;
+	DBusConnection *conn;
 	struct att_range *linkloss;
 	struct att_range *txpower;
 	struct att_range *immediate;
@@ -235,14 +236,25 @@ static void read_tx_power(struct monitor *monitor)
 				&uuid, tx_power_handle_cb, monitor);
 }
 
+static void immediate_written(gpointer user_data)
+{
+	struct monitor *monitor = user_data;
+	const char *path = device_get_path(monitor->device);
+
+	g_free(monitor->fallbacklevel);
+	monitor->fallbacklevel = NULL;
+
+	emit_property_changed(monitor->conn, path, PROXIMITY_INTERFACE,
+				"ImmediateAlertLevel",
+				DBUS_TYPE_STRING, &monitor->immediatelevel);
+}
+
 static void write_immediate_alert(struct monitor *monitor)
 {
 	uint8_t value = str2level(monitor->immediatelevel);
 
 	gatt_write_cmd(monitor->attrib, monitor->immediatehandle, &value, 1,
-								NULL, NULL);
-	g_free(monitor->fallbacklevel);
-	monitor->fallbacklevel = NULL;
+						immediate_written, monitor);
 }
 
 static void immediate_handle_cb(GSList *characteristics, guint8 status,
@@ -341,7 +353,6 @@ static DBusMessage *set_immediate_alert(DBusConnection *conn, DBusMessage *msg,
 						const char *level, void *data)
 {
 	struct monitor *monitor = data;
-	const gchar *path = device_get_path(monitor->device);
 
 	if (!level_is_valid(level))
 		return btd_error_invalid_args(msg);
@@ -355,10 +366,6 @@ static DBusMessage *set_immediate_alert(DBusConnection *conn, DBusMessage *msg,
 
 	monitor->immediatelevel = g_strdup(level);
 
-	emit_property_changed(conn, path, PROXIMITY_INTERFACE,
-					"ImmediateAlertLevel",
-					DBUS_TYPE_STRING, &level);
-
 	return dbus_message_new_method_return(msg);
 }
 
@@ -464,6 +471,7 @@ static void monitor_destroy(gpointer user_data)
 	if (monitor->attrib)
 		g_attrib_unref(monitor->attrib);
 
+	dbus_connection_unref(monitor->conn);
 	btd_device_unref(monitor->device);
 	g_free(monitor->linkloss);
 	g_free(monitor->immediate);
@@ -490,6 +498,7 @@ int monitor_register(DBusConnection *conn, struct btd_device *device,
 
 	monitor = g_new0(struct monitor, 1);
 	monitor->device = btd_device_ref(device);
+	monitor->conn = dbus_connection_ref(conn);
 	monitor->linklosslevel = (level ? : g_strdup("none"));
 	monitor->signallevel = g_strdup("unknown");
 
-- 
1.7.6

