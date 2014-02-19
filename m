Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: Move SMP LTK notification after key distribution
Date: Wed, 19 Feb 2014 14:57:47 +0200
Message-Id: <1392814668-4830-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
References: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch moves the SMP Long Term Key notification over mgmt from the
hci_add_ltk function to smp.c when both sides have completed their key
distribution. This way we are also able to update the identity address
into the mgmt_new_ltk event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  5 ++---
 net/bluetooth/hci_core.c         | 11 ++---------
 net/bluetooth/mgmt.c             |  6 +++---
 net/bluetooth/smp.c              | 29 ++++++++++++++++++++++++-----
 4 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8ca95e5e3765..59ae04c2684f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -788,9 +788,8 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8],
 			     bool master);
 struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			    u8 addr_type, u8 type, int new_key,
-			    u8 authenticated, u8 tk[16], u8 enc_size,
-			    __le16 ediv, u8 rand[8]);
+			    u8 addr_type, u8 type, u8 authenticated,
+			    u8 tk[16], u8 enc_size, __le16 ediv, u8 rand[8]);
 struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type, bool master);
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 60c875267c19..3711c7626cb2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2762,9 +2762,8 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 }
 
 struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			    u8 addr_type, u8 type, int new_key,
-			    u8 authenticated, u8 tk[16], u8 enc_size,
-			    __le16 ediv, u8 rand[8])
+			    u8 addr_type, u8 type, u8 authenticated,
+			    u8 tk[16], u8 enc_size, __le16 ediv, u8 rand[8])
 {
 	struct smp_ltk *key, *old_key;
 	bool master = ltk_type_master(type);
@@ -2788,12 +2787,6 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	key->type = type;
 	memcpy(key->rand, rand, sizeof(key->rand));
 
-	if (!new_key)
-		return key;
-
-	if (type == HCI_SMP_LTK || type == HCI_SMP_LTK_SLAVE)
-		mgmt_new_ltk(hdev, key);
-
 	return key;
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ad51da1b6dc2..bcfc6da67a5c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4330,9 +4330,9 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		else
 			type = HCI_SMP_LTK_SLAVE;
 
-		hci_add_ltk(hdev, &key->addr.bdaddr, addr_type,
-			    type, 0, key->type, key->val,
-			    key->enc_size, key->ediv, key->rand);
+		hci_add_ltk(hdev, &key->addr.bdaddr, addr_type, type,
+			    key->type, key->val, key->enc_size, key->ediv,
+			    key->rand);
 	}
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS, 0,
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index eaac54be91b1..f05c1b71d99a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -532,7 +532,7 @@ static void random_work(struct work_struct *work)
 		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
 
 		hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-			    HCI_SMP_STK_SLAVE, 0, 0, stk, smp->enc_key_size,
+			    HCI_SMP_STK_SLAVE, 0, stk, smp->enc_key_size,
 			    ediv, rand);
 	}
 
@@ -931,7 +931,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	authenticated = (hcon->sec_level == BT_SECURITY_HIGH);
-	ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type, HCI_SMP_LTK, 1,
+	ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type, HCI_SMP_LTK,
 			  authenticated, smp->tk, smp->enc_key_size,
 			  rp->ediv, rp->rand);
 	smp->ltk = ltk;
@@ -1106,6 +1106,25 @@ done:
 	return err;
 }
 
+static void smp_notify_keys(struct l2cap_conn *conn)
+{
+	struct smp_chan *smp = conn->smp_chan;
+	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
+
+	if (smp->ltk) {
+		smp->ltk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->ltk->bdaddr, &hcon->dst);
+		mgmt_new_ltk(hdev, smp->ltk);
+	}
+
+	if (smp->slave_ltk) {
+		smp->slave_ltk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->slave_ltk->bdaddr, &hcon->dst);
+		mgmt_new_ltk(hdev, smp->slave_ltk);
+	}
+}
+
 int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 {
 	struct smp_cmd_pairing *req, *rsp;
@@ -1151,9 +1170,8 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
 		ltk = hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-				  HCI_SMP_LTK_SLAVE, 1, authenticated,
-				  enc.ltk, smp->enc_key_size, ediv,
-				  ident.rand);
+				  HCI_SMP_LTK_SLAVE, authenticated, enc.ltk,
+				  smp->enc_key_size, ediv, ident.rand);
 		smp->slave_ltk = ltk;
 
 		ident.ediv = ediv;
@@ -1197,6 +1215,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags);
 		cancel_delayed_work_sync(&conn->security_timer);
 		set_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
+		smp_notify_keys(conn);
 		smp_chan_destroy(conn);
 	}
 
-- 
1.8.5.3

