Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Fix parameter type in att_put_u32
Date: Thu,  3 Feb 2011 11:37:02 -0200
Message-Id: <1296740222-27174-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 1caa62a..7e81dc4 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -180,7 +180,7 @@ static inline void att_put_u16(uint16_t src, void *dst)
 	bt_put_unaligned(htobs(src), (uint16_t *) dst);
 }
 
-static inline void att_put_u32(uint16_t src, void *dst)
+static inline void att_put_u32(uint32_t src, void *dst)
 {
 	bt_put_unaligned(htobl(src), (uint32_t *) dst);
 }
-- 
1.7.1

