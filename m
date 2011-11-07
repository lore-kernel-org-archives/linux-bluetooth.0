Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Update link key mgmt APIs to match latest spec.
Date: Mon,  7 Nov 2011 23:13:38 +0200
Message-Id: <1320700419-4665-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320700419-4665-1-git-send-email-johan.hedberg@gmail.com>
References: <1320700419-4665-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

BR/EDR link keys have their own commands and events (separate from SMP)
and the remove_keys command (previously remove_key) removes keys of any
kind for the specified remote address.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/mgmt.h     |   18 ++++++++--------
 net/bluetooth/hci_core.c         |    4 +-
 net/bluetooth/mgmt.c             |   43 ++++++++++++++++++++-----------------
 4 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bca53aa..4ebc882 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -911,7 +911,7 @@ int mgmt_powered(u16 index, u8 powered);
 int mgmt_discoverable(u16 index, u8 discoverable);
 int mgmt_connectable(u16 index, u8 connectable);
 int mgmt_write_scan_failed(u16 index, u8 scan, u8 status);
-int mgmt_new_key(u16 index, struct link_key *key, u8 persistent);
+int mgmt_new_link_key(u16 index, struct link_key *key, u8 persistent);
 int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type);
 int mgmt_disconnected(u16 index, bdaddr_t *bdaddr);
 int mgmt_disconnect_failed(u16 index);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index b5320aa..fa33bc6 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -100,22 +100,22 @@ struct mgmt_cp_set_service_cache {
 	__u8 enable;
 } __packed;
 
