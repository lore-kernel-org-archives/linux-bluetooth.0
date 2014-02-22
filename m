Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/15] Bluetooth: Move enable/disable_advertising higher up in mgmt.c
Date: Sat, 22 Feb 2014 19:06:33 +0200
Message-Id: <1393088805-28658-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

These functions will soon be needed by the RPA regeneration timeout so
move them higher up in mgmt.c to avoid a forward declaration.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 88 ++++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bc329d911706..37a6c4eab881 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -812,6 +812,50 @@ static void update_class(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
 }
 
+static u8 get_adv_type(struct hci_dev *hdev)
+{
+	struct pending_cmd *cmd;
+	bool connectable;
+
+	/* If there's a pending mgmt command the flag will not yet have
+	 * it's final value, so check for this first.
+	 */
+	cmd = mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
+	if (cmd) {
+		struct mgmt_mode *cp = cmd->param;
+		connectable = !!cp->val;
+	} else {
+		connectable = test_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+	}
+
+	return connectable ? LE_ADV_IND : LE_ADV_NONCONN_IND;
+}
+
+static void enable_advertising(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_adv_param cp;
+	u8 enable = 0x01;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.min_interval = __constant_cpu_to_le16(0x0800);
+	cp.max_interval = __constant_cpu_to_le16(0x0800);
+	cp.type = get_adv_type(hdev);
+	cp.own_address_type = hdev->own_addr_type;
+	cp.channel_map = hdev->le_adv_channel_map;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+}
+
+static void disable_advertising(struct hci_request *req)
+{
+	u8 enable = 0x00;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+}
+
 static void service_cache_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -1345,50 +1389,6 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
 }
 
-static u8 get_adv_type(struct hci_dev *hdev)
-{
-	struct pending_cmd *cmd;
-	bool connectable;
-
-	/* If there's a pending mgmt command the flag will not yet have
-	 * it's final value, so check for this first.
-	 */
-	cmd = mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
-	if (cmd) {
-		struct mgmt_mode *cp = cmd->param;
-		connectable = !!cp->val;
-	} else {
-		connectable = test_bit(HCI_CONNECTABLE, &hdev->dev_flags);
-	}
-
-	return connectable ? LE_ADV_IND : LE_ADV_NONCONN_IND;
-}
-
-static void enable_advertising(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_adv_param cp;
-	u8 enable = 0x01;
-
-	memset(&cp, 0, sizeof(cp));
-	cp.min_interval = __constant_cpu_to_le16(0x0800);
-	cp.max_interval = __constant_cpu_to_le16(0x0800);
-	cp.type = get_adv_type(hdev);
-	cp.own_address_type = hdev->own_addr_type;
-	cp.channel_map = hdev->le_adv_channel_map;
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
-}
-
-static void disable_advertising(struct hci_request *req)
-{
-	u8 enable = 0x00;
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
-}
-
 static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
-- 
1.8.5.3

