Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/12] Bluetooth: Fix link key persistent storage criteria
Date: Thu, 28 Apr 2011 11:28:59 -0700
Message-Id: <1304015344-12238-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
References: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

Link keys should only be stored if very specific criteria of the
authentication process are fulfilled. This patch essentially copies the
criteria that user space has so far been using to the kernel side so
that the management interface works properly.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    4 +-
 net/bluetooth/hci_core.c         |   54 ++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/mgmt.c             |    2 +-
 4 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 135dfac..3a3f7b4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -515,8 +515,8 @@ int hci_uuids_clear(struct hci_dev *hdev);
 
 int hci_link_keys_clear(struct hci_dev *hdev);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
-int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-						u8 *key, u8 type, u8 pin_len);
+int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
+			bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 int hci_remote_oob_data_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 07d0ba3..85fae57 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1022,8 +1022,44 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return NULL;
 }
 
-int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-						u8 *val, u8 type, u8 pin_len)
+int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
+						u8 key_type, u8 old_key_type)
+{
+	/* Legacy key */
+	if (key_type < 0x03)
+		return 1;
+
+	/* Debug keys are insecure so don't store them persistently */
+	if (key_type == HCI_LK_DEBUG_COMBINATION)
+		return 0;
+
+	/* Changed combination key and there's no previous one */
+	if (key_type == HCI_LK_CHANGED_COMBINATION && old_key_type == 0xff)
+		return 0;
+
+	/* Security mode 3 case */
+	if (!conn)
+		return 1;
+
+	/* Neither local nor remote side had no-bonding as requirement */
+	if (conn->auth_type > 0x01 && conn->remote_auth > 0x01)
+		return 1;
+
+	/* Local side had dedicated bonding as requirement */
+	if (conn->auth_type == 0x02 || conn->auth_type == 0x03)
+		return 1;
+
+	/* Remote side had dedicated bonding as requirement */
+	if (conn->remote_auth == 0x02 || conn->remote_auth == 0x03)
+		return 1;
+
+	/* If none of the above criteria match, then don't store the key
+	 * persistently */
+	return 0;
+}
+
+int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
+				bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len)
 {
 	struct link_key *key, *old_key;
 	u8 old_key_type;
@@ -1042,6 +1078,20 @@ int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 
 	BT_DBG("%s key for %s type %u", hdev->name, batostr(bdaddr), type);
 
+	/* Some buggy controller combinations generate a changed
+	 * combination key for legacy pairing even when there's no
+	 * previous key */
+	if (type == HCI_LK_CHANGED_COMBINATION &&
+					(!conn || conn->remote_auth == 0xff) &&
+					old_key_type == 0xff)
+		type = HCI_LK_COMBINATION;
+
+	if (new_key && !hci_persistent_key(hdev, conn, type, old_key_type)) {
+		list_del(&key->list);
+		kfree(key);
+		return 0;
+	}
+
 	bacpy(&key->bdaddr, bdaddr);
 	memcpy(key->val, val, 16);
 	key->type = type;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8b72b8a..8dfd386 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2136,7 +2136,7 @@ static inline void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff
 	}
 
 	if (test_bit(HCI_LINK_KEYS, &hdev->flags))
-		hci_add_link_key(hdev, 1, &ev->bdaddr, ev->link_key,
+		hci_add_link_key(hdev, conn, 1, &ev->bdaddr, ev->link_key,
 							ev->key_type, pin_len);
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a1b0ec4..e1384fc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -945,7 +945,7 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_key_info *key = &cp->keys[i];
 
-		hci_add_link_key(hdev, 0, &key->bdaddr, key->val, key->type,
+		hci_add_link_key(hdev, NULL, 0, &key->bdaddr, key->val, key->type,
 								key->pin_len);
 	}
 
-- 
1.7.4.4

