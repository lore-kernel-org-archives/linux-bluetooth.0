Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 02/20] Bluetooth: hci_core/mgmt: move adv timeout to hdev
Date: Thu, 18 Jun 2015 03:16:35 +0200
Message-Id: <1434590213-26599-3-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
References: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently the delayed work managing advertising duration and timeout is
part of the advertising instance structure. This is not correct as only
a single instance can be advertised at any given time. To implement
round robin advertising a single delayed work structure is needed.

To fix this the delayed work structure is being moved to the hci_dev
structure. The instance specific variable is renamed to "remaining_time"
to make it clear that this is the remaining lifetime of the instance and
not the current advertising timeout.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 include/net/bluetooth/hci_core.h |  5 ++++-
 net/bluetooth/hci_core.c         | 29 +++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 27 +++++++++++----------------
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4242dbf..b53e1b1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -156,11 +156,11 @@ struct oob_data {
 };
 
 struct adv_info {
-	struct delayed_work timeout_exp;
 	struct list_head list;
 	__u8	instance;
 	__u32	flags;
 	__u16	timeout;
+	__u16	remaining_time;
 	__u16	duration;
 	__u16	adv_data_len;
 	__u8	adv_data[HCI_MAX_AD_LENGTH];
@@ -382,6 +382,8 @@ struct hci_dev {
 	struct list_head	adv_instances;
 	unsigned int		adv_instance_cnt;
 	__u8			cur_adv_instance;
+	__u16			adv_instance_timeout;
+	struct delayed_work	adv_instance_expire;
 
 	__u8			irk[16];
 	__u32			rpa_timeout;
@@ -1379,6 +1381,7 @@ void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
 int mgmt_update_adv_data(struct hci_dev *hdev);
 void mgmt_discoverable_timeout(struct hci_dev *hdev);
+void mgmt_adv_timeout_expired(struct hci_dev *hdev);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
 void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ebf37eb..d1110db 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1591,6 +1591,11 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		cancel_delayed_work_sync(&hdev->rpa_expired);
 
+	if (hdev->adv_instance_timeout) {
+		cancel_delayed_work_sync(&hdev->adv_instance_expire);
+		hdev->adv_instance_timeout = 0;
+	}
+
 	/* Avoid potential lockdep warnings from the *_flush() calls by
 	 * ensuring the workqueue is empty up front.
 	 */
@@ -2147,6 +2152,17 @@ static void hci_discov_off(struct work_struct *work)
 	mgmt_discoverable_timeout(hdev);
 }
 
+static void hci_adv_timeout_expire(struct work_struct *work)
+{
+	struct hci_dev *hdev;
+
+	hdev = container_of(work, struct hci_dev, adv_instance_expire.work);
+
+	BT_DBG("%s", hdev->name);
+
+	mgmt_adv_timeout_expired(hdev);
+}
+
 void hci_uuids_clear(struct hci_dev *hdev)
 {
 	struct bt_uuid *uuid, *tmp;
@@ -2650,6 +2666,11 @@ int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
 
 	BT_DBG("%s removing %dMR", hdev->name, instance);
 
+	if (hdev->cur_adv_instance == instance && hdev->adv_instance_timeout) {
+		cancel_delayed_work(&hdev->adv_instance_expire);
+		hdev->adv_instance_timeout = 0;
+	}
+
 	list_del(&adv_instance->list);
 	kfree(adv_instance);
 
@@ -2663,6 +2684,11 @@ void hci_adv_instances_clear(struct hci_dev *hdev)
 {
 	struct adv_info *adv_instance, *n;
 
+	if (hdev->adv_instance_timeout) {
+		cancel_delayed_work(&hdev->adv_instance_expire);
+		hdev->adv_instance_timeout = 0;
+	}
+
 	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
 		list_del(&adv_instance->list);
 		kfree(adv_instance);
@@ -2712,6 +2738,7 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 		       scan_rsp_data, scan_rsp_len);
 
 	adv_instance->timeout = timeout;
+	adv_instance->remaining_time = timeout;
 
 	if (duration == 0)
 		adv_instance->duration = HCI_DEFAULT_ADV_DURATION;
@@ -3130,6 +3157,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->adv_tx_power = HCI_TX_POWER_INVALID;
 	hdev->adv_instance_cnt = 0;
 	hdev->cur_adv_instance = 0x00;
+	hdev->adv_instance_timeout = 0;
 
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
@@ -3183,6 +3211,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
+	INIT_DELAYED_WORK(&hdev->adv_instance_expire, hci_adv_timeout_expire);
 
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 92c50a1..a8319f6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1466,8 +1466,8 @@ static void clear_adv_instance(struct hci_dev *hdev)
 	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
 		return;
 
-	if (hdev->adv_instance.timeout)
-		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
+	if (hdev->adv_instance_timeout)
+		cancel_delayed_work(&hdev->adv_instance_expire);
 
 	memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
 	advertising_removed(NULL, hdev, 1);
@@ -1497,7 +1497,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
-	if (hdev->adv_instance.timeout)
+	if (hdev->adv_instance_timeout)
 		clear_adv_instance(hdev);
 
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
@@ -6914,12 +6914,9 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static void adv_timeout_expired(struct work_struct *work)
+void mgmt_adv_timeout_expired(struct hci_dev *hdev)
 {
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    adv_instance.timeout_exp.work);
-
-	hdev->adv_instance.timeout = 0;
+	hdev->adv_instance_timeout = 0;
 
 	hci_dev_lock(hdev);
 	clear_adv_instance(hdev);
@@ -6981,8 +6978,6 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	INIT_DELAYED_WORK(&hdev->adv_instance.timeout_exp, adv_timeout_expired);
-
 	hdev->adv_instance.flags = flags;
 	hdev->adv_instance.adv_data_len = cp->adv_data_len;
 	hdev->adv_instance.scan_rsp_len = cp->scan_rsp_len;
@@ -6994,14 +6989,14 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		memcpy(hdev->adv_instance.scan_rsp_data,
 		       cp->data + cp->adv_data_len, cp->scan_rsp_len);
 
-	if (hdev->adv_instance.timeout)
-		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
+	if (hdev->adv_instance_timeout)
+		cancel_delayed_work(&hdev->adv_instance_expire);
 
-	hdev->adv_instance.timeout = timeout;
+	hdev->adv_instance_timeout = timeout;
 
 	if (timeout)
 		queue_delayed_work(hdev->workqueue,
-				   &hdev->adv_instance.timeout_exp,
+				   &hdev->adv_instance_expire,
 				   msecs_to_jiffies(timeout * 1000));
 
 	if (!hci_dev_test_and_set_flag(hdev, HCI_ADVERTISING_INSTANCE))
@@ -7106,8 +7101,8 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (hdev->adv_instance.timeout)
-		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
+	if (hdev->adv_instance_timeout)
+		cancel_delayed_work(&hdev->adv_instance_expire);
 
 	memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
 
-- 
1.9.1

