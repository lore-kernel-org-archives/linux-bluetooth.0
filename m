Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 10/15] Bluetooth: Limit acceptable link key types to only supported ones
Date: Fri, 10 Jan 2014 01:29:37 -0800
Message-Id: <1389346182-12387-10-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The link keys that are loaded by userspace during controller setup
should be limited to actual valid and supported types. With the
support for Secure Connections, it is limited to types 0x00 - 0x08
at the moment. Reject any other link key types.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 68a3c998d19c..9b162038acb7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2241,7 +2241,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
-		if (key->addr.type != BDADDR_BREDR)
+		if (key->addr.type != BDADDR_BREDR || key->type > 0x08)
 			return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
 					  MGMT_STATUS_INVALID_PARAMS);
 	}
-- 
1.8.4.2

