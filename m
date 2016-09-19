Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 1/5] Bluetooth: Refactor read_ext_controller_info handler
Date: Mon, 19 Sep 2016 20:04:24 +0200
Message-Id: <1474308268-3940-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to allocate heap for reply only to copy stack data to
it. This also fix rp memory leak and missing hdev unlock if kmalloc
failed.

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/mgmt.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 54dd218..604c481 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -881,42 +881,38 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 static int read_ext_controller_info(struct sock *sk, struct hci_dev *hdev,
 				    void *data, u16 data_len)
 {
-	struct mgmt_rp_read_ext_info *rp;
-	char buff[512];
+	char buf[512];
+	struct mgmt_rp_read_ext_info *rp = (void *)buf;
 	u16 eir_len = 0;
-	u8 name_len;
+	size_t name_len;
 
 	BT_DBG("sock %p %s", sk, hdev->name);
 
+	memset(&buf, 0, sizeof(buf));
+
 	hci_dev_lock(hdev);
 
+	bacpy(&rp->bdaddr, &hdev->bdaddr);
+
+	rp->version = hdev->hci_ver;
+	rp->manufacturer = cpu_to_le16(hdev->manufacturer);
+
+	rp->supported_settings = cpu_to_le32(get_supported_settings(hdev));
+	rp->current_settings = cpu_to_le32(get_current_settings(hdev));
+
 	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		eir_len = eir_append_data(buff, eir_len,
-					  EIR_CLASS_OF_DEV,
+		eir_len = eir_append_data(rp->eir, eir_len, EIR_CLASS_OF_DEV,
 					  hdev->dev_class, 3);
 
 	name_len = strlen(hdev->dev_name);
-	eir_len = eir_append_data(buff, eir_len, EIR_NAME_COMPLETE,
+	eir_len = eir_append_data(rp->eir, eir_len, EIR_NAME_COMPLETE,
 				  hdev->dev_name, name_len);
 
 	name_len = strlen(hdev->short_name);
-	eir_len = eir_append_data(buff, eir_len, EIR_NAME_SHORT,
+	eir_len = eir_append_data(rp->eir, eir_len, EIR_NAME_SHORT,
 				  hdev->short_name, name_len);
 
-	rp = kzalloc(sizeof(*rp) + eir_len, GFP_KERNEL);
-	if (!rp)
-		return -ENOMEM;
-
 	rp->eir_len = cpu_to_le16(eir_len);
-	memcpy(rp->eir, buff, eir_len);
-
-	bacpy(&rp->bdaddr, &hdev->bdaddr);
-
-	rp->version = hdev->hci_ver;
-	rp->manufacturer = cpu_to_le16(hdev->manufacturer);
-
-	rp->supported_settings = cpu_to_le32(get_supported_settings(hdev));
-	rp->current_settings = cpu_to_le32(get_current_settings(hdev));
 
 	hci_dev_unlock(hdev);
 
-- 
2.7.4

