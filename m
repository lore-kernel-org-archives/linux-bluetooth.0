Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 02/11] Add Immediate Alert handle discovery
Date: Mon,  8 Aug 2011 15:46:41 -0300
Message-Id: <1312829210-6781-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/monitor.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index e9cf2e7..64e9690 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -73,6 +73,7 @@ struct monitor {
 	uint16_t linklosshandle;	/* Link Loss Characteristic
 					 * Value Handle */
 	uint16_t txpowerhandle;		/* Tx Characteristic Value Handle */
+	uint16_t immediatehandle;	/* Immediate Alert Value Handle */
 	guint attioid;
 };
 
@@ -233,6 +234,35 @@ static void read_tx_power(struct monitor *monitor)
 				&uuid, tx_power_handle_cb, monitor);
 }
 
+static void immediate_handle_cb(GSList *characteristics, guint8 status,
+							gpointer user_data)
+{
+	struct monitor *monitor = user_data;
+	struct att_char *chr;
+
+	if (status) {
+		error("Discover Immediate Alert handle: %s",
+						att_ecode2str(status));
+		return;
+	}
+
+	chr = characteristics->data;
+	monitor->immediatehandle = chr->value_handle;
+
+	DBG("Immediate Alert handle: 0x%04x", monitor->immediatehandle);
+}
+
+static void discover_immediate_handle(struct monitor *monitor)
+{
+	struct att_range *immediate = monitor->immediate;
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
+
+	gatt_discover_char(monitor->attrib, immediate->start, immediate->end,
+					&uuid, immediate_handle_cb, monitor);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct monitor *monitor = user_data;
@@ -244,6 +274,10 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	if (monitor->enabled.pathloss)
 		read_tx_power(monitor);
+
+	if (monitor->immediatehandle == 0 &&
+			(monitor->enabled.pathloss || monitor->enabled.findme))
+		discover_immediate_handle(monitor);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
-- 
1.7.6

