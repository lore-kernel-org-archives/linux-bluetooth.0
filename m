Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 3/7] Bluetooth: Support the "discoverable" adv flag
Date: Tue, 24 Mar 2015 20:02:58 -0700
Message-Id: <1427252582-24814-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1427252582-24814-1-git-send-email-armansito@chromium.org>
References: <1427252582-24814-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for the "discoverable" flag of the
Add Advertising command.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a5995a2..b197dc1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -975,13 +975,28 @@ static u8 create_default_adv_data(struct hci_dev *hdev, u8 *ptr)
 
 static u8 create_instance_adv_data(struct hci_dev *hdev, u8 *ptr)
 {
-	/* TODO: Set the appropriate entries based on advertising instance flags
-	 * here once flags other than 0 are supported.
-	 */
+	u8 ad_len = 0, flags = 0;
+
+	if (hdev->adv_instance.flags & MGMT_ADV_FLAG_DISCOV)
+		flags |= LE_AD_GENERAL;
+
+	if (flags) {
+		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+			flags |= LE_AD_NO_BREDR;
+
+		ptr[0] = 0x02;
+		ptr[1] = EIR_FLAGS;
+		ptr[2] = flags;
+
+		ad_len += 3;
+		ptr += 3;
+	}
+
 	memcpy(ptr, hdev->adv_instance.adv_data,
 	       hdev->adv_instance.adv_data_len);
+	ad_len += hdev->adv_instance.adv_data_len;
 
-	return hdev->adv_instance.adv_data_len;
+	return ad_len;
 }
 
 static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
@@ -6539,12 +6554,16 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 }
 
 static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
-			      u8 len)
+			      u8 len, bool is_adv_data)
 {
 	u8 max_len = HCI_MAX_AD_LENGTH;
 	int i, cur_len;
+	bool flags_managed = false;
 
-	/* TODO: Correctly reduce len based on adv_flags. */
+	if (is_adv_data && (adv_flags & MGMT_ADV_FLAG_DISCOV)) {
+		flags_managed = true;
+		max_len -= 3;
+	}
 
 	if (len > max_len)
 		return false;
@@ -6553,6 +6572,9 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 	for (i = 0, cur_len = 0; i < len; i += (cur_len + 1)) {
 		cur_len = data[i];
 
+		if (flags_managed && data[i + 1] == EIR_FLAGS)
+			return false;
+
 		/* If the current field length would exceed the total data
 		 * length, then it's invalid.
 		 */
@@ -6654,9 +6676,9 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (!tlv_data_is_valid(hdev, flags, cp->data, cp->adv_data_len) ||
+	if (!tlv_data_is_valid(hdev, flags, cp->data, cp->adv_data_len, true) ||
 	    !tlv_data_is_valid(hdev, flags, cp->data + cp->adv_data_len,
-			       cp->scan_rsp_len)) {
+			       cp->scan_rsp_len, false)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				      MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
-- 
2.2.0.rc0.207.ga3a616c

