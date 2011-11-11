Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: LE scan infra-structure
Date: Fri, 11 Nov 2011 19:50:21 -0300
Message-Id: <1321051824-5216-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hci_core the infra-structure to carry out the
LE scan. Functions were created to init the LE scan and cancel
an ongoing scanning (hci_do_le_scan and hci_cancel_le_scan).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    5 +++
 net/bluetooth/hci_core.c         |   69 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f6d5d90..69dda9b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -232,6 +232,8 @@ struct hci_dev {
 	struct list_head	adv_entries;
 	struct timer_list	adv_timer;
 
+	struct timer_list	le_scan_timer;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
@@ -987,5 +989,8 @@ void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
+int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
+								int timeout);
+int hci_cancel_le_scan(struct hci_dev *hdev);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 64cdafe..c07dc15 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1423,6 +1423,23 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	return 0;
 }
 
+static int le_scan(struct hci_dev *hdev, u8 enable)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = enable;
+
+	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
+
+static void le_scan_timeout(unsigned long arg)
+{
+	struct hci_dev *hdev = (void *) arg;
+
+	le_scan(hdev, 0);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1501,6 +1518,9 @@ int hci_register_dev(struct hci_dev *hdev)
 	setup_timer(&hdev->adv_timer, hci_clear_adv_cache,
 						(unsigned long) hdev);
 
+	setup_timer(&hdev->le_scan_timer, le_scan_timeout,
+						(unsigned long) hdev);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 
@@ -1587,6 +1607,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_del_sysfs(hdev);
 
 	del_timer(&hdev->adv_timer);
+	del_timer(&hdev->le_scan_timer);
 
 	destroy_workqueue(hdev->workqueue);
 
@@ -2615,3 +2636,51 @@ int hci_cancel_inquiry(struct hci_dev *hdev)
 
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 }
+
+static int set_le_scan_param(struct hci_dev *hdev, u8 type, u16 interval,
+								u16 window)
+{
+	struct hci_cp_le_set_scan_param cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.type = type;
+	cp.interval = cpu_to_le16(interval);
+	cp.window = cpu_to_le16(window);
+
+	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
+}
+
+int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
+								int timeout)
+{
+	int err;
+
+	if (test_bit(HCI_LE_SCAN, &hdev->hci_flags))
+		return -EINPROGRESS;
+
+	BT_DBG("%s", hdev->name);
+
+	err = set_le_scan_param(hdev, type, interval, window);
+	if (err < 0)
+		return err;
+
+	err = le_scan(hdev, 1);
+	if (err < 0)
+		return err;
+
+	mod_timer(&hdev->le_scan_timer, jiffies + msecs_to_jiffies(timeout));
+
+	return 0;
+}
+
+int hci_cancel_le_scan(struct hci_dev *hdev)
+{
+	if (!test_bit(HCI_LE_SCAN, &hdev->hci_flags))
+		return -EPERM;
+
+	BT_DBG("%s", hdev->name);
+
+	del_timer(&hdev->le_scan_timer);
+
+	return le_scan(hdev, 0);
+}
-- 
1.7.7.1

