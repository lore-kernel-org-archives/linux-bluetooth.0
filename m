Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 33/49] Bluetooth: Use debug keys for SMP when HCI_USE_DEBUG_KEYS is set
Date: Wed,  3 Dec 2014 17:02:27 +0200
Message-Id: <1417618963-18010-34-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The HCI_USE_DEBUG_KEYS flag is intended to force our side to always use
debug keys for pairing. This means both BR/EDR SSP as well as SMP with
LE Secure Connections. This patch updates the SMP code to use the debug
keys instead of generating a random local key pair when the flag is set.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 16bd15e04b85..3aad5864a5e1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1585,18 +1585,27 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 sc_send_public_key(struct smp_chan *smp)
 {
+	struct hci_dev *hdev = smp->conn->hcon->hdev;
+
 	BT_DBG("");
 
-	while (true) {
-		/* Generate local key pair for Secure Connections */
-		if (!ecc_make_key(smp->local_pk, smp->local_sk))
-			return SMP_UNSPECIFIED;
+	if (test_bit(HCI_USE_DEBUG_KEYS, &hdev->dev_flags)) {
+		BT_DBG("Using debug keys");
+		memcpy(smp->local_pk, debug_pk, 64);
+		memcpy(smp->local_sk, debug_sk, 32);
+		set_bit(SMP_FLAG_DEBUG_KEY, &smp->flags);
+	} else {
+		while (true) {
+			/* Generate local key pair for Secure Connections */
+			if (!ecc_make_key(smp->local_pk, smp->local_sk))
+				return SMP_UNSPECIFIED;
 
-		/* This is unlikely, but we need to check that we didn't
-		 * accidentially generate a debug key.
-		 */
-		if (memcmp(smp->local_sk, debug_sk, 32))
-			break;
+			/* This is unlikely, but we need to check that
+			 * we didn't accidentially generate a debug key.
+			 */
+			if (memcmp(smp->local_sk, debug_sk, 32))
+				break;
+		}
 	}
 
 	BT_DBG("Local Public Key X: %32phN", smp->local_pk);
-- 
2.1.0

