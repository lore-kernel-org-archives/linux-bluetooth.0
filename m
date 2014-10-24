Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] Add le_scan_restart that can be used to restart le scan. In order to use it please i.e. do:
Date: Thu, 23 Oct 2014 17:20:08 -0700
Message-Id: <1414110008-8525-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart, 300);
---
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  3 ++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b8685a7..0865bc1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -307,6 +307,8 @@ struct hci_dev {
 	struct discovery_state	discovery;
 	struct hci_conn_hash	conn_hash;
 
+	bool scan_restart;
+
 	struct list_head	mgmt_pending;
 	struct list_head	blacklist;
 	struct list_head	whitelist;
@@ -334,6 +336,7 @@ struct hci_dev {
 	unsigned long		dev_flags;
 
 	struct delayed_work	le_scan_disable;
+	struct delayed_work	le_scan_restart;
 
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cb05d7f..19f0b03 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2580,6 +2580,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		cancel_delayed_work(&hdev->service_cache);
 
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		cancel_delayed_work_sync(&hdev->rpa_expired);
@@ -3846,6 +3847,8 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
+
 	hci_req_init(&req, hdev);
 
 	hci_req_add_le_scan_disable(&req);
@@ -3855,6 +3858,40 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
+static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
+{
+	hdev->scan_restart = false;
+
+	if (status) {
+		BT_ERR("Failed to restart LE scanning: status %d", status);
+	}
+}
+
+static void le_scan_restart_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    le_scan_restart.work);
+	struct hci_request req;
+	struct hci_cp_le_set_scan_enable cp;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_req_init(&req, hdev);
+
+	hci_req_add_le_scan_disable(&req);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_ENABLE;
+	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+
+	hdev->scan_restart = true;
+
+	err = hci_req_run(&req, le_scan_restart_work_complete);
+	if (err)
+		BT_ERR("Disable LE scanning request failed: err %d", err);
+}
+
 static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -4007,6 +4044,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->conn_info_min_age = DEFAULT_CONN_INFO_MIN_AGE;
 	hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
 
+	hdev->scan_restart = false;
+
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
@@ -4032,6 +4071,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9629153..0191f76 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1155,7 +1155,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		/* Cancel this timer so that we don't try to disable scanning
 		 * when it's already disabled.
 		 */
-		cancel_delayed_work(&hdev->le_scan_disable);
+		if (!hdev->scan_restart)
+			cancel_delayed_work(&hdev->le_scan_disable);
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
-- 
2.1.0.rc2.206.gedb03e5

