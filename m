Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't send public key if OOB data verification fails
Date: Mon, 16 Mar 2015 18:12:57 +0200
Message-Id: <1426522377-31485-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we receive the remote public key, if we have remote OOB data
there's no point in sending our public key to the remote if the OOB data
doesn't match. This patch moves the test for this higher up in the
smp_cmd_public_key() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index de53ba1905fe..82824213d0fb 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2515,6 +2515,16 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	memcpy(smp->remote_pk, key, 64);
 
+	if (test_bit(SMP_FLAG_REMOTE_OOB, &smp->flags)) {
+		err = smp_f4(smp->tfm_cmac, smp->remote_pk, smp->remote_pk,
+			     smp->rr, 0, cfm.confirm_val);
+		if (err)
+			return SMP_UNSPECIFIED;
+
+		if (memcmp(cfm.confirm_val, smp->pcnf, 16))
+			return SMP_CONFIRM_FAILED;
+	}
+
 	/* Non-initiating device sends its public key after receiving
 	 * the key from the initiating device.
 	 */
@@ -2562,16 +2572,6 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 		return sc_passkey_round(smp, SMP_CMD_PUBLIC_KEY);
 	}
 
-	if (test_bit(SMP_FLAG_REMOTE_OOB, &smp->flags)) {
-		err = smp_f4(smp->tfm_cmac, smp->remote_pk, smp->remote_pk,
-			     smp->rr, 0, cfm.confirm_val);
-		if (err)
-			return SMP_UNSPECIFIED;
-
-		if (memcmp(cfm.confirm_val, smp->pcnf, 16))
-			return SMP_CONFIRM_FAILED;
-	}
-
 	if (smp->method == REQ_OOB) {
 		if (hcon->out)
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
-- 
2.1.0

