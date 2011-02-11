Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] Add const modifier to avoid wrong usage of byte order functions
Date: Fri, 11 Feb 2011 15:51:39 -0200
Message-Id: <1297446699-17349-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1297446699-17349-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1297446699-17349-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index d5b99d4..3e3a8f8 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -62,14 +62,14 @@
 
 #if __BYTE_ORDER == __BIG_ENDIAN
 #define ntoh64(x) (x)
-static inline void ntoh128(uint128_t *src, uint128_t *dst)
+static inline void ntoh128(const uint128_t *src, uint128_t *dst)
 {
 	int i;
 	for (i = 0; i < 16; i++)
 		dst->data[i] = src->data[i];
 }
 
-static inline void btoh128(uint128_t *src, uint128_t *dst)
+static inline void btoh128(const uint128_t *src, uint128_t *dst)
 {
 	int i;
 	for (i = 0; i < 16; i++)
@@ -87,14 +87,14 @@ static inline uint64_t ntoh64(uint64_t n)
 	return h;
 }
 
-static inline void ntoh128(uint128_t *src, uint128_t *dst)
+static inline void ntoh128(const uint128_t *src, uint128_t *dst)
 {
 	int i;
 	for (i = 0; i < 16; i++)
 		dst->data[15 - i] = src->data[i];
 }
 
-static inline void btoh128(uint128_t *src, uint128_t *dst)
+static inline void btoh128(const uint128_t *src, uint128_t *dst)
 {
 	memcpy(dst, src, sizeof(uint128_t));
 }
-- 
1.7.4

