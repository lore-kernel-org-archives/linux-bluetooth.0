Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH 3/3] Bluetooth: Refactor append name and appearance
Date: Wed,  5 Oct 2016 12:28:27 +0200
Message-Id: <1475663307-3191-3-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1475663307-3191-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1475663307-3191-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use eir_append_data to remove code duplication.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
---
 net/bluetooth/hci_request.c | 44 +++++++++++++++-----------------------------
 net/bluetooth/hci_request.h | 23 +++++++++++++++++++++++
 net/bluetooth/mgmt.c        | 21 ---------------------
 3 files changed, 38 insertions(+), 50 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3c44c54..e228842 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -21,8 +21,6 @@
    SOFTWARE IS DISCLAIMED.
 */
 
-#include <asm/unaligned.h>
-
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
@@ -992,46 +990,39 @@ static u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 	/* complete name fits and is eq to max short name len or smaller */
 	if (complete_len <= max_len &&
 	    complete_len <= HCI_MAX_SHORT_NAME_LENGTH) {
-		ptr[0] = complete_len + 1;
-		ptr[1] = EIR_NAME_COMPLETE;
-		memcpy(ptr + 2, hdev->dev_name, complete_len);
-
-		return ad_len + complete_len + 2;
+		return eir_append_data(ptr, ad_len, EIR_NAME_COMPLETE,
+				       hdev->dev_name, complete_len);
 	}
 
 	/* short name set and fits */
 	if (short_len && short_len <= max_len) {
-		ptr[0] = short_len + 1;
-		ptr[1] = EIR_NAME_SHORT;
-		memcpy(ptr + 2, hdev->short_name, short_len);
-
-		return ad_len + short_len + 2;
+		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
+				       hdev->short_name, short_len);
 	}
 
 	/* no short name set so shorten complete name */
 	if (!short_len) {
-		ptr[0] = max_len + 1;
-		ptr[1] = EIR_NAME_SHORT;
-		memcpy(ptr + 2, hdev->dev_name, max_len);
-
-		return ad_len + max_len + 2;
+		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
+				       hdev->dev_name, max_len);
 	}
 
 	return ad_len;
 }
 
+static u8 append_appearance(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
+{
+	return eir_append_le16(ptr, ad_len, EIR_APPEARANCE, hdev->appearance);
+}
+
 static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 scan_rsp_len = 0;
 
 	if (hdev->appearance) {
-		ptr[0] = 3;
-		ptr[1] = EIR_APPEARANCE;
-		put_unaligned_le16(hdev->appearance, ptr + 2);
-		scan_rsp_len += 4;
+		scan_rsp_len = append_appearance(hdev, ptr, scan_rsp_len);
 	}
 
-	return append_local_name(hdev, ptr + scan_rsp_len, scan_rsp_len);
+	return append_local_name(hdev, ptr, scan_rsp_len);
 }
 
 static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
@@ -1048,18 +1039,13 @@ static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
 	instance_flags = adv_instance->flags;
 
 	if ((instance_flags & MGMT_ADV_FLAG_APPEARANCE) && hdev->appearance) {
-		ptr[0] = 3;
-		ptr[1] = EIR_APPEARANCE;
-		put_unaligned_le16(hdev->appearance, ptr + 2);
-		scan_rsp_len += 4;
-		ptr += 4;
+		scan_rsp_len = append_appearance(hdev, ptr, scan_rsp_len);
 	}
 
-	memcpy(ptr, adv_instance->scan_rsp_data,
+	memcpy(&ptr[scan_rsp_len], adv_instance->scan_rsp_data,
 	       adv_instance->scan_rsp_len);
 
 	scan_rsp_len += adv_instance->scan_rsp_len;
-	ptr += adv_instance->scan_rsp_len;
 
 	if (instance_flags & MGMT_ADV_FLAG_LOCAL_NAME)
 		scan_rsp_len = append_local_name(hdev, ptr, scan_rsp_len);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index ac1e110..6b06629 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -20,6 +20,8 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#include <asm/unaligned.h>
+
 #define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
 #define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
 
@@ -103,3 +105,24 @@ static inline void hci_update_background_scan(struct hci_dev *hdev)
 
 void hci_request_setup(struct hci_dev *hdev);
 void hci_request_cancel_all(struct hci_dev *hdev);
+
+static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type,
+				  u8 *data, u8 data_len)
+{
+	eir[eir_len++] = sizeof(type) + data_len;
+	eir[eir_len++] = type;
+	memcpy(&eir[eir_len], data, data_len);
+	eir_len += data_len;
+
+	return eir_len;
+}
+
+static inline u16 eir_append_le16(u8 *eir, u16 eir_len, u8 type, u16 data)
+{
+	eir[eir_len++] = sizeof(type) + sizeof(data);
+	eir[eir_len++] = type;
+	put_unaligned_le16(data, &eir[eir_len]);
+	eir_len += sizeof(data);
+
+	return eir_len;
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 19b8a5e..7360380 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -867,27 +867,6 @@ static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
 				 sizeof(rp));
 }
 
-static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
-				  u8 data_len)
-{
-	eir[eir_len++] = sizeof(type) + data_len;
-	eir[eir_len++] = type;
-	memcpy(&eir[eir_len], data, data_len);
-	eir_len += data_len;
-
-	return eir_len;
-}
-
-static inline u16 eir_append_le16(u8 *eir, u16 eir_len, u8 type, u16 data)
-{
-	eir[eir_len++] = sizeof(type) + sizeof(data);
-	eir[eir_len++] = type;
-	put_unaligned_le16(data, &eir[eir_len]);
-	eir_len += sizeof(data);
-
-	return eir_len;
-}
-
 static u16 append_eir_data_to_buf(struct hci_dev *hdev, u8 *eir)
 {
 	u16 eir_len = 0;
-- 
2.7.4

