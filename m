Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Store OOB data present value for each set of remote OOB data
Date: Fri, 30 Jan 2015 23:10:05 -0800
Message-Id: <1422688206-19350-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of doing complex calculation every time the OOB data is used,
just calculate the OOB data present value and store it with the OOB
data raw values.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1780f1681ecf..a37e10f4e2b3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -145,6 +145,7 @@ struct oob_data {
 	struct list_head list;
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
+	u8 present;
 	u8 hash192[16];
 	u8 rand192[16];
 	u8 hash256[16];
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5d4ac3fbbc08..f045c062f8f0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2581,9 +2581,15 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (hash192 && rand192) {
 		memcpy(data->hash192, hash192, sizeof(data->hash192));
 		memcpy(data->rand192, rand192, sizeof(data->rand192));
+		if (hash256 && rand256)
+			data->present = 0x03;
 	} else {
 		memset(data->hash192, 0, sizeof(data->hash192));
 		memset(data->rand192, 0, sizeof(data->rand192));
+		if (hash256 && rand256)
+			data->present = 0x02;
+		else
+			data->present = 0x00;
 	}
 
 	if (hash256 && rand256) {
@@ -2592,6 +2598,8 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	} else {
 		memset(data->hash256, 0, sizeof(data->hash256));
 		memset(data->rand256, 0, sizeof(data->rand256));
+		if (hash192 && rand192)
+			data->present = 0x01;
 	}
 
 	BT_DBG("%s for %pMR", hdev->name, bdaddr);
-- 
2.1.0

