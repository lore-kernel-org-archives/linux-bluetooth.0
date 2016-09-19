Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>,
        Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 2/5] Bluetooth: Factor appending EIR to separate helper
Date: Mon, 19 Sep 2016 20:25:53 +0200
Message-Id: <1474309556-7447-2-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474309556-7447-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474309556-7447-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michał Narajowski <michal.narajowski@codecoup.pl>

This will also be used for Extended Information Event handling.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/mgmt.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 604c481..2b6fe10 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -878,13 +878,32 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 	return eir_len;
 }
 
+static u16 append_eir_data_to_buf(struct hci_dev *hdev, u8 *eir)
+{
+	u16 eir_len = 0;
+	size_t name_len;
+
+	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		eir_len = eir_append_data(eir, eir_len, EIR_CLASS_OF_DEV,
+					  hdev->dev_class, 3);
+
+	name_len = strlen(hdev->dev_name);
+	eir_len = eir_append_data(eir, eir_len, EIR_NAME_COMPLETE,
+				  hdev->dev_name, name_len);
+
+	name_len = strlen(hdev->short_name);
+	eir_len = eir_append_data(eir, eir_len, EIR_NAME_SHORT,
+				  hdev->short_name, name_len);
+
+	return eir_len;
+}
+
 static int read_ext_controller_info(struct sock *sk, struct hci_dev *hdev,
 				    void *data, u16 data_len)
 {
 	char buf[512];
 	struct mgmt_rp_read_ext_info *rp = (void *)buf;
-	u16 eir_len = 0;
-	size_t name_len;
+	u16 eir_len;
 
 	BT_DBG("sock %p %s", sk, hdev->name);
 
@@ -900,18 +919,8 @@ static int read_ext_controller_info(struct sock *sk, struct hci_dev *hdev,
 	rp->supported_settings = cpu_to_le32(get_supported_settings(hdev));
 	rp->current_settings = cpu_to_le32(get_current_settings(hdev));
 
-	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		eir_len = eir_append_data(rp->eir, eir_len, EIR_CLASS_OF_DEV,
-					  hdev->dev_class, 3);
-
-	name_len = strlen(hdev->dev_name);
-	eir_len = eir_append_data(rp->eir, eir_len, EIR_NAME_COMPLETE,
-				  hdev->dev_name, name_len);
-
-	name_len = strlen(hdev->short_name);
-	eir_len = eir_append_data(rp->eir, eir_len, EIR_NAME_SHORT,
-				  hdev->short_name, name_len);
 
+	eir_len = append_eir_data_to_buf(hdev, rp->eir);
 	rp->eir_len = cpu_to_le16(eir_len);
 
 	hci_dev_unlock(hdev);
-- 
2.7.4

