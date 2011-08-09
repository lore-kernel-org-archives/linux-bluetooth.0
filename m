Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 13/14] Define low/high RSSI threshold for Proximity
Date: Tue,  9 Aug 2011 18:00:40 -0300
Message-Id: <1312923641-12028-14-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Empirical values based on test results with keyfobs. Improvements
may be needed: storing the last operation results to handle situations
which high alert level is not received before disconnection. For this
case, shifting the thresholds may be an option.
---
 proximity/monitor.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 818325a..4b5a4ff 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -56,6 +56,9 @@
 
 #define IMMEDIATE_TIMEOUT	5
 
+#define LOW_RSSI_THRESHOLD	-60
+#define HIGH_RSSI_THRESHOLD	-75
+
 enum {
 	ALERT_NONE = 0,
 	ALERT_MILD,
@@ -221,7 +224,7 @@ static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	struct btd_adapter *adapter = device_get_adapter(device);
 	uint8_t value;
 	int vlen;
-	int8_t low = -20, high = -40;
+	int8_t low, high, txpower;
 	bdaddr_t dba;
 
 	if (status != 0) {
@@ -234,8 +237,11 @@ static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	DBG("Tx Power Level: %02x", (int8_t) value);
+	txpower = (int8_t) value;
+	DBG("Tx Power Level: %d", txpower);
 
+	low = LOW_RSSI_THRESHOLD - txpower;
+	high = HIGH_RSSI_THRESHOLD - txpower;
 	device_get_address(device, &dba);
 	monitor->rssimon = btd_adapter_enable_rssi_monitor(adapter, &dba,
 						low, high, monitor_rssi_alert,
-- 
1.7.6

