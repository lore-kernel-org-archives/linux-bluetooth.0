Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: mgmt: Add address type to link key messages
Date: Fri, 17 Feb 2012 14:32:25 +0200
Message-Id: <1329481947-19108-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The latest mgmt API includes an address type wherever there's an address
present. This patch updates the link key messages to match it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    2 +-
 net/bluetooth/mgmt.c         |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 255a996..5aafe92 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -153,7 +153,7 @@ struct mgmt_cp_remove_uuid {
 } __packed;
 
 struct mgmt_link_key_info {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	u8 type;
 	u8 val[16];
 	u8 pin_len;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 36c4ff6..b0de719 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1274,8 +1274,8 @@ static int load_link_keys(struct sock *sk, u16 index, void *data, u16 len)
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
-		hci_add_link_key(hdev, NULL, 0, &key->bdaddr, key->val, key->type,
-								key->pin_len);
+		hci_add_link_key(hdev, NULL, 0, &key->addr.bdaddr, key->val,
+						key->type, key->pin_len);
 	}
 
 	cmd_complete(sk, index, MGMT_OP_LOAD_LINK_KEYS, NULL, 0);
@@ -2788,7 +2788,8 @@ int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 	memset(&ev, 0, sizeof(ev));
 
 	ev.store_hint = persistent;
-	bacpy(&ev.key.bdaddr, &key->bdaddr);
+	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
+	ev.key.addr.type = MGMT_ADDR_BREDR;
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, 16);
 	ev.key.pin_len = key->pin_len;
-- 
1.7.9

