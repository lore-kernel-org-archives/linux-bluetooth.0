Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: Fix const declarations for smp_f5 and smp_f6
Date: Mon, 29 Dec 2014 12:04:10 +0200
Message-Id: <1419847454-574-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1419847454-574-1-git-send-email-johan.hedberg@gmail.com>
References: <1419847454-574-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

These SMP crypto functions should have all their input parameters
declared as const. This patch fixes the parameters that were missing the
const declaration.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b67749bb55bf..9025e177d278 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -223,8 +223,9 @@ static int smp_f4(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
 	return err;
 }
 
-static int smp_f5(struct crypto_hash *tfm_cmac, u8 w[32], u8 n1[16], u8 n2[16],
-		  u8 a1[7], u8 a2[7], u8 mackey[16], u8 ltk[16])
+static int smp_f5(struct crypto_hash *tfm_cmac, const u8 w[32],
+		  const u8 n1[16], const u8 n2[16], const u8 a1[7],
+		  const u8 a2[7], u8 mackey[16], u8 ltk[16])
 {
 	/* The btle, salt and length "magic" values are as defined in
 	 * the SMP section of the Bluetooth core specification. In ASCII
@@ -276,7 +277,7 @@ static int smp_f5(struct crypto_hash *tfm_cmac, u8 w[32], u8 n1[16], u8 n2[16],
 }
 
 static int smp_f6(struct crypto_hash *tfm_cmac, const u8 w[16],
-		  const u8 n1[16], u8 n2[16], const u8 r[16],
+		  const u8 n1[16], const u8 n2[16], const u8 r[16],
 		  const u8 io_cap[3], const u8 a1[7], const u8 a2[7],
 		  u8 res[16])
 {
-- 
2.1.0

