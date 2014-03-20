Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 47/62] attrib: Remove att_put_u8()
Date: Thu, 20 Mar 2014 11:43:12 -0300
Message-Id: <1395326607-27068-48-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h                  | 5 -----
 profiles/proximity/reporter.c | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 645b6cf..4db015d 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -134,11 +134,6 @@ static inline uint128_t att_get_u128(const void *ptr)
 	return dst;
 }
 
-static inline void att_put_u8(uint8_t src, void *dst)
-{
-	bt_put_unaligned(src, (uint8_t *) dst);
-}
-
 static inline void att_put_u16(uint16_t src, void *dst)
 {
 	bt_put_unaligned(htobs(src), (uint16_t *) dst);
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 5861923..9be4a95 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -130,7 +130,7 @@ static void register_tx_power(struct btd_adapter *adapter)
 
 	/* Power level value */
 	bt_uuid16_create(&uuid, POWER_LEVEL_CHR_UUID);
-	att_put_u8(0x00, &atval[0]);
+	atval[0] = 0x00;
 	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
 
 	/* Client characteristic configuration */
-- 
1.8.3.1

