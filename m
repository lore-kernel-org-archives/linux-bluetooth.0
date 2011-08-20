Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 02/11] Revert "Bluetooth: Add support for communicating keys with userspace"
Date: Fri, 19 Aug 2011 21:08:06 -0300
Message-Id: <1313798895-8705-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts commit 5a0a8b49746771fba79866fb9185ffa051a6a183.

If we use separate messages and list for SMP specific keys we can
simplify the code.

Conflicts:

	net/bluetooth/mgmt.c

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/mgmt.c |   60 ++++++++++++-------------------------------------
 1 files changed, 15 insertions(+), 45 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dac7d39..0e73880 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -908,7 +908,7 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	struct hci_dev *hdev;
 	struct mgmt_cp_load_keys *cp;
 	u16 key_count, expected_len;
-	int i, err;
+	int i;
 
 	cp = (void *) data;
 
@@ -918,9 +918,9 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	key_count = get_unaligned_le16(&cp->key_count);
 
 	expected_len = sizeof(*cp) + key_count * sizeof(struct mgmt_key_info);
-	if (expected_len > len) {
-		BT_ERR("load_keys: expected at least %u bytes, got %u bytes",
-							expected_len, len);
+	if (expected_len != len) {
+		BT_ERR("load_keys: expected %u bytes, got %u bytes",
+							len, expected_len);
 		return -EINVAL;
 	}
 
@@ -942,36 +942,17 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	else
 		clear_bit(HCI_DEBUG_KEYS, &hdev->flags);
 
-	len -= sizeof(*cp);
-	i = 0;
-
-	while (i < len) {
-		struct mgmt_key_info *key = (void *) cp->keys + i;
-
-		i += sizeof(*key) + key->dlen;
-
-		if (key->type == HCI_LK_SMP_LTK) {
-			struct key_master_id *id = (void *) key->data;
-
-			if (key->dlen != sizeof(struct key_master_id))
-				continue;
-
-			hci_add_ltk(hdev, 0, &key->bdaddr, key->pin_len,
-						id->ediv, id->rand, key->val);
-
-			continue;
-		}
+	for (i = 0; i < key_count; i++) {
+		struct mgmt_key_info *key = &cp->keys[i];
 
 		hci_add_link_key(hdev, NULL, 0, &key->bdaddr, key->val, key->type,
 								key->pin_len);
 	}
 
-	err = cmd_complete(sk, index, MGMT_OP_LOAD_KEYS, NULL, 0);
-
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
-	return err;
+	return 0;
 }
 
 static int remove_key(struct sock *sk, u16 index, unsigned char *data, u16 len)
@@ -1988,28 +1969,17 @@ int mgmt_connectable(u16 index, u8 connectable)
 
 int mgmt_new_key(u16 index, struct link_key *key, u8 persistent)
 {
-	struct mgmt_ev_new_key *ev;
-	int err, total;
-
-	total = sizeof(struct mgmt_ev_new_key) + key->dlen;
-	ev = kzalloc(total, GFP_ATOMIC);
-	if (!ev)
-		return -ENOMEM;
-
-	bacpy(&ev->key.bdaddr, &key->bdaddr);
-	ev->key.type = key->type;
-	memcpy(ev->key.val, key->val, 16);
-	ev->key.pin_len = key->pin_len;
-	ev->key.dlen = key->dlen;
-	ev->store_hint = persistent;
-
-	memcpy(ev->key.data, key->data, key->dlen);
+	struct mgmt_ev_new_key ev;
 
-	err = mgmt_event(MGMT_EV_NEW_KEY, index, ev, total, NULL);
+	memset(&ev, 0, sizeof(ev));
 
-	kfree(ev);
+	ev.store_hint = persistent;
+	bacpy(&ev.key.bdaddr, &key->bdaddr);
+	ev.key.type = key->type;
+	memcpy(ev.key.val, key->val, 16);
+	ev.key.pin_len = key->pin_len;
 
-	return err;
+	return mgmt_event(MGMT_EV_NEW_KEY, index, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type)
-- 
1.7.6

