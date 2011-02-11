Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Fix wrong parameter order for memcpy in btoh128 function
Date: Fri, 11 Feb 2011 15:51:38 -0200
Message-Id: <1297446699-17349-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 8a31b55..d5b99d4 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -96,7 +96,7 @@ static inline void ntoh128(uint128_t *src, uint128_t *dst)
 
 static inline void btoh128(uint128_t *src, uint128_t *dst)
 {
-	memcpy(src, dst, sizeof(uint128_t));
+	memcpy(dst, src, sizeof(uint128_t));
 }
 
 #endif
-- 
1.7.4

