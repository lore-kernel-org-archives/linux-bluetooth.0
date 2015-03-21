Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v1 6/7] Bluetooth: Add support for instance scan response
Date: Fri, 20 Mar 2015 19:48:09 -0700
Message-Id: <1426906090-9026-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1426906090-9026-1-git-send-email-armansito@chromium.org>
References: <1426906090-9026-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements setting the Scan Response data provided as part
of an advertising instance through the Add Advertising command.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 58 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1f97a19..02bb42f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -793,7 +793,7 @@ static struct mgmt_pending_cmd *pending_find_data(u16 opcode,
 	return mgmt_pending_find_data(HCI_CHANNEL_CONTROL, opcode, hdev, data);
 }
 
-static u8 create_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
+static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 ad_len = 0;
 	size_t name_len;
@@ -819,6 +819,17 @@ static u8 create_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 	return ad_len;
 }
 
+static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
+{
+	/* TODO: Set the appropriate entries based on advertising instance flags
+	 * here once flags other than 0 are supported.
+	 */
+	memcpy(ptr, hdev->adv_instance.scan_rsp_data,
+	       hdev->adv_instance.scan_rsp_len);
+
+	return hdev->adv_instance.scan_rsp_len;
+}
+
 static void update_scan_rsp_data(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -830,7 +841,15 @@ static void update_scan_rsp_data(struct hci_request *req)
 
 	memset(&cp, 0, sizeof(cp));
 
-	len = create_scan_rsp_data(hdev, cp.data);
+	/* The "Set Advertising" setting supersedes the "Add Advertising"
+	 * setting. Here we set the advertising data based on which
+	 * setting was set. Default to the global settings when neither apply.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		len = create_instance_scan_rsp_data(hdev, cp.data);
+	else
+		len = create_default_scan_rsp_data(hdev, cp.data);
 
 	if (hdev->scan_rsp_data_len == len &&
 	    memcmp(cp.data, hdev->scan_rsp_data, len) == 0)
@@ -922,7 +941,7 @@ static void update_adv_data(struct hci_request *req)
 
 	memset(&cp, 0, sizeof(cp));
 
-	/* The "Set Advertising" setting supercedes the "Add Advertising"
+	/* The "Set Advertising" setting supersedes the "Add Advertising"
 	 * setting. Here we set the advertising data based on which
 	 * setting was set. Default to the global settings when neither apply.
 	 */
@@ -4532,11 +4551,12 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (val) {
 		/* Set the HCI_ADVERTISING bit temporarily so that
-		 * update_adv_data knows to use the default advertising
-		 * settings.
+		 * update_adv_data and update_scan_rsp_data know to use the
+		 * default advertising settings.
 		 */
 		hci_dev_set_flag(hdev, HCI_ADVERTISING);
 		update_adv_data(&req);
+		update_scan_rsp_data(&req);
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
 
 		enable_advertising(&req);
@@ -6400,33 +6420,26 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static bool adv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *adv_data,
-			      u8 adv_data_len)
+static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
+			      u8 len)
 {
-	u8 max_adv_len = HCI_MAX_AD_LENGTH;
+	u8 max_len = HCI_MAX_AD_LENGTH;
 	int i, cur_len;
 
-	/* TODO: Correctly reduce adv_len based on adv_flags. */
-
-	/* The only global settings that affects the maximum length is BREDR
-	 * support, which must be included in the "flags" AD field.
-	 */
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		max_adv_len -= 3;
-
-	if (adv_data_len > max_adv_len)
+	/* TODO: Correctly reduce len based on adv_flags. */
+	if (len > max_len)
 		return false;
 
 	/* Make sure that adv_data is correctly formatted and doesn't contain
 	 * any fields that are managed by adv_flags and global settings.
 	 */
-	for (i = 0, cur_len = 0; i < adv_data_len; i += (cur_len + 1)) {
-		cur_len = adv_data[i];
+	for (i = 0, cur_len = 0; i < len; i += (cur_len + 1)) {
+		cur_len = data[i];
 
 		/* If the current field length would exceed the total data
 		 * length, then it's invalid.
 		 */
-		if (i + cur_len >= adv_data_len)
+		if (i + cur_len >= len)
 			return false;
 	}
 
@@ -6526,7 +6539,9 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (!adv_data_is_valid(hdev, flags, cp->data, cp->adv_data_len)) {
+	if (!tlv_data_is_valid(hdev, flags, cp->data, cp->adv_data_len) ||
+	    !tlv_data_is_valid(hdev, flags, cp->data + cp->adv_data_len,
+			       cp->scan_rsp_len)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				      MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
@@ -6570,6 +6585,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	hci_req_init(&req, hdev);
 
 	update_adv_data(&req);
+	update_scan_rsp_data(&req);
 	enable_advertising(&req);
 
 	err = hci_req_run(&req, add_advertising_complete);
-- 
2.2.0.rc0.207.ga3a616c

