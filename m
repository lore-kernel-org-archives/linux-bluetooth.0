Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 12/14] Emit SignalLevel when RSSI alert is received
Date: Tue,  9 Aug 2011 18:00:39 -0300
Message-Id: <1312923641-12028-13-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes Proximity Monitor emitting a signal when the RSSI threshold
monitoring event is received.
---
 proximity/monitor.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 4bd4506..818325a 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -186,7 +186,31 @@ static int write_alert_level(struct monitor *monitor)
 
 static void monitor_rssi_alert(uint8_t alert, gpointer user_data)
 {
-	DBG("");
+	struct monitor *monitor = user_data;
+	const char *level, *path = device_get_path(monitor->device);
+
+	switch (alert) {
+	case 0x00:
+		level = "good";
+		break;
+	case 0x01:
+		level = "regular";
+		break;
+	case 0x02:
+		level = "weak";
+		break;
+	default:
+		level = "unknown";
+		break;
+	}
+
+	emit_property_changed(monitor->conn, path, PROXIMITY_INTERFACE,
+					"SignalLevel", DBUS_TYPE_STRING,
+					&level);
+	g_free(monitor->signallevel);
+	monitor->signallevel = g_strdup(level);
+
+	DBG("SignalLevel: %s", level);
 }
 
 static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-- 
1.7.6

