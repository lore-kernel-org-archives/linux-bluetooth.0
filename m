Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: Fix ignoring debug keys in mgmt_load_link_keys
Date: Tue, 24 Jun 2014 13:15:52 +0300
Message-Id: <1403604953-19539-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com>
References: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If support for debug keys is not enabled we should simply ignore any
debug keys fed to us from user space using the mgmt_load_link_keys
command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 634b44ddc9f9..49c9a4dbfd15 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2426,6 +2426,11 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
+		/* Ignore debug keys if support is not enabled */
+		if (key->type == HCI_LK_DEBUG_COMBINATION &&
+		    !test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->flags))
+			continue;
+
 		hci_add_link_key(hdev, NULL, &key->addr.bdaddr, key->val,
 				 key->type, key->pin_len, NULL);
 	}
-- 
1.9.3

