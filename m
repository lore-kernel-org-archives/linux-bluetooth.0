Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 24 Nov 2015 14:06:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Move connectable changes to
 hdev->req_workqueue
Message-ID: <20151124120636.GB30180@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448366527-29714-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This way the connectable changes are synchronized against each other,
which helps avoid potential races. The connectable mode is also linked
together with LE advertising which makes is more convenient to have it
behind the same workqueue.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +
 net/bluetooth/hci_request.c      | 39 ++++++++++++++++++
 net/bluetooth/mgmt.c             | 86 ++++++----------------------------------
 3 files changed, 53 insertions(+), 74 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b56085b6ecce..a855e41df68c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -330,6 +330,7 @@ struct hci_dev {
 	struct work_struct	discov_update;
 	struct work_struct	bg_scan_update;
 	struct work_struct	scan_update;
+	struct work_struct	connectable_update;
 	struct delayed_work	le_scan_disable;
 	struct delayed_work	le_scan_restart;
 
@@ -1491,6 +1492,7 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			 u16 max_interval, u16 latency, u16 timeout);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 bool mgmt_get_connectable(struct hci_dev *hdev);
+void mgmt_set_connectable_complete(struct hci_dev *hdev, u8 status);
 u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev);
 void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev,
 			    u8 instance);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e6622bd1926d..167c90644b4b 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1274,6 +1274,43 @@ static void scan_update_work(struct work_struct *work)
 	hci_req_sync(hdev, update_scan, 0, HCI_CMD_TIMEOUT, NULL);
 }
 
+static int connectable_update(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	hci_dev_lock(hdev);
+
+	__hci_req_update_scan(req);
+
+	/* If BR/EDR is not enabled and we disable advertising as a
+	 * by-product of disabling connectable, we need to update the
+	 * advertising flags.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		__hci_req_update_adv_data(req, HCI_ADV_CURRENT);
+
+	/* Update the advertising parameters if necessary */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	    hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+		__hci_req_enable_advertising(req);
+
+	__hci_update_background_scan(req);
+
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static void connectable_update_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    connectable_update);
+	u8 status;
+
+	hci_req_sync(hdev, connectable_update, 0, HCI_CMD_TIMEOUT, &status);
+	mgmt_set_connectable_complete(hdev, status);
+}
+
 void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 		      u8 reason)
 {
@@ -1789,6 +1826,7 @@ void hci_request_setup(struct hci_dev *hdev)
 	INIT_WORK(&hdev->discov_update, discov_update);
 	INIT_WORK(&hdev->bg_scan_update, bg_scan_update);
 	INIT_WORK(&hdev->scan_update, scan_update_work);
+	INIT_WORK(&hdev->connectable_update, connectable_update_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
@@ -1801,6 +1839,7 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->discov_update);
 	cancel_work_sync(&hdev->bg_scan_update);
 	cancel_work_sync(&hdev->scan_update);
+	cancel_work_sync(&hdev->connectable_update);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6d0f0025052f..d8b76ca5c820 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1580,12 +1580,9 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
 }
 
-static void set_connectable_complete(struct hci_dev *hdev, u8 status,
-				     u16 opcode)
+void mgmt_set_connectable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct mgmt_pending_cmd *cmd;
-	struct mgmt_mode *cp;
-	bool conn_changed, discov_changed;
 
 	BT_DBG("status 0x%02x", status);
 
@@ -1601,27 +1598,8 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status,
 		goto remove_cmd;
 	}
 
-	cp = cmd->param;
-	if (cp->val) {
-		conn_changed = !hci_dev_test_and_set_flag(hdev,
-							  HCI_CONNECTABLE);
-		discov_changed = false;
-	} else {
-		conn_changed = hci_dev_test_and_clear_flag(hdev,
-							   HCI_CONNECTABLE);
-		discov_changed = hci_dev_test_and_clear_flag(hdev,
-							     HCI_DISCOVERABLE);
-	}
-
 	send_settings_rsp(cmd->sk, MGMT_OP_SET_CONNECTABLE, hdev);
-
-	if (conn_changed || discov_changed) {
-		new_settings(hdev, cmd->sk);
-		hci_req_update_scan(hdev);
-		if (discov_changed)
-			hci_req_update_adv_data(hdev, HCI_ADV_CURRENT);
-		hci_update_background_scan(hdev);
-	}
+	new_settings(hdev, cmd->sk);
 
 remove_cmd:
 	mgmt_pending_remove(cmd);
@@ -1664,8 +1642,6 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_mode *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
-	u8 scan;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
@@ -1699,57 +1675,19 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	hci_req_init(&req, hdev);
-
-	/* If BR/EDR is not enabled and we disable advertising as a
-	 * by-product of disabling connectable, we need to update the
-	 * advertising flags.
-	 */
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
-		if (!cp->val) {
-			hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
-			hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
-		}
-		__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
-	} else if (cp->val != test_bit(HCI_PSCAN, &hdev->flags)) {
-		if (cp->val) {
-			scan = SCAN_PAGE;
-		} else {
-			/* If we don't have any whitelist entries just
-			 * disable all scanning. If there are entries
-			 * and we had both page and inquiry scanning
-			 * enabled then fall back to only page scanning.
-			 * Otherwise no changes are needed.
-			 */
-			if (list_empty(&hdev->whitelist))
-				scan = SCAN_DISABLED;
-			else if (test_bit(HCI_ISCAN, &hdev->flags))
-				scan = SCAN_PAGE;
-			else
-				goto no_scan_update;
-
-			if (test_bit(HCI_ISCAN, &hdev->flags) &&
-			    hdev->discov_timeout > 0)
-				cancel_delayed_work(&hdev->discov_off);
-		}
+	if (cp->val) {
+		hci_dev_set_flag(hdev, HCI_CONNECTABLE);
+	} else {
+		if (hdev->discov_timeout > 0)
+			cancel_delayed_work(&hdev->discov_off);
 
-		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
+		hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
+		hci_dev_clear_flag(hdev, HCI_CONNECTABLE);
 	}
 
-no_scan_update:
-	/* Update the advertising parameters if necessary */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
-		__hci_req_enable_advertising(&req);
-
-	err = hci_req_run(&req, set_connectable_complete);
-	if (err < 0) {
-		mgmt_pending_remove(cmd);
-		if (err == -ENODATA)
-			err = set_connectable_update_settings(hdev, sk,
-							      cp->val);
-		goto failed;
-	}
+	queue_work(hdev->req_workqueue, &hdev->connectable_update);
+	err = 0;
 
 failed:
 	hci_dev_unlock(hdev);
-- 
2.5.0

