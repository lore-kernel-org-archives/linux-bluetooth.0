Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 06/12] tools: Fix unaligned memory access on smp-tester
Date: Fri,  3 Jan 2014 21:55:22 -0400
Message-Id: <1388800528-10699-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes clang errors like:

tools/smp-tester.c:263:11: error: cast from 'uint8_t *' (aka 'unsigned
char *') to 'u128 *' increases required alignment from 1 to 8
[-Werror,-Wcast-align]
---
 tools/smp-tester.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index 685d379..20429a9 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -233,10 +233,16 @@ typedef struct {
 	uint64_t a, b;
 } u128;
 
-static inline void u128_xor(u128 *r, const u128 *p, const u128 *q)
+static inline void u128_xor(void *r, const void *p, const void *q)
 {
-	r->a = p->a ^ q->a;
-	r->b = p->b ^ q->b;
+	const u128 pp = bt_get_unaligned((const u128 *) p);
+	const u128 qq = bt_get_unaligned((const u128 *) q);
+	u128 rr;
+
+	rr.a = pp.a ^ qq.a;
+	rr.b = pp.b ^ qq.b;
+
+	bt_put_unaligned(rr, (u128 *) r);
 }
 
 static int smp_c1(uint8_t r[16], uint8_t res[16])
@@ -260,7 +266,7 @@ static int smp_c1(uint8_t r[16], uint8_t res[16])
 	baswap((bdaddr_t *) (p2 + 10), (bdaddr_t *) data->ra);
 
 	/* res = r XOR p1 */
-	u128_xor((u128 *) res, (u128 *) r, (u128 *) p1);
+	u128_xor(res, r, p1);
 
 	/* res = e(k, res) */
 	err = smp_e(data->smp_tk, res, res);
@@ -268,7 +274,7 @@ static int smp_c1(uint8_t r[16], uint8_t res[16])
 		return err;
 
 	/* res = res XOR p2 */
-	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
+	u128_xor(res, res, p2);
 
 	/* res = e(k, res) */
 	return smp_e(data->smp_tk, res, res);
-- 
1.8.3.2

