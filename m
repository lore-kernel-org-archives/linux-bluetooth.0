Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 0/1] shared/ecc: Make ecc_make_key() a stand alone API
Date: Mon,  7 May 2018 15:35:24 -0700
Message-Id: <20180507223524.32070-2-brian.gix@intel.com>
In-Reply-To: <20180507223524.32070-1-brian.gix@intel.com>
References: <20180507223524.32070-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

And correct minor flaws in API descriptions
---
 src/shared/ecc.c | 25 +++++++++++++++++--------
 src/shared/ecc.h |  4 +++-
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/src/shared/ecc.c b/src/shared/ecc.c
index 15f6b8a93..1c1c3446a 100644
--- a/src/shared/ecc.c
+++ b/src/shared/ecc.c
@@ -883,20 +883,29 @@ bool ecc_make_public_key(const uint8_t private_key[32], uint8_t public_key[64])
 
 bool ecc_make_key(uint8_t public_key[64], uint8_t private_key[32])
 {
+	struct ecc_point pk;
 	uint64_t priv[NUM_ECC_DIGITS];
-	unsigned int tries = 0;
-	bool result = false;
+	unsigned tries = 0;
+
+	do {
+		if (!get_random_number(priv) || (tries++ >= MAX_TRIES))
+			return false;
 
-	for (tries = 0; !result && tries < MAX_TRIES; tries++) {
-		if (!get_random_number(priv))
+		if (vli_is_zero(priv))
 			continue;
 
-		ecc_native2bytes(priv, private_key);
+		/* Make sure the private key is in the range [1, n-1]. */
+		if (vli_cmp(curve_n, priv) != 1)
+			continue;
 
-		result = ecc_make_public_key(private_key, public_key);
-	}
+		ecc_point_mult(&pk, &curve_g, priv, NULL, vli_num_bits(priv));
+	} while (ecc_point_is_zero(&pk));
 
-	return result;
+	ecc_native2bytes(priv, private_key);
+	ecc_native2bytes(pk.x, public_key);
+	ecc_native2bytes(pk.y, &public_key[32]);
+
+	return true;
 }
 
 bool ecc_valid_public_key(const uint8_t public_key[64])
diff --git a/src/shared/ecc.h b/src/shared/ecc.h
index a88e735c7..8c15e4ee8 100644
--- a/src/shared/ecc.h
+++ b/src/shared/ecc.h
@@ -28,9 +28,11 @@
 #include <stdint.h>
 
 /* Create a public key from a private key.
+ *
+ * Inputs:
+ *	private_key - Your private key.
  *
  * Outputs:
- *	private_key - Const private key
  *	public_key  - Will be filled in with the public key.
  *
  * Returns true if the public key was generated successfully, false
-- 
2.14.3

