Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/12] Bluetooth: Move LE scan disable/restart behind req_workqueue
Date: Tue, 10 Nov 2015 20:14:30 +0200
Message-Id: <1447179274-12276-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
References: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To avoid any risks of races, place also these LE scan modification
work callbacks behind the same work queue as the other LE scan
changes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   5 +-
 net/bluetooth/hci_core.c         | 168 ------------------------------------
 net/bluetooth/hci_request.c      | 179 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |   4 +-
 4 files changed, 183 insertions(+), 173 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c2ca6a58d1e0..1f75aebbd8c4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -328,6 +328,8 @@ struct hci_dev {
 	struct work_struct	tx_work;
 
 	struct work_struct	bg_scan_update;
+	struct delayed_work	le_scan_disable;
+	struct delayed_work	le_scan_restart;
 
 	struct sk_buff_head	rx_q;
 	struct sk_buff_head	raw_q;
@@ -372,9 +374,6 @@ struct hci_dev {
 
 	DECLARE_BITMAP(dev_flags, __HCI_NUM_FLAGS);
 
-	struct delayed_work	le_scan_disable;
-	struct delayed_work	le_scan_restart;
-
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
 	__u8			adv_data_len;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9c7e4b8e56ae..9f5984003e0e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1522,9 +1522,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
 	if (hci_dev_test_and_clear_flag(hdev, HCI_SERVICE_CACHE))
 		cancel_delayed_work(&hdev->service_cache);
 
-	cancel_delayed_work_sync(&hdev->le_scan_disable);
-	cancel_delayed_work_sync(&hdev->le_scan_restart);
-
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		cancel_delayed_work_sync(&hdev->rpa_expired);
 
@@ -2884,169 +2881,6 @@ static void hci_conn_params_clear_all(struct hci_dev *hdev)
 	BT_DBG("All LE connection parameters were removed");
 }
 
-static void inquiry_complete(struct hci_dev *hdev, u8 status, u16 opcode)
-{
-	if (status) {
-		BT_ERR("Failed to start inquiry: status %d", status);
-
-		hci_dev_lock(hdev);
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-		hci_dev_unlock(hdev);
-		return;
-	}
-}
-
-static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
-					  u16 opcode)
-{
-	/* General inquiry access code (GIAC) */
-	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	struct hci_cp_inquiry cp;
-	int err;
-
-	if (status) {
-		BT_ERR("Failed to disable LE scanning: status %d", status);
-		return;
-	}
-
-	hdev->discovery.scan_start = 0;
-
-	switch (hdev->discovery.type) {
-	case DISCOV_TYPE_LE:
-		hci_dev_lock(hdev);
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-		hci_dev_unlock(hdev);
-		break;
-
-	case DISCOV_TYPE_INTERLEAVED:
-		hci_dev_lock(hdev);
-
-		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
-			     &hdev->quirks)) {
-			/* If we were running LE only scan, change discovery
-			 * state. If we were running both LE and BR/EDR inquiry
-			 * simultaneously, and BR/EDR inquiry is already
-			 * finished, stop discovery, otherwise BR/EDR inquiry
-			 * will stop discovery when finished. If we will resolve
-			 * remote device name, do not change discovery state.
-			 */
-			if (!test_bit(HCI_INQUIRY, &hdev->flags) &&
-			    hdev->discovery.state != DISCOVERY_RESOLVING)
-				hci_discovery_set_state(hdev,
-							DISCOVERY_STOPPED);
-		} else {
-			struct hci_request req;
-
-			hci_inquiry_cache_flush(hdev);
-
-			hci_req_init(&req, hdev);
-
-			memset(&cp, 0, sizeof(cp));
-			memcpy(&cp.lap, lap, sizeof(cp.lap));
-			cp.length = DISCOV_INTERLEAVED_INQUIRY_LEN;
-			hci_req_add(&req, HCI_OP_INQUIRY, sizeof(cp), &cp);
-
-			err = hci_req_run(&req, inquiry_complete);
-			if (err) {
-				BT_ERR("Inquiry request failed: err %d", err);
-				hci_discovery_set_state(hdev,
-							DISCOVERY_STOPPED);
-			}
-		}
-
-		hci_dev_unlock(hdev);
-		break;
-	}
-}
-
-static void le_scan_disable_work(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    le_scan_disable.work);
-	struct hci_request req;
-	int err;
-
-	BT_DBG("%s", hdev->name);
-
-	cancel_delayed_work_sync(&hdev->le_scan_restart);
-
-	hci_req_init(&req, hdev);
-
-	hci_req_add_le_scan_disable(&req);
-
-	err = hci_req_run(&req, le_scan_disable_work_complete);
-	if (err)
-		BT_ERR("Disable LE scanning request failed: err %d", err);
-}
-
-static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status,
-					  u16 opcode)
-{
-	unsigned long timeout, duration, scan_start, now;
-
-	BT_DBG("%s", hdev->name);
-
-	if (status) {
-		BT_ERR("Failed to restart LE scan: status %d", status);
-		return;
-	}
-
-	if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
-	    !hdev->discovery.scan_start)
-		return;
-
-	/* When the scan was started, hdev->le_scan_disable has been queued
-	 * after duration from scan_start. During scan restart this job
-	 * has been canceled, and we need to queue it again after proper
-	 * timeout, to make sure that scan does not run indefinitely.
-	 */
-	duration = hdev->discovery.scan_duration;
-	scan_start = hdev->discovery.scan_start;
-	now = jiffies;
-	if (now - scan_start <= duration) {
-		int elapsed;
-
-		if (now >= scan_start)
-			elapsed = now - scan_start;
-		else
-			elapsed = ULONG_MAX - scan_start + now;
-
-		timeout = duration - elapsed;
-	} else {
-		timeout = 0;
-	}
-	queue_delayed_work(hdev->workqueue,
-			   &hdev->le_scan_disable, timeout);
-}
-
-static void le_scan_restart_work(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    le_scan_restart.work);
-	struct hci_request req;
-	struct hci_cp_le_set_scan_enable cp;
-	int err;
-
-	BT_DBG("%s", hdev->name);
-
-	/* If controller is not scanning we are done. */
-	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		return;
-
-	hci_req_init(&req, hdev);
-
-	hci_req_add_le_scan_disable(&req);
-
-	memset(&cp, 0, sizeof(cp));
-	cp.enable = LE_SCAN_ENABLE;
-	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
-
-	err = hci_req_run(&req, le_scan_restart_work_complete);
-	if (err)
-		BT_ERR("Restart LE scan request failed: err %d", err);
-}
-
 /* Copy the Identity Address of the controller.
  *
  * If the controller has a public BD_ADDR, then by default use that one.
@@ -3146,8 +2980,6 @@ struct hci_dev *hci_alloc_dev(void)
 
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
-	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
-	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, hci_adv_timeout_expire);
 
 	skb_queue_head_init(&hdev->rx_q);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index cd045c6bab90..4ed4d1460467 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -858,12 +858,191 @@ static void bg_scan_update(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+static void inquiry_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+{
+	if (status) {
+		BT_ERR("Failed to start inquiry: status %d", status);
+
+		hci_dev_lock(hdev);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		hci_dev_unlock(hdev);
+		return;
+	}
+}
+
+static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
+{
+	/* General inquiry access code (GIAC) */
+	u8 lap[3] = { 0x33, 0x8b, 0x9e };
+	struct hci_cp_inquiry cp;
+	int err;
+
+	if (status) {
+		BT_ERR("Failed to disable LE scanning: status %d", status);
+		return;
+	}
+
+	hdev->discovery.scan_start = 0;
+
+	switch (hdev->discovery.type) {
+	case DISCOV_TYPE_LE:
+		hci_dev_lock(hdev);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		hci_dev_unlock(hdev);
+		break;
+
+	case DISCOV_TYPE_INTERLEAVED:
+		hci_dev_lock(hdev);
+
+		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
+			     &hdev->quirks)) {
+			/* If we were running LE only scan, change discovery
+			 * state. If we were running both LE and BR/EDR inquiry
+			 * simultaneously, and BR/EDR inquiry is already
+			 * finished, stop discovery, otherwise BR/EDR inquiry
+			 * will stop discovery when finished. If we will resolve
+			 * remote device name, do not change discovery state.
+			 */
+			if (!test_bit(HCI_INQUIRY, &hdev->flags) &&
+			    hdev->discovery.state != DISCOVERY_RESOLVING)
+				hci_discovery_set_state(hdev,
+							DISCOVERY_STOPPED);
+		} else {
+			struct hci_request req;
+
+			hci_inquiry_cache_flush(hdev);
+
+			hci_req_init(&req, hdev);
+
+			memset(&cp, 0, sizeof(cp));
+			memcpy(&cp.lap, lap, sizeof(cp.lap));
+			cp.length = DISCOV_INTERLEAVED_INQUIRY_LEN;
+			hci_req_add(&req, HCI_OP_INQUIRY, sizeof(cp), &cp);
+
+			err = hci_req_run(&req, inquiry_complete);
+			if (err) {
+				BT_ERR("Inquiry request failed: err %d", err);
+				hci_discovery_set_state(hdev,
+							DISCOVERY_STOPPED);
+			}
+		}
+
+		hci_dev_unlock(hdev);
+		break;
+	}
+}
+
+static void le_scan_disable(struct hci_request *req, unsigned long opt)
+{
+	hci_req_add_le_scan_disable(req);
+}
+
+static void le_scan_disable_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    le_scan_disable.work);
+	u8 status;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	cancel_delayed_work(&hdev->le_scan_restart);
+
+	err = hci_req_sync(hdev, le_scan_disable, 0, HCI_CMD_TIMEOUT, &status);
+	if (err)
+		return;
+
+	le_scan_disable_work_complete(hdev, status);
+}
+
+static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
+{
+	unsigned long timeout, duration, scan_start, now;
+
+	BT_DBG("%s", hdev->name);
+
+	if (status) {
+		BT_ERR("Failed to restart LE scan: status %d", status);
+		return;
+	}
+
+	hci_dev_lock(hdev);
+
+	if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
+	    !hdev->discovery.scan_start)
+		goto unlock;
+
+	/* When the scan was started, hdev->le_scan_disable has been queued
+	 * after duration from scan_start. During scan restart this job
+	 * has been canceled, and we need to queue it again after proper
+	 * timeout, to make sure that scan does not run indefinitely.
+	 */
+	duration = hdev->discovery.scan_duration;
+	scan_start = hdev->discovery.scan_start;
+	now = jiffies;
+	if (now - scan_start <= duration) {
+		int elapsed;
+
+		if (now >= scan_start)
+			elapsed = now - scan_start;
+		else
+			elapsed = ULONG_MAX - scan_start + now;
+
+		timeout = duration - elapsed;
+	} else {
+		timeout = 0;
+	}
+
+	queue_delayed_work(hdev->req_workqueue,
+			   &hdev->le_scan_disable, timeout);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static void le_scan_restart(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_scan_enable cp;
+
+	/* If controller is not scanning we are done. */
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		return;
+
+	hci_req_add_le_scan_disable(req);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_ENABLE;
+	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
+
+static void le_scan_restart_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    le_scan_restart.work);
+	u8 status;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	err = hci_req_sync(hdev, le_scan_restart, 0, HCI_CMD_TIMEOUT, &status);
+	if (err)
+		return;
+
+	le_scan_restart_work_complete(hdev, status);
+}
+
 void hci_request_setup(struct hci_dev *hdev)
 {
 	INIT_WORK(&hdev->bg_scan_update, bg_scan_update);
+	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 }
 
 void hci_request_cleanup(struct hci_dev *hdev)
 {
 	cancel_work_sync(&hdev->bg_scan_update);
+	cancel_delayed_work_sync(&hdev->le_scan_disable);
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 95184c1e8877..2594f551ef9d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4367,7 +4367,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
 			hdev->discovery.scan_duration = timeout;
 		}
 
-		queue_delayed_work(hdev->workqueue,
+		queue_delayed_work(hdev->req_workqueue,
 				   &hdev->le_scan_disable, timeout);
 	}
 
@@ -8389,7 +8389,7 @@ static void restart_le_scan(struct hci_dev *hdev)
 		       hdev->discovery.scan_duration))
 		return;
 
-	queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart,
+	queue_delayed_work(hdev->req_workqueue, &hdev->le_scan_restart,
 			   DISCOV_LE_RESTART_DELAY);
 }
 
-- 
2.5.0

