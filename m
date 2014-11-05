Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5 1/3] Bluetooth: add hci_restart_le_scan
Date: Wed,  5 Nov 2014 14:37:24 -0800
Message-Id: <1415227046-28448-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently there is no way to restart le scan. It's needed in
preparation for new service scan method. The way it work: it disable,
and then enable le scan on controller. During this restart special flag
is set to make sure we won't remove disable scan work from workqueue.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 42 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  9 ++++++---
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d5f85d7..8d43a50 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -203,6 +203,7 @@ enum {
 	HCI_FAST_CONNECTABLE,
 	HCI_BREDR_ENABLED,
 	HCI_LE_SCAN_INTERRUPTED,
+	HCI_LE_SCAN_RESTARTING,
 };
 
 /* A mask for the flags that are supposed to remain when a reset happens
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4e39a5a..1b7f9a6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -334,6 +334,7 @@ struct hci_dev {
 	unsigned long		dev_flags;
 
 	struct delayed_work	le_scan_disable;
+	struct delayed_work	le_scan_restart;
 
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
@@ -1400,6 +1401,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 			      u8 *own_addr_type);
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
+void hci_restart_le_scan(struct hci_dev *hdev, unsigned long delay);
 
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6c162c8..b926b6a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2560,6 +2560,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		cancel_delayed_work(&hdev->service_cache);
 
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		cancel_delayed_work_sync(&hdev->rpa_expired);
@@ -3826,6 +3827,8 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
+
 	hci_req_init(&req, hdev);
 
 	hci_req_add_le_scan_disable(&req);
@@ -3835,6 +3838,44 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
+void hci_restart_le_scan(struct hci_dev *hdev, unsigned long delay)
+{
+	queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart, delay);
+}
+
+static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
+{
+	clear_bit(HCI_LE_SCAN_RESTARTING, &hdev->dev_flags);
+
+	if (status)
+		BT_ERR("Failed to restart LE scanning: status %d", status);
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
+	set_bit(HCI_LE_SCAN_RESTARTING, &hdev->dev_flags);
+
+	err = hci_req_run(&req, le_scan_restart_work_complete);
+	if (err)
+		BT_ERR("Disable LE scanning request failed: err %d", err);
+}
+
 static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -4012,6 +4053,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2f02ff0..0ea8c57 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1157,10 +1157,13 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 					  d->last_adv_data_len, NULL, 0);
 		}
 
-		/* Cancel this timer so that we don't try to disable scanning
-		 * when it's already disabled.
+		/* If HCI_LE_SCAN_RESTARTING is set, don't cancel this timer,
+		 * because we're just restarting scan. Otherwise cancel it so
+		 * that we don't try to disable scanning when it's already
+		 * disabled.
 		 */
-		cancel_delayed_work(&hdev->le_scan_disable);
+		if (!test_bit(HCI_LE_SCAN_RESTARTING, &hdev->dev_flags))
+			cancel_delayed_work(&hdev->le_scan_disable);
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
-- 
2.1.0.rc2.206.gedb03e5

