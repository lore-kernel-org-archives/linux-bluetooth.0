Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/49] Bluetooth: Remove unused hci_find_ltk function
Date: Wed,  3 Dec 2014 17:02:04 +0200
Message-Id: <1417618963-18010-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that LTKs are always looked up based on bdaddr (with EDiv/Rand
checks done after a successful lookup) the hci_find_ltk function is not
needed anymore. This patch removes the function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 --
 net/bluetooth/hci_core.c         | 28 ----------------------------
 2 files changed, 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7f08ea36d246..b41969b561d8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -921,8 +921,6 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 				  bdaddr_t *bdaddr, u8 *val, u8 type,
 				  u8 pin_len, bool *persistent);
-struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
-			     u8 role);
 struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 type, u8 authenticated,
 			    u8 tk[16], u8 enc_size, __le16 ediv, __le64 rand);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e091e8ffeb8e..cb9bc8e2c58d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3185,34 +3185,6 @@ static u8 ltk_role(u8 type)
 	return HCI_ROLE_SLAVE;
 }
 
-struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
-			     u8 role)
-{
-	struct smp_ltk *k;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
-		if (k->ediv != ediv || k->rand != rand)
-			continue;
-
-		if (smp_ltk_is_sc(k)) {
-			if (k->type == SMP_LTK_P256_DEBUG &&
-			    !test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags))
-				continue;
-			rcu_read_unlock();
-			return k;
-		}
-
-		if (ltk_role(k->type) == role) {
-			rcu_read_unlock();
-			return k;
-		}
-	}
-	rcu_read_unlock();
-
-	return NULL;
-}
-
 struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type, u8 role)
 {
-- 
2.1.0

