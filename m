Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v12 1/2] Bluetooth: Add le_scan_restart work for LE scan restarting
Date: Sun,  1 Feb 2015 23:07:54 -0800
Message-Id: <1422860875-3966-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently there is no way to restart le scan, and it's needed in
service scan method. The way it work: it disable, and then enable le
scan on controller.

During the restart, we must remember when the scan was started, and
it's duration, to later re-schedule the le_scan_disable work, that was
stopped during the stop scan phase.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h |  5 +++
 net/bluetooth/hci_core.c         | 74 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 18 +++++++++-
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a37e10f..d3a232b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -79,6 +79,8 @@ struct discovery_state {
 	s8			rssi;
 	u16			uuid_count;
 	u8			(*uuids)[16];
+	unsigned long		scan_start;
+	unsigned long		scan_duration;
 };
 
 struct hci_conn_hash {
@@ -354,6 +356,7 @@ struct hci_dev {
 	unsigned long		dev_flags;
 
 	struct delayed_work	le_scan_disable;
+	struct delayed_work	le_scan_restart;
 
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
@@ -531,6 +534,8 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 	hdev->discovery.uuid_count = 0;
 	kfree(hdev->discovery.uuids);
 	hdev->discovery.uuids = NULL;
+	hdev->discovery.scan_start = 0;
+	hdev->discovery.scan_duration = 0;
 }
 
 bool hci_discovery_active(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f045c06..946fbb9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1617,6 +1617,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		cancel_delayed_work(&hdev->service_cache);
 
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		cancel_delayed_work_sync(&hdev->rpa_expired);
@@ -2830,6 +2831,8 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
 		return;
 	}
 
+	hdev->discovery.scan_start = 0;
+
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_LE:
 		hci_dev_lock(hdev);
@@ -2869,6 +2872,8 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
+
 	hci_req_init(&req, hdev);
 
 	hci_req_add_le_scan_disable(&req);
@@ -2878,6 +2883,74 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
+static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status,
+					  u16 opcode)
+{
+	unsigned long timeout, duration, scan_start, jiffy;
+
+	BT_DBG("%s", hdev->name);
+
+	if (status) {
+		BT_ERR("Failed to restart LE scan: status %d", status);
+		return;
+	}
+
+	if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
+	    !hdev->discovery.scan_start)
+		return;
+
+	/* When the scan was sterted, hdev->le_scan_disable was queued after
+	 * duration from scan_start. During scan restart this job was canceled,
+	 * and we need to queue it again after proper timeout, to make sure that
+	 * scan wouldn't work infinitely.
+	 */
+	duration = hdev->discovery.scan_duration;
+	scan_start = hdev->discovery.scan_start;
+	jiffy = jiffies;
+	if (jiffy - scan_start <= duration) {
+		int elapsed;
+
+		if (jiffy >= scan_start)
+			elapsed = jiffy - scan_start;
+		else
+			elapsed = ULONG_MAX - scan_start + jiffy;
+
+		timeout = duration - elapsed;
+	} else {
+		timeout = 0;
+	}
+	queue_delayed_work(hdev->workqueue,
+			   &hdev->le_scan_disable, timeout);
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
+	if (err)
+		BT_ERR("Restart LE scan request failed: err %d", err);
+}
+
 /* Copy the Identity Address of the controller.
  *
  * If the controller has a public BD_ADDR, then by default use that one.
@@ -2974,6 +3047,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ba3b4a5..93eadef 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3896,6 +3896,9 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
 
 	hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 
+	/* If the scan involves LE scan, pick proper timeout to shedule
+	 * hdev->le_scan_disable that will stop it.
+	 */
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_LE:
 		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
@@ -3912,9 +3915,22 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
 		break;
 	}
 
-	if (timeout)
+	if (timeout) {
+		if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
+			     &hdev->quirks) &&
+		    (hdev->discovery.uuid_count > 0 ||
+		     hdev->discovery.rssi != HCI_RSSI_INVALID)) {
+			/* We mignt need to restart filtered scan. Remember when
+			 * it was started and it's duration, so we might queue
+			 * hdev->le_scan_disable again after the restart.
+			 */
+			hdev->discovery.scan_start = jiffies;
+			hdev->discovery.scan_duration = timeout;
+		}
+
 		queue_delayed_work(hdev->workqueue,
 				   &hdev->le_scan_disable, timeout);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.2.0.rc0.207.ga3a616c

