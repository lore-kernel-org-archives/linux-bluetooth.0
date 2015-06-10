Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix exposing full value of shortened LTKs
Date: Wed, 10 Jun 2015 11:11:20 +0300
Message-Id: <1433923880-16430-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we notify user space of a new LTK or distribute an LTK to the
remote peer the value passed should be the shortened version so that
it's easy to compare values in various traces. The core spec also sets
the requirements for the shortening/masking as:

"The masking shall be done after generation and before being
distributed, used or stored."

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 7 ++++++-
 net/bluetooth/smp.c  | 9 ++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a6f21f8c2f98..e41bbe28a36e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7603,7 +7603,12 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 	if (key->type == SMP_LTK)
 		ev.key.master = 1;
 
-	memcpy(ev.key.val, key->val, sizeof(key->val));
+	/* Make sure we copy only the significant bytes based on the
+	 * encryption key size, and set the rest of the value to zeroes.
+	 */
+	memcpy(ev.key.val, key->val, sizeof(key->enc_size));
+	memset(ev.key.val + key->enc_size, 0,
+	       sizeof(ev.key.val) - key->enc_size);
 
 	mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev), NULL);
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3921cba056d3..4bfaa3d3ed28 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1271,7 +1271,14 @@ static void smp_distribute_keys(struct smp_chan *smp)
 		__le16 ediv;
 		__le64 rand;
 
-		get_random_bytes(enc.ltk, sizeof(enc.ltk));
+		/* Make sure we generate only the significant amount of
+		 * bytes based on the encryption key size, and set the rest
+		 * of the value to zeroes.
+		 */
+		get_random_bytes(enc.ltk, smp->enc_key_size);
+		memset(enc.ltk + smp->enc_key_size, 0,
+		       sizeof(enc.ltk) - smp->enc_key_size);
+
 		get_random_bytes(&ediv, sizeof(ediv));
 		get_random_bytes(&rand, sizeof(rand));
 
-- 
2.4.2

