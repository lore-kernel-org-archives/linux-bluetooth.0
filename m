Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use helper functions for enabling/disabling advertising
Date: Sun,  6 Oct 2013 02:55:21 -0700
Message-Id: <1381053321-9760-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The tasks of enabling and disabling advertising are required in many
cases. So refactor the actual HCI operations into two common helpers
to make the code simpler.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e09ceff..8386684 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1411,6 +1411,20 @@ unlock:
 	return err;
 }
 
+static void enable_advertising(struct hci_request *req)
+{
+	u8 adv = 0x01;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(adv), &adv);
+}
+
+static void disable_advertising(struct hci_request *req)
+{
+	u8 adv = 0x00;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(adv), &adv);
+}
+
 static void le_enable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
@@ -1505,11 +1519,8 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_req_init(&req, hdev);
 
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) && !val) {
-		u8 adv = 0x00;
-
-		hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(adv), &adv);
-	}
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) && !val)
+		disable_advertising(&req);
 
 	hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
 		    &hci_cp);
@@ -3283,7 +3294,10 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data, u1
 
 	hci_req_init(&req, hdev);
 
-	hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(val), &val);
+	if (val)
+		enable_advertising(&req);
+	else
+		disable_advertising(&req);
 
 	err = hci_req_run(&req, set_advertising_complete);
 	if (err < 0)
@@ -3861,12 +3875,9 @@ static int powered_update_hci(struct hci_dev *hdev)
 		if (bacmp(&hdev->static_addr, BDADDR_ANY))
 			hci_req_add(&req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
 				    &hdev->static_addr);
-	}
-
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
-		u8 adv = 0x01;
 
-		hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(adv), &adv);
+		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+			enable_advertising(&req);
 	}
 
 	link_sec = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
-- 
1.8.3.1

