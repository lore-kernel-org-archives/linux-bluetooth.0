Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>,
        =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH 3/5] Bluetooth: Add appearance to Read Ext Controller Info command
Date: Mon, 19 Sep 2016 20:04:26 +0200
Message-Id: <1474308268-3940-3-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474308268-3940-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474308268-3940-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If LE is enabled appearance is added to EIR data.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/mgmt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2b6fe10..2c77c63 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -887,6 +887,13 @@ static u16 append_eir_data_to_buf(struct hci_dev *hdev, u8 *eir)
 		eir_len = eir_append_data(eir, eir_len, EIR_CLASS_OF_DEV,
 					  hdev->dev_class, 3);
 
+	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
+		u16 appearance = cpu_to_le16(hdev->appearance);
+
+		eir_len = eir_append_data(eir, eir_len, EIR_APPEARANCE,
+					  (u8 *)&appearance, 2);
+	}
+
 	name_len = strlen(hdev->dev_name);
 	eir_len = eir_append_data(eir, eir_len, EIR_NAME_COMPLETE,
 				  hdev->dev_name, name_len);
-- 
2.7.4

