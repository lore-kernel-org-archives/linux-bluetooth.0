Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 08/15] Bluetooth: Add support for storing the LTK
Date: Tue,  5 Apr 2011 23:11:21 -0300
Message-Id: <1302055888-28177-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now when the LTK is received from the remote or generated it is stored,
so it can later be used.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3d2fb13..1aa620f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -505,18 +505,45 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 
 static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 {
+	struct smp_cmd_encrypt_info *rp = (void *) skb->data;
+	u8 rand[8];
+	int err;
+
+	skb_pull(skb, sizeof(*rp));
+
 	BT_DBG("conn %p", conn);
-	/* FIXME: store the ltk */
+
+	memset(rand, 0, sizeof(rand));
+
+	err = hci_add_ltk(conn->hcon->hdev, 0, conn->dst, 0, rand, rp->ltk);
+	if (err)
+		return SMP_UNSPECIFIED;
+
 	return 0;
 }
 
 static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 {
+	struct smp_cmd_master_ident *rp = (void *) skb->data;
 	struct smp_cmd_pairing *paircmd = (void *) &conn->prsp[1];
+	struct link_key *key;
+	struct key_master_id *id;
 	u8 keydist = paircmd->init_key_dist;
 
+	skb_pull(skb, sizeof(*rp));
+
+	key = hci_find_link_key_type(conn->hcon->hdev, conn->dst, KEY_TYPE_LTK);
+	if (key == NULL)
+		return SMP_UNSPECIFIED;
+
 	BT_DBG("keydist 0x%x", keydist);
-	/* FIXME: store ediv and rand */
+
+	id = (void *) key->data;
+	id->ediv = rp->ediv;
+	memcpy(id->rand, rp->rand, sizeof(rp->rand));
+
+	hci_add_ltk(conn->hcon->hdev, 1, conn->src, rp->ediv,
+						rp->rand, key->val);
 
 	smp_distribute_keys(conn, 1);
 
@@ -635,6 +662,9 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
+		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, ediv,
+							ident.rand, enc.ltk);
+
 		ident.ediv = cpu_to_le16(ediv);
 
 		smp_send_cmd(conn, SMP_CMD_MASTER_IDENT, sizeof(ident), &ident);
-- 
1.7.4.1

