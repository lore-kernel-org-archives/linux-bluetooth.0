Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/12] Bluetooth: Add store_hint parameter to mgmt_new_key
Date: Thu, 28 Apr 2011 11:29:03 -0700
Message-Id: <1304015344-12238-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
References: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

Even for keys that shouldn't be stored some use cases require the
knowledge of a new key having been created so that the conclusion of a
successful pairing can be made. Therefore, always send the mgmt_new_key
event but add a store_hint parameter to it to indicate to user space
whether the key should be stored or not.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/mgmt.h     |    1 +
 net/bluetooth/hci_core.c         |   21 ++++++++++++---------
 net/bluetooth/mgmt.c             |    3 ++-
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 88c2cd9..14cc324 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -775,7 +775,7 @@ int mgmt_index_removed(u16 index);
 int mgmt_powered(u16 index, u8 powered);
 int mgmt_discoverable(u16 index, u8 discoverable);
 int mgmt_connectable(u16 index, u8 connectable);
-int mgmt_new_key(u16 index, struct link_key *key);
+int mgmt_new_key(u16 index, struct link_key *key, u8 persistent);
 int mgmt_connected(u16 index, bdaddr_t *bdaddr);
 int mgmt_disconnected(u16 index, bdaddr_t *bdaddr);
 int mgmt_disconnect_failed(u16 index);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 353a85d..4899286 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -230,6 +230,7 @@ struct mgmt_ev_controller_error {
 
 #define MGMT_EV_NEW_KEY			0x000A
 struct mgmt_ev_new_key {
+	__u8 store_hint;
 	struct mgmt_key_info key;
 } __packed;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 13ac796..dfc600c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1062,7 +1062,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 				bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len)
 {
 	struct link_key *key, *old_key;
-	u8 old_key_type;
+	u8 old_key_type, persistent;
 
 	old_key = hci_find_link_key(hdev, bdaddr);
 	if (old_key) {
@@ -1089,12 +1089,6 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 			conn->key_type = type;
 	}
 
-	if (new_key && !hci_persistent_key(hdev, conn, type, old_key_type)) {
-		list_del(&key->list);
-		kfree(key);
-		return 0;
-	}
-
 	bacpy(&key->bdaddr, bdaddr);
 	memcpy(key->val, val, 16);
 	key->pin_len = pin_len;
@@ -1104,8 +1098,17 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 	else
 		key->type = type;
 
-	if (new_key)
-		mgmt_new_key(hdev->id, key);
+	if (!new_key)
+		return 0;
+
+	persistent = hci_persistent_key(hdev, conn, type, old_key_type);
+
+	mgmt_new_key(hdev->id, key, persistent);
+
+	if (!persistent) {
+		list_del(&key->list);
+		kfree(key);
+	}
 
 	return 0;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 232ea8b..2481d25 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1858,12 +1858,13 @@ int mgmt_connectable(u16 index, u8 connectable)
 	return ret;
 }
 
-int mgmt_new_key(u16 index, struct link_key *key)
+int mgmt_new_key(u16 index, struct link_key *key, u8 persistent)
 {
 	struct mgmt_ev_new_key ev;
 
 	memset(&ev, 0, sizeof(ev));
 
+	ev.store_hint = persistent;
 	bacpy(&ev.key.bdaddr, &key->bdaddr);
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, 16);
-- 
1.7.4.4

