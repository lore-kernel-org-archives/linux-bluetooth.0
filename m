Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for local OOB data with Secure Connections
Date: Thu,  9 Jan 2014 20:09:16 -0800
Message-Id: <1389326956-6671-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For Secure Connections support and the usage of out-of-band pairing,
it is needed to read the P-256 hash and randomizer or P-192 hash and
randomizer. This change will read P-192 data when Secure Connections
is disabled and P-192 and P-256 data when it is enabled.

The difference is between using HCI Read Local OOB Data and using the
new HCI Read Local OOB Extended Data command. The first one has been
introduced with Bluetooth 2.1 and returns only the P-192 data.

< HCI Command: Read Local OOB Data (0x03|0x0057) plen 0
> HCI Event: Command Complete (0x0e) plen 36
      Read Local OOB Data (0x03|0x0057) ncmd 1
        Status: Success (0x00)
        Hash C from P-192: 975a59baa1c4eee391477cb410b23e6d
        Randomizer R with P-192: 9ee63b7dec411d3b467c5ae446df7f7d

The second command has been introduced with Bluetooth 4.1 and will
return P-192 and P-256 data.

< HCI Command: Read Local OOB Extended Data (0x03|0x007d) plen 0
> HCI Event: Command Complete (0x0e) plen 68
      Read Local OOB Extended Data (0x03|0x007d) ncmd 1
        Status: Success (0x00)
        Hash C from P-192: 6489731804b156fa6355efb8124a1389
        Randomizer R with P-192: 4781d5352fb215b2958222b3937b6026
        Hash C from P-256: 69ef8a928b9d07fc149e630e74ecb991
        Randomizer R with P-256: 4781d5352fb215b2958222b3937b6026

The change for the management interface is transparent and no change
is required for existing userspace. The Secure Connections feature
needs to be manually enabled. When it is disabled, then userspace
only gets the P-192 returned and with Secure Connections enabled,
userspace gets P-192 and P-256 in an extended structure.

It is also acceptable to just ignore the P-256 data since it is not
required to support them. The pairing with out-of-band credentials
will still succeed. However then of course no Secure Connection will
b established.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  5 +++--
 include/net/bluetooth/mgmt.h     |  6 ++++++
 net/bluetooth/hci_event.c        | 28 ++++++++++++++++++++++-----
 net/bluetooth/mgmt.c             | 41 ++++++++++++++++++++++++++++++++--------
 4 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1eb55ec40ac0..bd15eaa4c06e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1129,8 +1129,9 @@ void mgmt_sc_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				    u8 status);
 void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
-void mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
-					     u8 *randomizer, u8 status);
+void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
+				       u8 *randomizer192, u8 *hash256,
+				       u8 *randomizer256, u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
 		       u8 ssp, u8 *eir, u16 eir_len);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 8a2c78175997..036ddc7dc7ed 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -295,6 +295,12 @@ struct mgmt_rp_read_local_oob_data {
 	__u8	hash[16];
 	__u8	randomizer[16];
 } __packed;
+struct mgmt_rp_read_local_oob_ext_data {
+	__u8	hash192[16];
+	__u8	randomizer192[16];
+	__u8	hash256[16];
+	__u8	randomizer256[16];
+} __packed;
 
 #define MGMT_OP_ADD_REMOTE_OOB_DATA	0x0021
 struct mgmt_cp_add_remote_oob_data {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 820a01965ce3..6923241d2b3e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -932,16 +932,30 @@ static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
-					     struct sk_buff *skb)
+static void hci_cc_read_local_oob_data(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	struct hci_rp_read_local_oob_data *rp = (void *) skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	hci_dev_lock(hdev);
-	mgmt_read_local_oob_data_reply_complete(hdev, rp->hash,
-						rp->randomizer, rp->status);
+	mgmt_read_local_oob_data_complete(hdev, rp->hash, rp->randomizer,
+					  NULL, NULL, rp->status);
+	hci_dev_unlock(hdev);
+}
+
+static void hci_cc_read_local_oob_ext_data(struct hci_dev *hdev,
+					   struct sk_buff *skb)
+{
+	struct hci_rp_read_local_oob_ext_data *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	hci_dev_lock(hdev);
+	mgmt_read_local_oob_data_complete(hdev, rp->hash192, rp->randomizer192,
+					  rp->hash256, rp->randomizer256,
+					  rp->status);
 	hci_dev_unlock(hdev);
 }
 
@@ -2248,7 +2262,11 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 
 	case HCI_OP_READ_LOCAL_OOB_DATA:
-		hci_cc_read_local_oob_data_reply(hdev, skb);
+		hci_cc_read_local_oob_data(hdev, skb);
+		break;
+
+	case HCI_OP_READ_LOCAL_OOB_EXT_DATA:
+		hci_cc_read_local_oob_ext_data(hdev, skb);
 		break;
 
 	case HCI_OP_LE_READ_BUFFER_SIZE:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9b162038acb7..a7d4ae679ab7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3078,7 +3078,12 @@ static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_READ_LOCAL_OOB_DATA, 0, NULL);
+	if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags))
+		err = hci_send_cmd(hdev, HCI_OP_READ_LOCAL_OOB_EXT_DATA,
+				   0, NULL);
+	else
+		err = hci_send_cmd(hdev, HCI_OP_READ_LOCAL_OOB_DATA, 0, NULL);
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -5077,8 +5082,9 @@ void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 		   cmd ? cmd->sk : NULL);
 }
 
-void mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
-					     u8 *randomizer, u8 status)
+void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
+				       u8 *randomizer192, u8 *hash256,
+				       u8 *randomizer256, u8 status)
 {
 	struct pending_cmd *cmd;
 
@@ -5092,13 +5098,32 @@ void mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 		cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
 			   mgmt_status(status));
 	} else {
-		struct mgmt_rp_read_local_oob_data rp;
+		if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags) &&
+		    hash256 && randomizer256) {
+			struct mgmt_rp_read_local_oob_ext_data rp;
+
+			memcpy(rp.hash192, hash192, sizeof(rp.hash192));
+			memcpy(rp.randomizer192, randomizer192,
+			       sizeof(rp.randomizer192));
 
-		memcpy(rp.hash, hash, sizeof(rp.hash));
-		memcpy(rp.randomizer, randomizer, sizeof(rp.randomizer));
+			memcpy(rp.hash256, hash256, sizeof(rp.hash256));
+			memcpy(rp.randomizer256, randomizer256,
+			       sizeof(rp.randomizer256));
 
-		cmd_complete(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
-			     0, &rp, sizeof(rp));
+			cmd_complete(cmd->sk, hdev->id,
+				     MGMT_OP_READ_LOCAL_OOB_DATA, 0,
+				     &rp, sizeof(rp));
+		} else {
+			struct mgmt_rp_read_local_oob_data rp;
+
+			memcpy(rp.hash, hash192, sizeof(rp.hash));
+			memcpy(rp.randomizer, randomizer192,
+			       sizeof(rp.randomizer));
+
+			cmd_complete(cmd->sk, hdev->id,
+				     MGMT_OP_READ_LOCAL_OOB_DATA, 0,
+				     &rp, sizeof(rp));
+		}
 	}
 
 	mgmt_pending_remove(cmd);
-- 
1.8.4.2

