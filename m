Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH] sbc: added "cc" to the clobber list of mmx inline assembly
Date: Thu, 11 Nov 2010 11:29:42 +0200
Message-Id: <1289467782-2472-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

In the case of scale factors calculation optimizations, the inline
assembly code has instructions which update flags register, but
"cc" was not mentioned in the clobber list. When optimizing code,
gcc theoretically is allowed to do a comparison before the inline
assembly block, and a conditional branch after it which would lead
to a problem if the flags register gets clobbered. While this is
apparently not happening in practice with the current versions of
gcc, the clobber list needs to be corrected.

Regarding the other inline assembly blocks. While most likely it
is actually unnecessary based on quick review, "cc" is also added
there to the clobber list because it should have no impact on
performance in practice. It's kind of cargo cult, but relieves
us from the need to track the potential updates of flags register
in all these places.
---
 sbc/sbc_primitives_mmx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index 45c62ac..7f2fbc3 100644
--- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -101,7 +101,7 @@ static inline void sbc_analyze_four_mmx(const int16_t *in, int32_t *out,
 		:
 		: "r" (in), "r" (consts), "r" (&round_c), "r" (out),
 			"i" (SBC_PROTO_FIXED4_SCALE)
-		: "memory");
+		: "cc", "memory");
 }
 
 static inline void sbc_analyze_eight_mmx(const int16_t *in, int32_t *out,
@@ -243,7 +243,7 @@ static inline void sbc_analyze_eight_mmx(const int16_t *in, int32_t *out,
 		:
 		: "r" (in), "r" (consts), "r" (&round_c), "r" (out),
 			"i" (SBC_PROTO_FIXED8_SCALE)
-		: "memory");
+		: "cc", "memory");
 }
 
 static inline void sbc_analyze_4b_4s_mmx(int16_t *x, int32_t *out,
@@ -323,7 +323,7 @@ static void sbc_calc_scalefactors_mmx(
 				"r" (&scale_factor[ch][sb]),
 				"r" (&consts),
 				"i" (SCALE_OUT_BITS)
-			: "memory");
+			: "cc", "memory");
 		}
 	}
 	asm volatile ("emms\n");
-- 
1.7.2.2

