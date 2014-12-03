Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/49] Bluetooth: Rename hci_find_ltk_by_addr to hci_find_ltk
Date: Wed,  3 Dec 2014 17:02:05 +0200
Message-Id: <1417618963-18010-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that hci_find_ltk_by_addr is the only LTK lookup function there's no
need to keep the long name anymore. This patch shortens the function
name to simply hci_find_ltk.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/hci_core.c         | 6 +++---
 net/bluetooth/hci_event.c        | 3 +--
 net/bluetooth/smp.c              | 6 ++----
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b41969b561d8..90929641d0f0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -924,8 +924,8 @@ struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 type, u8 authenticated,
 			    u8 tk[16], u8 enc_size, __le16 ediv, __le64 rand);
-struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				     u8 addr_type, u8 role);
+struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			     u8 addr_type, u8 role);
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type);
 void hci_smp_ltks_clear(struct hci_dev *hdev);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cb9bc8e2c58d..6c3220e9484f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3185,8 +3185,8 @@ static u8 ltk_role(u8 type)
 	return HCI_ROLE_SLAVE;
 }
 
-struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				     u8 addr_type, u8 role)
+struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			     u8 addr_type, u8 role)
 {
 	struct smp_ltk *k;
 
@@ -3313,7 +3313,7 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	struct smp_ltk *key, *old_key;
 	u8 role = ltk_role(type);
 
-	old_key = hci_find_ltk_by_addr(hdev, bdaddr, addr_type, role);
+	old_key = hci_find_ltk(hdev, bdaddr, addr_type, role);
 	if (old_key)
 		key = old_key;
 	else {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0058b545c5ed..34ecbf0b7e5b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4590,8 +4590,7 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn == NULL)
 		goto not_found;
 
-	ltk = hci_find_ltk_by_addr(hdev, &conn->dst, conn->dst_type,
-				   conn->role);
+	ltk = hci_find_ltk(hdev, &conn->dst, conn->dst_type, conn->role);
 	if (!ltk)
 		goto not_found;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4ecbf2774fbd..0973e37073e2 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1118,8 +1118,7 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	struct smp_ltk *key;
 	struct hci_conn *hcon = conn->hcon;
 
-	key = hci_find_ltk_by_addr(hcon->hdev, &hcon->dst, hcon->dst_type,
-				   hcon->role);
+	key = hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type, hcon->role);
 	if (!key)
 		return false;
 
@@ -1152,8 +1151,7 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
 	 */
 	if (key_pref == SMP_USE_LTK &&
 	    test_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags) &&
-	    hci_find_ltk_by_addr(hcon->hdev, &hcon->dst, hcon->dst_type,
-				 hcon->role))
+	    hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type, hcon->role))
 		return false;
 
 	if (hcon->sec_level >= sec_level)
-- 
2.1.0

