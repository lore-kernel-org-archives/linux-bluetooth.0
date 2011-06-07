Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 09/13] Bluetooth: Use the link key list to temporarily store the STK
Date: Tue,  7 Jun 2011 19:50:10 -0300
Message-Id: <1307487014-19398-10-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307487014-19398-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307487014-19398-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this we can use only one place to store all keys, without
need to use a field in the connection structure for this
purpose.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index bbc327b..11f5f4f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -388,29 +388,36 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (conn->hcon->out) {
+		u8 stk[16], rand[8];
 		__le16 ediv;
-		u8 rand[8];
+
+		memset(rand, 0, sizeof(rand));
+		ediv = 0;
 
 		smp_s1(tfm, conn->tk, random, conn->prnd, key);
-		swap128(key, hcon->ltk);
+		swap128(key, stk);
 
-		memset(hcon->ltk + conn->smp_key_size, 0,
+		memset(stk + conn->smp_key_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
 
+		hci_le_start_enc(hcon, ediv, rand, stk);
+	} else {
+		u8 stk[16], r[16], rand[8];
+		__le16 ediv;
+
 		memset(rand, 0, sizeof(rand));
 		ediv = 0;
-		hci_le_start_enc(hcon, ediv, rand, hcon->ltk);
-	} else {
-		u8 r[16];
 
 		swap128(conn->prnd, r);
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(r), r);
 
 		smp_s1(tfm, conn->tk, conn->prnd, random, key);
-		swap128(key, hcon->ltk);
+		swap128(key, stk);
 
-		memset(hcon->ltk + conn->smp_key_size, 0,
+		memset(stk + conn->smp_key_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
+
+		hci_add_ltk(conn->hcon->hdev, 0, conn->dst, ediv, rand, stk);
 	}
 
 	return 0;
-- 
1.7.5.4

