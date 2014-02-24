Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v11 14/15] Bluetooth: Create hci_req_add_le_passive_scan helper
Date: Mon, 24 Feb 2014 19:31:00 -0300
Message-Id: <1393281061-14320-15-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
References: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patches creates the hci_req_add_le_passive_scan helper so it can
be re-used in the next patch.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5d51086..e0ebbd9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5095,6 +5095,31 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
 
+static void hci_req_add_le_passive_scan(struct hci_request *req,
+					struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_scan_param param_cp;
+	struct hci_cp_le_set_scan_enable enable_cp;
+	u8 own_addr_type;
+
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
@@ -5110,8 +5135,6 @@ static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
  */
 void hci_update_background_scan(struct hci_dev *hdev)
 {
-	struct hci_cp_le_set_scan_param param_cp;
-	struct hci_cp_le_set_scan_enable enable_cp;
 	struct hci_request req;
 	struct hci_conn *conn;
 	int err;
@@ -5131,8 +5154,6 @@ void hci_update_background_scan(struct hci_dev *hdev)
 
 		BT_DBG("%s stopping background scanning", hdev->name);
 	} else {
-		u8 own_addr_type;
-
 		/* If there is at least one pending LE connection, we should
 		 * keep the background scan running.
 		 */
@@ -5149,22 +5170,7 @@ void hci_update_background_scan(struct hci_dev *hdev)
 		if (conn)
 			return;
 
-		if (hci_update_random_address(&req, false, &own_addr_type))
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
+		hci_req_add_le_passive_scan(&req, hdev);
 
 		BT_DBG("%s starting background scanning", hdev->name);
 	}
-- 
1.8.5.4

