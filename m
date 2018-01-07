Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Austin Morton <austinpmorton@gmail.com>
Date: Sun, 7 Jan 2018 16:17:20 -0500
Message-ID: <CAPWKHJSraT_wG9FDtarTXQuWN=1pymf5dMbmwdgz8EQp_JPaMg@mail.gmail.com>
Subject: [PATCH] sbc: fix endian detection on arm-none-eabi
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The gcc-arm-none-eabi toolchain defines its byte order constants with a single
preceding underscore rather than two.
Additionally, the macros do not get defined unless <sys/param.h> is included.

Signed-off-by: Austin Morton <austinpmorton@gmail.com>
---
 sbc/sbc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 606f11c..d3f5948 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -35,6 +35,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <sys/types.h>
+#include <sys/param.h>
 #include <limits.h>

 #include "sbc_math.h"
@@ -70,7 +71,8 @@
 #define A2DP_ALLOCATION_SNR (1 << 1)
 #define A2DP_ALLOCATION_LOUDNESS (1 << 0)

-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if (defined(__BYTE_ORDER) && __BYTE_ORDER == __LITTLE_ENDIAN) || \
+ (defined(_BYTE_ORDER) && _BYTE_ORDER == _LITTLE_ENDIAN)

 struct a2dp_sbc {
  uint8_t channel_mode:4;
@@ -82,7 +84,8 @@ struct a2dp_sbc {
  uint8_t max_bitpool;
 } __attribute__ ((packed));

-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif (defined(__BYTE_ORDER) && __BYTE_ORDER == __BIG_ENDIAN) || \
+ (defined(_BYTE_ORDER) && _BYTE_ORDER == _BIG_ENDIAN)

 struct a2dp_sbc {
  uint8_t frequency:4;
@@ -1024,9 +1027,11 @@ static void sbc_set_defaults(sbc_t *sbc,
unsigned long flags)
  sbc->subbands = SBC_SB_8;
  sbc->blocks = SBC_BLK_16;
  sbc->bitpool = 32;
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if (defined(__BYTE_ORDER) && __BYTE_ORDER == __LITTLE_ENDIAN) || \
+ (defined(_BYTE_ORDER) && _BYTE_ORDER == _LITTLE_ENDIAN)
  sbc->endian = SBC_LE;
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif (defined(__BYTE_ORDER) && __BYTE_ORDER == __BIG_ENDIAN) || \
+ (defined(_BYTE_ORDER) && _BYTE_ORDER == _BIG_ENDIAN)
  sbc->endian = SBC_BE;
 #else
 #error "Unknown byte order"
-- 
2.15.1.windows.2
