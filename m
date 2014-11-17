Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Use shorter "rand" name for "randomizer"
Date: Mon, 17 Nov 2014 20:52:20 +0200
Message-Id: <1416250340-23675-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1416250340-23675-1-git-send-email-johan.hedberg@gmail.com>
References: <1416250340-23675-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The common short form of "randomizer" is "rand" in many places
(including the Bluetooth specification). The shorter version also makes
for easier to read code with less forced line breaks. This patch renames
all occurences of "randomizer" to "rand" in the Bluetooth subsystem
code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      | 12 ++++++------
 include/net/bluetooth/hci_core.h | 14 +++++++-------
 include/net/bluetooth/mgmt.h     | 12 ++++++------
 net/bluetooth/hci_core.c         | 14 +++++++-------
 net/bluetooth/hci_event.c        | 17 +++++++----------
 net/bluetooth/mgmt.c             | 23 +++++++++--------------
 6 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d5f85d7746bc..e56f9099f8e3 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -639,7 +639,7 @@ struct hci_cp_user_passkey_reply {
 struct hci_cp_remote_oob_data_reply {
 	bdaddr_t bdaddr;
 	__u8     hash[16];
-	__u8     randomizer[16];
+	__u8     rand[16];
 } __packed;
 
 #define HCI_OP_REMOTE_OOB_DATA_NEG_REPLY	0x0433
@@ -731,9 +731,9 @@ struct hci_rp_set_csb {
 struct hci_cp_remote_oob_ext_data_reply {
 	bdaddr_t bdaddr;
 	__u8     hash192[16];
-	__u8     randomizer192[16];
+	__u8     rand192[16];
 	__u8     hash256[16];
-	__u8     randomizer256[16];
+	__u8     rand256[16];
 } __packed;
 
 #define HCI_OP_SNIFF_MODE		0x0803
@@ -940,7 +940,7 @@ struct hci_cp_write_ssp_mode {
 struct hci_rp_read_local_oob_data {
 	__u8     status;
 	__u8     hash[16];
-	__u8     randomizer[16];
+	__u8     rand[16];
 } __packed;
 
 #define HCI_OP_READ_INQ_RSP_TX_POWER	0x0c58
@@ -1024,9 +1024,9 @@ struct hci_cp_write_sc_support {
 struct hci_rp_read_local_oob_ext_data {
 	__u8     status;
 	__u8     hash192[16];
-	__u8     randomizer192[16];
+	__u8     rand192[16];
 	__u8     hash256[16];
-	__u8     randomizer256[16];
+	__u8     rand256[16];
 } __packed;
 
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fe2d5f299e12..a805b3d97c0b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -140,9 +140,9 @@ struct oob_data {
 	struct list_head list;
 	bdaddr_t bdaddr;
 	u8 hash192[16];
-	u8 randomizer192[16];
+	u8 rand192[16];
 	u8 hash256[16];
-	u8 randomizer256[16];
+	u8 rand256[16];
 };
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
@@ -943,10 +943,10 @@ void hci_remote_oob_data_clear(struct hci_dev *hdev);
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr);
 int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			    u8 *hash, u8 *randomizer);
+			    u8 *hash, u8 *rand);
 int hci_add_remote_oob_ext_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				u8 *hash192, u8 *randomizer192,
-				u8 *hash256, u8 *randomizer256);
+				u8 *hash192, u8 *rand192,
+				u8 *hash256, u8 *rand256);
 int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
@@ -1374,8 +1374,8 @@ void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				    u8 status);
 void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
