Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5 1/3] Bluetooth: Add lock for HCI_OP_SCAN_ENABLE command
Date: Thu, 11 Dec 2014 02:26:12 -0800
Message-Id: <1418293574-25095-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces new lock, that need to be acquired if you want
to use HCI_OP_SCAN_ENABLE in a series of request. Next patch introduces
le restarting that would have race condition without that.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h |  6 ++++++
 net/bluetooth/hci_conn.c         |  4 ++++
 net/bluetooth/hci_core.c         | 16 ++++++++++++++--
 net/bluetooth/mgmt.c             | 34 ++++++++++++++++++++++++++++++++--
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3c78270..55d66c6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -343,6 +343,7 @@ struct hci_dev {
 	unsigned long		dev_flags;
 
 	struct delayed_work	le_scan_disable;
+	struct mutex		le_scan_enable_lock;
 
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
@@ -875,6 +876,11 @@ static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 #define hci_dev_lock(d)		mutex_lock(&d->lock)
 #define hci_dev_unlock(d)	mutex_unlock(&d->lock)
 
+/* HCI operations modifying LE scan state */
+
+#define hci_le_scan_enable_lock(d)	mutex_lock(&d->le_scan_enable_lock)
+#define hci_le_scan_enable_unlock(d)	mutex_unlock(&d->le_scan_enable_lock)
+
 #define to_hci_dev(d) container_of(d, struct hci_dev, dev)
 #define to_hci_conn(c) container_of(c, struct hci_conn, dev)
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fe18825..f5a83b9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -633,6 +633,8 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
 {
 	struct hci_conn *conn;
 
+	hci_le_scan_enable_unlock(hdev);
+
 	if (status == 0)
 		return;
 
@@ -836,8 +838,10 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	hci_req_add_le_create_conn(&req, conn);
 
 create_conn:
+	hci_le_scan_enable_lock(hdev);
 	err = hci_req_run(&req, create_le_conn_complete);
 	if (err) {
+		hci_le_scan_enable_unlock(hdev);
 		hci_conn_del(conn);
 		return ERR_PTR(err);
 	}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 96e7321..3906d8a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3830,6 +3830,7 @@ void hci_conn_params_clear_all(struct hci_dev *hdev)
 
 static void inquiry_complete(struct hci_dev *hdev, u8 status)
 {
+	hci_le_scan_enable_unlock(hdev);
 	if (status) {
 		BT_ERR("Failed to start inquiry: status %d", status);
 
@@ -3848,6 +3849,8 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
 	struct hci_cp_inquiry cp;
 	int err;
 
+	hci_le_scan_enable_unlock(hdev);
+
 	if (status) {
 		BT_ERR("Failed to disable LE scanning: status %d", status);
 		return;
@@ -3896,9 +3899,12 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	hci_req_add_le_scan_disable(&req);
 
+	hci_le_scan_enable_lock(hdev);
 	err = hci_req_run(&req, le_scan_disable_work_complete);
-	if (err)
+	if (err) {
 		BT_ERR("Disable LE scanning request failed: err %d", err);
+		hci_le_scan_enable_unlock(hdev);
+	}
 }
 
 static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
@@ -4067,6 +4073,7 @@ struct hci_dev *hci_alloc_dev(void)
 
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
+	mutex_init(&hdev->le_scan_enable_lock);
 
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->blacklist);
@@ -5682,6 +5689,8 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 
 static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
 {
+	hci_le_scan_enable_unlock(hdev);
+
 	if (status)
 		BT_DBG("HCI request failed to update background scanning: "
 		       "status 0x%2.2x", status);
@@ -5764,9 +5773,12 @@ void hci_update_background_scan(struct hci_dev *hdev)
 		BT_DBG("%s starting background scanning", hdev->name);
 	}
 
+	hci_le_scan_enable_lock(hdev);
 	err = hci_req_run(&req, update_background_scan_complete);
-	if (err)
+	if (err) {
 		BT_ERR("Failed to run HCI request: err %d", err);
+		hci_le_scan_enable_unlock(hdev);
+	}
 }
 
 static bool disconnected_whitelist_entries(struct hci_dev *hdev)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 44b20de..b17bb65 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1255,6 +1255,8 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
 {
 	BT_DBG("%s status 0x%02x", hdev->name, status);
 
+	hci_le_scan_enable_unlock(hdev);
+
 	if (hci_conn_count(hdev) == 0) {
 		cancel_delayed_work(&hdev->power_off);
 		queue_work(hdev->req_workqueue, &hdev->power_off.work);
@@ -1355,7 +1357,11 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		}
 	}
 
+	hci_le_scan_enable_lock(hdev);
 	err = hci_req_run(&req, clean_up_hci_complete);
+	if (err)
+		hci_le_scan_enable_unlock(hdev);
+
 	if (!err && discov_stopped)
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
 
@@ -3828,6 +3834,8 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 
 	BT_DBG("status %d", status);
 
+	hci_le_scan_enable_unlock(hdev);
+
 	hci_dev_lock(hdev);
 
 	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
@@ -3923,8 +3931,10 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	hci_le_scan_enable_lock(hdev);
 	err = hci_req_run(&req, start_discovery_complete);
 	if (err < 0) {
+		hci_le_scan_enable_unlock(hdev);
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
@@ -4036,8 +4046,10 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	hci_le_scan_enable_lock(hdev);
 	err = hci_req_run(&req, start_discovery_complete);
 	if (err < 0) {
+		hci_le_scan_enable_unlock(hdev);
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
@@ -4055,6 +4067,8 @@ static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
 
 	BT_DBG("status %d", status);
 
+	hci_le_scan_enable_unlock(hdev);
+
 	hci_dev_lock(hdev);
 
 	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
@@ -4107,7 +4121,11 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_stop_discovery(&req);
 
+	hci_le_scan_enable_lock(hdev);
 	err = hci_req_run(&req, stop_discovery_complete);
+	if (err)
+		hci_le_scan_enable_unlock(hdev);
+
 	if (!err) {
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
 		goto unlock;
@@ -4421,6 +4439,13 @@ static int set_static_address(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static void set_scan_params_complete(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("%s status 0x%02x", hdev->name, status);
+
+	hci_le_scan_enable_unlock(hdev);
+}
+
 static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 len)
 {
@@ -4462,6 +4487,8 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 	 */
 	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
 	    hdev->discovery.state == DISCOVERY_STOPPED) {
+		int req_err;
+
 		struct hci_request req;
 
 		hci_req_init(&req, hdev);
@@ -4469,7 +4496,10 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 		hci_req_add_le_scan_disable(&req);
 		hci_req_add_le_passive_scan(&req);
 
-		hci_req_run(&req, NULL);
+		hci_le_scan_enable_lock(hdev);
+		req_err = hci_req_run(&req, set_scan_params_complete);
+		if (req_err)
+			hci_le_scan_enable_unlock(hdev);
 	}
 
 	hci_dev_unlock(hdev);
@@ -4533,7 +4563,7 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				  MGMT_STATUS_NOT_POWERED);
 
-	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+4	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				  MGMT_STATUS_REJECTED);
 
-- 
2.2.0.rc0.207.ga3a616c

