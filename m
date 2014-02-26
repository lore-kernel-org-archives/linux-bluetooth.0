Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Re-encrypt link after receiving an LTK
Date: Wed, 26 Feb 2014 23:33:46 +0200
Message-Id: <1393450427-12438-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393450427-12438-1-git-send-email-johan.hedberg@gmail.com>
References: <1393450427-12438-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It's not strictly speaking required to re-encrypt a link once we receive
an LTK since the connection is already encrypted with the STK. However,
re-encrypting with the LTK allows us to verify that we've received an
LTK that actually works.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0de98fe23330..52708f79545f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1268,6 +1268,13 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 	set_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
 	smp_notify_keys(conn);
 
+	/* Re-encrypt the link with LTK */
+	if (smp->ltk) {
+		struct smp_ltk *ltk = smp->ltk;
+		hci_le_start_enc(hcon, ltk->ediv, ltk->rand, ltk->val);
+		hcon->enc_key_size = ltk->enc_size;
+	}
+
 	smp_chan_destroy(conn);
 
 	return 0;
-- 
1.8.5.3

