Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix ignoring debug keys in mgmt_load_link_keys
Date: Tue, 24 Jun 2014 14:00:26 +0300
Message-Id: <1403607628-30926-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should never allow user space to feed back debug keys to the kernel.
If the user desires to use debug keys require setting the appropriate
debug keys mode and performing a new pairing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 634b44ddc9f9..747746b0d2c4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2426,6 +2426,12 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
+		/* Always ignore debug keys and require a new pairing if
+		 * the user wants to use them.
+		 */
+		if (key->type == HCI_LK_DEBUG_COMBINATION)
+			continue;
+
 		hci_add_link_key(hdev, NULL, &key->addr.bdaddr, key->val,
 				 key->type, key->pin_len, NULL);
 	}
-- 
1.9.3

