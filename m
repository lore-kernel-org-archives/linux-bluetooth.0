Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 49/49] Bluetooth: Fix false-positive "uninitialized" compiler warning
Date: Wed,  3 Dec 2014 17:02:43 +0200
Message-Id: <1417618963-18010-50-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Some gcc versions don't seem to be able to properly track the flow of
the smp_cmd_pairing_random() function and end up causing the following
types of (false-positive) warnings:

 smp.c:1995:6: warning: ‘nb’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
 smp.c:1995:6: warning: ‘na’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
       ^
 smp.c:1995:6: warning: ‘pkbx’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
       ^
 smp.c:1995:6: warning: ‘pkax’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);

This patch fixes the issue by moving the pkax/pkbx and na/nb
initialization earlier in the function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 96e2b329c8ce..53340e8f0b95 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1947,6 +1947,18 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_SC, &smp->flags))
 		return smp_random(smp);
 
+	if (hcon->out) {
+		pkax = smp->local_pk;
+		pkbx = smp->remote_pk;
+		na   = smp->prnd;
+		nb   = smp->rrnd;
+	} else {
+		pkax = smp->remote_pk;
+		pkbx = smp->local_pk;
+		na   = smp->rrnd;
+		nb   = smp->prnd;
+	}
+
 	if (smp->method == REQ_OOB) {
 		if (!hcon->out)
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
@@ -1969,20 +1981,10 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 
 		if (memcmp(smp->pcnf, cfm, 16))
 			return SMP_CONFIRM_FAILED;
-
-		pkax = smp->local_pk;
-		pkbx = smp->remote_pk;
-		na   = smp->prnd;
-		nb   = smp->rrnd;
 	} else {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
-
-		pkax = smp->remote_pk;
-		pkbx = smp->local_pk;
-		na   = smp->rrnd;
-		nb   = smp->prnd;
 	}
 
 mackey_and_ltk:
-- 
2.1.0

