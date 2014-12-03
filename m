Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 15/49] Bluetooth: Add basic support for sending our LE SC public key
Date: Wed,  3 Dec 2014 17:02:09 +0200
Message-Id: <1417618963-18010-16-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the initial pairing request & response PDUs have been exchanged and
both have had the LE SC bit set the next step is to generate a ECDH
key pair and to send the public key to the remote side. This patch adds
basic support for generating the key pair and sending the public key
using the new Public Key SMP PDU. It is the initiating device that sends
the public key first and the non-initiating device responds by sending
its public key respectively (in a subsequent patch).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4fed367da380..9317583751eb 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -29,10 +29,14 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/mgmt.h>
 
+#include "ecc.h"
 #include "smp.h"
 
 #define SMP_ALLOW_CMD(smp, code)	set_bit(code, &smp->allow_cmd)
 
+/* Keys which are not distributed with Secure Connections */
+#define SMP_SC_NO_DIST (SMP_DIST_ENC_KEY | SMP_DIST_LINK_KEY);
+
 #define SMP_TIMEOUT	msecs_to_jiffies(30000)
 
 #define AUTH_REQ_MASK(dev)	(test_bit(HCI_SC_ENABLED, &(dev)->dev_flags) ? \
@@ -71,6 +75,10 @@ struct smp_chan {
 	struct smp_irk	*remote_irk;
 	unsigned long	flags;
 
+	/* Secure Connections variables */
+	u8			local_pk[64];
+	u8			local_sk[32];
+
 	struct crypto_blkcipher	*tfm_aes;
 	struct crypto_hash	*tfm_cmac;
 };
@@ -1012,7 +1020,18 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&smp->prsp[1], &rsp, sizeof(rsp));
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(rsp), &rsp);
-	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
+
+	clear_bit(SMP_FLAG_INITIATOR, &smp->flags);
+
+	if (test_bit(SMP_FLAG_SC, &smp->flags)) {
+		SMP_ALLOW_CMD(smp, SMP_CMD_PUBLIC_KEY);
+		/* Clear bits which are generated but not distributed */
+		smp->remote_key_dist &= ~SMP_SC_NO_DIST;
+		/* Wait for Public Key from Initiating Device */
+		return 0;
+	} else {
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
+	}
 
 	/* Request setup of TK */
 	ret = tk_request(conn, 0, auth, rsp.io_capability, req->io_capability);
@@ -1022,6 +1041,23 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
+static u8 sc_send_public_key(struct smp_chan *smp)
+{
+	BT_DBG("");
+
+	/* Generate local key pair for Secure Connections */
+	if (!ecc_make_key(smp->local_pk, smp->local_sk))
+		return SMP_UNSPECIFIED;
+
+	BT_DBG("Local Public Key X: %32phN", smp->local_pk);
+	BT_DBG("Local Public Key Y: %32phN", &smp->local_pk[32]);
+	BT_DBG("Local Private Key:  %32phN", smp->local_sk);
+
+	smp_send_cmd(smp->conn, SMP_CMD_PUBLIC_KEY, 64, smp->local_pk);
+
+	return 0;
+}
+
 static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing *req, *rsp = (void *) skb->data;
@@ -1074,6 +1110,13 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	 */
 	smp->remote_key_dist &= rsp->resp_key_dist;
 
+	if (test_bit(SMP_FLAG_SC, &smp->flags)) {
+		/* Clear bits which are generated but not distributed */
+		smp->remote_key_dist &= ~SMP_SC_NO_DIST;
+		SMP_ALLOW_CMD(smp, SMP_CMD_PUBLIC_KEY);
+		return sc_send_public_key(smp);
+	}
+
 	auth |= req->auth_req;
 
 	ret = tk_request(conn, 0, auth, req->io_capability, rsp->io_capability);
-- 
2.1.0

