Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Do not include LE SC out-of-band data if not enabled
Date: Mon, 16 Mar 2015 12:38:41 -0700
Message-Id: <1426534721-29007-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case LE Secure Connections is not enabled, then the command for
returning local out-of-band data should not include the confirmation
and random value for LE SC pairing. All other fields are still valid,
but these two need to be left out. In that case it is also no needed
to generate the public/private key pair for out-of-band pairing.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5322584460c1..32c2c75c0888 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6327,12 +6327,13 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 					  hdev->dev_class, 3);
 		break;
 	case (BIT(BDADDR_LE_PUBLIC) | BIT(BDADDR_LE_RANDOM)):
-		if (smp_generate_oob(hdev, hash, rand) < 0) {
+		if (hci_dev_test_flag(hdev, HCI_SC_ENABLED) &&
+		    smp_generate_oob(hdev, hash, rand) < 0) {
 			hci_dev_unlock(hdev);
 			err = mgmt_cmd_complete(sk, hdev->id,
-					 MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
-					 MGMT_STATUS_FAILED,
-					 &cp->type, sizeof(cp->type));
+						MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
+						MGMT_STATUS_FAILED,
+						&cp->type, sizeof(cp->type));
 			goto done;
 		}
 
@@ -6361,11 +6362,15 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 		eir_len = eir_append_data(rp->eir, eir_len, EIR_LE_ROLE,
 					  &role, sizeof(role));
 
-		eir_len = eir_append_data(rp->eir, eir_len, EIR_LE_SC_CONFIRM,
-					  hash, sizeof(hash));
+		if (hci_dev_test_flag(hdev, HCI_SC_ENABLED)) {
+			eir_len = eir_append_data(rp->eir, eir_len,
+						  EIR_LE_SC_CONFIRM,
+						  hash, sizeof(hash));
 
-		eir_len = eir_append_data(rp->eir, eir_len, EIR_LE_SC_RANDOM,
-					  rand, sizeof(rand));
+			eir_len = eir_append_data(rp->eir, eir_len,
+						  EIR_LE_SC_RANDOM,
+						  rand, sizeof(rand));
+		}
 
 		flags = get_adv_discov_flags(hdev);
 
-- 
2.1.0

