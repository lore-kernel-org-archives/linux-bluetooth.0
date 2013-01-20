Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10 v2] Bluetooth: Fix checking for proper key->master value in Load LTKs
Date: Sun, 20 Jan 2013 14:27:15 +0200
Message-Id: <1358684842-4441-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
References: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
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
index a050eee..c7ec47c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2721,6 +2721,15 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s key_count %u", hdev->name, key_count);
 
+	for (i = 0; i < key_count; i++) {
+		struct mgmt_ltk_info *key = &cp->keys[i];
+
+		if (key->master != 0x00 && key->master != 0x01)
+			return cmd_status(sk, hdev->id,
+					  MGMT_OP_LOAD_LONG_TERM_KEYS,
+					  MGMT_STATUS_INVALID_PARAMS);
+	}
+
 	hci_dev_lock(hdev);
 
 	hci_smp_ltks_clear(hdev);
-- 
1.7.10.4

