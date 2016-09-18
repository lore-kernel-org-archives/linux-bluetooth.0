Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>,
        Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 1/6] Bluetooth: Add support for local name in scan rsp
Date: Sun, 18 Sep 2016 12:50:02 +0200
Message-Id: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michał Narajowski <michal.narajowski@codecoup.pl>

This patch enables appending local name to scan response data. If
currently advertised instance has name flag set it is expired
immediately.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/hci_request.c | 28 +++++++++++++++++++--------
 net/bluetooth/mgmt.c        | 46 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 9566ff8..0ce6cdd 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -971,14 +971,14 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
 }
 
-static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
+static u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 {
-	u8 ad_len = 0;
 	size_t name_len;
+	int max_len;
 
+	max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
 	name_len = strlen(hdev->dev_name);
-	if (name_len > 0) {
-		size_t max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
+	if (name_len > 0 && max_len > 0) {
 
 		if (name_len > max_len) {
 			name_len = max_len;
@@ -997,22 +997,34 @@ static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 	return ad_len;
 }
 
+static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
+{
+	return append_local_name(hdev, ptr, 0);
+}
+
 static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
 					u8 *ptr)
 {
 	struct adv_info *adv_instance;
+	u32 instance_flags;
+	u8 scan_rsp_len = 0;
 
 	adv_instance = hci_find_adv_instance(hdev, instance);
 	if (!adv_instance)
 		return 0;
 
-	/* TODO: Set the appropriate entries based on advertising instance flags
-	 * here once flags other than 0 are supported.
-	 */
+	instance_flags = adv_instance->flags;
+
 	memcpy(ptr, adv_instance->scan_rsp_data,
 	       adv_instance->scan_rsp_len);
 
-	return adv_instance->scan_rsp_len;
+	scan_rsp_len += adv_instance->scan_rsp_len;
+	ptr += adv_instance->scan_rsp_len;
+
+	if (instance_flags & MGMT_ADV_FLAG_LOCAL_NAME)
+		scan_rsp_len = append_local_name(hdev, ptr, scan_rsp_len);
+
+	return scan_rsp_len;
 }
 
 void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 74179b9..fa1f1c7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3014,6 +3014,35 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 				 HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
+static void adv_expire(struct hci_dev *hdev, u32 flags)
+{
+	struct adv_info *adv_instance;
+	struct hci_request req;
+	int err;
+
+	adv_instance = hci_find_adv_instance(hdev, hdev->cur_adv_instance);
+	if (!adv_instance)
+		return;
+
+	/* stop if current instance doesn't need to be changed */
+	if (!(adv_instance->flags & flags))
+		return;
+
+	cancel_adv_timeout(hdev);
+
+	adv_instance = hci_get_next_instance(hdev, adv_instance->instance);
+	if (!adv_instance)
+		return;
+
+	hci_req_init(&req, hdev);
+	err = __hci_req_schedule_adv_instance(&req, adv_instance->instance,
+					      true);
+	if (err)
+		return;
+
+	hci_req_run(&req, NULL);
+}
+
 static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct mgmt_cp_set_local_name *cp;
@@ -3029,13 +3058,17 @@ static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	cp = cmd->param;
 
-	if (status)
+	if (status) {
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
 			        mgmt_status(status));
-	else
+	} else {
 		mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
 				  cp, sizeof(*cp));
 
+		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+			adv_expire(hdev, MGMT_ADV_FLAG_LOCAL_NAME);
+	}
+
 	mgmt_pending_remove(cmd);
 
 unlock:
@@ -5887,6 +5920,7 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
 	flags |= MGMT_ADV_FLAG_DISCOV;
 	flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
 	flags |= MGMT_ADV_FLAG_MANAGED_FLAGS;
+	flags |= MGMT_ADV_FLAG_LOCAL_NAME;
 
 	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID)
 		flags |= MGMT_ADV_FLAG_TX_POWER;
@@ -5963,6 +5997,10 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 			tx_power_managed = true;
 			max_len -= 3;
 		}
+	} else {
+		/* at least 1 byte of name should fit in */
+		if (adv_flags & MGMT_ADV_FLAG_LOCAL_NAME)
+			max_len -= 3;
 	}
 
 	if (len > max_len)
@@ -6295,6 +6333,10 @@ static u8 tlv_data_max_len(u32 adv_flags, bool is_adv_data)
 
 		if (adv_flags & MGMT_ADV_FLAG_TX_POWER)
 			max_len -= 3;
+	} else {
+		/* at least 1 byte of name should fit in */
+		if (adv_flags & MGMT_ADV_FLAG_LOCAL_NAME)
+			max_len -= 3;
 	}
 
 	return max_len;
-- 
2.7.4

