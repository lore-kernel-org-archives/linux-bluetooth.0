Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 26/49] Bluetooth: Add check for accidentally generating a debug key
Date: Wed,  3 Dec 2014 17:02:20 +0200
Message-Id: <1417618963-18010-27-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It is very unlikely, but to have a 100% guarantee of the generated key
type we need to reject any keys which happen to match the debug key.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 74b0489fea4f..13fbe05d33cb 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1399,9 +1399,17 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 {
 	BT_DBG("");
 
-	/* Generate local key pair for Secure Connections */
-	if (!ecc_make_key(smp->local_pk, smp->local_sk))
-		return SMP_UNSPECIFIED;
+	while (true) {
+		/* Generate local key pair for Secure Connections */
+		if (!ecc_make_key(smp->local_pk, smp->local_sk))
+			return SMP_UNSPECIFIED;
+
+		/* This is unlikely, but we need to check that we didn't
+		 * accidentially generate a debug key.
+		 */
+		if (memcmp(smp->local_sk, debug_sk, 32))
+			break;
+	}
 
 	BT_DBG("Local Public Key X: %32phN", smp->local_pk);
 	BT_DBG("Local Public Key Y: %32phN", &smp->local_pk[32]);
-- 
2.1.0

