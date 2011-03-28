Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: paulepanter@users.sourceforge.net,
	Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH] sbc: better compatibility with ARM thumb/thumb2
Date: Tue, 29 Mar 2011 01:57:39 +0300
Message-Id: <1301353059-12776-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

ARM assembly optimizations fail to compile in thumb mode, but are fine
for thumb2. Update ifdefs in the code to make use of ARM assembly only
when it is safe and also make sure that no optimizations are missed
when compiling for thumb2.

The problem was reported by Paul Menzel:
https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-February/009022.html
---
 sbc/sbc_math.h             |    2 +-
 sbc/sbc_primitives_armv6.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sbc/sbc_math.h b/sbc/sbc_math.h
index 9f126c6..5476860 100644
--- a/sbc/sbc_math.h
+++ b/sbc/sbc_math.h
@@ -48,7 +48,7 @@ typedef int32_t sbc_fixed_t;
 
 #define SBC_FIXED_0(val) { val = 0; }
 #define MUL(a, b)        ((a) * (b))
-#ifdef __arm__
+#if defined(__arm__) && (!defined(__thumb__) || defined(__thumb2__))
 #define MULA(a, b, res) ({				\
 		int tmp = res;			\
 		__asm__(				\
diff --git a/sbc/sbc_primitives_armv6.h b/sbc/sbc_primitives_armv6.h
index 1862aed..6a9efe5 100644
--- a/sbc/sbc_primitives_armv6.h
+++ b/sbc/sbc_primitives_armv6.h
@@ -40,8 +40,8 @@
 
 #if !defined(SBC_HIGH_PRECISION) && (SCALE_OUT_BITS == 15) && \
 	defined(__GNUC__) && defined(SBC_HAVE_ARMV6) && \
-	defined(__ARM_EABI__) && !defined(__thumb__) && \
-	!defined(__ARM_NEON__)
+	defined(__ARM_EABI__) && !defined(__ARM_NEON__) && \
+	(!defined(__thumb__) || defined(__thumb2__))
 
 #define SBC_BUILD_WITH_ARMV6_SUPPORT
 
-- 
1.7.3.4

