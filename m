Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next v3 09/16] Bluetooth: Remove debug statements
Date: Tue,  7 Jun 2011 18:46:38 -0300
Message-Id: <1307483205-1518-10-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that these commands are sent to the controller we can use hcidump
to verify that the correct values are produced.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 22c362b..c1c4bc0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -279,7 +279,7 @@ static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct hci_conn *hcon = conn->hcon;
 	struct crypto_blkcipher *tfm = hcon->hdev->tfm;
 	int ret;
-	u8 key[16], res[16], random[16], confirm[16], buf[128];
+	u8 key[16], res[16], random[16], confirm[16];
 
 	swap128(skb->data, random);
 	skb_pull(skb, sizeof(random));
@@ -313,10 +313,6 @@ static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		swap128(key, hcon->ltk);
 
 		hci_le_start_enc(hcon, hcon->ltk);
-
-		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf,
-							sizeof(buf), 0);
-		BT_DBG("key %s", buf);
 	} else {
 		u8 r[16];
 
@@ -325,10 +321,6 @@ static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 
 		smp_s1(tfm, conn->tk, conn->prnd, random, key);
 		swap128(key, hcon->ltk);
-
-		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf,
-							sizeof(buf), 0);
-		BT_DBG("key %s", buf);
 	}
 }
 
-- 
1.7.5.4

