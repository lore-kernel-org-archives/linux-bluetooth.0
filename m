Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Fix differentiating stored master vs slave LTK types
Date: Thu, 30 Jan 2014 19:40:00 -0800
Message-Id: <1391139600-15366-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1391139600-15366-1-git-send-email-johan.hedberg@gmail.com>
References: <1391139600-15366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If LTK distribution happens in both directions we will have two LTKs for
the same remote device: one which is used when we're connecting as
master and another when we're connecting as slave. When looking up LTKs
from the locally stored list we shouldn't blindly return the first match
but also consider which type of key is in question. If we do not do this
we may end up selecting an incorrect encryption key for a connection.

This patch fixes the issue by always specifying to the LTK lookup
functions whether we're looking for a master or a slave key.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  5 +++--
 net/bluetooth/hci_core.c         | 22 ++++++++++++++++++----
 net/bluetooth/hci_event.c        |  2 +-
 net/bluetooth/smp.c              |  3 ++-
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8d225e4ea2ce..378e2f32cfa0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -757,12 +757,13 @@ int hci_link_keys_clear(struct hci_dev *hdev);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		     bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
-struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
+struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8],
+			     bool master);
 int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 		int new_key, u8 authenticated, u8 tk[16], u8 enc_size,
 		__le16 ediv, u8 rand[8]);
 struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				     u8 addr_type);
+				     u8 addr_type, bool master);
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_smp_ltks_clear(struct hci_dev *hdev);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 180473d965f6..d370b432aea6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2605,7 +2605,16 @@ static bool hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
 	return false;
 }
 
-struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
+static bool ltk_type_master(u8 type)
+{
+	if (type == HCI_SMP_STK || type == HCI_SMP_LTK)
+		return true;
+
+	return false;
+}
+
+struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8],
+			     bool master)
 {
 	struct smp_ltk *k;
 
@@ -2614,6 +2623,9 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
 		    memcmp(rand, k->rand, sizeof(k->rand)))
 			continue;
 
+		if (ltk_type_master(k->type) != master)
+			continue;
+
 		return k;
 	}
 
@@ -2621,13 +2633,14 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
 }
 
 struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				     u8 addr_type)
+				     u8 addr_type, bool master)
 {
 	struct smp_ltk *k;
 
 	list_for_each_entry(k, &hdev->long_term_keys, list)
 		if (addr_type == k->bdaddr_type &&
-		    bacmp(bdaddr, &k->bdaddr) == 0)
+		    bacmp(bdaddr, &k->bdaddr) == 0 &&
+		    ltk_type_master(k->type) == master)
 			return k;
 
 	return NULL;
@@ -2691,8 +2704,9 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 		ediv, u8 rand[8])
 {
 	struct smp_ltk *key, *old_key;
+	bool master = ltk_type_master(type);
 
-	old_key = hci_find_ltk_by_addr(hdev, bdaddr, addr_type);
+	old_key = hci_find_ltk_by_addr(hdev, bdaddr, addr_type, master);
 	if (old_key)
 		key = old_key;
 	else {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8c44bbe19add..7bb8094a3ff2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3650,7 +3650,7 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn == NULL)
 		goto not_found;
 
-	ltk = hci_find_ltk(hdev, ev->ediv, ev->random);
+	ltk = hci_find_ltk(hdev, ev->ediv, ev->random, conn->out);
 	if (ltk == NULL)
 		goto not_found;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 9b1167007653..efe51ccdc615 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -699,7 +699,8 @@ static u8 smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	struct smp_ltk *key;
 	struct hci_conn *hcon = conn->hcon;
 
-	key = hci_find_ltk_by_addr(hcon->hdev, &hcon->dst, hcon->dst_type);
+	key = hci_find_ltk_by_addr(hcon->hdev, &hcon->dst, hcon->dst_type,
+				   hcon->out);
 	if (!key)
 		return 0;
 
-- 
1.8.5.3

