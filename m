Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Return added key when adding LTKs and IRKs
Date: Wed, 19 Feb 2014 14:57:44 +0200
Message-Id: <1392814668-4830-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
References: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The SMP code will need to postpone the mgmt event emission for the IRK
and LTKs. To avoid extra lookups at the end of the key distribution
simply return the added value from the add_ltk and add_irk functions.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 11 ++++++-----
 net/bluetooth/hci_core.c         | 21 +++++++++++----------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 64c4e3f0a515..5366dc9e25eb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -787,9 +787,10 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		     bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
 struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8],
 			     bool master);
-int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
-		int new_key, u8 authenticated, u8 tk[16], u8 enc_size,
-		__le16 ediv, u8 rand[8]);
+struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			    u8 addr_type, u8 type, int new_key,
+			    u8 authenticated, u8 tk[16], u8 enc_size,
+			    __le16 ediv, u8 rand[8]);
 struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type, bool master);
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type);
@@ -799,8 +800,8 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa);
 struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type);
-int hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type,
-		u8 val[16], bdaddr_t *rpa);
+struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			    u8 addr_type, u8 val[16], bdaddr_t *rpa);
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type);
 void hci_smp_irks_clear(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7e679e085506..e23c718d668b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2761,9 +2761,10 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 	return 0;
 }
 
-int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
-		int new_key, u8 authenticated, u8 tk[16], u8 enc_size, __le16
-		ediv, u8 rand[8])
+struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			    u8 addr_type, u8 type, int new_key,
+			    u8 authenticated, u8 tk[16], u8 enc_size,
+			    __le16 ediv, u8 rand[8])
 {
 	struct smp_ltk *key, *old_key;
 	bool master = ltk_type_master(type);
@@ -2775,7 +2776,7 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 	else {
 		key = kzalloc(sizeof(*key), GFP_KERNEL);
 		if (!key)
-			return -ENOMEM;
+			return NULL;
 		list_add(&key->list, &hdev->long_term_keys);
 	}
 
@@ -2789,7 +2790,7 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 	memcpy(key->rand, rand, sizeof(key->rand));
 
 	if (!new_key)
-		return 0;
+		return key;
 
 	if (addr_type == ADDR_LE_DEV_RANDOM && (bdaddr->b[5] & 0xc0) != 0xc0)
 		persistent = 0;
@@ -2799,11 +2800,11 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 	if (type == HCI_SMP_LTK || type == HCI_SMP_LTK_SLAVE)
 		mgmt_new_ltk(hdev, key, persistent);
 
-	return 0;
+	return key;
 }
 
-int hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type,
-		u8 val[16], bdaddr_t *rpa)
+struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			    u8 addr_type, u8 val[16], bdaddr_t *rpa)
 {
 	struct smp_irk *irk;
 
@@ -2811,7 +2812,7 @@ int hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type,
 	if (!irk) {
 		irk = kzalloc(sizeof(*irk), GFP_KERNEL);
 		if (!irk)
-			return -ENOMEM;
+			return NULL;
 
 		bacpy(&irk->bdaddr, bdaddr);
 		irk->addr_type = addr_type;
@@ -2822,7 +2823,7 @@ int hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type,
 	memcpy(irk->val, val, 16);
 	bacpy(&irk->rpa, rpa);
 
-	return 0;
+	return irk;
 }
 
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
-- 
1.8.5.3

