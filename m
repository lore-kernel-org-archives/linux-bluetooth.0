Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 5/8] Bluetooth: Add new mgmt handlers for Long Term Keys
Date: Tue,  6 Dec 2011 21:48:09 -0300
Message-Id: <1323218892-15785-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes use of the new messages defined to exchange LTKs
between the kernel and userspace. Handlers for loading LTKs
into the kernel and for informing userspace of a new LTK are
defined.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    6 +++
 net/bluetooth/mgmt.c             |   71 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6939012..96407cf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -953,6 +953,7 @@ int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5b819cd..8d96125 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1181,6 +1181,12 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type, int new_key,
 	key->enc_size = enc_size;
 	memcpy(key->rand, rand, sizeof(key->rand));
 
+	if (!new_key)
+		return 0;
+
+	if (type == HCI_LK_SMP_LTK)
+		mgmt_new_ltk(hdev, key, 1);
+
 	return 0;
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 49729fa..f7314d1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2066,6 +2066,56 @@ done:
 	return err;
 }
 
+static int load_long_term_keys(struct sock *sk, u16 index,
+					unsigned char *data, u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_load_long_term_keys *cp;
+	u16 key_count, expected_len;
+	int i;
+
+	cp = (void *) data;
+
+	if (len < sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_LOAD_LONG_TERM_KEYS,
+								EINVAL);
+
+	key_count = get_unaligned_le16(&cp->key_count);
+
+	expected_len = sizeof(*cp) + key_count *
+					sizeof(struct mgmt_ltk_info);
+	if (expected_len != len) {
+		BT_ERR("load_keys: expected %u bytes, got %u bytes",
+							len, expected_len);
+		return cmd_status(sk, index, MGMT_OP_LOAD_LONG_TERM_KEYS,
+								EINVAL);
+	}
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_LOAD_LONG_TERM_KEYS,
+								ENODEV);
+
+	BT_DBG("hci%u key_count %u", index, key_count);
+
+	hci_dev_lock_bh(hdev);
+
+	hci_smp_ltks_clear(hdev);
+
+	for (i = 0; i < key_count; i++) {
+		struct mgmt_ltk_info *key = &cp->keys[i];
+
+		hci_add_ltk(hdev, &key->bdaddr, HCI_LK_SMP_LTK, 0,
+				key->pin_len, key->val, key->enc_size,
+				key->ediv, key->rand);
+	}
+
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return 0;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -2198,6 +2248,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		err = set_fast_connectable(sk, index, buf + sizeof(*hdr),
 								len);
 		break;
+	case MGMT_OP_LOAD_LONG_TERM_KEYS:
+		err = load_long_term_keys(sk, index, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode,
@@ -2353,6 +2406,24 @@ int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 	return mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
+int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
+{
+	struct mgmt_ev_new_long_term_key ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.store_hint = persistent;
+	bacpy(&ev.key.bdaddr, &key->bdaddr);
+	ev.key.pin_len = key->pin_len;
+	ev.key.enc_size = key->enc_size;
+	ev.key.ediv = key->ediv;
+	memcpy(ev.key.rand, key->rand, sizeof(key->rand));
+	memcpy(ev.key.val, key->val, sizeof(key->val));
+
+	return mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev,
+						&ev, sizeof(ev), NULL);
+}
+
 int mgmt_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 								u8 addr_type)
 {
-- 
1.7.8

