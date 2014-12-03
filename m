Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 48/49] Bluetooth: Fix minor coding style issue in smp.c
Date: Wed,  3 Dec 2014 17:02:42 +0200
Message-Id: <1417618963-18010-49-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The convention for checking for NULL pointers is !ptr and not
ptr == NULL. This patch fixes such an occurrence in smp.c.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index aeae4bed7ded..96e2b329c8ce 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -356,7 +356,7 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 	uint8_t tmp[16], data[16];
 	int err;
 
-	if (tfm == NULL) {
+	if (!tfm) {
 		BT_ERR("tfm %p", tfm);
 		return -EINVAL;
 	}
-- 
2.1.0

