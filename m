Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v7 1/2] Bluetooth: Add le_scan_restart
Date: Fri,  9 Jan 2015 05:46:15 -0800
Message-Id: <1420811176-31658-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently there is no way to restart le scan, and it's needed in
service scan method. The way it work: it disable, and then enable le
scan on controller.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 54 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |  7 +++++-
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 89f4e3c..add94f6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -79,6 +79,7 @@ struct discovery_state {
 	s8			rssi;
 	u16			uuid_count;
 	u8			(*uuids)[16];
+	long		scan_end;
 };
 
 struct hci_conn_hash {
@@ -349,6 +350,7 @@ struct hci_dev {
 	unsigned long		dev_flags;
 
 	struct delayed_work	le_scan_disable;
+	struct delayed_work	le_scan_restart;
 
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
@@ -525,6 +527,7 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 	hdev->discovery.uuid_count = 0;
 	kfree(hdev->discovery.uuids);
 	hdev->discovery.uuids = NULL;
+	hdev->discovery.scan_end = 0;
 }
 
 bool hci_discovery_active(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bc5486e..89968dc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1608,6 +1608,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		cancel_delayed_work(&hdev->service_cache);
 
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		cancel_delayed_work_sync(&hdev->rpa_expired);
@@ -2781,12 +2782,15 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_LE:
+		hdev->discovery.scan_end = 0;
 		hci_dev_lock(hdev);
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		hci_dev_unlock(hdev);
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
+		hdev->discovery.scan_end = 0;
+
 		hci_req_init(&req, hdev);
 
 		memset(&cp, 0, sizeof(cp));
@@ -2818,6 +2822,8 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
+
 	hci_req_init(&req, hdev);
 
 	hci_req_add_le_scan_disable(&req);
@@ -2827,6 +2833,53 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
+static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("%s", hdev->name);
+
+	if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) &&
+	    hdev->discovery.scan_end != 0) {
+		long timeout = hdev->discovery.scan_end - jiffies;
+
+		if (timeout < 0)
+			timeout = 0;
+		queue_delayed_work(hdev->workqueue,
+				   &hdev->le_scan_disable, timeout);
+	}
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
+	err = hci_req_run(&req, le_scan_restart_work_complete);
+
+	if (err)
+		BT_ERR("Restart LE scan request failed: err %d", err);
+}
+
 /* Copy the Identity Address of the controller.
  *
  * If the controller has a public BD_ADDR, then by default use that one.
@@ -2922,6 +2975,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6b3f553..9f295cd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3875,9 +3875,14 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 		break;
 	}
 
-	if (timeout)
+	if (timeout) {
+		if (hdev->discovery.uuid_count > 0 &&
+		    test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))
+			hdev->discovery.scan_end = jiffies + timeout;
+
 		queue_delayed_work(hdev->workqueue,
 				   &hdev->le_scan_disable, timeout);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.2.0.rc0.207.ga3a616c

