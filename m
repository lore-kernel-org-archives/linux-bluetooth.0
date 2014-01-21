Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] emulator: Fix unaligned memory access compilation errors
Date: Mon, 20 Jan 2014 21:46:09 -0400
Message-Id: <1390268769-30209-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The u128_xor() function does proper aligned access and accepts void *
arguments, therefore the casts are unnecessary and trigger clang errors.
---
 emulator/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/emulator/smp.c b/emulator/smp.c
index 2b4f9a5..cb7cda0 100644
--- a/emulator/smp.c
+++ b/emulator/smp.c
@@ -248,7 +248,7 @@ static int smp_c1(struct smp_conn *conn, uint8_t rnd[16], uint8_t res[16])
 	baswap((bdaddr_t *) (p2 + 10), (bdaddr_t *) conn->ra);
 
 	/* res = r XOR p1 */
-	u128_xor((u128 *) res, (u128 *) rnd, (u128 *) p1);
+	u128_xor(res, rnd, p1);
 
 	/* res = e(k, res) */
 	err = smp_e(conn->smp->alg_sk, conn->tk, res, res);
@@ -256,7 +256,7 @@ static int smp_c1(struct smp_conn *conn, uint8_t rnd[16], uint8_t res[16])
 		return err;
 
 	/* res = res XOR p2 */
-	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
+	u128_xor(res, res, p2);
 
 	/* res = e(k, res) */
 	return smp_e(conn->smp->alg_sk, conn->tk, res, res);
-- 
1.8.3.2

