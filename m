Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 24 Nov 2015 14:08:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Move discoverable changes to
 hdev->req_workqueue
Message-ID: <20151124120819.GD30180@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448366527-29714-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The discoverable mode is intrinsically linked with the connectable
mode e.g. through sharing the same HCI command (Write Scan Enable) for
BR/EDR. It makes therefore sense to move it to hci_request.c and run
the changes through the same hdev->req_workqueue.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +
 net/bluetooth/hci_request.c      | 64 ++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 90 ++++++----------------------------------
 3 files changed, 79 insertions(+), 77 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a855e41df68c..0a6966ed7ee1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -331,6 +331,7 @@ struct hci_dev {
 	struct work_struct	bg_scan_update;
 	struct work_struct	scan_update;
 	struct work_struct	connectable_update;
+	struct work_struct	discoverable_update;
 	struct delayed_work	le_scan_disable;
 	struct delayed_work	le_scan_restart;
 
@@ -1493,6 +1494,7 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 bool mgmt_get_connectable(struct hci_dev *hdev);
 void mgmt_set_connectable_complete(struct hci_dev *hdev, u8 status);
+void mgmt_set_discoverable_complete(struct hci_dev *hdev, u8 status);
 u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev);
 void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev,
 			    u8 instance);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e5e827b762b9..8f72218ed805 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1351,6 +1351,68 @@ void __hci_req_update_class(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
 }
 