-struct mgmt_key_info {
+struct mgmt_link_key_info {
 	bdaddr_t bdaddr;
 	u8 type;
 	u8 val[16];
 	u8 pin_len;
 } __packed;
 
-#define MGMT_OP_LOAD_KEYS		0x000D
-struct mgmt_cp_load_keys {
+#define MGMT_OP_LOAD_LINK_KEYS		0x000D
+struct mgmt_cp_load_link_keys {
 	__u8 debug_keys;
 	__le16 key_count;
-	struct mgmt_key_info keys[0];
+	struct mgmt_link_key_info keys[0];
 } __packed;
 
-#define MGMT_OP_REMOVE_KEY		0x000E
-struct mgmt_cp_remove_key {
+#define MGMT_OP_REMOVE_KEYS		0x000E
+struct mgmt_cp_remove_keys {
 	bdaddr_t bdaddr;
 	__u8 disconnect;
 } __packed;
@@ -247,10 +247,10 @@ struct mgmt_ev_controller_error {
 
 #define MGMT_EV_PAIRABLE		0x0009
 
-#define MGMT_EV_NEW_KEY			0x000A
-struct mgmt_ev_new_key {
+#define MGMT_EV_NEW_LINK_KEY		0x000A
+struct mgmt_ev_new_link_key {
 	__u8 store_hint;
-	struct mgmt_key_info key;
+	struct mgmt_link_key_info key;
 } __packed;
 
 #define MGMT_EV_CONNECTED		0x000B
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e4ddf36..693c0df 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1140,7 +1140,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 
 	persistent = hci_persistent_key(hdev, conn, type, old_key_type);
 
-	mgmt_new_key(hdev->id, key, persistent);
+	mgmt_new_link_key(hdev->id, key, persistent);
 
 	if (!persistent) {
 		list_del(&key->list);
@@ -1183,7 +1183,7 @@ int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 	memcpy(id->rand, rand, sizeof(id->rand));
 
 	if (new_key)
-		mgmt_new_key(hdev->id, key, old_key_type);
+		mgmt_new_link_key(hdev->id, key, old_key_type);
 
 	return 0;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 16ccc7e..7d32981 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -908,30 +908,32 @@ static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
 	return err;
 }
 
-static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
+static int load_link_keys(struct sock *sk, u16 index, unsigned char *data,
+								u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_load_keys *cp;
+	struct mgmt_cp_load_link_keys *cp;
 	u16 key_count, expected_len;
 	int i;
 
 	cp = (void *) data;
 
 	if (len < sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_LOAD_KEYS, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS, EINVAL);
 
 	key_count = get_unaligned_le16(&cp->key_count);
 
-	expected_len = sizeof(*cp) + key_count * sizeof(struct mgmt_key_info);
+	expected_len = sizeof(*cp) + key_count *
+					sizeof(struct mgmt_link_key_info);
 	if (expected_len != len) {
-		BT_ERR("load_keys: expected %u bytes, got %u bytes",
+		BT_ERR("load_link_keys: expected %u bytes, got %u bytes",
 							len, expected_len);
-		return cmd_status(sk, index, MGMT_OP_LOAD_KEYS, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS, EINVAL);
 	}
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_LOAD_KEYS, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS, ENODEV);
 
 	BT_DBG("hci%u debug_keys %u key_count %u", index, cp->debug_keys,
 								key_count);
@@ -948,7 +950,7 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		clear_bit(HCI_DEBUG_KEYS, &hdev->flags);
 
 	for (i = 0; i < key_count; i++) {
-		struct mgmt_key_info *key = &cp->keys[i];
+		struct mgmt_link_key_info *key = &cp->keys[i];
 
 		hci_add_link_key(hdev, NULL, 0, &key->bdaddr, key->val, key->type,
 								key->pin_len);
@@ -960,27 +962,28 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	return 0;
 }
 
-static int remove_key(struct sock *sk, u16 index, unsigned char *data, u16 len)
+static int remove_keys(struct sock *sk, u16 index, unsigned char *data,
+								u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_remove_key *cp;
+	struct mgmt_cp_remove_keys *cp;
 	struct hci_conn *conn;
 	int err;
 
 	cp = (void *) data;
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_REMOVE_KEY, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_REMOVE_KEYS, EINVAL);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_REMOVE_KEY, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_REMOVE_KEYS, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
 	err = hci_remove_link_key(hdev, &cp->bdaddr);
 	if (err < 0) {
-		err = cmd_status(sk, index, MGMT_OP_REMOVE_KEY, -err);
+		err = cmd_status(sk, index, MGMT_OP_REMOVE_KEYS, -err);
 		goto unlock;
 	}
 
@@ -1881,11 +1884,11 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_SERVICE_CACHE:
 		err = set_service_cache(sk, index, buf + sizeof(*hdr), len);
 		break;
-	case MGMT_OP_LOAD_KEYS:
-		err = load_keys(sk, index, buf + sizeof(*hdr), len);
+	case MGMT_OP_LOAD_LINK_KEYS:
+		err = load_link_keys(sk, index, buf + sizeof(*hdr), len);
 		break;
-	case MGMT_OP_REMOVE_KEY:
-		err = remove_key(sk, index, buf + sizeof(*hdr), len);
+	case MGMT_OP_REMOVE_KEYS:
+		err = remove_keys(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_DISCONNECT:
 		err = disconnect(sk, index, buf + sizeof(*hdr), len);
@@ -2076,9 +2079,9 @@ int mgmt_write_scan_failed(u16 index, u8 scan, u8 status)
 	return 0;
 }
 
-int mgmt_new_key(u16 index, struct link_key *key, u8 persistent)
+int mgmt_new_link_key(u16 index, struct link_key *key, u8 persistent)
 {
-	struct mgmt_ev_new_key ev;
+	struct mgmt_ev_new_link_key ev;
 
 	memset(&ev, 0, sizeof(ev));
 
@@ -2088,7 +2091,7 @@ int mgmt_new_key(u16 index, struct link_key *key, u8 persistent)
 	memcpy(ev.key.val, key->val, 16);
 	ev.key.pin_len = key->pin_len;
 
-	return mgmt_event(MGMT_EV_NEW_KEY, index, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_NEW_LINK_KEY, index, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type)
-- 
1.7.7.1

