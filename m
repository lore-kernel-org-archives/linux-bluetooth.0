Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 53/62] attrib: Remove att_get_u128()
Date: Thu, 20 Mar 2014 11:43:18 -0300
Message-Id: <1395326607-27068-54-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 0b98df3..670f51a 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -112,16 +112,6 @@ struct att_range {
 };
 
 /* These functions do byte conversion */
-static inline uint128_t att_get_u128(const void *ptr)
-{
-	const uint128_t *u128_ptr = ptr;
-	uint128_t dst;
-
-	btoh128(u128_ptr, &dst);
-
-	return dst;
-}
-
 static inline void att_put_u16(uint16_t src, void *dst)
 {
 	bt_put_unaligned(htobs(src), (uint16_t *) dst);
-- 
1.8.3.1

