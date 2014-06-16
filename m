Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] Bluetooth: Remove HCI prefix from SMP LTK defines
Date: Mon, 16 Jun 2014 19:25:16 +0300
Message-Id: <1402935919-32348-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1402935919-32348-1-git-send-email-johan.hedberg@gmail.com>
References: <1402935919-32348-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The LTK type has really nothing to do with HCI so it makes more sense to
have these in smp.h than hci.h. This patch moves the defines to smp.h
and removes the HCI_ prefix in the same go.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h | 4 ----
 net/bluetooth/hci_core.c    | 2 +-
 net/bluetooth/hci_event.c   | 3 ++-
 net/bluetooth/mgmt.c        | 6 +++---
 net/bluetooth/smp.c         | 7 +++----
 net/bluetooth/smp.h         | 7 +++++++
 6 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 98f7520d2f57..6ec5b3bd1f67 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -347,10 +347,6 @@ enum {
 #define HCI_LK_CHANGED_COMBINATION	0x06
 #define HCI_LK_UNAUTH_COMBINATION_P256	0x07
 #define HCI_LK_AUTH_COMBINATION_P256	0x08
-/* The spec doesn't define types for SMP keys, the _MASTER suffix is implied */
-#define HCI_SMP_STK			0x80
-#define HCI_SMP_LTK			0x82
-#define HCI_SMP_LTK_SLAVE		0x83
 
 /* Long Term Key types */
 #define HCI_LTK_UNAUTH			0x00
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9e0368b02a11..6001b9293905 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2974,7 +2974,7 @@ static bool hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
 
 static bool ltk_type_master(u8 type)
 {
-	if (type == HCI_SMP_STK || type == HCI_SMP_LTK)
+	if (type == SMP_STK || type == SMP_LTK)
 		return true;
 
 	return false;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8dde40430b5f..15a0a65bf447 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -32,6 +32,7 @@
 
 #include "a2mp.h"
 #include "amp.h"
+#include "smp.h"
 
 /* Handle HCI Event packets */
 
@@ -4241,7 +4242,7 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 * distribute the keys. Later, security can be re-established
 	 * using a distributed LTK.
 	 */
-	if (ltk->type == HCI_SMP_STK) {
+	if (ltk->type == SMP_STK) {
 		list_del(&ltk->list);
 		kfree(ltk);
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index af8e0a6243b7..99eb845865ef 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4550,9 +4550,9 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			addr_type = ADDR_LE_DEV_RANDOM;
 
 		if (key->master)
-			type = HCI_SMP_LTK;
+			type = SMP_LTK;
 		else
-			type = HCI_SMP_LTK_SLAVE;
+			type = SMP_LTK_SLAVE;
 
 		switch (key->type) {
 		case MGMT_LTK_UNAUTHENTICATED:
@@ -5279,7 +5279,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 	ev.key.ediv = key->ediv;
 	ev.key.rand = key->rand;
 
-	if (key->type == HCI_SMP_LTK)
+	if (key->type == SMP_LTK)
 		ev.key.master = 1;
 
 	memcpy(ev.key.val, key->val, sizeof(key->val));
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4fb9f9aa0cea..83f70352e434 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -566,8 +566,7 @@ static u8 smp_random(struct smp_chan *smp)
 		 * STK never needs to be stored).
 		 */
 		hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-			    HCI_SMP_STK, auth, stk, smp->enc_key_size,
-			    ediv, rand);
+			    SMP_STK, auth, stk, smp->enc_key_size, ediv, rand);
 	}
 
 	return 0;
@@ -995,7 +994,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	authenticated = (hcon->sec_level == BT_SECURITY_HIGH);
-	ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type, HCI_SMP_LTK,
+	ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type, SMP_LTK,
 			  authenticated, smp->tk, smp->enc_key_size,
 			  rp->ediv, rp->rand);
 	smp->ltk = ltk;
@@ -1311,7 +1310,7 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 
 		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
 		ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type,
-				  HCI_SMP_LTK_SLAVE, authenticated, enc.ltk,
+				  SMP_LTK_SLAVE, authenticated, enc.ltk,
 				  smp->enc_key_size, ediv, rand);
 		smp->slave_ltk = ltk;
 
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 5a8dc36460a1..796f4f45f92f 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -116,6 +116,13 @@ struct smp_cmd_security_req {
 #define SMP_MIN_ENC_KEY_SIZE		7
 #define SMP_MAX_ENC_KEY_SIZE		16
 
+/* LTK types used in internal storage (struct smp_ltk) */
+enum {
+	SMP_STK,
+	SMP_LTK,
+	SMP_LTK_SLAVE,
+};
+
 /* SMP Commands */
 bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
-- 
1.9.3

