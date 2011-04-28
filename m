Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/12] Bluetooth: Remove old_key_type from mgmt_ev_new_key
Date: Thu, 28 Apr 2011 11:29:02 -0700
Message-Id: <1304015344-12238-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
References: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

User space shouldn't have any need for the old key type so remove it
from the corresponding Management interface event.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/mgmt.h     |    1 -
 net/bluetooth/hci_core.c         |    9 +++++----
 net/bluetooth/mgmt.c             |    3 +--
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3a3f7b4..88c2cd9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -775,7 +775,7 @@ int mgmt_index_removed(u16 index);
 int mgmt_powered(u16 index, u8 powered);
 int mgmt_discoverable(u16 index, u8 discoverable);
 int mgmt_connectable(u16 index, u8 connectable);
-int mgmt_new_key(u16 index, struct link_key *key, u8 old_key_type);
+int mgmt_new_key(u16 index, struct link_key *key);
 int mgmt_connected(u16 index, bdaddr_t *bdaddr);
 int mgmt_disconnected(u16 index, bdaddr_t *bdaddr);
 int mgmt_disconnect_failed(u16 index);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index c444a2b..353a85d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -231,7 +231,6 @@ struct mgmt_ev_controller_error {
 #define MGMT_EV_NEW_KEY			0x000A
 struct mgmt_ev_new_key {
 	struct mgmt_key_info key;
-	__u8 old_key_type;
 } __packed;
 
 #define MGMT_EV_CONNECTED		0x000B
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1531dd7..13ac796 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1097,14 +1097,15 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 
 	bacpy(&key->bdaddr, bdaddr);
 	memcpy(key->val, val, 16);
-	key->type = type;
 	key->pin_len = pin_len;
 
-	if (new_key)
-		mgmt_new_key(hdev->id, key, old_key_type);
-
 	if (type == HCI_LK_CHANGED_COMBINATION)
 		key->type = old_key_type;
+	else
+		key->type = type;
+
+	if (new_key)
+		mgmt_new_key(hdev->id, key);
 
 	return 0;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e1384fc..232ea8b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1858,7 +1858,7 @@ int mgmt_connectable(u16 index, u8 connectable)
 	return ret;
 }
 
-int mgmt_new_key(u16 index, struct link_key *key, u8 old_key_type)
+int mgmt_new_key(u16 index, struct link_key *key)
 {
 	struct mgmt_ev_new_key ev;
 
@@ -1868,7 +1868,6 @@ int mgmt_new_key(u16 index, struct link_key *key, u8 old_key_type)
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, 16);
 	ev.key.pin_len = key->pin_len;
-	ev.old_key_type = old_key_type;
 
 	return mgmt_event(MGMT_EV_NEW_KEY, index, &ev, sizeof(ev), NULL);
 }
-- 
1.7.4.4

