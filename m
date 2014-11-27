Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v11 1/3] Bluetooth: add hci_restart_le_scan
Date: Wed, 26 Nov 2014 17:29:25 -0800
Message-Id: <1417051767-19597-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently there is no way to restart le scan. It's needed in
preparation for new service scan method. The way it work: it disable,
and then enable le scan on controller. During this restart special flag
is set to make sure we won't remove disable scan work from workqueue.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci.h      |  8 +++++++
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_core.c         | 50 +++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c        |  9 +++++---
 4 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e56f909..a8784e6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -205,6 +205,14 @@ enum {
 	HCI_LE_SCAN_INTERRUPTED,
 };
 
+/*
+ * BR/EDR and/or LE discovery state flags: the flags defined here should
+ * represent state of discovery
+ */
+enum {
+	HCI_LE_SCAN_RESTARTING,
+};
+
 /* A mask for the flags that are supposed to remain when a reset happens
  * or the HCI device is closed.
  */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 396c098..7e10308 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -75,6 +75,7 @@ struct discovery_state {
 	u32			last_adv_flags;
 	u8			last_adv_data[HCI_MAX_AD_LENGTH];
 	u8			last_adv_data_len;
+	unsigned long		flags;
 };
 
 struct hci_conn_hash {
@@ -337,6 +338,7 @@ struct hci_dev {
 	unsigned long		dev_flags;
 
 	struct delayed_work	le_scan_disable;
+	struct delayed_work	le_scan_restart;
 
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
@@ -1326,6 +1328,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define DISCOV_INTERLEAVED_TIMEOUT	5120	/* msec */
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
+#define DISCOV_LE_RESTART_DELAY		300	/* msec */
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_new_settings(struct hci_dev *hdev);
@@ -1403,6 +1406,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 			      u8 *own_addr_type);
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
+void hci_restart_le_scan(struct hci_dev *hdev);
 
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5c319a4..97d2d35 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2557,6 +2557,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		cancel_delayed_work(&hdev->service_cache);
 
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		cancel_delayed_work_sync(&hdev->rpa_expired);
@@ -3851,13 +3852,59 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
+
 	hci_req_init(&req, hdev);
 
 	hci_req_add_le_scan_disable(&req);
 
 	err = hci_req_run(&req, le_scan_disable_work_complete);
 	if (err)
-		BT_ERR("Disable LE scanning request failed: err %d", err);
+		BT_ERR("Disable LE scan request failed: err %d", err);
+}
+
+void hci_restart_le_scan(struct hci_dev *hdev)
+{
+	queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart,
+			   msecs_to_jiffies(DISCOV_LE_RESTART_DELAY));
+}
+
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
 }
 
 static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
@@ -4037,6 +4084,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bd0a801..ee19656 100644
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

