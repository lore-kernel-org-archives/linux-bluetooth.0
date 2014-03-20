Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 46/62] attrib: Remove att_get_u8()
Date: Thu, 20 Mar 2014 11:43:11 -0300
Message-Id: <1395326607-27068-47-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 28bc944..645b6cf 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -112,12 +112,6 @@ struct att_range {
 };
 
 /* These functions do byte conversion */
-static inline uint8_t att_get_u8(const void *ptr)
-{
-	const uint8_t *u8_ptr = ptr;
-	return bt_get_unaligned(u8_ptr);
-}
-
 static inline uint16_t att_get_u16(const void *ptr)
 {
 	const uint16_t *u16_ptr = ptr;
-- 
1.8.3.1

