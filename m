Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH 4/7] Bluetooth: Implement RSSI Monitor Alert event
Date: Tue,  9 Aug 2011 16:29:39 -0400
Message-Id: <4e4198cd.0750640a.58f6.0ec3@mx.google.com>
In-Reply-To: <1312921782-27523-1-git-send-email-y>
References: <y>
 <1312921782-27523-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch implements functions to calculate and send a Management event
according to RSSI value from a monitored connection. The event was
divided in three types: high, in range and low. The RSSI Monitor Alert
event is sent when a monitored RSSI value (stored into RSSI Monitor
list), reaches one of the two thresholds (low and high).

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |    6 ++++++
 net/bluetooth/mgmt.c             |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b1e3e615..df3b943 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -870,6 +870,7 @@ int mgmt_has_pending_stop_discov(u16 index);
 int mgmt_cancel_discovery(u16 index);
 int mgmt_is_interleaved_discovery(u16 index);
 int mgmt_do_interleaved_discovery(u16 index);
+int mgmt_rssi_monitor_send_alert(u16 index, bdaddr_t *bdaddr, s8 rssi);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index ef3b636..f254f40 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -313,3 +313,9 @@ struct mgmt_ev_remote_name {
 } __packed;
 
 #define MGMT_EV_DISCOVERING		0x0014
+
+#define MGMT_EV_RSSI_MONITOR_ALERT	0x0015
+struct mgmt_ev_rssi_monitor_alert {
+	bdaddr_t bdaddr;
+	__u8 alert_type;
+} __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a4a2927..635ab8c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -44,6 +44,10 @@ enum bt_device_type {
 #define BREDR_LE_SCAN_TIMEOUT 5120 /* TGAP(100)/2 */
 #define LE_ONLY_SCAN_TIMEOUT 10240 /* TGAP(gen_disc_scan_min) */
 
+#define RSSI_MONITOR_ALERT_IN_RANGE	0x00
+#define RSSI_MONITOR_ALERT_LOW		0x01
+#define RSSI_MONITOR_ALERT_HIGH		0x02
+
 struct pending_cmd {
 	struct list_head list;
 	__u16 opcode;
@@ -1943,6 +1947,7 @@ static int rssi_monitor_add(u16 index, bdaddr_t *bdaddr, s8 low_trigger,
 	bacpy(&rm->bdaddr, bdaddr);
 	rm->low_trigger = low_trigger;
 	rm->high_trigger = high_trigger;
+	rm->last_alert = RSSI_MONITOR_ALERT_HIGH;
 
 	hdev = hci_dev_get(index);
 	if (!hdev) {
@@ -2004,6 +2009,33 @@ static int disable_rssi_monitor(struct sock *sk, u16 index,
 	return rssi_monitor_remove(index, &cp->bdaddr);
 }
 
+int mgmt_rssi_monitor_send_alert(u16 index, bdaddr_t *bdaddr, s8 rssi)
+{
+	struct rssi_monitor *rm;
+	struct mgmt_ev_rssi_monitor_alert ev;
+	u8 alert;
+
+	rm = rssi_monitor_find(index, bdaddr);
+	if (!rm)
+		return -EINVAL;
+
+	if (rssi <= rm->high_trigger)
+		alert = RSSI_MONITOR_ALERT_HIGH;
+	else if (rssi <= rm->low_trigger)
+		alert = RSSI_MONITOR_ALERT_LOW;
+	else
+		alert = RSSI_MONITOR_ALERT_IN_RANGE;
+
+	if (rm->last_alert == alert)
+		return 0;
+
+	bacpy(&ev.bdaddr, bdaddr);
+	ev.alert_type = alert;
+	rm->last_alert = alert;
+	return mgmt_event(MGMT_EV_RSSI_MONITOR_ALERT, index, &ev,
+							sizeof(ev), NULL);
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
-- 
1.7.4.1

