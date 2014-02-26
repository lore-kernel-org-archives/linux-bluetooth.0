Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 16/17] Bluetooth: Create hci_req_add_le_passive_scan helper
Date: Wed, 26 Feb 2014 20:21:55 -0300
Message-Id: <1393456916-22701-16-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
References: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patches creates the public hci_req_add_le_passive_scan helper so
it can be re-used outside hci_core.c in the next patch.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 56 ++++++++++++++++++++++------------------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4b192d0..79a75ed 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1150,6 +1150,7 @@ void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
 void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
 
 void hci_req_add_le_scan_disable(struct hci_request *req);
+void hci_req_add_le_passive_scan(struct hci_request *req);
 
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			       const void *param, u32 timeout);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0b96f20..bbd085d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5115,6 +5115,36 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
 
+void hci_req_add_le_passive_scan(struct hci_request *req)
+{
+	struct hci_cp_le_set_scan_param param_cp;
+	struct hci_cp_le_set_scan_enable enable_cp;
+	struct hci_dev *hdev = req->hdev;
+	u8 own_addr_type;
+
+	/* Set require_privacy to true to avoid identification from
+	 * unknown peer devices. Since this is passive scanning, no
+	 * SCAN_REQ using the local identity should be sent. Mandating
+	 * privacy is just an extra precaution.
+	 */
+	if (hci_update_random_address(req, true, &own_addr_type))
+		return;
+
+	memset(&param_cp, 0, sizeof(param_cp));
+	param_cp.type = LE_SCAN_PASSIVE;
+	param_cp.interval = cpu_to_le16(hdev->le_scan_interval);
+	param_cp.window = cpu_to_le16(hdev->le_scan_window);
+	param_cp.own_address_type = own_addr_type;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
+		    &param_cp);
+
+	memset(&enable_cp, 0, sizeof(enable_cp));
+	enable_cp.enable = LE_SCAN_ENABLE;
+	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+		    &enable_cp);
+}
+
 static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
 {
 	if (status)
@@ -5130,8 +5160,6 @@ static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
  */
 void hci_update_background_scan(struct hci_dev *hdev)
 {
-	struct hci_cp_le_set_scan_param param_cp;
-	struct hci_cp_le_set_scan_enable enable_cp;
 	struct hci_request req;
 	struct hci_conn *conn;
 	int err;
@@ -5151,8 +5179,6 @@ void hci_update_background_scan(struct hci_dev *hdev)
 
 		BT_DBG("%s stopping background scanning", hdev->name);
 	} else {
-		u8 own_addr_type;
-
 		/* If there is at least one pending LE connection, we should
 		 * keep the background scan running.
 		 */
@@ -5169,27 +5195,7 @@ void hci_update_background_scan(struct hci_dev *hdev)
 		if (conn)
 			return;
 
-		/* Set require_privacy to true to avoid identification from
-		 * unknown peer devices. Since this is passive scanning, no
-		 * SCAN_REQ using the local identity should be sent. Mandating
-		 * privacy is just an extra precaution.
-		 */
-		if (hci_update_random_address(&req, true, &own_addr_type))
-			return;
-
-		memset(&param_cp, 0, sizeof(param_cp));
-		param_cp.type = LE_SCAN_PASSIVE;
-		param_cp.interval = cpu_to_le16(hdev->le_scan_interval);
-		param_cp.window = cpu_to_le16(hdev->le_scan_window);
-		param_cp.own_address_type = own_addr_type;
-		hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
-			    &param_cp);
-
-		memset(&enable_cp, 0, sizeof(enable_cp));
-		enable_cp.enable = LE_SCAN_ENABLE;
-		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
-		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
-			    &enable_cp);
+		hci_req_add_le_passive_scan(&req);
 
 		BT_DBG("%s starting background scanning", hdev->name);
 	}
-- 
1.8.5.4

