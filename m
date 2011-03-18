Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Fix compilation against latest BlueZ
Date: Fri, 18 Mar 2011 15:10:19 -0400
Message-Id: <1300475419-7009-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BlueZ now has ntoh64()/hton64() functions in bluetooth.h, therefore the
hcidump local copy is not necessary.
---
 src/hcidump.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/src/hcidump.c b/src/hcidump.c
index af086c7..2023130 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -50,22 +50,6 @@
 #include "parser/parser.h"
 #include "parser/sdp.h"
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-static inline uint64_t ntoh64(uint64_t n)
-{
-	uint64_t h;
-	uint64_t tmp = ntohl(n & 0x00000000ffffffff);
-	h = ntohl(n >> 32);
-	h |= tmp << 32;
-	return h;
-}
-#elif __BYTE_ORDER == __BIG_ENDIAN
-#define ntoh64(x) (x)
-#else
-#error "Unknown byte order"
-#endif
-#define hton64(x) ntoh64(x)
-
 #define SNAP_LEN 	HCI_MAX_FRAME_SIZE
 #define DEFAULT_PORT	"10839";
 
-- 
1.7.0.4

