Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Add connectable argument to enable_advertising()
Date: Mon, 14 Oct 2013 13:52:39 +0300
Message-Id: <1381747965-24599-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381747965-24599-1-git-send-email-johan.hedberg@gmail.com>
References: <1381747965-24599-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We want to be able to control whether enable_advertising() enables
connectable or non-connectable advertising based on the connectable
setting of the adapter. We could have the function check directly for
the HCI_CONNECTABLE flag, but since the flag may not be set or unset
before we call the function it's necessary to pass an explicit parameter
value to it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 020f95b..6f07523 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1418,7 +1418,7 @@ unlock:
 	return err;
 }
 
-static void enable_advertising(struct hci_request *req)
+static void enable_advertising(struct hci_request *req, bool connectable)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_adv_param cp;
@@ -1427,7 +1427,10 @@ static void enable_advertising(struct hci_request *req)
 	memset(&cp, 0, sizeof(cp));
 	cp.min_interval = __constant_cpu_to_le16(0x0800);
 	cp.max_interval = __constant_cpu_to_le16(0x0800);
-	cp.type = LE_ADV_IND;
+	if (connectable)
+		cp.type = LE_ADV_IND;
+	else
+		cp.type = LE_ADV_NONCONN_IND;
 	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
 		cp.own_address_type = ADDR_LE_DEV_PUBLIC;
 	else
@@ -3323,7 +3326,8 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_req_init(&req, hdev);
 
 	if (val)
-		enable_advertising(&req);
+		enable_advertising(&req,
+				   test_bit(HCI_CONNECTABLE, &hdev->dev_flags));
 	else
 		disable_advertising(&req);
 
@@ -3948,7 +3952,9 @@ static int powered_update_hci(struct hci_dev *hdev)
 				    &hdev->static_addr);
 
 		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
-			enable_advertising(&req);
+			enable_advertising(&req,
+					   test_bit(HCI_CONNECTABLE,
+						    &hdev->dev_flags));
 	}
 
 	link_sec = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
@@ -4735,7 +4741,7 @@ void mgmt_reenable_advertising(struct hci_dev *hdev)
 		return;
 
 	hci_req_init(&req, hdev);
-	enable_advertising(&req);
+	enable_advertising(&req, test_bit(HCI_CONNECTABLE, &hdev->dev_flags));
 
 	/* If this fails we have no option but to let user space know
 	 * that we've disabled advertising.
-- 
1.8.3.1

