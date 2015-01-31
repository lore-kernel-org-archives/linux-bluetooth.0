Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Allow remote OOB data to only provide P-192 or P-256 values
Date: Sat, 31 Jan 2015 00:37:02 -0800
Message-Id: <1422693422-12944-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case the remote only provided P-192 or P-256 data for OOB pairing,
then make sure that the data value pointers are correctly set. That way
the core can provide correct information when remote OOB data present
information have to be communicated.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 78939e0ed1f4..ba3b4a5820b1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3672,7 +3672,7 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 				   status, &cp->addr, sizeof(cp->addr));
 	} else if (len == MGMT_ADD_REMOTE_OOB_EXT_DATA_SIZE) {
 		struct mgmt_cp_add_remote_oob_ext_data *cp = data;
-		u8 *rand192, *hash192;
+		u8 *rand192, *hash192, *rand256, *hash256;
 		u8 status;
 
 		if (bdaddr_type_is_le(cp->addr.type)) {
@@ -3691,13 +3691,34 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 			rand192 = NULL;
 			hash192 = NULL;
 		} else {
-			rand192 = cp->rand192;
-			hash192 = cp->hash192;
+			/* In case one of the P-192 values is set to zero,
+			 * then just disable OOB data for P-192.
+			 */
+			if (!memcmp(cp->rand192, ZERO_KEY, 16) ||
+			    !memcmp(cp->hash192, ZERO_KEY, 16)) {
+				rand192 = NULL;
+				hash192 = NULL;
+			} else {
+				rand192 = cp->rand192;
+				hash192 = cp->hash192;
+			}
+		}
+
+		/* In case one of the P-256 values is set to zero, then just
+		 * disable OOB data for P-256.
+		 */
+		if (!memcmp(cp->rand256, ZERO_KEY, 16) ||
+		    !memcmp(cp->hash256, ZERO_KEY, 16)) {
+			rand256 = NULL;
+			hash256 = NULL;
+		} else {
+			rand256 = cp->rand256;
+			hash256 = cp->hash256;
 		}
 
 		err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr,
 					      cp->addr.type, hash192, rand192,
-					      cp->hash256, cp->rand256);
+					      hash256, rand256);
 		if (err < 0)
 			status = MGMT_STATUS_FAILED;
 		else
-- 
2.1.0

