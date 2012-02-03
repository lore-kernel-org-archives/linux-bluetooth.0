Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 4/7] Bluetooth: Add MGMT handlers for dealing with SMP LTK's
Date: Thu,  2 Feb 2012 21:08:02 -0300
Message-Id: <1328227685-27245-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a method to notify that a new LTK is available and
a handler to store keys coming from userspace into the kernel LTK
list.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/mgmt.c             |   80 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3f22f03..6cf39d7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -995,6 +995,8 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
+int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
+
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f8720de..d1433de 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2196,6 +2196,60 @@ done:
 	return err;
 }
 
+static int load_long_term_keys(struct sock *sk, u16 index,
+					void *cp_data, u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_load_long_term_keys *cp = cp_data;
+	u16 key_count, expected_len;
+	int i;
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
+	hci_dev_lock(hdev);
+
+	hci_smp_ltks_clear(hdev);
+
+	for (i = 0; i < key_count; i++) {
+		struct mgmt_ltk_info *key = &cp->keys[i];
+		u8 type;
+
+		if (key->master)
+			type = HCI_SMP_LTK;
+		else
+			type = HCI_SMP_LTK_SLAVE;
+
+		hci_add_ltk(hdev, &key->addr.bdaddr, key->addr.type,
+					type, 0, key->authenticated, key->val,
+					key->enc_size, key->ediv, key->rand);
+	}
+
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
+	return 0;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	void *buf;
@@ -2330,6 +2384,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_UNBLOCK_DEVICE:
 		err = unblock_device(sk, index, cp, len);
 		break;
+	case MGMT_OP_LOAD_LONG_TERM_KEYS:
+		err = load_long_term_keys(sk, index, cp, len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode,
@@ -2483,6 +2540,29 @@ int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 	return mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
+int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
+{
+	struct mgmt_ev_new_long_term_key ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.store_hint = persistent;
+	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
+	ev.key.addr.type = key->bdaddr_type;
+	ev.key.authenticated = key->authenticated;
+	ev.key.enc_size = key->enc_size;
+	ev.key.ediv = key->ediv;
+
+	if (key->type == HCI_SMP_LTK)
+		ev.key.master = 1;
+
+	memcpy(ev.key.rand, key->rand, sizeof(key->rand));
+	memcpy(ev.key.val, key->val, sizeof(key->val));
+
+	return mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev,
+						&ev, sizeof(ev), NULL);
+}
+
 int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 					u8 addr_type, u8 *name, u8 name_len,
 					u8 *dev_class)
-- 
1.7.8.1

