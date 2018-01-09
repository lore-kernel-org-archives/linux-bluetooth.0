Return-Path: <austinpmorton@gmail.com>
MIME-Version: 1.0
From: Austin Morton <austinpmorton@gmail.com>
Date: Tue, 9 Jan 2018 10:59:23 -0500
Message-ID: <CAPWKHJQhmP=0TS4AUt37PaympD=vbZgGMbcuygWFghhdpC1npw@mail.gmail.com>
Subject: [PATCH v2] sbc: improve compatibility with ARM Cortex-M
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Specifically test the compiler for the feature required to use the
smuad/smlad instructions when determining if we can build with ARMV6
primitive support rather than guessing based on thumb version.
__ARM_FEATURE_SIMD32 is defined in section 9.5.1 of the "ARM C
Language Extensions 2.1" specification published by ARM.
---
 sbc/sbc_primitives_armv6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sbc/sbc_primitives_armv6.h b/sbc/sbc_primitives_armv6.h
index 6a9efe5..4a9b53d 100644
--- a/sbc/sbc_primitives_armv6.h
+++ b/sbc/sbc_primitives_armv6.h
@@ -41,7 +41,7 @@
 #if !defined(SBC_HIGH_PRECISION) && (SCALE_OUT_BITS == 15) && \
  defined(__GNUC__) && defined(SBC_HAVE_ARMV6) && \
  defined(__ARM_EABI__) && !defined(__ARM_NEON__) && \
- (!defined(__thumb__) || defined(__thumb2__))
+ defined(__ARM_FEATURE_SIMD32)

 #define SBC_BUILD_WITH_ARMV6_SUPPORT

-- 
2.15.1.windows.2
