Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Simplify usage of the enable_advertising function
Date: Tue,  8 Jul 2014 15:07:50 +0300
Message-Id: <1404821273-28005-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
References: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

By adding support for disabling advertising when necessary and doing the
checks for existing LE connections inside the enable_advertising
function we can simplify the calling code quite a lot.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 49 ++++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index be589d8d437f..68c0698124fb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1039,6 +1039,13 @@ static bool get_connectable(struct hci_dev *hdev)
 	return test_bit(HCI_CONNECTABLE, &hdev->dev_flags);
 }
 
+static void disable_advertising(struct hci_request *req)
+{
+	u8 enable = 0x00;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+}
+
 static void enable_advertising(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -1046,6 +1053,12 @@ static void enable_advertising(struct hci_request *req)
 	u8 own_addr_type, enable = 0x01;
 	bool connectable;
 
+	if (hci_conn_num(hdev, LE_LINK) > 0)
+		return;
+
+	if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
+		disable_advertising(req);
+
 	/* Clear the HCI_LE_ADV bit temporarily so that the
 	 * hci_update_random_address knows that it's safe to go ahead
 	 * and write a new random address. The flag will be set back on
@@ -1074,13 +1087,6 @@ static void enable_advertising(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
 }
 
-static void disable_advertising(struct hci_request *req)
-{
-	u8 enable = 0x00;
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
-}
-
 static void service_cache_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -1112,19 +1118,14 @@ static void rpa_expired(struct work_struct *work)
 
 	set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
 
-	if (!test_bit(HCI_ADVERTISING, &hdev->dev_flags) ||
-	    hci_conn_num(hdev, LE_LINK) > 0)
+	if (!test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		return;
 
 	/* The generation of a new RPA and programming it into the
 	 * controller happens in the enable_advertising() function.
 	 */
-
 	hci_req_init(&req, hdev);
-
-	disable_advertising(&req);
 	enable_advertising(&req);
-
 	hci_req_run(&req, NULL);
 }
 
@@ -1864,10 +1865,8 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		write_fast_connectable(&req, false);
 
 	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) &&
-	    hci_conn_num(hdev, LE_LINK) == 0) {
-		disable_advertising(&req);
+	    !test_bit(HCI_LE_ADV, &hdev->dev_flags))
 		enable_advertising(&req);
-	}
 
 	err = hci_req_run(&req, set_connectable_complete);
 	if (err < 0) {
@@ -6809,32 +6808,16 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 static void adv_enable_complete(struct hci_dev *hdev, u8 status)
 {
 	BT_DBG("%s status %u", hdev->name, status);
-
-	/* Clear the advertising mgmt setting if we failed to re-enable it */
-	if (status) {
-		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
-		new_settings(hdev, NULL);
-	}
 }
 
 void mgmt_reenable_advertising(struct hci_dev *hdev)
 {
 	struct hci_request req;
 
-	if (hci_conn_num(hdev, LE_LINK) > 0)
-		return;
-
 	if (!test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		return;
 
 	hci_req_init(&req, hdev);
 	enable_advertising(&req);
-
-	/* If this fails we have no option but to let user space know
-	 * that we've disabled advertising.
-	 */
-	if (hci_req_run(&req, adv_enable_complete) < 0) {
-		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
-		new_settings(hdev, NULL);
-	}
+	hci_req_run(&req, adv_enable_complete);
 }
-- 
1.9.3

