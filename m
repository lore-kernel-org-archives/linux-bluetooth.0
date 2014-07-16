Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Use explicit role instead of a bool in function parameters
Date: Wed, 16 Jul 2014 11:42:28 +0300
Message-Id: <1405500148-12370-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1405500148-12370-1-git-send-email-johan.hedberg@gmail.com>
References: <1405500148-12370-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To make the code more understandable it makes sense to use the new HCI
defines for connection role instead of a "bool master" parameter. This
makes it immediately clear when looking at the function calls what the
last parameter is describing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  6 +++---
 net/bluetooth/hci_conn.c         |  7 ++++---
 net/bluetooth/hci_core.c         | 19 +++++++++++--------
 net/bluetooth/hci_event.c        |  5 ++---
 net/bluetooth/l2cap_core.c       |  9 ++++++---
 net/bluetooth/mgmt.c             |  4 ++--
 net/bluetooth/smp.c              |  4 ++--
 7 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e335c5fd8824..abe5083becd3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -707,7 +707,7 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
-				bool master);
+				u8 role);
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
@@ -881,12 +881,12 @@ struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 				  bdaddr_t *bdaddr, u8 *val, u8 type,
 				  u8 pin_len, bool *persistent);
 struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
-			     bool master);
+			     u8 role);
 struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 type, u8 authenticated,
 			    u8 tk[16], u8 enc_size, __le16 ediv, __le64 rand);
 struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				     u8 addr_type, bool master);
+				     u8 addr_type, u8 role);
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type);
 void hci_smp_ltks_clear(struct hci_dev *hdev);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6c1c5048984c..6edd55340157 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -697,7 +697,7 @@ static void hci_req_directed_advertising(struct hci_request *req,
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
-				bool master)
+				u8 role)
 {
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
@@ -769,8 +769,10 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 			    &enable);
 	}
 
+	conn->role = role;
+
 	/* If requested to connect as slave use directed advertising */
-	if (!master) {
+	if (conn->role == HCI_ROLE_SLAVE) {
 		/* If we're active scanning most controllers are unable
 		 * to initiate advertising. Simply reject the attempt.
 		 */
@@ -786,7 +788,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	}
 
 	conn->out  = true;
-	conn->role = HCI_ROLE_MASTER;
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 172041e2b15a..f575abdf2b4e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3121,13 +3121,16 @@ static bool hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
 	return false;
 }
 
-static bool ltk_type_master(u8 type)
+static u8 ltk_role(u8 type)
 {
-	return (type == SMP_LTK);
+	if (type == SMP_LTK)
+		return HCI_ROLE_MASTER;
+
+	return HCI_ROLE_SLAVE;
 }
 
 struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
-			     bool master)
+			     u8 role)
 {
 	struct smp_ltk *k;
 
@@ -3135,7 +3138,7 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
 		if (k->ediv != ediv || k->rand != rand)
 			continue;
 
-		if (ltk_type_master(k->type) != master)
+		if (ltk_role(k->type) != role)
 			continue;
 
 		return k;
@@ -3145,14 +3148,14 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
 }
 
 struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				     u8 addr_type, bool master)
+				     u8 addr_type, u8 role)
 {
 	struct smp_ltk *k;
 
 	list_for_each_entry(k, &hdev->long_term_keys, list)
 		if (addr_type == k->bdaddr_type &&
 		    bacmp(bdaddr, &k->bdaddr) == 0 &&
-		    ltk_type_master(k->type) == master)
+		    ltk_role(k->type) == role)
 			return k;
 
 	return NULL;
@@ -3247,9 +3250,9 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 tk[16], u8 enc_size, __le16 ediv, __le64 rand)
 {
 	struct smp_ltk *key, *old_key;
-	bool master = ltk_type_master(type);
+	u8 role = ltk_role(type);
 
-	old_key = hci_find_ltk_by_addr(hdev, bdaddr, addr_type, master);
+	old_key = hci_find_ltk_by_addr(hdev, bdaddr, addr_type, role);
 	if (old_key)
 		key = old_key;
 	else {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3b1d2dadedc8..5f7fd410fb3b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4263,9 +4263,8 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		return;
 
 connect:
-	/* Request connection in master = true role */
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
-			      HCI_LE_AUTOCONN_TIMEOUT, true);
+			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER);
 	if (!IS_ERR(conn))
 		return;
 
@@ -4443,7 +4442,7 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn == NULL)
 		goto not_found;
 
-	ltk = hci_find_ltk(hdev, ev->ediv, ev->rand, conn->out);
+	ltk = hci_find_ltk(hdev, ev->ediv, ev->rand, conn->role);
 	if (ltk == NULL)
 		goto not_found;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ea68d3219b7e..d0f36336b6ce 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7128,7 +7128,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	chan->dcid = cid;
 
 	if (bdaddr_type_is_le(dst_type)) {
-		bool master;
+		u8 role;
 
 		/* Convert from L2CAP channel address type to HCI address type
 		 */
@@ -7137,10 +7137,13 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		else
 			dst_type = ADDR_LE_DEV_RANDOM;
 
-		master = !test_bit(HCI_ADVERTISING, &hdev->dev_flags);
+		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+			role = HCI_ROLE_SLAVE;
+		else
+			role = HCI_ROLE_MASTER;
 
 		hcon = hci_connect_le(hdev, dst, dst_type, chan->sec_level,
-				      HCI_LE_CONN_TIMEOUT, master);
+				      HCI_LE_CONN_TIMEOUT, role);
 	} else {
 		u8 auth_type = l2cap_get_auth_type(chan);
 		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7703b72653ff..b981bfb87f86 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3154,9 +3154,9 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		 */
 		hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
 
-		/* Request a connection with master = true role */
 		conn = hci_connect_le(hdev, &cp->addr.bdaddr, addr_type,
-				      sec_level, HCI_LE_CONN_TIMEOUT, true);
+				      sec_level, HCI_LE_CONN_TIMEOUT,
+				      HCI_ROLE_MASTER);
 	}
 
 	if (IS_ERR(conn)) {
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 78eeb8b5970a..70b726518d7b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -849,7 +849,7 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	struct hci_conn *hcon = conn->hcon;
 
 	key = hci_find_ltk_by_addr(hcon->hdev, &hcon->dst, hcon->dst_type,
-				   hcon->out);
+				   hcon->role);
 	if (!key)
 		return false;
 
@@ -881,7 +881,7 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level)
 	 */
 	if (test_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags) &&
 	    hci_find_ltk_by_addr(hcon->hdev, &hcon->dst, hcon->dst_type,
-				 hcon->out))
+				 hcon->role))
 		return false;
 
 	if (hcon->sec_level >= sec_level)
-- 
1.9.3

