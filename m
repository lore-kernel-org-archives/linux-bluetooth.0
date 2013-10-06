Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set LE advertising parameters before enabling it
Date: Sun,  6 Oct 2013 03:17:56 -0700
Message-Id: <1381054676-15507-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LE advertising parameters can only be modified when advertising
is disabled. So before enabling it, make sure the controller has all
the right parameters.

Right now all default values are used and thus this does no change
any existing behavior. One minor exception is that in case of single
mode LE-only controllers without a public address, now the random
address is used for advertising.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8386684..b78a0ee 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1413,16 +1413,30 @@ unlock:
 
 static void enable_advertising(struct hci_request *req)
 {
-	u8 adv = 0x01;
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_adv_param cp;
+	u8 enable = 0x01;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.min_interval = __constant_cpu_to_le16(0x0800);
+	cp.max_interval = __constant_cpu_to_le16(0x0800);
+	cp.type = LE_ADV_IND;
+	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
+		cp.own_address_type = ADDR_LE_DEV_PUBLIC;
+	else
+		cp.own_address_type = ADDR_LE_DEV_RANDOM;
+	cp.channel_map = 0x07;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
 
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(adv), &adv);
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
 }
 
 static void disable_advertising(struct hci_request *req)
 {
-	u8 adv = 0x00;
+	u8 enable = 0x00;
 
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(adv), &adv);
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
 }
 
 static void le_enable_complete(struct hci_dev *hdev, u8 status)
-- 
1.8.3.1

