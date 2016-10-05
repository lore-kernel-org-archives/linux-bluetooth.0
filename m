Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH 2/3] Bluetooth: Add appearance to default scan rsp data
Date: Wed,  5 Oct 2016 12:28:26 +0200
Message-Id: <1475663307-3191-2-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1475663307-3191-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1475663307-3191-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add appearance value to beginning of scan rsp data for
default advertising instance if the value is not 0.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
---
 net/bluetooth/hci_request.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index fd6406d..3c44c54 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1022,7 +1022,16 @@ static u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 
 static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 {
-	return append_local_name(hdev, ptr, 0);
+	u8 scan_rsp_len = 0;
+
+	if (hdev->appearance) {
+		ptr[0] = 3;
+		ptr[1] = EIR_APPEARANCE;
+		put_unaligned_le16(hdev->appearance, ptr + 2);
+		scan_rsp_len += 4;
+	}
+
+	return append_local_name(hdev, ptr + scan_rsp_len, scan_rsp_len);
 }
 
 static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
-- 
2.7.4

