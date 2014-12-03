Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 25/49] Bluetooth: Detect SMP SC debug keys
Date: Wed,  3 Dec 2014 17:02:19 +0200
Message-Id: <1417618963-18010-26-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need to be able to detect if the remote side used a debug key for the
pairing. This patch adds the debug key defines and sets a flag to
indicate that a debug key was used. The debug private key (debug_sk) is
also added in this patch but will only be used in a subsequent patch
when local debug key support is implemented.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8753d8120850..74b0489fea4f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -54,6 +54,7 @@ enum {
 	SMP_FLAG_INITIATOR,
 	SMP_FLAG_SC,
 	SMP_FLAG_REMOTE_PK,
+	SMP_FLAG_DEBUG_KEY,
 };
 
 struct smp_chan {
@@ -92,6 +93,29 @@ struct smp_chan {
 	struct crypto_hash	*tfm_cmac;
 };
 
+/* These debug key values are defined in the SMP section of the core
+ * specification. debug_pk is the public debug key and debug_sk the
+ * private debug key.
+ */
+static const u8 debug_pk[64] = {
+		0xe6, 0x9d, 0x35, 0x0e, 0x48, 0x01, 0x03, 0xcc,
+		0xdb, 0xfd, 0xf4, 0xac, 0x11, 0x91, 0xf4, 0xef,
+		0xb9, 0xa5, 0xf9, 0xe9, 0xa7, 0x83, 0x2c, 0x5e,
+		0x2c, 0xbe, 0x97, 0xf2, 0xd2, 0x03, 0xb0, 0x20,
+
+		0x8b, 0xd2, 0x89, 0x15, 0xd0, 0x8e, 0x1c, 0x74,
+		0x24, 0x30, 0xed, 0x8f, 0xc2, 0x45, 0x63, 0x76,
+		0x5c, 0x15, 0x52, 0x5a, 0xbf, 0x9a, 0x32, 0x63,
+		0x6d, 0xeb, 0x2a, 0x65, 0x49, 0x9c, 0x80, 0xdc,
+};
+
+static const u8 debug_sk[32] = {
+		0xbd, 0x1a, 0x3c, 0xcd, 0xa6, 0xb8, 0x99, 0x58,
+		0x99, 0xb7, 0x40, 0xeb, 0x7b, 0x60, 0xff, 0x4a,
+		0x50, 0x3f, 0x10, 0xd2, 0xe3, 0xb3, 0xc9, 0x74,
+		0x38, 0x5f, 0xc5, 0xa3, 0xd4, 0xf6, 0x49, 0x3f,
+};
+
 static inline void swap_buf(const u8 *src, u8 *dst, size_t len)
 {
 	size_t i;
@@ -2000,6 +2024,9 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	else
 		hcon->pending_sec_level = BT_SECURITY_FIPS;
 
+	if (!memcmp(debug_pk, smp->remote_pk, 64))
+		set_bit(SMP_FLAG_DEBUG_KEY, &smp->flags);
+
 	/* The Initiating device waits for the non-initiating device to
 	 * send the confirm value.
 	 */
-- 
2.1.0

