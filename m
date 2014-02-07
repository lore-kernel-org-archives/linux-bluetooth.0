Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btsnoop: Remove unused local function and macro
Date: Fri,  7 Feb 2014 19:27:59 -0300
Message-Id: <1391812080-19529-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391812080-19529-1-git-send-email-andre.guedes@openbossa.org>
References: <1391812080-19529-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btsnoop.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index a65d8c5..260dfdb 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -40,19 +40,6 @@
 
 #include "monitor/btsnoop.h"
 
-static inline uint64_t ntoh64(uint64_t n)
-{
-	uint64_t h;
-	uint64_t tmp = ntohl(n & 0x00000000ffffffff);
-
-	h = ntohl(n >> 32);
-	h |= tmp << 32;
-
-	return h;
-}
-
-#define hton64(x)     ntoh64(x)
-
 struct btsnoop_hdr {
 	uint8_t		id[8];		/* Identification Pattern */
 	uint32_t	version;	/* Version Number = 1 */
-- 
1.8.5.3