-				       u8 *randomizer192, u8 *hash256,
-				       u8 *randomizer256, u8 status);
+				       u8 *rand192, u8 *hash256, u8 *rand256,
+				       u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 414cd2f9a437..b391fd663468 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -299,28 +299,28 @@ struct mgmt_cp_user_passkey_neg_reply {
 #define MGMT_READ_LOCAL_OOB_DATA_SIZE	0
 struct mgmt_rp_read_local_oob_data {
 	__u8	hash[16];
-	__u8	randomizer[16];
+	__u8	rand[16];
 } __packed;
 struct mgmt_rp_read_local_oob_ext_data {
 	__u8	hash192[16];
-	__u8	randomizer192[16];
+	__u8	rand192[16];
 	__u8	hash256[16];
-	__u8	randomizer256[16];
+	__u8	rand256[16];
 } __packed;
 
 #define MGMT_OP_ADD_REMOTE_OOB_DATA	0x0021
 struct mgmt_cp_add_remote_oob_data {
 	struct mgmt_addr_info addr;
 	__u8	hash[16];
-	__u8	randomizer[16];
+	__u8	rand[16];
 } __packed;
 #define MGMT_ADD_REMOTE_OOB_DATA_SIZE	(MGMT_ADDR_INFO_SIZE + 32)
 struct mgmt_cp_add_remote_oob_ext_data {
 	struct mgmt_addr_info addr;
 	__u8	hash192[16];
-	__u8	randomizer192[16];
+	__u8	rand192[16];
 	__u8	hash256[16];
-	__u8	randomizer256[16];
+	__u8	rand256[16];
 } __packed;
 #define MGMT_ADD_REMOTE_OOB_EXT_DATA_SIZE (MGMT_ADDR_INFO_SIZE + 64)
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 90ea0b7670d2..bbefb4eea36e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3469,7 +3469,7 @@ void hci_remote_oob_data_clear(struct hci_dev *hdev)
 }
 
 int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			    u8 *hash, u8 *randomizer)
+			    u8 *hash, u8 *rand)
 {
 	struct oob_data *data;
 
@@ -3484,10 +3484,10 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	}
 
 	memcpy(data->hash192, hash, sizeof(data->hash192));
-	memcpy(data->randomizer192, randomizer, sizeof(data->randomizer192));
+	memcpy(data->rand192, rand, sizeof(data->rand192));
 
 	memset(data->hash256, 0, sizeof(data->hash256));
-	memset(data->randomizer256, 0, sizeof(data->randomizer256));
+	memset(data->rand256, 0, sizeof(data->rand256));
 
 	BT_DBG("%s for %pMR", hdev->name, bdaddr);
 
@@ -3495,8 +3495,8 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 }
 
 int hci_add_remote_oob_ext_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				u8 *hash192, u8 *randomizer192,
-				u8 *hash256, u8 *randomizer256)
+				u8 *hash192, u8 *rand192,
+				u8 *hash256, u8 *rand256)
 {
 	struct oob_data *data;
 
@@ -3511,10 +3511,10 @@ int hci_add_remote_oob_ext_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	}
 
 	memcpy(data->hash192, hash192, sizeof(data->hash192));
-	memcpy(data->randomizer192, randomizer192, sizeof(data->randomizer192));
+	memcpy(data->rand192, rand192, sizeof(data->rand192));
 
 	memcpy(data->hash256, hash256, sizeof(data->hash256));
-	memcpy(data->randomizer256, randomizer256, sizeof(data->randomizer256));
+	memcpy(data->rand256, rand256, sizeof(data->rand256));
 
 	BT_DBG("%s for %pMR", hdev->name, bdaddr);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 09d76547d985..844f7d1ff1cd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -994,8 +994,8 @@ static void hci_cc_read_local_oob_data(struct hci_dev *hdev,
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	hci_dev_lock(hdev);
-	mgmt_read_local_oob_data_complete(hdev, rp->hash, rp->randomizer,
-					  NULL, NULL, rp->status);
+	mgmt_read_local_oob_data_complete(hdev, rp->hash, rp->rand, NULL, NULL,
+					  rp->status);
 	hci_dev_unlock(hdev);
 }
 
