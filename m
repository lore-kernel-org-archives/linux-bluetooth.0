Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/49] Bluetooth: Update LTK lookup to correctly deal with SC LTKs
Date: Wed,  3 Dec 2014 17:02:03 +0200
Message-Id: <1417618963-18010-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

LTKs derived from Secure Connections based pairing are symmetric, i.e.
they should match both master and slave role. This patch updates the LTK
lookup functions to ignore the desired role when dealing with SC LTKs.

Furthermore, with Secure Connections the EDiv and Rand values are not
used and should always be set to zero. This patch updates the LTK lookup
to first use the bdaddr as key and then do the necessary verifications
of EDiv and Rand based on whether the found LTK is for SC or not.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c  | 30 +++++++++++++++++++++++-------
 net/bluetooth/hci_event.c | 15 +++++++++++++--
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2586e405adb3..e091e8ffeb8e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3195,11 +3195,18 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
 		if (k->ediv != ediv || k->rand != rand)
 			continue;
 
-		if (ltk_role(k->type) != role)
-			continue;
+		if (smp_ltk_is_sc(k)) {
+			if (k->type == SMP_LTK_P256_DEBUG &&
+			    !test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags))
+				continue;
+			rcu_read_unlock();
+			return k;
+		}
 
-		rcu_read_unlock();
-		return k;
+		if (ltk_role(k->type) == role) {
+			rcu_read_unlock();
+			return k;
+		}
 	}
 	rcu_read_unlock();
 
@@ -3213,9 +3220,18 @@ struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
-		if (addr_type == k->bdaddr_type &&
-		    bacmp(bdaddr, &k->bdaddr) == 0 &&
-		    ltk_role(k->type) == role) {
+		if (addr_type != k->bdaddr_type || bacmp(bdaddr, &k->bdaddr))
+			continue;
+
+		if (smp_ltk_is_sc(k)) {
+			if (k->type == SMP_LTK_P256_DEBUG &&
+			    !test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags))
+				continue;
+			rcu_read_unlock();
+			return k;
+		}
+
+		if (ltk_role(k->type) == role) {
 			rcu_read_unlock();
 			return k;
 		}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f980fc46ea5e..0058b545c5ed 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4590,10 +4590,21 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn == NULL)
 		goto not_found;
 
-	ltk = hci_find_ltk(hdev, ev->ediv, ev->rand, conn->role);
-	if (ltk == NULL)
+	ltk = hci_find_ltk_by_addr(hdev, &conn->dst, conn->dst_type,
+				   conn->role);
+	if (!ltk)
 		goto not_found;
 
+	if (smp_ltk_is_sc(ltk)) {
+		/* With SC both EDiv and Rand are set to zero */
+		if (ev->ediv || ev->rand)
+			goto not_found;
+	} else {
+		/* For non-SC keys check that EDiv and Rand match */
+		if (ev->ediv != ltk->ediv || ev->rand != ltk->rand)
+			goto not_found;
+	}
+
 	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
 	cp.handle = cpu_to_le16(conn->handle);
 
-- 
2.1.0

