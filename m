Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 18/49] Bluetooth: Add LE SC support for responding to Pairing Confirm PDU
Date: Wed,  3 Dec 2014 17:02:12 +0200
Message-Id: <1417618963-18010-19-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When LE SC is being used we should always respond to it by sending our
local random number. This patch adds a convenience function for it which
also contains a check for the pre-requisite public key exchange
completion

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a1bfcb601c03..36f3c75ac858 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1216,6 +1216,25 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
+static u8 sc_check_confirm(struct smp_chan *smp)
+{
+	struct l2cap_conn *conn = smp->conn;
+
+	BT_DBG("");
+
+	/* Public Key exchange must happen before any other steps */
+	if (!test_bit(SMP_FLAG_REMOTE_PK, &smp->flags))
+		return SMP_UNSPECIFIED;
+
+	if (conn->hcon->out) {
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
+			     smp->prnd);
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
+	}
+
+	return 0;
+}
+
 static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan = conn->smp;
@@ -1229,6 +1248,9 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(smp->pcnf, skb->data, sizeof(smp->pcnf));
 	skb_pull(skb, sizeof(smp->pcnf));
 
+	if (test_bit(SMP_FLAG_SC, &smp->flags))
+		return sc_check_confirm(smp);
+
 	if (conn->hcon->out) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
-- 
2.1.0

