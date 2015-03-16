Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/8] Bluetooth: Use OOB key pair for LE SC pairing with OOB method
Date: Mon, 16 Mar 2015 01:10:24 -0700
Message-Id: <1426493425-7427-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The OOB public and secret key pair is different from the non-OOB pairing
procedure. SO when OOB method is in use, then use this key pair instead
of generating a new one.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1669e7127e2e..0fcd8c8f1a6b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1819,6 +1819,25 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 
 	BT_DBG("");
 
+	if (test_bit(SMP_FLAG_OOB, &smp->flags)) {
+		struct l2cap_chan *chan = hdev->smp_data;
+		struct smp_dev *smp_dev;
+
+		if (!chan || !chan->data)
+			return SMP_UNSPECIFIED;
+
+		smp_dev = chan->data;
+
+		memcpy(smp->local_pk, smp_dev->local_pk, 64);
+		memcpy(smp->local_sk, smp_dev->local_sk, 32);
+		memcpy(smp->rr, smp_dev->local_rr, 16);
+
+		if (smp_dev->debug_key)
+			set_bit(SMP_FLAG_DEBUG_KEY, &smp->flags);
+
+		goto done;
+	}
+
 	if (hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS)) {
 		BT_DBG("Using debug keys");
 		memcpy(smp->local_pk, debug_pk, 64);
@@ -1838,6 +1857,7 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 		}
 	}
 
+done:
 	SMP_DBG("Local Public Key X: %32phN", smp->local_pk);
 	SMP_DBG("Local Public Key Y: %32phN", &smp->local_pk[32]);
 	SMP_DBG("Local Private Key:  %32phN", smp->local_sk);
-- 
2.1.0

