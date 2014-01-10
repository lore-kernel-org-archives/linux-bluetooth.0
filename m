Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 13/15] Bluetooth: Provide remote OOB data for Secure Connections
Date: Fri, 10 Jan 2014 02:07:28 -0800
Message-Id: <1389348450-23303-13-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When Secure Connections has been enabled it is possible to provide P-192
and/or P-256 data during the pairing process. The internal out-of-band
credentials storage has been extended to also hold P-256 data.

Initially the P-256 data will be empty and with Secure Connections enabled
no P-256 data will be provided. This is according to the specification
since it might be possible that the remote side did not provide either
of the out-of-band credentials.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  6 ++++--
 net/bluetooth/hci_core.c         |  6 +++---
 net/bluetooth/hci_event.c        | 32 ++++++++++++++++++++++++--------
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bd15eaa4c06e..5948930f92e6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -114,8 +114,10 @@ struct link_key {
 struct oob_data {
 	struct list_head list;
 	bdaddr_t bdaddr;
-	u8 hash[16];
-	u8 randomizer[16];
+	u8 hash192[16];
+	u8 randomizer192[16];
+	u8 hash256[16];
+	u8 randomizer256[16];
 };
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 946631ffe802..f13c0550f368 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2802,7 +2802,7 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 	data = hci_find_remote_oob_data(hdev, bdaddr);
 
 	if (!data) {
-		data = kmalloc(sizeof(*data), GFP_ATOMIC);
+		data = kzalloc(sizeof(*data), GFP_ATOMIC);
 		if (!data)
 			return -ENOMEM;
 
@@ -2810,8 +2810,8 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 		list_add(&data->list, &hdev->remote_oob_data);
 	}
 
-	memcpy(data->hash, hash, sizeof(data->hash));
-	memcpy(data->randomizer, randomizer, sizeof(data->randomizer));
+	memcpy(data->hash192, hash, sizeof(data->hash192));
+	memcpy(data->randomizer192, randomizer, sizeof(data->randomizer192));
 
 	BT_DBG("%s for %pMR", hdev->name, bdaddr);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6923241d2b3e..47b953e24864 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3391,20 +3391,36 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 
 	data = hci_find_remote_oob_data(hdev, &ev->bdaddr);
 	if (data) {
-		struct hci_cp_remote_oob_data_reply cp;
+		if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
+			struct hci_cp_remote_oob_ext_data_reply cp;
 
-		bacpy(&cp.bdaddr, &ev->bdaddr);
-		memcpy(cp.hash, data->hash, sizeof(cp.hash));
-		memcpy(cp.randomizer, data->randomizer, sizeof(cp.randomizer));
+			bacpy(&cp.bdaddr, &ev->bdaddr);
+			memcpy(cp.hash192, data->hash192, sizeof(cp.hash192));
+			memcpy(cp.randomizer192, data->randomizer192,
+			       sizeof(cp.randomizer192));
+			memcpy(cp.hash256, data->hash256, sizeof(cp.hash256));
+			memcpy(cp.randomizer256, data->randomizer256,
+			       sizeof(cp.randomizer256));
+
+			hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_EXT_DATA_REPLY,
+				     sizeof(cp), &cp);
+		} else {
+			struct hci_cp_remote_oob_data_reply cp;
 
-		hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_DATA_REPLY, sizeof(cp),
-			     &cp);
+			bacpy(&cp.bdaddr, &ev->bdaddr);
+			memcpy(cp.hash, data->hash192, sizeof(cp.hash));
+			memcpy(cp.randomizer, data->randomizer192,
+			       sizeof(cp.randomizer));
+
+			hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_DATA_REPLY,
+				     sizeof(cp), &cp);
+		}
 	} else {
 		struct hci_cp_remote_oob_data_neg_reply cp;
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
-		hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_DATA_NEG_REPLY, sizeof(cp),
-			     &cp);
+		hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_DATA_NEG_REPLY,
+			     sizeof(cp), &cp);
 	}
 
 unlock:
-- 
1.8.4.2

