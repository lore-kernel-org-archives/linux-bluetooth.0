Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 11/16] Bluetooth: mgmt: refactor update_*_data()
Date: Tue, 26 May 2015 02:34:18 +0200
Message-Id: <1432600463-7758-12-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
References: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
References: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The update_*_data_for_instance() methods are no longer being referenced
anywhere in the code. To reduce complexity and improve readability,
these methods are being joined with their corresponding update_*_data()
counterparts.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e999bbb..3d09cb9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -890,18 +890,18 @@ static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
 	return adv_instance->scan_rsp_len;
 }
 
-static void update_scan_rsp_data_for_instance(struct hci_request *req,
-					      u8 instance)
+static void update_scan_rsp_data(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_scan_rsp_data cp;
-	u8 len;
+	u8 instance, len;
 
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
 	memset(&cp, 0, sizeof(cp));
 
+	instance = get_current_adv_instance(hdev);
 	if (instance)
 		len = create_instance_scan_rsp_data(hdev, instance, cp.data);
 	else
@@ -919,14 +919,6 @@ static void update_scan_rsp_data_for_instance(struct hci_request *req,
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
 }
 
-static void update_scan_rsp_data(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 instance = get_current_adv_instance(hdev);
-
-	update_scan_rsp_data_for_instance(req, instance);
-}
-
 static u8 get_adv_discov_flags(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
@@ -1084,17 +1076,18 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 	return ad_len;
 }
 
-static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
+static void update_adv_data(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_adv_data cp;
-	u8 len;
+	u8 instance, len;
 
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
 	memset(&cp, 0, sizeof(cp));
 
+	instance = get_current_adv_instance(hdev);
 	len = create_instance_adv_data(hdev, instance, cp.data);
 
 	/* There's nothing to do if the data hasn't changed */
@@ -1110,14 +1103,6 @@ static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
 }
 
-static void update_adv_data(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 instance = get_current_adv_instance(hdev);
-
-	update_adv_data_for_instance(req, instance);
-}
-
 int mgmt_update_adv_data(struct hci_dev *hdev)
 {
 	struct hci_request req;
-- 
1.9.1

