Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Update hci_add_link_key() to return pointer to key
Date: Tue, 24 Jun 2014 13:15:48 +0300
Message-Id: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

By returning the added (or updated) key we pave the way for further
refactoring (in subsequent patches) that allows moving the mgmt event
sending out from this function (and thereby removal of the awkward
new_key parameter).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  5 +++--
 net/bluetooth/hci_core.c         | 11 ++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cd73a82cc713..7f81791a865d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -859,8 +859,9 @@ void hci_uuids_clear(struct hci_dev *hdev);
 
 void hci_link_keys_clear(struct hci_dev *hdev);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
-int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
-		     bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
+struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
+				  int new_key, bdaddr_t *bdaddr, u8 *val,
+				  u8 type, u8 pin_len);
 struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
 			     bool master);
 struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bbfc5455acec..ee42788aed2c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3001,8 +3001,9 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return NULL;
 }
 
-int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
-		     bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len)
+struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
+				  int new_key, bdaddr_t *bdaddr, u8 *val,
+				  u8 type, u8 pin_len)
 {
 	struct link_key *key, *old_key;
 	u8 old_key_type;
@@ -3016,7 +3017,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		old_key_type = conn ? conn->key_type : 0xff;
 		key = kzalloc(sizeof(*key), GFP_KERNEL);
 		if (!key)
-			return -ENOMEM;
+			return NULL;
 		list_add(&key->list, &hdev->link_keys);
 	}
 
@@ -3042,7 +3043,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		key->type = type;
 
 	if (!new_key)
-		return 0;
+		return key;
 
 	persistent = hci_persistent_key(hdev, conn, type, old_key_type);
 
@@ -3051,7 +3052,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 	if (conn)
 		conn->flush_key = !persistent;
 
-	return 0;
+	return key;
 }
 
 struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
-- 
1.9.3

