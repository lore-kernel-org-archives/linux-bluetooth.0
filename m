Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH 6/7] Bluetooth: Add RSSI Monitor timer and list lock
Date: Tue,  9 Aug 2011 16:29:41 -0400
Message-Id: <4e4198d2.0750640a.58f6.0ec8@mx.google.com>
In-Reply-To: <1312921782-27523-1-git-send-email-y>
References: <y>
 <1312921782-27523-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This is the polling mechanism to send HCI Read RSSI commands. The
command responses are used by the RSSI Monitor to get the current RSSI
value and calculate the current alert level for a given monitored
connection.

This patch also adds read and write locks on rssi_monitor_list avoiding
race conditions.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_core.c         |   11 +++++
 net/bluetooth/mgmt.c             |   77 +++++++++++++++++++++++++++++++++----
 3 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index df3b943..668dab2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -212,6 +212,7 @@ struct hci_dev {
 	struct timer_list	le_scan_timer;
 
 	struct list_head	rssi_monitors;
+	struct timer_list	rssi_timer;
 
 	struct hci_dev_stats	stat;
 
@@ -871,6 +872,7 @@ int mgmt_cancel_discovery(u16 index);
 int mgmt_is_interleaved_discovery(u16 index);
 int mgmt_do_interleaved_discovery(u16 index);
 int mgmt_rssi_monitor_send_alert(u16 index, bdaddr_t *bdaddr, s8 rssi);
+void mgmt_monitor_rssi(struct hci_dev *hdev);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 52414d4..0ae7997 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1448,6 +1448,14 @@ static void hci_disable_le_scan(unsigned long arg)
 	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
 
+static void hci_read_rssi(unsigned long arg)
+{
+	struct hci_dev *hdev = (void *) arg;
+
+	if (test_bit(HCI_UP, &hdev->flags))
+		mgmt_monitor_rssi(hdev);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1522,6 +1530,8 @@ int hci_register_dev(struct hci_dev *hdev)
 						(unsigned long) hdev);
 
 	INIT_LIST_HEAD(&hdev->rssi_monitors);
+	setup_timer(&hdev->rssi_timer, hci_read_rssi,
+						(unsigned long) hdev);
 
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
@@ -1605,6 +1615,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_del_off_timer(hdev);
 	del_timer(&hdev->adv_timer);
 	del_timer(&hdev->le_scan_timer);
+	del_timer(&hdev->rssi_timer);
 
 	destroy_workqueue(hdev->workqueue);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bda2b23..9c90090 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -48,6 +48,8 @@ enum bt_device_type {
 #define RSSI_MONITOR_ALERT_LOW		0x01
 #define RSSI_MONITOR_ALERT_HIGH		0x02
 
+#define RSSI_MONITOR_TIMEOUT		2000
+
 struct pending_cmd {
 	struct list_head list;
 	__u16 opcode;
@@ -67,6 +69,9 @@ struct rssi_monitor {
 	u8 last_alert;
 };
 
+static spinlock_t rssi_monitor_list_lock;
+static DEFINE_SPINLOCK(rssi_monitor_list_lock);
+
 static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
@@ -1933,16 +1938,23 @@ static int rssi_monitor_add(u16 index, bdaddr_t *bdaddr, s8 low_trigger,
 {
 	struct rssi_monitor *rm;
 	struct hci_dev *hdev;
+	int err = 0;
 
 	if (rssi_check_trigger_values(low_trigger, high_trigger))
 		return -EINVAL;
 
-	if (rssi_monitor_find(index, bdaddr))
-		return -EEXIST;
+	spin_lock_bh(&rssi_monitor_list_lock);
+
+	if (rssi_monitor_find(index, bdaddr)) {
+		err = -EEXIST;
+		goto out;
+	}
 
 	rm = kzalloc(sizeof(*rm), GFP_ATOMIC);
-	if (!rm)
-		return -ENOMEM;
+	if (!rm) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	bacpy(&rm->bdaddr, bdaddr);
 	rm->low_trigger = low_trigger;
@@ -1952,28 +1964,54 @@ static int rssi_monitor_add(u16 index, bdaddr_t *bdaddr, s8 low_trigger,
 	hdev = hci_dev_get(index);
 	if (!hdev) {
 		kfree(rm);
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
 	list_add(&rm->list, &hdev->rssi_monitors);
 
+	mod_timer(&hdev->rssi_timer, jiffies +
+			msecs_to_jiffies(RSSI_MONITOR_TIMEOUT));
+
 	hci_dev_put(hdev);
 
-	return 0;
+out:
+	spin_unlock_bh(&rssi_monitor_list_lock);
+
+	return err;
 }
 
 static int rssi_monitor_remove(u16 index, bdaddr_t *bdaddr)
 {
 	struct rssi_monitor *rm;
+	struct hci_dev *hdev;
+	int err = 0;
+
+	spin_lock_bh(&rssi_monitor_list_lock);
 
 	rm = rssi_monitor_find(index, bdaddr);
-	if (!rm)
-		return -EINVAL;
+	if (!rm) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	list_del(&rm->list);
 	kfree(rm);
 
-	return 0;
+	hdev = hci_dev_get(index);
+	if (!hdev) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (list_empty(&hdev->rssi_monitors))
+		del_timer(&hdev->rssi_timer);
+
+	hci_dev_put(hdev);
+
+out:
+	spin_unlock_bh(&rssi_monitor_list_lock);
+	return err;
 }
 
 static int enable_rssi_monitor(struct sock *sk, u16 index,
@@ -2015,7 +2053,11 @@ int mgmt_rssi_monitor_send_alert(u16 index, bdaddr_t *bdaddr, s8 rssi)
 	struct mgmt_ev_rssi_monitor_alert ev;
 	u8 alert;
 
+	spin_lock(&rssi_monitor_list_lock);
+
 	rm = rssi_monitor_find(index, bdaddr);
+
+	spin_unlock(&rssi_monitor_list_lock);
 	if (!rm)
 		return -EINVAL;
 
@@ -2729,3 +2771,20 @@ static int mgmt_read_rssi(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return hci_send_cmd(hdev, HCI_OP_READ_RSSI, sizeof(rs), &rs);
 }
 
+void mgmt_monitor_rssi(struct hci_dev *hdev)
+{
+	struct rssi_monitor *rm;
+
+	spin_lock(&rssi_monitor_list_lock);
+
+	list_for_each_entry(rm, &hdev->rssi_monitors, list)
+		mgmt_read_rssi(hdev, &rm->bdaddr);
+
+	if (list_empty(&hdev->rssi_monitors))
+		return;
+
+	mod_timer(&hdev->rssi_timer, jiffies +
+			msecs_to_jiffies(RSSI_MONITOR_TIMEOUT));
+
+	spin_unlock(&rssi_monitor_list_lock);
+}
-- 
1.7.4.1

