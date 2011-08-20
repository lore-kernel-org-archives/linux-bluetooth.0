Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 05/11] Bluetooth: Add handlers for the new mgmt messages
Date: Fri, 19 Aug 2011 21:08:09 -0300
Message-Id: <1313798895-8705-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/mgmt.c             |   97 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index be30aab..559f4d5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -260,6 +260,7 @@ enum {
 #define HCI_LK_AUTH_COMBINATION		0x05
 #define HCI_LK_CHANGED_COMBINATION	0x06
 /* The spec doesn't define types for SMP keys */
+#define HCI_LK_SMP_STK			0x80
 #define HCI_LK_SMP_LTK			0x81
 #define HCI_LK_SMP_IRK			0x82
 #define HCI_LK_SMP_CSRK			0x83
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f3a2e10..94097fd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -882,6 +882,7 @@ int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 								u8 *eir);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
 int mgmt_discovering(u16 index, u8 discovering);
+int mgmt_new_smp_key(u16 index, struct smp_link_key *key, u8 persistent);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0e73880..ebe6c3f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1741,6 +1741,73 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 	return err;
 }
 
+static int load_smp_keys(struct sock *sk, u16 index, unsigned char *data,
+								u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_load_smp_keys *cp;
+	u16 key_count, expected_len;
+	int i;
+
+	cp = (void *) data;
+
+	if (len < sizeof(*cp))
+		return -EINVAL;
+
+	key_count = get_unaligned_le16(&cp->key_count);
+
+	expected_len = sizeof(*cp) + key_count *
+					sizeof(struct mgmt_smp_key_info);
+	if (expected_len != len) {
+		BT_ERR("load_keys: expected %u bytes, got %u bytes",
+							len, expected_len);
+		return -EINVAL;
+	}
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_LOAD_KEYS, ENODEV);
+
+	BT_DBG("hci%u debug_keys %u key_count %u", index, cp->debug_keys,
+								key_count);
+
+	hci_dev_lock_bh(hdev);
+
+	hci_smp_keys_clear(hdev);
+
+	set_bit(HCI_LINK_KEYS, &hdev->flags);
+
+	if (cp->debug_keys)
+		set_bit(HCI_DEBUG_KEYS, &hdev->flags);
+	else
+		clear_bit(HCI_DEBUG_KEYS, &hdev->flags);
+
+	for (i = 0; i < key_count; i++) {
+		struct mgmt_smp_key_info *key = &cp->keys[i];
+		struct smp_ltk_info *ltk;
+
+		switch (key->type) {
+		case HCI_LK_SMP_STK:
+			BT_DBG("This key shouldn't be stored");
+			break;
+
+		case HCI_LK_SMP_LTK:
+			ltk = &key->ltk;
+			/* Add key to the smp list */
+			break;
+
+		default:
+			BT_DBG("Not supported");
+			break;
+		}
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
@@ -1861,6 +1928,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_UNBLOCK_DEVICE:
 		err = unblock_device(sk, index, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_LOAD_SMP_KEYS:
+		err = load_smp_keys(sk, index, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode, 0x01);
@@ -2268,3 +2338,30 @@ int mgmt_discovering(u16 index, u8 discovering)
 	return mgmt_event(MGMT_EV_DISCOVERING, index, &discovering,
 						sizeof(discovering), NULL);
 }
+
+int mgmt_new_smp_key(u16 index, struct smp_link_key *key, u8 persistent)
+{
+	struct mgmt_ev_new_smp_key ev;
+	struct smp_ltk_info *ltk;
+	struct smp_irsk_info *irsk;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.store_hint = persistent;
+	bacpy(&ev.key.bdaddr, &key->bdaddr);
+	ev.key.type = key->type;
+	memcpy(ev.key.val, key->val, 16);
+
+	switch (key->type) {
+	case HCI_LK_SMP_LTK:
+		ltk = &ev.key.ltk;
+		memcpy(ltk, &key->ltk, sizeof(*ltk));
+		break;
+	case HCI_LK_SMP_IRK:
+		irsk = &ev.key.irsk;
+		memcpy(irsk, &key->irsk, sizeof(*irsk));
+		break;
+	}
+
+	return mgmt_event(MGMT_EV_NEW_SMP_KEY, index, &ev, sizeof(ev), NULL);
+}
-- 
1.7.6

