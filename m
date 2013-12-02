Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove useless smp_rand function
Date: Mon,  2 Dec 2013 10:49:03 +0200
Message-Id: <1385974144-8836-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1385974144-8836-1-git-send-email-johan.hedberg@gmail.com>
References: <1385974144-8836-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This function was always just making a single get_random_bytes() call
and always returning the value 0. It's simpler to just call
get_random_bytes() directly where needed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f99352d1aa43..3bcb765b6a92 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -143,13 +143,6 @@ static int smp_s1(struct crypto_blkcipher *tfm, u8 k[16], u8 r1[16],
 	return err;
 }
 
-static int smp_rand(u8 *buf)
-{
-	get_random_bytes(buf, 16);
-
-	return 0;
-}
-
 static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
 				     u16 dlen, void *data)
 {
@@ -606,9 +599,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (check_enc_key_size(conn, key_size))
 		return SMP_ENC_KEY_SIZE;
 
-	ret = smp_rand(smp->prnd);
-	if (ret)
-		return SMP_UNSPECIFIED;
+	get_random_bytes(smp->prnd, sizeof(smp->prnd));
 
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
 	memcpy(&smp->prsp[1], &rsp, sizeof(rsp));
@@ -644,9 +635,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (check_enc_key_size(conn, key_size))
 		return SMP_ENC_KEY_SIZE;
 
-	ret = smp_rand(smp->prnd);
-	if (ret)
-		return SMP_UNSPECIFIED;
+	get_random_bytes(smp->prnd, sizeof(smp->prnd));
 
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
 	memcpy(&smp->prsp[1], rsp, sizeof(*rsp));
-- 
1.8.4.2

