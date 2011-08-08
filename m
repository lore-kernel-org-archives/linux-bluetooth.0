Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 01/11] Add read remote Tx Power
Date: Mon,  8 Aug 2011 15:46:40 -0300
Message-Id: <1312829210-6781-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Read the remote Tx Power when the connection is established.
---
 proximity/monitor.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 216eae4..e9cf2e7 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -52,6 +52,7 @@
 #define PROXIMITY_INTERFACE "org.bluez.Proximity"
 
 #define ALERT_LEVEL_CHR_UUID 0x2A06
+#define POWER_LEVEL_CHR_UUID 0x2A07
 
 enum {
 	ALERT_NONE = 0,
@@ -71,6 +72,7 @@ struct monitor {
 	char *signallevel;		/* Path Loss RSSI level */
 	uint16_t linklosshandle;	/* Link Loss Characteristic
 					 * Value Handle */
+	uint16_t txpowerhandle;		/* Tx Characteristic Value Handle */
 	guint attioid;
 };
 
@@ -175,6 +177,62 @@ static int write_alert_level(struct monitor *monitor)
 	return 0;
 }
 
+static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	uint8_t value;
+	int vlen;
+
+	if (status != 0) {
+		DBG("Tx Power Level read failed: %s", att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, plen, &value, &vlen)) {
+		DBG("Protocol error");
+		return;
+	}
+
+	DBG("Tx Power Level: %02x", (int8_t) value);
+}
+
+static void tx_power_handle_cb(GSList *characteristics, guint8 status,
+							gpointer user_data)
+{
+	struct monitor *monitor = user_data;
+	struct att_char *chr;
+
+	if (status) {
+		error("Discover Tx Power handle: %s", att_ecode2str(status));
+		return;
+	}
+
+	chr = characteristics->data;
+	monitor->txpowerhandle = chr->value_handle;
+
+	DBG("Tx Power handle: 0x%04x", monitor->txpowerhandle);
+
+	gatt_read_char(monitor->attrib, monitor->txpowerhandle, 0,
+							tx_power_read_cb, monitor);
+}
+
+static void read_tx_power(struct monitor *monitor)
+{
+	struct att_range *txpower = monitor->txpower;
+	bt_uuid_t uuid;
+
+	if (monitor->txpowerhandle != 0) {
+		gatt_read_char(monitor->attrib, monitor->txpowerhandle, 0,
+						tx_power_read_cb, monitor);
+		return;
+	}
+
+	bt_uuid16_create(&uuid, POWER_LEVEL_CHR_UUID);
+
+	gatt_discover_char(monitor->attrib, txpower->start, txpower->end,
+				&uuid, tx_power_handle_cb, monitor);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct monitor *monitor = user_data;
@@ -183,6 +241,9 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	if (monitor->enabled.linkloss)
 		write_alert_level(monitor);
+
+	if (monitor->enabled.pathloss)
+		read_tx_power(monitor);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
-- 
1.7.6

