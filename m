Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH 1/3] Bluetooth: Fix local name in scan rsp
Date: Wed,  5 Oct 2016 12:28:25 +0200
Message-Id: <1475663307-3191-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use complete name if it fits. If not and there is short name
check if it fits. If not then use shortened name as prefix
of complete name.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
---
 net/bluetooth/hci_request.c | 47 +++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c813568..fd6406d 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -973,25 +973,48 @@ void __hci_req_enable_advertising(struct hci_request *req)
 
 static u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 {
-	size_t name_len;
+	size_t complete_len;
+	size_t short_len;
 	int max_len;
 
 	max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
-	name_len = strlen(hdev->dev_name);
-	if (name_len > 0 && max_len > 0) {
+	complete_len = strlen(hdev->dev_name);
+	short_len = strlen(hdev->short_name);
 
-		if (name_len > max_len) {
-			name_len = max_len;
-			ptr[1] = EIR_NAME_SHORT;
-		} else
-			ptr[1] = EIR_NAME_COMPLETE;
+	/* no space left for name */
+	if (max_len < 1)
+		return ad_len;
 
-		ptr[0] = name_len + 1;
+	/* no name set */
+	if (!complete_len)
+		return ad_len;
 
-		memcpy(ptr + 2, hdev->dev_name, name_len);
+	/* complete name fits and is eq to max short name len or smaller */
+	if (complete_len <= max_len &&
+	    complete_len <= HCI_MAX_SHORT_NAME_LENGTH) {
+		ptr[0] = complete_len + 1;
+		ptr[1] = EIR_NAME_COMPLETE;
+		memcpy(ptr + 2, hdev->dev_name, complete_len);
 
-		ad_len += (name_len + 2);
-		ptr += (name_len + 2);
+		return ad_len + complete_len + 2;
+	}
+
+	/* short name set and fits */
+	if (short_len && short_len <= max_len) {
+		ptr[0] = short_len + 1;
+		ptr[1] = EIR_NAME_SHORT;
+		memcpy(ptr + 2, hdev->short_name, short_len);
+
+		return ad_len + short_len + 2;
+	}
+
+	/* no short name set so shorten complete name */
+	if (!short_len) {
+		ptr[0] = max_len + 1;
+		ptr[1] = EIR_NAME_SHORT;
+		memcpy(ptr + 2, hdev->dev_name, max_len);
+
+		return ad_len + max_len + 2;
 	}
 
 	return ad_len;
-- 
2.7.4

