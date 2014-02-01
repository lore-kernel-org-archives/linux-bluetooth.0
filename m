Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Rename authentication to key_type in mgmt_ltk_info
Date: Fri, 31 Jan 2014 18:42:17 -0800
Message-Id: <1391222538-34065-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The field is not a boolean, it is actually a field for a key type. So
name it properly.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 2 +-
 net/bluetooth/mgmt.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index dfab094fab73..4303fa90b7c1 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -182,7 +182,7 @@ struct mgmt_cp_load_link_keys {
 
 struct mgmt_ltk_info {
 	struct mgmt_addr_info addr;
-	__u8	authenticated;
+	__u8	type;
 	__u8	master;
 	__u8	enc_size;
 	__le16	ediv;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8030eeb44382..8c94841072a8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4207,7 +4207,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			type = HCI_SMP_LTK_SLAVE;
 
 		hci_add_ltk(hdev, &key->addr.bdaddr, addr_type,
-			    type, 0, key->authenticated, key->val,
+			    type, 0, key->type, key->val,
 			    key->enc_size, key->ediv, key->rand);
 	}
 
@@ -4648,7 +4648,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
 	ev.store_hint = persistent;
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
 	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
-	ev.key.authenticated = key->authenticated;
+	ev.key.type = key->authenticated;
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
 
-- 
1.8.5.3

