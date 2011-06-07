Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 08/13] Bluetooth: Add support for storing the LTK
Date: Tue,  7 Jun 2011 19:50:09 -0300
Message-Id: <1307487014-19398-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307487014-19398-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307487014-19398-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now when the LTK is received from the remote or generated it is stored,
so it can later be used.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b8f9910..bbc327b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -491,18 +491,23 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 
 static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	BT_DBG("conn %p", conn);
-	/* FIXME: store the ltk */
+	struct smp_cmd_encrypt_info *rp = (void *) skb->data;
+
+	skb_pull(skb, sizeof(*rp));
+
+	memcpy(conn->tk, rp->ltk, sizeof(conn->tk));
+
 	return 0;
 }
 
 static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_pairing *paircmd = (void *) &conn->prsp[1];
-	u8 keydist = paircmd->init_key_dist;
+	struct smp_cmd_master_ident *rp = (void *) skb->data;
+
+	skb_pull(skb, sizeof(*rp));
 
-	BT_DBG("keydist 0x%x", keydist);
-	/* FIXME: store ediv and rand */
+	hci_add_ltk(conn->hcon->hdev, 1, conn->src, rp->ediv,
+						rp->rand, conn->tk);
 
 	smp_distribute_keys(conn, 1);
 
@@ -621,6 +626,9 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
+		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, ediv,
+							ident.rand, enc.ltk);
+
 		ident.ediv = cpu_to_le16(ediv);
 
 		smp_send_cmd(conn, SMP_CMD_MASTER_IDENT, sizeof(ident), &ident);
-- 
1.7.5.4

