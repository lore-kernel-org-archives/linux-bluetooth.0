Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 03/20] Bluetooth: mgmt: dry update_scan_rsp_data()
Date: Thu, 18 Jun 2015 03:16:36 +0200
Message-Id: <1434590213-26599-4-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
References: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

update_scan_rsp_data() duplicates code from get_current_adv_instance().
This is being fixed by letting the former make use of the latter.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 50 +++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a8319f6..c330416 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -832,6 +832,20 @@ static struct mgmt_pending_cmd *pending_find_data(u16 opcode,
 	return mgmt_pending_find_data(HCI_CHANNEL_CONTROL, opcode, hdev, data);
 }
 
+static u8 get_current_adv_instance(struct hci_dev *hdev)
+{
+	/* The "Set Advertising" setting supersedes the "Add Advertising"
+	 * setting. Here we set the advertising data based on which
+	 * setting was set. When neither apply, default to the global settings,
+	 * represented by instance "0".
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		return 0x01;
+
+	return 0x00;
+}
+
 static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 ad_len = 0;
@@ -900,21 +914,8 @@ static void update_scan_rsp_data_for_instance(struct hci_request *req,
 
 static void update_scan_rsp_data(struct hci_request *req)
 {
-	struct hci_dev *hdev = req->hdev;
-	u8 instance;
-
-	/* The "Set Advertising" setting supersedes the "Add Advertising"
-	 * setting. Here we set the scan response data based on which
-	 * setting was set. When neither apply, default to the global settings,
-	 * represented by instance "0".
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		instance = 0x01;
-	else
-		instance = 0x00;
-
-	update_scan_rsp_data_for_instance(req, instance);
+	update_scan_rsp_data_for_instance(req,
+					  get_current_adv_instance(req->hdev));
 }
 
 static u8 get_adv_discov_flags(struct hci_dev *hdev)
@@ -941,20 +942,6 @@ static u8 get_adv_discov_flags(struct hci_dev *hdev)
 	return 0;
 }
 
-static u8 get_current_adv_instance(struct hci_dev *hdev)
-{
-	/* The "Set Advertising" setting supersedes the "Add Advertising"
-	 * setting. Here we set the advertising data based on which
-	 * setting was set. When neither apply, default to the global settings,
-	 * represented by instance "0".
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		return 0x01;
-
-	return 0x00;
-}
-
 static bool get_connectable(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
@@ -1093,10 +1080,7 @@ static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
 
 static void update_adv_data(struct hci_request *req)
 {
-	struct hci_dev *hdev = req->hdev;
-	u8 instance = get_current_adv_instance(hdev);
-
-	update_adv_data_for_instance(req, instance);
+	update_adv_data_for_instance(req, get_current_adv_instance(req->hdev));
 }
 
 int mgmt_update_adv_data(struct hci_dev *hdev)
-- 
1.9.1

