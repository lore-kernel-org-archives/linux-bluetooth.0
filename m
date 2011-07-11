Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 13/16] Bluetooth: Add 'le_scan_timer' to struct hci_dev
Date: Mon, 11 Jul 2011 18:11:56 -0300
Message-Id: <1310418719-12296-14-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a timer to disable LE Scan after some amount of
time. The timer will be controlled by the management interface and
it will be used to carry out discovery procedure in LE capable
devices.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   13 +++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fc9e8c4..5e78c45 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -209,6 +209,8 @@ struct hci_dev {
 	struct list_head	adv_entries;
 	struct timer_list	adv_timer;
 
+	struct timer_list	le_scan_timer;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 908fcd3..c0c46bf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1440,6 +1440,15 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	return 0;
 }
 
+static void hci_disable_le_scan(unsigned long arg)
+{
+	struct hci_cp_le_set_scan_enable cp;
+	struct hci_dev *hdev = (void *) arg;
+
+	memset(&cp, 0, sizeof(cp));
+	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1510,6 +1519,9 @@ int hci_register_dev(struct hci_dev *hdev)
 	setup_timer(&hdev->adv_timer, hci_clear_adv_cache,
 						(unsigned long) hdev);
 
+	setup_timer(&hdev->le_scan_timer, hci_disable_le_scan,
+						(unsigned long) hdev);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
@@ -1591,6 +1603,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_del_off_timer(hdev);
 	del_timer(&hdev->adv_timer);
+	del_timer(&hdev->le_scan_timer);
 
 	destroy_workqueue(hdev->workqueue);
 
-- 
1.7.4.1

