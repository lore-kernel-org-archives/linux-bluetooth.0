Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove mgmt_rp_read_local_oob_ext_data struct
Date: Mon,  2 Feb 2015 13:23:42 +0200
Message-Id: <1422876222-14858-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This extended return parameters struct conflicts with the new Read Local
OOB Extended Data command definition. To avoid the conflict simply
rename the old "extended" version to the normal one and update the code
appropriately to take into account the two possible response PDU sizes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |  4 ----
 net/bluetooth/mgmt.c         | 25 +++++++++----------------
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 95c34d5180fa..e218a30f2061 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -301,10 +301,6 @@ struct mgmt_cp_user_passkey_neg_reply {
 #define MGMT_OP_READ_LOCAL_OOB_DATA	0x0020
 #define MGMT_READ_LOCAL_OOB_DATA_SIZE	0
 struct mgmt_rp_read_local_oob_data {
-	__u8	hash[16];
-	__u8	rand[16];
-} __packed;
-struct mgmt_rp_read_local_oob_ext_data {
 	__u8	hash192[16];
 	__u8	rand192[16];
 	__u8	hash256[16];
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9e50b5c09b02..9ec5390c85eb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7168,28 +7168,21 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 		cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
 			   mgmt_status(status));
 	} else {
-		if (bredr_sc_enabled(hdev) && hash256 && rand256) {
-			struct mgmt_rp_read_local_oob_ext_data rp;
+		struct mgmt_rp_read_local_oob_data rp;
+		size_t rp_size = sizeof(rp);
 
-			memcpy(rp.hash192, hash192, sizeof(rp.hash192));
-			memcpy(rp.rand192, rand192, sizeof(rp.rand192));
+		memcpy(rp.hash192, hash192, sizeof(rp.hash192));
+		memcpy(rp.rand192, rand192, sizeof(rp.rand192));
 
+		if (bredr_sc_enabled(hdev) && hash256 && rand256) {
 			memcpy(rp.hash256, hash256, sizeof(rp.hash256));
 			memcpy(rp.rand256, rand256, sizeof(rp.rand256));
-
-			cmd_complete(cmd->sk, hdev->id,
-				     MGMT_OP_READ_LOCAL_OOB_DATA, 0,
-				     &rp, sizeof(rp));
 		} else {
-			struct mgmt_rp_read_local_oob_data rp;
-
-			memcpy(rp.hash, hash192, sizeof(rp.hash));
-			memcpy(rp.rand, rand192, sizeof(rp.rand));
-
-			cmd_complete(cmd->sk, hdev->id,
-				     MGMT_OP_READ_LOCAL_OOB_DATA, 0,
-				     &rp, sizeof(rp));
+			rp_size -= sizeof(rp.hash256) + sizeof(rp.rand256);
 		}
+
+		cmd_complete(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA, 0,
+			     &rp, rp_size);
 	}
 
 	mgmt_pending_remove(cmd);
-- 
2.1.0

