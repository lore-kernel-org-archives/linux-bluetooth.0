Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] Bluetooth: Fix checking for proper key->master value in Load LTKs
Date: Fri, 18 Jan 2013 15:25:51 +0200
Message-Id: <1358515558-17861-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
References: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The allowed values for the key->master parameter in the Load LTKs
command are 0x00 and 0x01. If there is a key in the list with some other
value the command should fail with a proper invalid params response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a050eee..5388151 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2729,6 +2729,14 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		struct mgmt_ltk_info *key = &cp->keys[i];
 		u8 type;
 
+		if (key->master != 0x00 && key->master != 0x01) {
+			hci_smp_ltks_clear(hdev);
+			err = cmd_status(sk, hdev->id,
+					 MGMT_OP_LOAD_LONG_TERM_KEYS,
+					 MGMT_STATUS_INVALID_PARAMS);
+			goto unlock;
+		}
+
 		if (key->master)
 			type = HCI_SMP_LTK;
 		else
@@ -2743,6 +2751,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	err = cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS, 0,
 			   NULL, 0);
 
+unlock:
 	hci_dev_unlock(hdev);
 
 	return err;
-- 
1.7.10.4

