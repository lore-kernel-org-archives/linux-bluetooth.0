Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Move mgmt event sending out from hci_add_link_key()
Date: Tue, 24 Jun 2014 13:15:49 +0300
Message-Id: <1403604953-19539-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com>
References: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are two callers of hci_add_link_key(). The first one is the HCI
Link Key Notification event and the second one the mgmt code that
receives a list of link keys from user space. Previously we've had the
hci_add_link_key() function being responsible for also emitting a mgmt
signal but for the latter use case this should not happen. Because of
this a rather awkward new_key paramter has been passed to the function.

This patch moves the mgmt event sending out from the hci_add_link_key()
function, thereby making the code a bit more understandable.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/hci_core.c         | 17 +++++------------
 net/bluetooth/hci_event.c        | 18 +++++++++++++++---
 net/bluetooth/mgmt.c             |  4 ++--
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7f81791a865d..888911d205dc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -860,8 +860,8 @@ void hci_uuids_clear(struct hci_dev *hdev);
 void hci_link_keys_clear(struct hci_dev *hdev);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
-				  int new_key, bdaddr_t *bdaddr, u8 *val,
-				  u8 type, u8 pin_len);
+				  bdaddr_t *bdaddr, u8 *val, u8 type,
+				  u8 pin_len, bool *persistent);
 struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
 			     bool master);
 struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ee42788aed2c..159783e746c0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3002,12 +3002,11 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 }
 
 struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
-				  int new_key, bdaddr_t *bdaddr, u8 *val,
-				  u8 type, u8 pin_len)
+				  bdaddr_t *bdaddr, u8 *val, u8 type,
+				  u8 pin_len, bool *persistent)
 {
 	struct link_key *key, *old_key;
 	u8 old_key_type;
-	bool persistent;
 
 	old_key = hci_find_link_key(hdev, bdaddr);
 	if (old_key) {
@@ -3042,15 +3041,9 @@ struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 	else
 		key->type = type;
 
-	if (!new_key)
-		return key;
-
-	persistent = hci_persistent_key(hdev, conn, type, old_key_type);
-
-	mgmt_new_link_key(hdev, key, persistent);
-
-	if (conn)
-		conn->flush_key = !persistent;
+	if (persistent)
+		*persistent = hci_persistent_key(hdev, conn, type,
+						 old_key_type);
 
 	return key;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e1e1ecb4db10..47bd48a597bd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3111,6 +3111,8 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_link_key_notify *ev = (void *) skb->data;
 	struct hci_conn *conn;
+	struct link_key *key;
+	bool persistent;
 	u8 pin_len = 0;
 
 	BT_DBG("%s", hdev->name);
@@ -3129,10 +3131,20 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_conn_drop(conn);
 	}
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
-		hci_add_link_key(hdev, conn, 1, &ev->bdaddr, ev->link_key,
-				 ev->key_type, pin_len);
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+		goto unlock;
+
+	key = hci_add_link_key(hdev, conn, &ev->bdaddr, ev->link_key,
+			        ev->key_type, pin_len, &persistent);
+	if (!key)
+		goto unlock;
+
+	mgmt_new_link_key(hdev, key, persistent);
 
+	if (conn)
+		conn->flush_key = !persistent;
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e1651c3fc676..bb5b04191253 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2424,8 +2424,8 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
-		hci_add_link_key(hdev, NULL, 0, &key->addr.bdaddr, key->val,
-				 key->type, key->pin_len);
+		hci_add_link_key(hdev, NULL, &key->addr.bdaddr, key->val,
+				 key->type, key->pin_len, NULL);
 	}
 
 	cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS, 0, NULL, 0);
-- 
1.9.3

