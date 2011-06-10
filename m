Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 13/16] Bluetooth: Add 'le_scan_timer' to struct hci_dev
Date: Fri, 10 Jun 2011 16:36:10 -0300
Message-Id: <1307734573-1630-14-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
References: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a timer to disable LE Scan after some amount of
time. The timer will be controlled by the management interface and
it will be used to carry out discovery procedure in LE capable
devices.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5610c48..4eb365d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -190,6 +190,8 @@ struct hci_dev {
 	struct list_head	adv_entries;
 	struct timer_list	adv_timer;
 
+	struct timer_list	le_scan_timer;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e14e8a1..1a6bfb8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1274,6 +1274,21 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	return 0;
 }
 
+static void hci_disable_le_scan(unsigned long arg)
+{
+	struct hci_cp_le_set_scan_enable cp;
+	struct hci_dev *hdev = (void *) arg;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = 0;
+
+	hci_dev_lock(hdev);
+
+	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+
+	hci_dev_unlock(hdev);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1344,6 +1359,9 @@ int hci_register_dev(struct hci_dev *hdev)
 	setup_timer(&hdev->adv_timer, hci_clear_adv_cache,
 						(unsigned long) hdev);
 
+	setup_timer(&hdev->le_scan_timer, hci_disable_le_scan,
+						(unsigned long) hdev);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
@@ -1417,6 +1435,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_del_off_timer(hdev);
 	del_timer(&hdev->adv_timer);
+	del_timer(&hdev->le_scan_timer);
 
 	destroy_workqueue(hdev->workqueue);
 
-- 
1.7.4.1

