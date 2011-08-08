Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 03/11] Write Immediate Alert if necessary
Date: Mon,  8 Aug 2011 15:46:42 -0300
Message-Id: <1312829210-6781-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Immediate Alert value needs to be written when the connection is
established.
---
 proximity/monitor.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 64e9690..824a87c 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -68,6 +68,7 @@ struct monitor {
 	struct att_range *immediate;
 	struct enabled enabled;
 	char *linklosslevel;		/* Link Loss Alert Level */
+	char *fallbacklevel;		/* Immediate fallback alert level */
 	char *immediatelevel;		/* Immediate Alert Level */
 	char *signallevel;		/* Path Loss RSSI level */
 	uint16_t linklosshandle;	/* Link Loss Characteristic
@@ -234,6 +235,16 @@ static void read_tx_power(struct monitor *monitor)
 				&uuid, tx_power_handle_cb, monitor);
 }
 
+static void write_immediate_alert(struct monitor *monitor)
+{
+	uint8_t value = str2level(monitor->immediatelevel);
+
+	gatt_write_cmd(monitor->attrib, monitor->immediatehandle, &value, 1,
+								NULL, NULL);
+	g_free(monitor->fallbacklevel);
+	monitor->fallbacklevel = NULL;
+}
+
 static void immediate_handle_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
@@ -275,9 +286,11 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	if (monitor->enabled.pathloss)
 		read_tx_power(monitor);
 
-	if (monitor->immediatehandle == 0 &&
-			(monitor->enabled.pathloss || monitor->enabled.findme))
-		discover_immediate_handle(monitor);
+	if (monitor->immediatehandle == 0) {
+		if(monitor->enabled.pathloss || monitor->enabled.findme)
+			discover_immediate_handle(monitor);
+	} else if (monitor->fallbacklevel)
+		write_immediate_alert(monitor);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
@@ -336,7 +349,10 @@ static DBusMessage *set_immediate_alert(DBusConnection *conn, DBusMessage *msg,
 	if (g_strcmp0(monitor->immediatelevel, level) == 0)
 		return dbus_message_new_method_return(msg);
 
-	g_free(monitor->immediatelevel);
+	/* Previous Immediate Alert level if connection/write fails */
+	g_free(monitor->fallbacklevel);
+	monitor->fallbacklevel = monitor->immediatelevel;
+
 	monitor->immediatelevel = g_strdup(level);
 
 	emit_property_changed(conn, path, PROXIMITY_INTERFACE,
-- 
1.7.6

