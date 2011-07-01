Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 10/12] Bluetooth: Add support for communicating keys with userspace
Date: Fri,  1 Jul 2011 16:07:45 -0300
Message-Id: <1309547267-9514-11-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As the key format has changed to something that has a dynamic size,
the way that keys are received and sent must be changed.

The structure fields order is changed to make the parsing of the
information received from the Management Interface easier.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/mgmt.c |   60 +++++++++++++++++++++++++++++++++++++------------
 1 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 64c0418..336f971 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -908,7 +908,7 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	struct hci_dev *hdev;
 	struct mgmt_cp_load_keys *cp;
 	u16 key_count, expected_len;
-	int i;
+	int i, err;
 
 	cp = (void *) data;
 
@@ -918,9 +918,9 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	key_count = get_unaligned_le16(&cp->key_count);
 
 	expected_len = sizeof(*cp) + key_count * sizeof(struct mgmt_key_info);
-	if (expected_len != len) {
-		BT_ERR("load_keys: expected %u bytes, got %u bytes",
-							len, expected_len);
+	if (expected_len > len) {
+		BT_ERR("load_keys: expected at least %u bytes, got %u bytes",
+							expected_len, len);
 		return -EINVAL;
 	}
 
@@ -942,17 +942,36 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	else
 		clear_bit(HCI_DEBUG_KEYS, &hdev->flags);
 
-	for (i = 0; i < key_count; i++) {
-		struct mgmt_key_info *key = &cp->keys[i];
+	len -= sizeof(*cp);
+	i = 0;
+
+	while (i < len) {
+		struct mgmt_key_info *key = (void *) cp->keys + i;
+
+		i += sizeof(*key) + key->dlen;
+
+		if (key->type == HCI_LK_SMP_LTK) {
+			struct key_master_id *id = (void *) key->data;
+
+			if (key->dlen != sizeof(struct key_master_id))
+				continue;
+
+			hci_add_ltk(hdev, 0, &key->bdaddr, id->ediv,
+							id->rand, key->val);
+
+			continue;
+		}
 
 		hci_add_link_key(hdev, NULL, 0, &key->bdaddr, key->val, key->type,
 								key->pin_len);
 	}
 
+	err = cmd_complete(sk, index, MGMT_OP_LOAD_KEYS, NULL, 0);
+
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
-	return 0;
+	return err;
 }
 
 static int remove_key(struct sock *sk, u16 index, unsigned char *data, u16 len)
@@ -1958,17 +1977,28 @@ int mgmt_connectable(u16 index, u8 connectable)
 
 int mgmt_new_key(u16 index, struct link_key *key, u8 persistent)
 {
-	struct mgmt_ev_new_key ev;
+	struct mgmt_ev_new_key *ev;
+	int err, total;
 
-	memset(&ev, 0, sizeof(ev));
+	total = sizeof(struct mgmt_ev_new_key) + key->dlen;
+	ev = kzalloc(total, GFP_ATOMIC);
+	if (!ev)
+		return -ENOMEM;
+
+	bacpy(&ev->key.bdaddr, &key->bdaddr);
+	ev->key.type = key->type;
+	memcpy(ev->key.val, key->val, 16);
+	ev->key.pin_len = key->pin_len;
+	ev->key.dlen = key->dlen;
+	ev->store_hint = persistent;
+
+	memcpy(ev->key.data, key->data, key->dlen);
 
-	ev.store_hint = persistent;
-	bacpy(&ev.key.bdaddr, &key->bdaddr);
-	ev.key.type = key->type;
-	memcpy(ev.key.val, key->val, 16);
-	ev.key.pin_len = key->pin_len;
+	err = mgmt_event(MGMT_EV_NEW_KEY, index, ev, total, NULL);
 
-	return mgmt_event(MGMT_EV_NEW_KEY, index, &ev, sizeof(ev), NULL);
+	kfree(ev);
+
+	return err;
 }
 
 int mgmt_connected(u16 index, bdaddr_t *bdaddr)
-- 
1.7.6

