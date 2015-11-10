Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/12] Bluetooth: Use req_workqueue for explicit connect requests
Date: Tue, 10 Nov 2015 20:14:27 +0200
Message-Id: <1447179274-12276-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
References: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since explicit connect requests are also a sub-category of passive
scan updates, run them through the same workqueue as the other passive
scan changes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c    | 39 ++++-----------------------------------
 net/bluetooth/hci_request.c | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fd6120a41138..1ed1e153b3fa 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -933,26 +933,6 @@ done:
 	return conn;
 }
 
-static void hci_connect_le_scan_complete(struct hci_dev *hdev, u8 status,
-					 u16 opcode)
-{
-	struct hci_conn *conn;
-
-	if (!status)
-		return;
-
-	BT_ERR("Failed to add device to auto conn whitelist: status 0x%2.2x",
-	       status);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-	if (conn)
-		hci_le_conn_failed(conn, status);
-
-	hci_dev_unlock(hdev);
-}
-
 static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 {
 	struct hci_conn *conn;
@@ -968,10 +948,9 @@ static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 }
 
 /* This function requires the caller holds hdev->lock */
-static int hci_explicit_conn_params_set(struct hci_request *req,
+static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 					bdaddr_t *addr, u8 addr_type)
 {
-	struct hci_dev *hdev = req->hdev;
 	struct hci_conn_params *params;
 
 	if (is_connected(hdev, addr, addr_type))
@@ -999,7 +978,6 @@ static int hci_explicit_conn_params_set(struct hci_request *req,
 	}
 
 	params->explicit_connect = true;
-	__hci_update_background_scan(req);
 
 	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
 	       params->auto_connect);
@@ -1013,8 +991,6 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 				     u16 conn_timeout, u8 role)
 {
 	struct hci_conn *conn;
-	struct hci_request req;
-	int err;
 
 	/* Let's make sure that le is enabled.*/
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
@@ -1046,25 +1022,18 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
-	hci_req_init(&req, hdev);
-
-	if (hci_explicit_conn_params_set(&req, dst, dst_type) < 0)
+	if (hci_explicit_conn_params_set(hdev, dst, dst_type) < 0)
 		return ERR_PTR(-EBUSY);
 
 	conn->state = BT_CONNECT;
 	set_bit(HCI_CONN_SCANNING, &conn->flags);
-
-	err = hci_req_run(&req, hci_connect_le_scan_complete);
-	if (err && err != -ENODATA) {
-		hci_conn_del(conn);
-		return ERR_PTR(err);
-	}
-
 	conn->dst_type = dst_type;
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
 	conn->conn_timeout = conn_timeout;
 
+	hci_update_background_scan(hdev);
+
 done:
 	hci_conn_hold(conn);
 	return conn;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3439b791c583..20778e887d50 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -841,8 +841,21 @@ static void bg_scan_update(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    bg_scan_update);
+	struct hci_conn *conn;
+	u8 status;
+	int err;
+
+	err = hci_req_sync(hdev, update_bg_scan, 0, HCI_CMD_TIMEOUT, &status);
+	if (!err)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+	if (conn)
+		hci_le_conn_failed(conn, status);
 
-	hci_req_sync(hdev, update_bg_scan, 0, HCI_CMD_TIMEOUT);
+	hci_dev_unlock(hdev);
 }
 
 void hci_request_setup(struct hci_dev *hdev)
-- 
2.5.0