+static void write_iac(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_write_current_iac_lap cp;
+
+	if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
+		return;
+
+	if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
+		/* Limited discoverable mode */
+		cp.num_iac = min_t(u8, hdev->num_iac, 2);
+		cp.iac_lap[0] = 0x00;	/* LIAC */
+		cp.iac_lap[1] = 0x8b;
+		cp.iac_lap[2] = 0x9e;
+		cp.iac_lap[3] = 0x33;	/* GIAC */
+		cp.iac_lap[4] = 0x8b;
+		cp.iac_lap[5] = 0x9e;
+	} else {
+		/* General discoverable mode */
+		cp.num_iac = 1;
+		cp.iac_lap[0] = 0x33;	/* GIAC */
+		cp.iac_lap[1] = 0x8b;
+		cp.iac_lap[2] = 0x9e;
+	}
+
+	hci_req_add(req, HCI_OP_WRITE_CURRENT_IAC_LAP,
+		    (cp.num_iac * 3) + 1, &cp);
+}
+
+static int discoverable_update(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	hci_dev_lock(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
+		write_iac(req);
+		__hci_req_update_scan(req);
+		__hci_req_update_class(req);
+	}
+
+	/* Advertising instances don't use the global discoverable setting, so
+	 * only update AD if advertising was enabled using Set Advertising.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		__hci_req_update_adv_data(req, HCI_ADV_CURRENT);
+
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static void discoverable_update_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    discoverable_update);
+	u8 status;
+
+	hci_req_sync(hdev, discoverable_update, 0, HCI_CMD_TIMEOUT, &status);
+	mgmt_set_discoverable_complete(hdev, status);
+}
+
 void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 		      u8 reason)
 {
@@ -1867,6 +1929,7 @@ void hci_request_setup(struct hci_dev *hdev)
 	INIT_WORK(&hdev->bg_scan_update, bg_scan_update);
 	INIT_WORK(&hdev->scan_update, scan_update_work);
 	INIT_WORK(&hdev->connectable_update, connectable_update_work);
+	INIT_WORK(&hdev->discoverable_update, discoverable_update_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
@@ -1880,6 +1943,7 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->bg_scan_update);
 	cancel_work_sync(&hdev->scan_update);
 	cancel_work_sync(&hdev->connectable_update);
+	cancel_work_sync(&hdev->discoverable_update);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f5a4ee92f2bf..8846cb3b0aaa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1282,13 +1282,9 @@ static u8 mgmt_le_support(struct hci_dev *hdev)
 		return MGMT_STATUS_SUCCESS;
 }
 
-static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
-				      u16 opcode)
+void mgmt_set_discoverable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct mgmt_pending_cmd *cmd;
-	struct mgmt_mode *cp;
-	struct hci_request req;
-	bool changed;
 
 	BT_DBG("status 0x%02x", status);
 
@@ -1305,33 +1301,14 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
 		goto remove_cmd;
 	}
 
-	cp = cmd->param;
-	if (cp->val) {
-		changed = !hci_dev_test_and_set_flag(hdev, HCI_DISCOVERABLE);
-
-		if (hdev->discov_timeout > 0) {
-			int to = msecs_to_jiffies(hdev->discov_timeout * 1000);
-			queue_delayed_work(hdev->workqueue, &hdev->discov_off,
-					   to);
-		}
-	} else {
-		changed = hci_dev_test_and_clear_flag(hdev, HCI_DISCOVERABLE);
+	if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE) &&
+	    hdev->discov_timeout > 0) {
+		int to = msecs_to_jiffies(hdev->discov_timeout * 1000);
+		queue_delayed_work(hdev->req_workqueue, &hdev->discov_off, to);
 	}
 
 	send_settings_rsp(cmd->sk, MGMT_OP_SET_DISCOVERABLE, hdev);
-
-	if (changed)
-		new_settings(hdev, cmd->sk);
-
-	/* When the discoverable mode gets changed, make sure
-	 * that class of device has the limited discoverable
-	 * bit correctly set. Also update page scan based on whitelist
-	 * entries.
-	 */
-	hci_req_init(&req, hdev);
-	__hci_req_update_scan(&req);
-	__hci_req_update_class(&req);
-	hci_req_run(&req, NULL);
+	new_settings(hdev, cmd->sk);
 
 remove_cmd:
 	mgmt_pending_remove(cmd);
@@ -1345,9 +1322,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_set_discoverable *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	u16 timeout;
-	u8 scan;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
@@ -1447,58 +1422,19 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	cancel_delayed_work(&hdev->discov_off);
 	hdev->discov_timeout = timeout;
 
+	if (cp->val)
+		hci_dev_set_flag(hdev, HCI_DISCOVERABLE);
+	else
+		hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
+
 	/* Limited discoverable mode */
 	if (cp->val == 0x02)
 		hci_dev_set_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 	else
 		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 
-	hci_req_init(&req, hdev);
-
-	/* The procedure for LE-only controllers is much simpler - just
-	 * update the advertising data.
-	 */
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		goto update_ad;
-
-	scan = SCAN_PAGE;
-
-	if (cp->val) {
-		struct hci_cp_write_current_iac_lap hci_cp;
-
-		if (cp->val == 0x02) {
-			/* Limited discoverable mode */
-			hci_cp.num_iac = min_t(u8, hdev->num_iac, 2);
-			hci_cp.iac_lap[0] = 0x00;	/* LIAC */
-			hci_cp.iac_lap[1] = 0x8b;
-			hci_cp.iac_lap[2] = 0x9e;
-			hci_cp.iac_lap[3] = 0x33;	/* GIAC */
-			hci_cp.iac_lap[4] = 0x8b;
-			hci_cp.iac_lap[5] = 0x9e;
-		} else {
-			/* General discoverable mode */
-			hci_cp.num_iac = 1;
-			hci_cp.iac_lap[0] = 0x33;	/* GIAC */
-			hci_cp.iac_lap[1] = 0x8b;
-			hci_cp.iac_lap[2] = 0x9e;
-		}
-
-		hci_req_add(&req, HCI_OP_WRITE_CURRENT_IAC_LAP,
-			    (hci_cp.num_iac * 3) + 1, &hci_cp);
-
-		scan |= SCAN_INQUIRY;
-	} else {
-		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
-	}
-
-	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
-
-update_ad:
-	__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
-
-	err = hci_req_run(&req, set_discoverable_complete);
-	if (err < 0)
-		mgmt_pending_remove(cmd);
+	queue_work(hdev->req_workqueue, &hdev->discoverable_update);
+	err = 0;
 
 failed:
 	hci_dev_unlock(hdev);
-- 
2.5.0

