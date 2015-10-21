Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/13] Bluetooth: Add le_addr_type() helper function
Date: Wed, 21 Oct 2015 18:02:59 +0300
Message-Id: <1445439791-2151-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
References: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The mgmt code needs to convert from mgmt/L2CAP address types to HCI in
many places. Having a dedicated helper function for this simplifies
code by shortening it and removing unnecessary 'addr_type' variables.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 56 +++++++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 98d8d20a05c1..de338d576907 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -268,6 +268,14 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 len,
 			       HCI_SOCK_TRUSTED, skip_sk);
 }
 
+static u8 le_addr_type(u8 mgmt_addr_type)
+{
+	if (mgmt_addr_type == BDADDR_LE_PUBLIC)
+		return ADDR_LE_DEV_PUBLIC;
+	else
+		return ADDR_LE_DEV_RANDOM;
+}
+
 static int read_version(struct sock *sk, struct hci_dev *hdev, void *data,
 			u16 data_len)
 {
@@ -3088,12 +3096,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		err = hci_remove_link_key(hdev, &cp->addr.bdaddr);
 	} else {
-		u8 addr_type;
-
-		if (cp->addr.type == BDADDR_LE_PUBLIC)
-			addr_type = ADDR_LE_DEV_PUBLIC;
-		else
-			addr_type = ADDR_LE_DEV_RANDOM;
+		u8 addr_type = le_addr_type(cp->addr.type);
 
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
 					       &cp->addr.bdaddr);
@@ -3546,16 +3549,9 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		conn = hci_connect_acl(hdev, &cp->addr.bdaddr, sec_level,
 				       auth_type);
 	} else {
-		u8 addr_type;
+		u8 addr_type = le_addr_type(cp->addr.type);
 		struct hci_conn_params *p;
 
-		/* Convert from L2CAP channel address type to HCI address type
-		 */
-		if (cp->addr.type == BDADDR_LE_PUBLIC)
-			addr_type = ADDR_LE_DEV_PUBLIC;
-		else
-			addr_type = ADDR_LE_DEV_RANDOM;
-
 		/* When pairing a new device, it is expected to remember
 		 * this device for future connections. Adding the connection
 		 * parameter information ahead of time allows tracking
@@ -5602,14 +5598,9 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 
 	for (i = 0; i < irk_count; i++) {
 		struct mgmt_irk_info *irk = &cp->irks[i];
-		u8 addr_type;
 
-		if (irk->addr.type == BDADDR_LE_PUBLIC)
-			addr_type = ADDR_LE_DEV_PUBLIC;
-		else
-			addr_type = ADDR_LE_DEV_RANDOM;
-
-		hci_add_irk(hdev, &irk->addr.bdaddr, addr_type, irk->val,
+		hci_add_irk(hdev, &irk->addr.bdaddr,
+			    le_addr_type(irk->addr.type), irk->val,
 			    BDADDR_ANY);
 	}
 
@@ -5689,12 +5680,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_ltk_info *key = &cp->keys[i];
-		u8 type, addr_type, authenticated;
-
-		if (key->addr.type == BDADDR_LE_PUBLIC)
-			addr_type = ADDR_LE_DEV_PUBLIC;
-		else
-			addr_type = ADDR_LE_DEV_RANDOM;
+		u8 type, authenticated;
 
 		switch (key->type) {
 		case MGMT_LTK_UNAUTHENTICATED:
@@ -5720,9 +5706,9 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			continue;
 		}
 
-		hci_add_ltk(hdev, &key->addr.bdaddr, addr_type, type,
-			    authenticated, key->val, key->enc_size, key->ediv,
-			    key->rand);
+		hci_add_ltk(hdev, &key->addr.bdaddr,
+			    le_addr_type(key->addr.type), type, authenticated,
+			    key->val, key->enc_size, key->ediv, key->rand);
 	}
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS, 0,
@@ -6234,10 +6220,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		goto added;
 	}
 
-	if (cp->addr.type == BDADDR_LE_PUBLIC)
-		addr_type = ADDR_LE_DEV_PUBLIC;
-	else
-		addr_type = ADDR_LE_DEV_RANDOM;
+	addr_type = le_addr_type(cp->addr.type);
 
 	if (cp->action == 0x02)
 		auto_conn = HCI_AUTO_CONN_ALWAYS;
@@ -6366,10 +6349,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			goto complete;
 		}
 
-		if (cp->addr.type == BDADDR_LE_PUBLIC)
-			addr_type = ADDR_LE_DEV_PUBLIC;
-		else
-			addr_type = ADDR_LE_DEV_RANDOM;
+		addr_type = le_addr_type(cp->addr.type);
 
 		/* Kernel internally uses conn_params with resolvable private
 		 * address, but Remove Device allows only identity addresses.
-- 
2.5.0

