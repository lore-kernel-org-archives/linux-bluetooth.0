Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 10/14] Disable RSSI monitor when device is removed
Date: Tue,  9 Aug 2011 18:00:37 -0300
Message-Id: <1312923641-12028-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/monitor.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 2b5acd5..eea77cb 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -80,6 +80,7 @@ struct monitor {
 	uint16_t immediatehandle;	/* Immediate Alert Value Handle */
 	guint immediateto;		/* Reset Immediate Alert to "none" */
 	guint attioid;
+	gboolean rssimon;		/* RSSI monitor enabled/disabled */
 };
 
 static inline int create_filename(char *buf, size_t size,
@@ -193,6 +194,7 @@ static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 {
 	struct monitor *monitor = user_data;
 	struct btd_device *device = monitor->device;
+	struct btd_adapter *adapter = device_get_adapter(device);
 	uint8_t value;
 	int vlen;
 	int8_t low = -20, high = -40;
@@ -211,9 +213,9 @@ static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	DBG("Tx Power Level: %02x", (int8_t) value);
 
 	device_get_address(device, &dba);
-	btd_adapter_enable_rssi_monitor(device_get_adapter(device), &dba,
-					low, high, monitor_rssi_alert,
-					monitor);
+	monitor->rssimon = btd_adapter_enable_rssi_monitor(adapter, &dba,
+						low, high, monitor_rssi_alert,
+						monitor);
 }
 
 static void tx_power_handle_cb(GSList *characteristics, guint8 status,
@@ -550,12 +552,21 @@ static GDBusSignalTable monitor_signals[] = {
 static void monitor_destroy(gpointer user_data)
 {
 	struct monitor *monitor = user_data;
+	struct btd_device *device = monitor->device;
 
 	if (monitor->immediateto)
 		g_source_remove(monitor->immediateto);
 
+	if (monitor->rssimon) {
+		struct btd_adapter *adapter = device_get_adapter(device);
+		bdaddr_t dba;
+
+		device_get_address(device, &dba);
+		btd_adapter_disable_rssi_monitor(adapter, &dba);
+	}
+
 	if (monitor->attioid)
-		btd_device_remove_attio_callback(monitor->device,
+		btd_device_remove_attio_callback(device,
 						monitor->attioid);
 	if (monitor->attrib)
 		g_attrib_unref(monitor->attrib);
-- 
1.7.6

