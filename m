Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 13/15] Bluetooth: LE scan infra-structure
Date: Wed,  5 Oct 2011 20:20:45 -0300
Message-Id: <1317856847-28167-14-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hci_core the infra-structure to carry out the
LE scan. Functions were created to init the LE scan and cancel
an ongoing scanning (hci_do_le_scan and hci_cancel_le_scan).

Also, the HCI_LE_SCAN flag was created to inform if the controller
is performing LE scan. The flag is set/cleared when the controller
starts/stops scanning.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    2 +
 include/net/bluetooth/hci_core.h |    5 +++
 net/bluetooth/hci_core.c         |   69 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |    4 ++
 4 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 11537b8..7520544 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -86,6 +86,8 @@ enum {
 	HCI_DEBUG_KEYS,
 
 	HCI_RESET,
+
+	HCI_LE_SCAN,
 };
 
 /* HCI ioctl defines */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 65a1ccf..c6ae380 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -208,6 +208,8 @@ struct hci_dev {
 	struct list_head	adv_entries;
 	struct timer_list	adv_timer;
 
+	struct timer_list	le_scan_timer;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
@@ -918,5 +920,8 @@ void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
+int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
+								int timeout);
+int hci_cancel_le_scan(struct hci_dev *hdev);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e60f16a..0d0e460 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1421,6 +1421,23 @@ int hci_add_adv_entry(struct hci_dev *hdev,
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
@@ -1491,6 +1508,9 @@ int hci_register_dev(struct hci_dev *hdev)
 	setup_timer(&hdev->adv_timer, hci_clear_adv_cache,
 						(unsigned long) hdev);
 
+	setup_timer(&hdev->le_scan_timer, le_scan_timeout,
+						(unsigned long) hdev);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
@@ -1564,6 +1584,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_del_off_timer(hdev);
 	del_timer(&hdev->adv_timer);
+	del_timer(&hdev->le_scan_timer);
 
 	destroy_workqueue(hdev->workqueue);
 
@@ -2434,3 +2455,51 @@ int hci_cancel_inquiry(struct hci_dev *hdev)
 
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
+	BT_DBG("%s", hdev->name);
+
+	if (test_bit(HCI_LE_SCAN, &hdev->flags))
+		return -EPERM;
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
+	BT_DBG("%s", hdev->name);
+
+	if (!test_bit(HCI_LE_SCAN, &hdev->flags))
+		return -EPERM;
+
+	del_timer(&hdev->le_scan_timer);
+
+	return le_scan(hdev, 0);
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8f3e00d..841501c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -897,6 +897,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		return;
 
 	if (cp->enable == 0x01) {
+		set_bit(HCI_LE_SCAN, &hdev->flags);
+
 		mgmt_discovering(hdev->id, 1);
 
 		del_timer(&hdev->adv_timer);
@@ -905,6 +907,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		hci_adv_entries_clear(hdev);
 		hci_dev_unlock(hdev);
 	} else if (cp->enable == 0x00) {
+		clear_bit(HCI_LE_SCAN, &hdev->flags);
+
 		mgmt_discovering(hdev->id, 0);
 
 		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
-- 
1.7.5.2

