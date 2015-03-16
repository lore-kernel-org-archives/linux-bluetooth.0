Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Fix verifying confirm value when lacking remote OOB data
Date: Mon, 16 Mar 2015 11:45:46 +0200
Message-Id: <1426499146-11959-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com>
References: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we haven't received remote OOB data we cannot perform any special
checks on the confirm value. This patch updates the check after having
received the public key to only perform the verification if we have
remote OOB data present.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b8a6ce840603..de53ba1905fe 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2562,7 +2562,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 		return sc_passkey_round(smp, SMP_CMD_PUBLIC_KEY);
 	}
 
-	if (smp->method == REQ_OOB) {
+	if (test_bit(SMP_FLAG_REMOTE_OOB, &smp->flags)) {
 		err = smp_f4(smp->tfm_cmac, smp->remote_pk, smp->remote_pk,
 			     smp->rr, 0, cfm.confirm_val);
 		if (err)
@@ -2570,7 +2570,9 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 
 		if (memcmp(cfm.confirm_val, smp->pcnf, 16))
 			return SMP_CONFIRM_FAILED;
+	}
 
+	if (smp->method == REQ_OOB) {
 		if (hcon->out)
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
-- 
2.1.0

