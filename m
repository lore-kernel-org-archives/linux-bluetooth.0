Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 24 Nov 2015 14:09:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Move discoverable timeout behind
 hdev->req_workqueue
Message-ID: <20151124120914.GE30180@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448366527-29714-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since the other discoverable changes are behind req_workqueue now it
only makes sense to move the discoverable timeout there as well.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 13 -------------
 net/bluetooth/hci_request.c      | 26 +++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 41 ++--------------------------------------
 4 files changed, 28 insertions(+), 53 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0a6966ed7ee1..319bf020cea6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1436,7 +1436,6 @@ void mgmt_index_added(struct hci_dev *hdev);
 void mgmt_index_removed(struct hci_dev *hdev);
 void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
-void mgmt_discoverable_timeout(struct hci_dev *hdev);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
 void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bab8958bf46e..484c75f3332c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1537,7 +1537,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
 	flush_work(&hdev->rx_work);
 
 	if (hdev->discov_timeout > 0) {
-		cancel_delayed_work(&hdev->discov_off);
 		hdev->discov_timeout = 0;
 		hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
 		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
@@ -2096,17 +2095,6 @@ static void hci_error_reset(struct work_struct *work)
 	hci_dev_do_open(hdev);
 }
 
-static void hci_discov_off(struct work_struct *work)
-{
-	struct hci_dev *hdev;
-
-	hdev = container_of(work, struct hci_dev, discov_off.work);
-
-	BT_DBG("%s", hdev->name);
-
-	mgmt_discoverable_timeout(hdev);
-}
-
 void hci_uuids_clear(struct hci_dev *hdev)
 {
 	struct bt_uuid *uuid, *tmp;
@@ -2986,7 +2974,6 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_WORK(&hdev->error_reset, hci_error_reset);
 
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
-	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 8f72218ed805..fe14fd121d36 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1923,6 +1923,30 @@ static void discov_update(struct work_struct *work)
 	}
 }
 
+static void discov_off(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    discov_off.work);
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	/* When discoverable timeout triggers, then just make sure
+	 * the limited discoverable flag is cleared. Even in the case
+	 * of a timeout triggered from general discoverable, it is
+	 * safe to unconditionally clear the flag.
+	 */
+	hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
+	hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
+	hdev->discov_timeout = 0;
+
+	hci_dev_unlock(hdev);
+
+	hci_req_sync(hdev, discoverable_update, 0, HCI_CMD_TIMEOUT, NULL);
+	mgmt_new_settings(hdev);
+}
+
 void hci_request_setup(struct hci_dev *hdev)
 {
 	INIT_WORK(&hdev->discov_update, discov_update);
@@ -1930,6 +1954,7 @@ void hci_request_setup(struct hci_dev *hdev)
 	INIT_WORK(&hdev->scan_update, scan_update_work);
 	INIT_WORK(&hdev->connectable_update, connectable_update_work);
 	INIT_WORK(&hdev->discoverable_update, discoverable_update_work);
+	INIT_DELAYED_WORK(&hdev->discov_off, discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
@@ -1944,6 +1969,7 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->scan_update);
 	cancel_work_sync(&hdev->connectable_update);
 	cancel_work_sync(&hdev->discoverable_update);
+	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8846cb3b0aaa..29b3bb70ae9f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1401,8 +1401,8 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		if (cp->val && hdev->discov_timeout > 0) {
 			int to = msecs_to_jiffies(hdev->discov_timeout * 1000);
-			queue_delayed_work(hdev->workqueue, &hdev->discov_off,
-					   to);
+			queue_delayed_work(hdev->req_workqueue,
+					   &hdev->discov_off, to);
 		}
 
 		err = send_settings_rsp(sk, MGMT_OP_SET_DISCOVERABLE, hdev);
@@ -6848,43 +6848,6 @@ void mgmt_set_powered_failed(struct hci_dev *hdev, int err)
 	mgmt_pending_remove(cmd);
 }
 
-void mgmt_discoverable_timeout(struct hci_dev *hdev)
-{
-	struct hci_request req;
-
-	hci_dev_lock(hdev);
-
-	/* When discoverable timeout triggers, then just make sure
-	 * the limited discoverable flag is cleared. Even in the case
-	 * of a timeout triggered from general discoverable, it is
-	 * safe to unconditionally clear the flag.
-	 */
-	hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
-	hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
-
-	hci_req_init(&req, hdev);
-	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
-		u8 scan = SCAN_PAGE;
-		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE,
-			    sizeof(scan), &scan);
-	}
-	__hci_req_update_class(&req);
-
-	/* Advertising instances don't use the global discoverable setting, so
-	 * only update AD if advertising was enabled using Set Advertising.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
-
-	hci_req_run(&req, NULL);
-
-	hdev->discov_timeout = 0;
-
-	new_settings(hdev, NULL);
-
-	hci_dev_unlock(hdev);
-}
-
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent)
 {
-- 
2.5.0

