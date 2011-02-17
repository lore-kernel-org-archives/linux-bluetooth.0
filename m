Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Use memcpy for network to host order function on BE hosts
Date: Thu, 17 Feb 2011 15:39:28 -0200
Message-Id: <1297964368-23733-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Harmless change replacing "for" by "memcpy". Note that this change
is inside the block reserved to big endian functions.
---
 lib/sdp.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 3e3a8f8..e782aec 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -62,13 +62,11 @@
 
 #if __BYTE_ORDER == __BIG_ENDIAN
 #define ntoh64(x) (x)
 static inline void ntoh128(const uint128_t *src, uint128_t *dst)
 {
-	int i;
-	for (i = 0; i < 16; i++)
-		dst->data[i] = src->data[i];
+	memcpy(dst, src, sizeof(uint128_t));
 }
 
 static inline void btoh128(const uint128_t *src, uint128_t *dst)
 {
 	int i;
-- 
1.7.4.1

