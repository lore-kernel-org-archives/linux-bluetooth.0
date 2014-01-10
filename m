Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 14/15] Bluetooth: Add internal function for storing P-192 and P-256 data
Date: Fri, 10 Jan 2014 02:07:29 -0800
Message-Id: <1389348450-23303-14-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add function to allow adding P-192 and P-256 data to the internal
storage. This also fixes a few coding style issues from the previous
helper functions for the out-of-band credentials storage.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  9 ++++++---
 net/bluetooth/hci_core.c         | 37 +++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5948930f92e6..66e96ebffe97 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -761,9 +761,12 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 int hci_remote_oob_data_clear(struct hci_dev *hdev);
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
-							bdaddr_t *bdaddr);
-int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
-								u8 *randomizer);
+					  bdaddr_t *bdaddr);
+int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			    u8 *hash, u8 *randomizer);
+int hci_add_remote_oob_ext_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				u8 *hash192, u8 *randomizer192,
+				u8 *hash256, u8 *randomizer256);
 int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f13c0550f368..499ec1b1095d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2794,15 +2794,14 @@ int hci_remote_oob_data_clear(struct hci_dev *hdev)
 	return 0;
 }
 
-int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
-			    u8 *randomizer)
+int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			    u8 *hash, u8 *randomizer)
 {
 	struct oob_data *data;
 
 	data = hci_find_remote_oob_data(hdev, bdaddr);
-
 	if (!data) {
-		data = kzalloc(sizeof(*data), GFP_ATOMIC);
+		data = kmalloc(sizeof(*data), GFP_ATOMIC);
 		if (!data)
 			return -ENOMEM;
 
@@ -2813,6 +2812,36 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 	memcpy(data->hash192, hash, sizeof(data->hash192));
 	memcpy(data->randomizer192, randomizer, sizeof(data->randomizer192));
 
+	memset(data->hash256, 0, sizeof(data->hash256));
+	memset(data->randomizer256, 0, sizeof(data->randomizer256));
+
+	BT_DBG("%s for %pMR", hdev->name, bdaddr);
+
+	return 0;
+}
+
+int hci_add_remote_oob_ext_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				u8 *hash192, u8 *randomizer192,
+				u8 *hash256, u8 *randomizer256)
+{
+	struct oob_data *data;
+
+	data = hci_find_remote_oob_data(hdev, bdaddr);
+	if (!data) {
+		data = kmalloc(sizeof(*data), GFP_ATOMIC);
+		if (!data)
+			return -ENOMEM;
+
+		bacpy(&data->bdaddr, bdaddr);
+		list_add(&data->list, &hdev->remote_oob_data);
+	}
+
+	memcpy(data->hash192, hash192, sizeof(data->hash192));
+	memcpy(data->randomizer192, randomizer192, sizeof(data->randomizer192));
+
+	memcpy(data->hash256, hash256, sizeof(data->hash256));
+	memcpy(data->randomizer256, randomizer256, sizeof(data->randomizer256));
+
 	BT_DBG("%s for %pMR", hdev->name, bdaddr);
 
 	return 0;
-- 
1.8.4.2

