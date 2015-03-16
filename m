Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Fix local OOB data handling for SMP
Date: Mon, 16 Mar 2015 11:45:43 +0200
Message-Id: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need to store the local ra/rb value in order to verify the Check
value received from the remote. This patch adds a new 'lr' for the local
ra/rb value and makes sure it gets used when verifying the DHKey Check
PDU received from the remote.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f0c5c2827372..1cc15de6ff1e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -95,7 +95,8 @@ struct smp_chan {
 	u8		rrnd[16]; /* SMP Pairing Random (remote) */
 	u8		pcnf[16]; /* SMP Pairing Confirm */
 	u8		tk[16]; /* SMP Temporary Key */
-	u8		rr[16];
+	u8		rr[16]; /* Remote OOB ra/rb value */
+	u8		lr[16]; /* Local OOB ra/rb value */
 	u8		enc_key_size;
 	u8		remote_key_dist;
 	bdaddr_t	id_addr;
@@ -1830,7 +1831,7 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 
 		memcpy(smp->local_pk, smp_dev->local_pk, 64);
 		memcpy(smp->local_sk, smp_dev->local_sk, 32);
-		memcpy(smp->rr, smp_dev->local_rr, 16);
+		memcpy(smp->lr, smp_dev->local_rr, 16);
 
 		if (smp_dev->debug_key)
 			set_bit(SMP_FLAG_DEBUG_KEY, &smp->flags);
@@ -2634,6 +2635,8 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		put_unaligned_le32(hcon->passkey_notify, r);
+	else if (smp->method == REQ_OOB)
+		memcpy(r, smp->lr, 16);
 
 	err = smp_f6(smp->tfm_cmac, smp->mackey, smp->rrnd, smp->prnd, r,
 		     io_cap, remote_addr, local_addr, e);
-- 
2.1.0

