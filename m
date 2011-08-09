Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH 2/7] Bluetooth: Implement Enable RSSI Monitor
Date: Tue,  9 Aug 2011 16:29:37 -0400
Message-Id: <4e4198c3.0750640a.58f6.0ec0@mx.google.com>
In-Reply-To: <1312921782-27523-1-git-send-email-y>
References: <y>
 <1312921782-27523-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch implements Enable RSSI Monitor Management command. This
command is responsible to add monitors into a list. This list stores all
RSSI monitors, one for each monitored connection.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_core.c         |    2 +
 net/bluetooth/mgmt.c             |   84 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1bc1c3a..b1e3e615 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -211,6 +211,8 @@ struct hci_dev {
 
 	struct timer_list	le_scan_timer;
 
+	struct list_head	rssi_monitors;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8f9ed8c..52414d4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1521,6 +1521,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	setup_timer(&hdev->le_scan_timer, hci_disable_le_scan,
 						(unsigned long) hdev);
 
+	INIT_LIST_HEAD(&hdev->rssi_monitors);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 36ed168..410f614 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -55,6 +55,14 @@ struct pending_cmd {
 
 static LIST_HEAD(cmd_list);
 
+struct rssi_monitor {
+	struct list_head list;
+	bdaddr_t bdaddr;
+	s8 low_trigger;
+	s8 high_trigger;
+	u8 last_alert;
+};
+
 static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
@@ -1884,12 +1892,86 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 	return err;
 }
 
+static struct rssi_monitor *rssi_monitor_find(u16 index, bdaddr_t *bdaddr)
+{
+	struct rssi_monitor *tmp, *rm;
+	struct hci_dev *hdev;
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return NULL;
+
+	rm = NULL;
+
+	list_for_each_entry(tmp, &hdev->rssi_monitors, list) {
+		if (bacmp(&tmp->bdaddr, bdaddr) == 0) {
+			rm = tmp;
+			break;
+		}
+	}
+
+	hci_dev_put(hdev);
+
+	return rm;
+}
+
+static int rssi_check_trigger_values(s8 low_trigger, s8 high_trigger)
+{
+	if (low_trigger < high_trigger ||
+			((high_trigger < -127 || low_trigger > 128)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rssi_monitor_add(u16 index, bdaddr_t *bdaddr, s8 low_trigger,
+							s8 high_trigger)
+{
+	struct rssi_monitor *rm;
+	struct hci_dev *hdev;
+
+	if (rssi_check_trigger_values(low_trigger, high_trigger))
+		return -EINVAL;
+
+	if (rssi_monitor_find(index, bdaddr))
+		return -EEXIST;
+
+	rm = kzalloc(sizeof(*rm), GFP_ATOMIC);
+	if (!rm)
+		return -ENOMEM;
+
+	bacpy(&rm->bdaddr, bdaddr);
+	rm->low_trigger = low_trigger;
+	rm->high_trigger = high_trigger;
+
+	hdev = hci_dev_get(index);
+	if (!hdev) {
+		kfree(rm);
+		return -EINVAL;
+	}
+
+	list_add(&rm->list, &hdev->rssi_monitors);
+
+	hci_dev_put(hdev);
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