@@ -1007,8 +1007,8 @@ static void hci_cc_read_local_oob_ext_data(struct hci_dev *hdev,
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	hci_dev_lock(hdev);
-	mgmt_read_local_oob_data_complete(hdev, rp->hash192, rp->randomizer192,
-					  rp->hash256, rp->randomizer256,
+	mgmt_read_local_oob_data_complete(hdev, rp->hash192, rp->rand192,
+					  rp->hash256, rp->rand256,
 					  rp->status);
 	hci_dev_unlock(hdev);
 }
@@ -3996,11 +3996,9 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 
 			bacpy(&cp.bdaddr, &ev->bdaddr);
 			memcpy(cp.hash192, data->hash192, sizeof(cp.hash192));
-			memcpy(cp.randomizer192, data->randomizer192,
-			       sizeof(cp.randomizer192));
+			memcpy(cp.rand192, data->rand192, sizeof(cp.rand192));
 			memcpy(cp.hash256, data->hash256, sizeof(cp.hash256));
-			memcpy(cp.randomizer256, data->randomizer256,
-			       sizeof(cp.randomizer256));
+			memcpy(cp.rand256, data->rand256, sizeof(cp.rand256));
 
 			hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_EXT_DATA_REPLY,
 				     sizeof(cp), &cp);
@@ -4009,8 +4007,7 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 
 			bacpy(&cp.bdaddr, &ev->bdaddr);
 			memcpy(cp.hash, data->hash192, sizeof(cp.hash));
-			memcpy(cp.randomizer, data->randomizer192,
-			       sizeof(cp.randomizer));
+			memcpy(cp.rand, data->rand192, sizeof(cp.rand));
 
 			hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_DATA_REPLY,
 				     sizeof(cp), &cp);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 258c9826e78c..cbeef5f62f3b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3598,7 +3598,7 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		}
 
 		err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr,
-					      cp->hash, cp->randomizer);
+					      cp->hash, cp->rand);
 		if (err < 0)
 			status = MGMT_STATUS_FAILED;
 		else
@@ -3619,10 +3619,8 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		}
 
 		err = hci_add_remote_oob_ext_data(hdev, &cp->addr.bdaddr,
-						  cp->hash192,
-						  cp->randomizer192,
-						  cp->hash256,
-						  cp->randomizer256);
+						  cp->hash192, cp->rand192,
+						  cp->hash256, cp->rand256);
 		if (err < 0)
 			status = MGMT_STATUS_FAILED;
 		else
@@ -6771,8 +6769,8 @@ void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 }
 
 void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
-				       u8 *randomizer192, u8 *hash256,
-				       u8 *randomizer256, u8 status)
+				       u8 *rand192, u8 *hash256, u8 *rand256,
+				       u8 status)
 {
 	struct pending_cmd *cmd;
 
@@ -6787,16 +6785,14 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 			   mgmt_status(status));
 	} else {
 		if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags) &&
-		    hash256 && randomizer256) {
+		    hash256 && rand256) {
 			struct mgmt_rp_read_local_oob_ext_data rp;
 
 			memcpy(rp.hash192, hash192, sizeof(rp.hash192));
-			memcpy(rp.randomizer192, randomizer192,
-			       sizeof(rp.randomizer192));
+			memcpy(rp.rand192, rand192, sizeof(rp.rand192));
 
 			memcpy(rp.hash256, hash256, sizeof(rp.hash256));
-			memcpy(rp.randomizer256, randomizer256,
-			       sizeof(rp.randomizer256));
+			memcpy(rp.rand256, rand256, sizeof(rp.rand256));
 
 			cmd_complete(cmd->sk, hdev->id,
 				     MGMT_OP_READ_LOCAL_OOB_DATA, 0,
@@ -6805,8 +6801,7 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 			struct mgmt_rp_read_local_oob_data rp;
 
 			memcpy(rp.hash, hash192, sizeof(rp.hash));
-			memcpy(rp.randomizer, randomizer192,
-			       sizeof(rp.randomizer));
+			memcpy(rp.rand, rand192, sizeof(rp.rand));
 
 			cmd_complete(cmd->sk, hdev->id,
 				     MGMT_OP_READ_LOCAL_OOB_DATA, 0,
-- 
2.1.0

