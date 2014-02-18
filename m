Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] Bluetooth: Fix minor whitespace issues in SMP code
Date: Tue, 18 Feb 2014 10:19:30 +0200
Message-Id: <1392711577-31431-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
References: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes a couple of unnecessary empty lines in the SMP code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 1 -
 net/bluetooth/smp.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1730bb2b6259..ae487e17380e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -990,7 +990,6 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		*keydist &= req->resp_key_dist;
 	}
 
-
 	BT_DBG("keydist 0x%x", *keydist);
 
 	if (*keydist & SMP_DIST_ENC_KEY) {
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index a700bcb490d7..777ee93a6c9b 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -132,7 +132,6 @@ struct smp_chan {
 	struct crypto_blkcipher	*tfm;
 	struct work_struct confirm;
 	struct work_struct random;
-
 };
 
 /* SMP Commands */
-- 
1.8.5.3

