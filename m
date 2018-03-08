Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 5/7] Bluetooth: Use ext adv for directed adv
Date: Thu,  8 Mar 2018 17:09:34 +0530
Message-Id: <1520509176-17569-8-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1520509176-17569-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1520509176-17569-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does extended advertising for directed advertising
if the controller supportes. Instance 0 is used for directed
advertising.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 net/bluetooth/hci_conn.c | 67 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4591e09..ec64fd5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -857,35 +857,58 @@ static void hci_req_directed_advertising(struct hci_request *req,
 					 struct hci_conn *conn)
 {
 	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_adv_param cp;
 	u8 own_addr_type;
 	u8 enable;
 
-	/* Clear the HCI_LE_ADV bit temporarily so that the
-	 * hci_update_random_address knows that it's safe to go ahead
-	 * and write a new random address. The flag will be set back on
-	 * as soon as the SET_ADV_ENABLE HCI command completes.
-	 */
-	hci_dev_clear_flag(hdev, HCI_LE_ADV);
+	if (ext_adv_capable(hdev)) {
+		struct hci_cp_le_set_ext_adv_params cp;
 
-	/* Set require_privacy to false so that the remote device has a
-	 * chance of identifying us.
-	 */
-	if (hci_update_random_address(req, false, conn_use_rpa(conn),
-				      &own_addr_type) < 0)
-		return;
+		memset(&cp, 0, sizeof(cp));
 
-	memset(&cp, 0, sizeof(cp));
-	cp.type = LE_ADV_DIRECT_IND;
-	cp.own_address_type = own_addr_type;
-	cp.direct_addr_type = conn->dst_type;
-	bacpy(&cp.direct_addr, &conn->dst);
-	cp.channel_map = hdev->le_adv_channel_map;
+		cp.evt_properties = LE_LEGACY_ADV_DIRECT_IND;
+		cp.own_addr_type = own_addr_type;
+		cp.channel_map = hdev->le_adv_channel_map;
+		cp.tx_power = 127;
+		cp.primary_phy = HCI_ADV_PHY_1M;
+		cp.secondary_phy = HCI_ADV_PHY_1M;
+		cp.handle = 0; /* Use instance 0 for directed adv */
+		cp.own_addr_type = own_addr_type;
+		cp.peer_addr_type = conn->dst_type;
+		bacpy(&cp.peer_addr, &conn->dst);
+
+		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
+
+		__hci_req_enable_ext_advertising(req);
+	} else {
+		struct hci_cp_le_set_adv_param cp;
+
+		/* Clear the HCI_LE_ADV bit temporarily so that the
+		 * hci_update_random_address knows that it's safe to go ahead
+		 * and write a new random address. The flag will be set back on
+		 * as soon as the SET_ADV_ENABLE HCI command completes.
+		 */
+		hci_dev_clear_flag(hdev, HCI_LE_ADV);
+
+		/* Set require_privacy to false so that the remote device has a
+		 * chance of identifying us.
+		 */
+		if (hci_update_random_address(req, false, conn_use_rpa(conn),
+					      &own_addr_type) < 0)
+			return;
 
-	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
+		memset(&cp, 0, sizeof(cp));
+		cp.type = LE_ADV_DIRECT_IND;
+		cp.own_address_type = own_addr_type;
+		cp.direct_addr_type = conn->dst_type;
+		bacpy(&cp.direct_addr, &conn->dst);
+		cp.channel_map = hdev->le_adv_channel_map;
+
+		hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
 
-	enable = 0x01;
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+		enable = 0x01;
+		hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
+			    &enable);
+	}
 
 	conn->state = BT_CONNECT;
 }
-- 
2.7.4

