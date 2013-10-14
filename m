Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Move static advertising functions to avoid forward declarations
Date: Mon, 14 Oct 2013 13:52:41 +0300
Message-Id: <1381747965-24599-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381747965-24599-1-git-send-email-johan.hedberg@gmail.com>
References: <1381747965-24599-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

These functions will soon be used by set_connectable() so move them to a
location in mgmt.c that doesn't require forward declarations.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 62 ++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 982b397..0200c7e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1072,6 +1072,37 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
 }
 
+static void enable_advertising(struct hci_request *req, bool connectable)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_adv_param cp;
+	u8 enable = 0x01;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.min_interval = __constant_cpu_to_le16(0x0800);
+	cp.max_interval = __constant_cpu_to_le16(0x0800);
+	if (connectable)
+		cp.type = LE_ADV_IND;
+	else
+		cp.type = LE_ADV_NONCONN_IND;
+	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
+		cp.own_address_type = ADDR_LE_DEV_PUBLIC;
+	else
+		cp.own_address_type = ADDR_LE_DEV_RANDOM;
+	cp.channel_map = 0x07;
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
 static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
@@ -1422,37 +1453,6 @@ unlock:
 	return err;
 }
 
-static void enable_advertising(struct hci_request *req, bool connectable)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_adv_param cp;
-	u8 enable = 0x01;
-
-	memset(&cp, 0, sizeof(cp));
-	cp.min_interval = __constant_cpu_to_le16(0x0800);
-	cp.max_interval = __constant_cpu_to_le16(0x0800);
-	if (connectable)
-		cp.type = LE_ADV_IND;
-	else
-		cp.type = LE_ADV_NONCONN_IND;
-	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
-		cp.own_address_type = ADDR_LE_DEV_PUBLIC;
-	else
-		cp.own_address_type = ADDR_LE_DEV_RANDOM;
-	cp.channel_map = 0x07;
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
 static void le_enable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
-- 
1.8.3.1

