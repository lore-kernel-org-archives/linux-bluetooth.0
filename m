Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Track SMP keys in the SMP context
Date: Wed, 19 Feb 2014 14:57:46 +0200
Message-Id: <1392814668-4830-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
References: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

As preparation to do mgmt notification in a single place at the end of
the key distribution, store the keys that need to be notified within the
SMP context.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 21 +++++++++++++--------
 net/bluetooth/smp.h |  3 +++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 27eebca260fa..eaac54be91b1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -915,6 +915,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp = conn->smp_chan;
 	struct hci_dev *hdev = conn->hcon->hdev;
 	struct hci_conn *hcon = conn->hcon;
+	struct smp_ltk *ltk;
 	u8 authenticated;
 
 	BT_DBG("conn %p", conn);
@@ -930,9 +931,10 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	authenticated = (hcon->sec_level == BT_SECURITY_HIGH);
-	hci_add_ltk(hdev, &hcon->dst, hcon->dst_type, HCI_SMP_LTK, 1,
-		    authenticated, smp->tk, smp->enc_key_size,
-		    rp->ediv, rp->rand);
+	ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type, HCI_SMP_LTK, 1,
+			  authenticated, smp->tk, smp->enc_key_size,
+			  rp->ediv, rp->rand);
+	smp->ltk = ltk;
 	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
 		smp_distribute_keys(conn, 1);
 	hci_dev_unlock(hdev);
@@ -988,8 +990,8 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	else
 		bacpy(&rpa, BDADDR_ANY);
 
-	hci_add_irk(conn->hcon->hdev, &smp->id_addr, smp->id_addr_type,
-		    smp->irk, &rpa);
+	smp->remote_irk = hci_add_irk(conn->hcon->hdev, &smp->id_addr,
+				      smp->id_addr_type, smp->irk, &rpa);
 
 	/* Track the connection based on the Identity Address from now on */
 	bacpy(&hcon->dst, &smp->id_addr);
@@ -1137,6 +1139,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		struct smp_cmd_encrypt_info enc;
 		struct smp_cmd_master_ident ident;
 		struct hci_conn *hcon = conn->hcon;
+		struct smp_ltk *ltk;
 		u8 authenticated;
 		__le16 ediv;
 
@@ -1147,9 +1150,11 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
 		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
-		hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-			    HCI_SMP_LTK_SLAVE, 1, authenticated,
-			    enc.ltk, smp->enc_key_size, ediv, ident.rand);
+		ltk = hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
+				  HCI_SMP_LTK_SLAVE, 1, authenticated,
+				  enc.ltk, smp->enc_key_size, ediv,
+				  ident.rand);
+		smp->slave_ltk = ltk;
 
 		ident.ediv = ediv;
 
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 675fd3b21d2c..d8cc543f523c 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -133,6 +133,9 @@ struct smp_chan {
 	bdaddr_t	id_addr;
 	u8		id_addr_type;
 	u8		irk[16];
+	struct smp_ltk	*ltk;
+	struct smp_ltk	*slave_ltk;
+	struct smp_irk	*remote_irk;
 	unsigned long	smp_flags;
 	struct work_struct confirm;
 	struct work_struct random;
-- 
1.8.5.3

