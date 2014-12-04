Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v14 1/3] Bluetooth: add le_scan_restart
Date: Wed,  3 Dec 2014 23:53:57 -0800
Message-Id: <1417679639-21409-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently there is no way to restart le scan. It's needed in
preparation for new service scan method. The way it work: it disable,
and then enable le scan on controller. During this restart special flag
is set to make sure we won't remove disable scan work from workqueue.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h |  9 +++++++++
 net/bluetooth/hci_core.c         | 42 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  9 ++++++---
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1dae700..d30e301 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -56,6 +56,13 @@ struct inquiry_entry {
 	struct inquiry_data	data;
 };
 
+/* BR/EDR and/or LE discovery state flags: the flags defined here should
+ * represent state of discovery
+ */
+enum {
+	HCI_LE_SCAN_RESTARTING,
+};
+
 struct discovery_state {
 	int			type;
 	enum {
@@ -75,6 +82,7 @@ struct discovery_state {
 	u32			last_adv_flags;
 	u8			last_adv_data[HCI_MAX_AD_LENGTH];
 	u8			last_adv_data_len;
+	unsigned long		flags;
 };
 
 struct hci_conn_hash {
@@ -339,6 +347,7 @@ struct hci_dev {
 	unsigned long		dev_flags;
 
 	struct delayed_work	le_scan_disable;
+	struct delayed_work	le_scan_restart;
 
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f001856..5351084 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2602,6 +2602,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		cancel_delayed_work(&hdev->service_cache);
 
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		cancel_delayed_work_sync(&hdev->rpa_expired);
@@ -3870,6 +3871,8 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
+
 	hci_req_init(&req, hdev);
 
 	hci_req_add_le_scan_disable(&req);
@@ -3879,6 +3882,44 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
+static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
+{
+	clear_bit(HCI_LE_SCAN_RESTARTING, &hdev->discovery.flags);
+
+	if (status)
+		BT_ERR("Failed to restart LE scan: status %d", status);
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
+	/* If controller is not scanning we are done. */
+	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return;
+
+	hci_req_init(&req, hdev);
+
+	hci_req_add_le_scan_disable(&req);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_ENABLE;
+	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+
+	set_bit(HCI_LE_SCAN_RESTARTING, &hdev->discovery.flags);
+
+	err = hci_req_run(&req, le_scan_restart_work_complete);
+	if (err)
+		BT_ERR("Restart LE scan request failed: err %d", err);
+}
+
 static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -4056,6 +4097,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f4e2a61..8c580d1 100644
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
+		if (!test_bit(HCI_LE_SCAN_RESTARTING, &hdev->discovery.flags))
+			cancel_delayed_work(&hdev->le_scan_disable);
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
-- 
2.2.0.rc0.207.ga3a616c

