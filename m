Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: [PATCH v3 3/6] Bluetooth: Add hci_do_le_scan()
Date: Wed, 25 Jan 2012 19:52:26 -0300
Message-Id: <1327531949-29463-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hci_core the hci_do_le_scan function which
should be used to scan LE devices.

In order to enable LE scan, hci_do_le_scan() sends commands (Set
LE Scan Parameters and Set LE Scan Enable) to the controller and
waits for its results. If commands were executed successfully a
delayed work is scheduled to disable the ongoing scanning after
some amount of time. This function blocks.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    5 +++
 net/bluetooth/hci_core.c         |   57 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   15 ++++++++--
 3 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4e569d8..d157762 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -263,6 +263,11 @@ struct hci_dev {
 
 	unsigned long		dev_flags;
 
+	struct delayed_work	le_scan_disable;
+
+	wait_queue_head_t	le_scan_wait_q;
+	u8			le_scan_result;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4830995..22abc37 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -779,6 +779,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		cancel_delayed_work(&hdev->service_cache);
 
+	cancel_delayed_work_sync(&hdev->le_scan_disable);
+
 	hci_dev_lock(hdev);
 	inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
@@ -1593,6 +1595,57 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	return 0;
 }
 
+static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
+						u16 window, int timeout)
+{
+	long timeo = msecs_to_jiffies(3000);
+	DECLARE_WAITQUEUE(wait, current);
+
+	BT_DBG("%s", hdev->name);
+
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return -EINPROGRESS;
+
+	add_wait_queue(&hdev->le_scan_wait_q, &wait);
+
+	/* Send LE Set Scan Parameter command and wait for the result */
+	hdev->le_scan_result = -ETIMEDOUT;
+	send_le_scan_param_cmd(hdev, type, interval, window);
+
+	schedule_timeout_uninterruptible(timeo);
+	if (hdev->le_scan_result)
+		goto failed;
+
+	/* Send LE Set Scan Enable command and wait for the result */
+	hdev->le_scan_result = -ETIMEDOUT;
+	send_le_scan_enable_cmd(hdev, 1);
+
+	schedule_timeout_uninterruptible(timeo);
+	if (hdev->le_scan_result)
+		goto failed;
+
+	remove_wait_queue(&hdev->le_scan_wait_q, &wait);
+
+	schedule_delayed_work(&hdev->le_scan_disable,
+						msecs_to_jiffies(timeout));
+
+	return 0;
+
+failed:
+	remove_wait_queue(&hdev->le_scan_wait_q, &wait);
+	return hdev->le_scan_result;
+}
+
+static void le_scan_disable_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+						le_scan_disable.work);
+
+	BT_DBG("%s", hdev->name);
+
+	send_le_scan_enable_cmd(hdev, 0);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1678,6 +1731,10 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	atomic_set(&hdev->promisc, 0);
 
+	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+
+	init_waitqueue_head(&hdev->le_scan_wait_q);
+
 	write_unlock(&hci_dev_list_lock);
 
 	hdev->workqueue = alloc_workqueue(hdev->name, WQ_HIGHPRI | WQ_UNBOUND |
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dd8056c..856ab35 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1030,6 +1030,9 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	hdev->le_scan_result = -bt_to_errno(status);
+	wake_up(&hdev->le_scan_wait_q);
 }
 
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
@@ -1040,15 +1043,18 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
-		return;
-
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
 	if (!cp)
 		return;
 
 	switch (cp->enable) {
 	case LE_SCANNING_ENABLED:
+		hdev->le_scan_result = -bt_to_errno(status);
+		wake_up(&hdev->le_scan_wait_q);
+
+		if (status)
+			return;
+
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		cancel_delayed_work_sync(&hdev->adv_work);
@@ -1060,6 +1066,9 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		break;
 
 	case LE_SCANNING_DISABLED:
+		if (status)
+			return;
+
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		hci_dev_lock(hdev);
-- 
1.7.8.4
