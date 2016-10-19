Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH v3] Bluetooth: Fix append max 11 bytes of name to scan rsp data
Date: Wed, 19 Oct 2016 10:20:27 +0200
Message-Id: <1476865227-18807-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Append maximum of 10 + 1 bytes of name to scan response data.
Complete name is appended only if exists and is <= 10 characters.
Else append short name if exists or shorten complete name if not.
This makes sure name is consistent across multiple advertising
instances.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
---
 net/bluetooth/hci_request.c | 49 +++++++++++++++++++++------------------------
 net/bluetooth/hci_request.h |  2 ++
 net/bluetooth/mgmt.c        | 26 +++++++++++++++---------
 3 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e228842..1015d9c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -969,41 +969,38 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
 }
 
-static u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
+u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 {
-	size_t complete_len;
 	size_t short_len;
-	int max_len;
-
-	max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
-	complete_len = strlen(hdev->dev_name);
-	short_len = strlen(hdev->short_name);
-
-	/* no space left for name */
-	if (max_len < 1)
-		return ad_len;
+	size_t complete_len;
 
-	/* no name set */
-	if (!complete_len)
+	/* no space left for name (+ NULL + type + len) */
+	if ((HCI_MAX_AD_LENGTH - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
 		return ad_len;
 
-	/* complete name fits and is eq to max short name len or smaller */
-	if (complete_len <= max_len &&
-	    complete_len <= HCI_MAX_SHORT_NAME_LENGTH) {
+	/* use complete name if present and fits */
+	complete_len = strlen(hdev->dev_name);
+	if (complete_len && complete_len <= HCI_MAX_SHORT_NAME_LENGTH)
 		return eir_append_data(ptr, ad_len, EIR_NAME_COMPLETE,
-				       hdev->dev_name, complete_len);
-	}
+				       hdev->dev_name, complete_len + 1);
 
-	/* short name set and fits */
-	if (short_len && short_len <= max_len) {
+	/* use short name if present */
+	short_len = strlen(hdev->short_name);
+	if (short_len)
 		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
-				       hdev->short_name, short_len);
-	}
+				       hdev->short_name, short_len + 1);
 
-	/* no short name set so shorten complete name */
-	if (!short_len) {
-		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
-				       hdev->dev_name, max_len);
+	/* use shortened full name if present, we already know that name
+	 * is longer then HCI_MAX_SHORT_NAME_LENGTH
+	 */
+	if (complete_len) {
+		u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
+
+		memcpy(name, hdev->dev_name, HCI_MAX_SHORT_NAME_LENGTH);
+		name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
+
+		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT, name,
+				       sizeof(name));
 	}
 
 	return ad_len;
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 6b06629..dde77bd 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -106,6 +106,8 @@ static inline void hci_update_background_scan(struct hci_dev *hdev)
 void hci_request_setup(struct hci_dev *hdev);
 void hci_request_cancel_all(struct hci_dev *hdev);
 
+u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len);
+
 static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type,
 				  u8 *data, u8 data_len)
 {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7360380..1fba2a0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6017,7 +6017,15 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static u8 tlv_data_max_len(u32 adv_flags, bool is_adv_data)
+static u8 calculate_name_len(struct hci_dev *hdev)
+{
+	u8 buf[HCI_MAX_SHORT_NAME_LENGTH + 3];
+
+	return append_local_name(hdev, buf, 0);
+}
+
+static u8 tlv_data_max_len(struct hci_dev *hdev, u32 adv_flags,
+			   bool is_adv_data)
 {
 	u8 max_len = HCI_MAX_AD_LENGTH;
 
@@ -6030,9 +6038,8 @@ static u8 tlv_data_max_len(u32 adv_flags, bool is_adv_data)
 		if (adv_flags & MGMT_ADV_FLAG_TX_POWER)
 			max_len -= 3;
 	} else {
-		/* at least 1 byte of name should fit in */
 		if (adv_flags & MGMT_ADV_FLAG_LOCAL_NAME)
-			max_len -= 3;
+			max_len -= calculate_name_len(hdev);
 
 		if (adv_flags & (MGMT_ADV_FLAG_APPEARANCE))
 			max_len -= 4;
@@ -6063,12 +6070,13 @@ static bool appearance_managed(u32 adv_flags)
 	return adv_flags & MGMT_ADV_FLAG_APPEARANCE;
 }
 
-static bool tlv_data_is_valid(u32 adv_flags, u8 *data, u8 len, bool is_adv_data)
+static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
+			      u8 len, bool is_adv_data)
 {
 	int i, cur_len;
 	u8 max_len;
 
-	max_len = tlv_data_max_len(adv_flags, is_adv_data);
+	max_len = tlv_data_max_len(hdev, adv_flags, is_adv_data);
 
 	if (len > max_len)
 		return false;
@@ -6215,8 +6223,8 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (!tlv_data_is_valid(flags, cp->data, cp->adv_data_len, true) ||
-	    !tlv_data_is_valid(flags, cp->data + cp->adv_data_len,
+	if (!tlv_data_is_valid(hdev, flags, cp->data, cp->adv_data_len, true) ||
+	    !tlv_data_is_valid(hdev, flags, cp->data + cp->adv_data_len,
 			       cp->scan_rsp_len, false)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				      MGMT_STATUS_INVALID_PARAMS);
@@ -6429,8 +6437,8 @@ static int get_adv_size_info(struct sock *sk, struct hci_dev *hdev,
 
 	rp.instance = cp->instance;
 	rp.flags = cp->flags;
-	rp.max_adv_data_len = tlv_data_max_len(flags, true);
-	rp.max_scan_rsp_len = tlv_data_max_len(flags, false);
+	rp.max_adv_data_len = tlv_data_max_len(hdev, flags, true);
+	rp.max_scan_rsp_len = tlv_data_max_len(hdev, flags, false);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_ADV_SIZE_INFO,
 				MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
-- 
2.7.4

