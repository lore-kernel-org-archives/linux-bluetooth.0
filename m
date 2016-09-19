Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>,
        =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH v2 3/5] Bluetooth: Add appearance to Read Ext Controller Info command
Date: Mon, 19 Sep 2016 20:25:54 +0200
Message-Id: <1474309556-7447-3-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474309556-7447-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474309556-7447-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If LE is enabled appearance is added to EIR data.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/mgmt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2b6fe10..d3837e0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -878,6 +878,16 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 	return eir_len;
 }
 
+static inline u16 eir_append_le16(u8 *eir, u16 eir_len, u8 type, u16 data)
+{
+	eir[eir_len++] = sizeof(type) + sizeof(data);
+	eir[eir_len++] = type;
+	put_unaligned_le16(data, &eir[eir_len]);
+	eir_len += sizeof(data);
+
+	return eir_len;
+}
+
 static u16 append_eir_data_to_buf(struct hci_dev *hdev, u8 *eir)
 {
 	u16 eir_len = 0;
@@ -887,6 +897,10 @@ static u16 append_eir_data_to_buf(struct hci_dev *hdev, u8 *eir)
 		eir_len = eir_append_data(eir, eir_len, EIR_CLASS_OF_DEV,
 					  hdev->dev_class, 3);
 
+	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		eir_len = eir_append_le16(eir, eir_len, EIR_APPEARANCE,
+					  hdev->appearance);
+
 	name_len = strlen(hdev->dev_name);
 	eir_len = eir_append_data(eir, eir_len, EIR_NAME_COMPLETE,
 				  hdev->dev_name, name_len);
-- 
2.7.4

