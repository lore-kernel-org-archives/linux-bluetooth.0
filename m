Return-Path: <andreas@kemnade.info>
From: Andreas Kemnade <andreas@kemnade.info>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC] bluetooth: fix paring problems with 0cf3:0036 and certain devices
Date: Thu, 14 Jun 2018 21:33:30 +0200
Message-Id: <20180614193330.28410-1-andreas@kemnade.info>
List-ID: <linux-bluetooth.vger.kernel.org>

This is clearly a RFC patch, things should be fixed in a cleaner way.
With the bluetooth usb adapter 0cf3:0036 (Atheros), there are pairing
problems in combination with certain remove devices. The cause is that
smp_resume_cb() gets called after SMP_CMD_IDENT_INFO arrives in the end 
of a SC pairing with numerical comparison. so that there are unexpected
packet messages in dmesg and although an ltk is known, bluetoothd
considers the device as unpaired and not even the ltk is not stored.

The patch makes the smp code be more tolerant with the order but that
does not feel like a safe thing to do.
Maybe the pairing result should be given back to userspace without the
irk related stuff.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 net/bluetooth/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a2ddae2f37d7..8023b6e6342f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1012,6 +1012,7 @@ static u8 smp_random(struct smp_chan *smp)
 			return SMP_UNSPECIFIED;
 
 		hci_le_start_enc(hcon, ediv, rand, stk, smp->enc_key_size);
+		smp_distribute_keys(smp);
 		hcon->enc_key_size = smp->enc_key_size;
 		set_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags);
 	} else {
@@ -2837,6 +2838,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	if (hcon->out) {
 		hci_le_start_enc(hcon, 0, 0, smp->tk, smp->enc_key_size);
+		smp_distribute_keys(smp);
 		hcon->enc_key_size = smp->enc_key_size;
 	}
 
@@ -3067,7 +3069,6 @@ static void smp_resume_cb(struct l2cap_chan *chan)
 
 	cancel_delayed_work(&smp->security_timer);
 
-	smp_distribute_keys(smp);
 }
 
 static void smp_ready_cb(struct l2cap_chan *chan)
-- 
2.11.0
