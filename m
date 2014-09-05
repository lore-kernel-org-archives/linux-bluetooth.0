Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 6/8] Bluetooth: Add define for key distribution mask
Date: Fri,  5 Sep 2014 22:19:53 +0300
Message-Id: <1409944795-21916-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1409944795-21916-1-git-send-email-johan.hedberg@gmail.com>
References: <1409944795-21916-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a define for the allowed bits of the key distribution
mask so we don't have to have magic 0x07 constants throughout the code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index c71589f4b435..5003d224c4b6 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -34,6 +34,7 @@
 #define SMP_TIMEOUT	msecs_to_jiffies(30000)
 
 #define AUTH_REQ_MASK   0x07
+#define KEY_DIST_MASK	0x07
 
 enum {
 	SMP_FLAG_TK_VALID,
@@ -703,7 +704,7 @@ static void smp_distribute_keys(struct smp_chan *smp)
 	rsp = (void *) &smp->prsp[1];
 
 	/* The responder sends its keys first */
-	if (hcon->out && (smp->remote_key_dist & 0x07))
+	if (hcon->out && (smp->remote_key_dist & KEY_DIST_MASK))
 		return;
 
 	req = (void *) &smp->preq[1];
@@ -789,7 +790,7 @@ static void smp_distribute_keys(struct smp_chan *smp)
 	}
 
 	/* If there are still keys to be received wait for them */
-	if ((smp->remote_key_dist & 0x07))
+	if (smp->remote_key_dist & KEY_DIST_MASK)
 		return;
 
 	set_bit(SMP_FLAG_COMPLETE, &smp->flags);
-- 
1.9.3

