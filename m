Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 50/62] attrib: Remove att_get_uuid16()
Date: Thu, 20 Mar 2014 11:43:15 -0300
Message-Id: <1395326607-27068-51-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 89698dc..35281e5 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -158,15 +158,6 @@ static inline void att_put_uuid(bt_uuid_t src, void *dst)
 		att_put_uuid128(src, dst);
 }
 
-static inline bt_uuid_t att_get_uuid16(const void *ptr)
-{
-	bt_uuid_t uuid;
-
-	bt_uuid16_create(&uuid, att_get_u16(ptr));
-
-	return uuid;
-}
-
 static inline bt_uuid_t att_get_uuid128(const void *ptr)
 {
 	bt_uuid_t uuid;
-- 
1.8.3.1

