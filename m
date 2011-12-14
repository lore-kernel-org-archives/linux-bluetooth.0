Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: LE scan infra-structure
Date: Wed, 14 Dec 2011 13:25:24 -0300
Message-Id: <1323879926-15971-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hci_core an infra-structure to scan LE devices.

The LE scan is implemented using a work_struct which is enqueued
on hdev->workqueue. The LE scan work sends commands (Set LE Scan
Parameters and Set LE Scan Enable) to the controller and waits for
its results. If commands were executed successfully a timer is set
to disable the ongoing scanning after some amount of time.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |   13 ++++++++
 net/bluetooth/hci_core.c         |   60 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   15 +++++++--
 4 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 67ad984..e419e1c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -274,6 +274,7 @@ enum {
 
 /* ---- HCI Error Codes ---- */
 #define HCI_ERROR_AUTH_FAILURE		0x05
+#define HCI_ERROR_TIMEOUT		0x08
 #define HCI_ERROR_REJ_BAD_ADDR		0x0f
 #define HCI_ERROR_REMOTE_USER_TERM	0x13
 #define HCI_ERROR_LOCAL_HOST_TERM	0x16
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4db9a2f..0ef3c7c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -121,6 +121,13 @@ struct adv_entry {
 	u8 bdaddr_type;
 };
 
+struct le_scan_params {
+	u8 type;
+	u16 interval;
+	u16 window;
+	int timeout;
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -254,6 +261,12 @@ struct hci_dev {
 
 	unsigned long		dev_flags;
 
+	struct work_struct	le_scan_wk;
+	struct le_scan_params	le_scan_params;
+	u8			le_scan_result;
+	wait_queue_head_t	le_scan_wait_q;
+	struct timer_list	le_scan_timer;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7923efc..56fcc59 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -620,6 +620,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
 		cancel_delayed_work(&hdev->power_off);
 
+	cancel_work_sync(&hdev->le_scan_wk);
+	del_timer_sync(&hdev->le_scan_timer);
+
 	hci_dev_lock_bh(hdev);
 	inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
@@ -1435,6 +1438,58 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	return 0;
 }
 
+static void le_scan_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, le_scan_wk);
+	struct le_scan_params *params = &hdev->le_scan_params;
+	long timeout = msecs_to_jiffies(3000);
+	DECLARE_WAITQUEUE(wait, current);
+
+	BT_DBG("%s", hdev->name);
+
+	add_wait_queue(&hdev->le_scan_wait_q, &wait);
+
+	/* Send LE Set Scan Parameter command and wait for the result */
+	hdev->le_scan_result = HCI_ERROR_TIMEOUT;
+	send_le_scan_param_cmd(hdev, params->type, params->interval,
+							params->window);
+
+	schedule_timeout_uninterruptible(timeout);
+	if (hdev->le_scan_result)
+		goto failed;
+
+	/* Send LE Set Scan Enable command and wait for the result */
+	hdev->le_scan_result = HCI_ERROR_TIMEOUT;
+	send_le_scan_enable_cmd(hdev, 1);
+
+	schedule_timeout_uninterruptible(timeout);
+	if (hdev->le_scan_result)
+		goto failed;
+
+	remove_wait_queue(&hdev->le_scan_wait_q, &wait);
+
+	mod_timer(&hdev->le_scan_timer, jiffies +
+					msecs_to_jiffies(params->timeout));
+
+	return;
+
+failed:
+	remove_wait_queue(&hdev->le_scan_wait_q, &wait);
+
+	hci_dev_lock_bh(hdev);
+	mgmt_start_discovery_failed(hdev, hdev->le_scan_result);
+	hci_dev_unlock_bh(hdev);
+}
+
+static void le_scan_timeout(unsigned long arg)
+{
+	struct hci_dev *hdev = (void *) arg;
+
+	BT_DBG("%s", hdev->name);
+
+	send_le_scan_enable_cmd(hdev, 0);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1522,6 +1577,11 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	atomic_set(&hdev->promisc, 0);
 
+	INIT_WORK(&hdev->le_scan_wk, le_scan_work);
+	init_waitqueue_head(&hdev->le_scan_wait_q);
+	setup_timer(&hdev->le_scan_timer, le_scan_timeout,
+							(unsigned long) hdev);
+
 	write_unlock_bh(&hci_dev_list_lock);
 
 	hdev->workqueue = create_singlethread_workqueue(hdev->name);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1f74b54..232505b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -997,6 +997,9 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	hdev->le_scan_result = status;
+	wake_up(&hdev->le_scan_wait_q);
 }
 
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
@@ -1007,14 +1010,17 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
-		return;
-
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
 	if (!cp)
 		return;
 
 	if (cp->enable == 0x01) {
+		hdev->le_scan_result = status;
+		wake_up(&hdev->le_scan_wait_q);
+
+		if (status)
+			return;
+
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		del_timer(&hdev->adv_timer);
@@ -1027,6 +1033,9 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		hci_dev_unlock(hdev);
 	} else if (cp->enable == 0x00) {
+		if (status)
+			return;
+
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
-- 
1.7.8

