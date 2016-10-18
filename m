Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH 2/2] Bluetooth: Fix append max 11 bytes of name to scan rsp data
Date: Tue, 18 Oct 2016 15:10:24 +0200
Message-Id: <1476796224-14476-2-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1476796224-14476-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1476796224-14476-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Append maximum of 10 + 1 bytes of name to scan response data.
Complete name is appended only if exists and is <= 10 characters.
Else append short name if exists. This makes sure name
is consistent across multiple advertising instances.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
---
 net/bluetooth/hci_request.c | 40 +++++++++++-----------------------------
 net/bluetooth/mgmt.c        |  4 ++--
 2 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e228842..fc3d2a4 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -971,41 +971,23 @@ void __hci_req_enable_advertising(struct hci_request *req)
 
 static u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 {
-	size_t complete_len;
-	size_t short_len;
-	int max_len;
+	size_t len;
 
-	max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
-	complete_len = strlen(hdev->dev_name);
-	short_len = strlen(hdev->short_name);
-
-	/* no space left for name */
-	if (max_len < 1)
-		return ad_len;
-
-	/* no name set */
-	if (!complete_len)
+	/* no space left for name (+ NULL + type + len) */
+	if ((HCI_MAX_AD_LENGTH - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
 		return ad_len;
 
-	/* complete name fits and is eq to max short name len or smaller */
-	if (complete_len <= max_len &&
-	    complete_len <= HCI_MAX_SHORT_NAME_LENGTH) {
+	/* use complete name if present and fits */
+	len = strlen(hdev->dev_name);
+	if (len && len <= HCI_MAX_SHORT_NAME_LENGTH)
 		return eir_append_data(ptr, ad_len, EIR_NAME_COMPLETE,
-				       hdev->dev_name, complete_len);
-	}
+				       hdev->dev_name, len + 1);
 
-	/* short name set and fits */
-	if (short_len && short_len <= max_len) {
+	/* use short name if present */
+	len = strlen(hdev->short_name);
+	if (len)
 		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
-				       hdev->short_name, short_len);
-	}
-
-	/* no short name set so shorten complete name */
-	if (!short_len) {
-		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
-				       hdev->dev_name, max_len);
-	}
-
+				       hdev->short_name, len + 1);
 	return ad_len;
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cc6e571..53be90e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6039,9 +6039,9 @@ static u8 tlv_data_max_len(u32 adv_flags, bool is_adv_data)
 		if (adv_flags & MGMT_ADV_FLAG_TX_POWER)
 			max_len -= 3;
 	} else {
-		/* at least 1 byte of name should fit in */
+		/* max 11 bytes of name should fit in */
 		if (adv_flags & MGMT_ADV_FLAG_LOCAL_NAME)
-			max_len -= 3;
+			max_len -= (1 + 1 + 11);
 
 		if (adv_flags & (MGMT_ADV_FLAG_APPEARANCE))
 			max_len -= 4;
-- 
2.7.4

