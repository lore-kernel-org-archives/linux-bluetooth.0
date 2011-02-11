Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC 2/7] Use memcpy to convert from network to host order on BE hosts
Date: Fri, 11 Feb 2011 18:37:01 -0200
Message-Id: <1297456626-22837-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1297456626-22837-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1297456626-22837-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index bc020ad..d8f36f8 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -127,9 +127,7 @@ static inline void btoh128(const uint128_t *src, uint128_t *dst)
 #define ntoh64(x) (x)
 static inline void ntoh128(const uint128_t *src, uint128_t *dst)
 {
-	int i;
-	for (i = 0; i < 16; i++)
-		dst->data[i] = src->data[i];
+	memcpy(dst, src, sizeof(uint128_t));
 }
 
 static inline void btoh128(const uint128_t *src, uint128_t *dst)
-- 
1.7.4

