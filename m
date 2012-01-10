Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/7] Bluetooth: LE scan infrastructure
Date: Tue, 10 Jan 2012 18:20:53 -0300
Message-Id: <1326230455-9117-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1326230455-9117-1-git-send-email-andre.guedes@openbossa.org>
References: <1326230455-9117-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hci_core an infrastructure to scan LE devices.

Two works were created to handle the LE scan. The le_scan_enable
work sends commands to the controller and waits for its results.
If the commands were executed successfully a delayed work
(le_scan_disable) is scheduled to disable the ongoing scanning
after some amount of time.

The le_scan_enable work should be queue on system_long_wq since
it can sleep for a few seconds in the worst case.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |   13 ++++++++
 net/bluetooth/hci_core.c         |   61 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   15 +++++++--
 4 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3ee39ed..5a45538 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -276,6 +276,7 @@ enum {
 
 /* ---- HCI Error Codes ---- */
 #define HCI_ERROR_AUTH_FAILURE		0x05
+#define HCI_ERROR_TIMEOUT		0x08
 #define HCI_ERROR_REJ_BAD_ADDR		0x0f
 #define HCI_ERROR_REMOTE_USER_TERM	0x13
 #define HCI_ERROR_LOCAL_HOST_TERM	0x16
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 954a577..07b9681 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -126,6 +126,13 @@ struct adv_entry {
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
@@ -264,6 +271,12 @@ struct hci_dev {
 
 	unsigned long		dev_flags;
 
+	struct work_struct	le_scan_enable;
+	struct delayed_work	le_scan_disable;
+	struct le_scan_params	le_scan_params;
+	wait_queue_head_t	le_scan_wait_q;
+	u8			le_scan_result;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0f8884f..46bb069 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -778,6 +778,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		cancel_delayed_work(&hdev->service_cache);
 
+	cancel_work_sync(&hdev->le_scan_enable);
+	cancel_delayed_work_sync(&hdev->le_scan_disable);
+
 	hci_dev_lock(hdev);
 	inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
@@ -1592,6 +1595,60 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	return 0;
 }
 
+static void le_scan_enable_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+							le_scan_enable);
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
+	schedule_delayed_work(&hdev->le_scan_disable,
+					msecs_to_jiffies(params->timeout));
+
+	return;
+
+failed:
+	remove_wait_queue(&hdev->le_scan_wait_q, &wait);
+
+	hci_dev_lock(hdev);
+	mgmt_start_discovery_failed(hdev, hdev->le_scan_result);
+	hci_dev_unlock(hdev);
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
@@ -1677,6 +1734,10 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	atomic_set(&hdev->promisc, 0);
 
+	INIT_WORK(&hdev->le_scan_enable, le_scan_enable_work);
+	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+	init_waitqueue_head(&hdev->le_scan_wait_q);
+
 	write_unlock(&hci_dev_list_lock);
 
 	hdev->workqueue = alloc_workqueue(hdev->name, WQ_HIGHPRI | WQ_UNBOUND |
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2d86604..9ef2057 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1024,6 +1024,9 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	hdev->le_scan_result = status;
+	wake_up(&hdev->le_scan_wait_q);
 }
 
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
@@ -1034,15 +1037,18 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
-		return;
-
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
 	if (!cp)
 		return;
 
 	switch (cp->enable) {
 	case LE_SCANNING_ENABLED:
+		hdev->le_scan_result = status;
+		wake_up(&hdev->le_scan_wait_q);
+
+		if (status)
+			return;
+
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		cancel_delayed_work_sync(&hdev->adv_work);
@@ -1054,6 +1060,9 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		break;
 
 	case LE_SCANNING_DISABLED:
+		if (status)
+			return;
+
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		hci_dev_lock(hdev);
-- 
1.7.8.1

