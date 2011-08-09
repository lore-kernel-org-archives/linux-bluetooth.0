Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 09/14] Add RSSI threshold monitor in Proximity Monitor
Date: Tue,  9 Aug 2011 18:00:36 -0300
Message-Id: <1312923641-12028-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/monitor.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index c32ddec..2b5acd5 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -183,11 +183,20 @@ static int write_alert_level(struct monitor *monitor)
 	return 0;
 }
 
+static void monitor_rssi_alert(uint8_t alert, gpointer user_data)
+{
+	DBG("");
+}
+
 static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
+	struct monitor *monitor = user_data;
+	struct btd_device *device = monitor->device;
 	uint8_t value;
 	int vlen;
+	int8_t low = -20, high = -40;
+	bdaddr_t dba;
 
 	if (status != 0) {
 		DBG("Tx Power Level read failed: %s", att_ecode2str(status));
@@ -200,6 +209,11 @@ static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	DBG("Tx Power Level: %02x", (int8_t) value);
+
+	device_get_address(device, &dba);
+	btd_adapter_enable_rssi_monitor(device_get_adapter(device), &dba,
+					low, high, monitor_rssi_alert,
+					monitor);
 }
 
 static void tx_power_handle_cb(GSList *characteristics, guint8 status,
-- 
1.7.6

