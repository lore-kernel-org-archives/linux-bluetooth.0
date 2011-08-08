Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 07/11] Reset Immediate Alert after 5 seconds
Date: Mon,  8 Aug 2011 15:46:46 -0300
Message-Id: <1312829210-6781-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add implementation specific timeout. Immediate Alert is set to "none"
after the timeout. Reporter can also implement a timeout for reseting
the alert level. Alert level is a write only and not notifiable
characteristic. In the timeout source, the Proximity Monitor writes
"none" in the Reporter and notifies the D-Bus clients that the alert
level has changed.
---
 proximity/monitor.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 5664c4b..f765824 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -54,6 +54,8 @@
 #define ALERT_LEVEL_CHR_UUID 0x2A06
 #define POWER_LEVEL_CHR_UUID 0x2A07
 
+#define IMMEDIATE_TIMEOUT	5
+
 enum {
 	ALERT_NONE = 0,
 	ALERT_MILD,
@@ -76,6 +78,7 @@ struct monitor {
 					 * Value Handle */
 	uint16_t txpowerhandle;		/* Tx Characteristic Value Handle */
 	uint16_t immediatehandle;	/* Immediate Alert Value Handle */
+	guint immediateto;		/* Reset Immediate Alert to "none" */
 	guint attioid;
 };
 
@@ -236,6 +239,31 @@ static void read_tx_power(struct monitor *monitor)
 				&uuid, tx_power_handle_cb, monitor);
 }
 
+static gboolean immediate_timeout(gpointer user_data)
+{
+	struct monitor *monitor = user_data;
+	const char *path = device_get_path(monitor->device);
+
+	monitor->immediateto = 0;
+
+	if (g_strcmp0(monitor->immediatelevel, "none") == 0)
+		return FALSE;
+
+	if (monitor->attrib) {
+		uint8_t value = ALERT_NONE;
+		gatt_write_cmd(monitor->attrib, monitor->immediatehandle,
+				&value, 1, NULL, NULL);
+	}
+
+	g_free(monitor->immediatelevel);
+	monitor->immediatelevel = g_strdup("none");
+	emit_property_changed(monitor->conn, path, PROXIMITY_INTERFACE,
+					"ImmediateAlertLevel", DBUS_TYPE_STRING,
+					&monitor->immediatelevel);
+
+	return FALSE;
+}
+
 static void immediate_written(gpointer user_data)
 {
 	struct monitor *monitor = user_data;
@@ -247,6 +275,9 @@ static void immediate_written(gpointer user_data)
 	emit_property_changed(monitor->conn, path, PROXIMITY_INTERFACE,
 				"ImmediateAlertLevel",
 				DBUS_TYPE_STRING, &monitor->immediatelevel);
+
+	monitor->immediateto = g_timeout_add_seconds(IMMEDIATE_TIMEOUT,
+						immediate_timeout, monitor);
 }
 
 static void write_immediate_alert(struct monitor *monitor)
@@ -363,6 +394,11 @@ static DBusMessage *set_immediate_alert(DBusConnection *conn, DBusMessage *msg,
 	if (g_strcmp0(monitor->immediatelevel, level) == 0)
 		return dbus_message_new_method_return(msg);
 
+	if (monitor->immediateto) {
+		g_source_remove(monitor->immediateto);
+		monitor->immediateto = 0;
+	}
+
 	/* Previous Immediate Alert level if connection/write fails */
 	g_free(monitor->fallbacklevel);
 	monitor->fallbacklevel = monitor->immediatelevel;
@@ -480,6 +516,9 @@ static void monitor_destroy(gpointer user_data)
 {
 	struct monitor *monitor = user_data;
 
+	if (monitor->immediateto)
+		g_source_remove(monitor->immediateto);
+
 	if (monitor->attioid)
 		btd_device_remove_attio_callback(monitor->device,
 						monitor->attioid);
-- 
1.7.6

