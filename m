Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next v4 09/16] Bluetooth: Remove debug statements
Date: Thu,  9 Jun 2011 18:50:48 -0300
Message-Id: <1307656255-8659-10-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307656255-8659-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307656255-8659-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that these commands are sent to the controller we can use hcidump
to verify that the correct values are produced.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 56828db..6983979 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -280,7 +280,7 @@ static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct hci_conn *hcon = conn->hcon;
 	struct crypto_blkcipher *tfm = hcon->hdev->tfm;
 	int ret;
-	u8 key[16], res[16], random[16], confirm[16], buf[128];
+	u8 key[16], res[16], random[16], confirm[16];
 
 	swap128(skb->data, random);
 	skb_pull(skb, sizeof(random));
@@ -329,10 +329,6 @@ static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 
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

