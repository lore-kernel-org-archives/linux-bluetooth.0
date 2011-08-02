Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 2/7] Bluetooth: Implement Enable RSSI Monitor
Date: Tue,  2 Aug 2011 14:35:04 -0400
Message-Id: <1312310109-27082-3-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
References: <y>
 <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements Enable RSSI Monitor Management command. This
command is responsible to add monitors into a list. This list stores all
RSSI monitors, one for each monitored connection.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 net/bluetooth/mgmt.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 36ed168..ccfc19b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -55,6 +55,17 @@ struct pending_cmd {
 
 static LIST_HEAD(cmd_list);
 
+struct rssi_monitor {
+	struct list_head list;
+	int index;
+	bdaddr_t bdaddr;
+	s8 low_trigger;
+	s8 high_trigger;
+	u8 last_alert;
+};
+
+static LIST_HEAD(rssi_monitor_list);
+
 static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
@@ -1884,12 +1895,64 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 	return err;
 }
 
+static struct rssi_monitor *rssi_monitor_find(u16 index, bdaddr_t *bdaddr)
+{
+	struct rssi_monitor *rm;
+
+	list_for_each_entry(rm, &rssi_monitor_list, list) {
+		if (rm->index != index)
+			continue;
+
+		if (bacmp(&rm->bdaddr, bdaddr) != 0)
+			continue;
+
+		return rm;
+	}
+
+	return NULL;
+}
+
+static int rssi_monitor_add(u16 index, bdaddr_t *bdaddr, s8 low_trigger,
+							s8 high_trigger)
+{
+	struct rssi_monitor *rm;
+
+	if (rssi_monitor_find(index, bdaddr))
+		return -EEXIST;
+
+	if (low_trigger < -127 || low_trigger > 128 ||
+			high_trigger < -127 || high_trigger > 128)
+		return -EINVAL;
+
+	rm = kzalloc(sizeof(*rm), GFP_ATOMIC);
+	if (!rm)
+		return -ENOMEM;
+
+	rm->index = index;
+	bacpy(&rm->bdaddr, bdaddr);
+	rm->low_trigger = low_trigger;
+	rm->high_trigger = high_trigger;
+
+	list_add(&rm->list, &rssi_monitor_list);
+
+	return 0;
+}
+
 static int enable_rssi_monitor(struct sock *sk, u16 index,
 					unsigned char *data, u16 len)
 {
+	struct mgmt_cp_enable_rssi_monitor *cp;
+
 	BT_DBG("hci%u", index);
 
-	return -ENOSYS;
+	cp = (void *) data;
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index,
+					MGMT_OP_ENABLE_RSSI_MONITOR, EINVAL);
+
+	return rssi_monitor_add(index, &cp->bdaddr,
+			cp->low_alert_trigger, cp->high_alert_trigger);
 }
 
 static int disable_rssi_monitor(struct sock *sk, u16 index,
-- 
1.7.4.1

