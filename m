Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>
Subject: [PATCH 1/1] shared/ecc: Allow pre-composed Private Keys
Date: Mon, 23 Apr 2018 15:20:08 -0700
Message-Id: <20180423222008.19990-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a non-Zero private_key is passed as input to ecc_make_key(),
the incoming private_key is attempted, before falling back
to an ephemeral key.  We need to be able to use non-ephemeral
keys in Mesh.
---
 src/shared/ecc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/shared/ecc.c b/src/shared/ecc.c
index eb2cc005d..ee592b91b 100644
--- a/src/shared/ecc.c
+++ b/src/shared/ecc.c
@@ -863,8 +863,12 @@ bool ecc_make_key(uint8_t public_key[64], uint8_t private_key[32])
 	unsigned tries = 0;
 
 	do {
-		if (!get_random_number(priv) || (tries++ >= MAX_TRIES))
-			return false;
+		if (tries++ == 0)
+			ecc_bytes2native(private_key, priv);
+		else {
+			if (!get_random_number(priv) || (tries >= MAX_TRIES))
+				return false;
+		}
 
 		if (vli_is_zero(priv))
 			continue;
-- 
2.14.3

