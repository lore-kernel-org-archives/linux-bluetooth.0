Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 2/2] attrib: Remove att_get_* and att_put_* helpers
Date: Tue, 25 Mar 2014 11:50:19 -0300
Message-Id: <1395759019-9643-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395759019-9643-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395759019-9643-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h | 89 ------------------------------------------------------------
 1 file changed, 89 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 28bc944..297c302 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -111,95 +111,6 @@ struct att_range {
 	uint16_t end;
 };
 
-/* These functions do byte conversion */
-static inline uint8_t att_get_u8(const void *ptr)
-{
-	const uint8_t *u8_ptr = ptr;
-	return bt_get_unaligned(u8_ptr);
-}
-
-static inline uint16_t att_get_u16(const void *ptr)
-{
-	const uint16_t *u16_ptr = ptr;
-	return btohs(bt_get_unaligned(u16_ptr));
-}
-
-static inline uint32_t att_get_u32(const void *ptr)
-{
-	const uint32_t *u32_ptr = ptr;
-	return btohl(bt_get_unaligned(u32_ptr));
-}
-
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
-static inline void att_put_u8(uint8_t src, void *dst)
-{
-	bt_put_unaligned(src, (uint8_t *) dst);
-}
-
-static inline void att_put_u16(uint16_t src, void *dst)
-{
-	bt_put_unaligned(htobs(src), (uint16_t *) dst);
-}
-
-static inline void att_put_u32(uint32_t src, void *dst)
-{
-	bt_put_unaligned(htobl(src), (uint32_t *) dst);
-}
-
-static inline void att_put_u128(uint128_t src, void *dst)
-{
-	uint128_t *d128 = dst;
-
-	htob128(&src, d128);
-}
-
-static inline void att_put_uuid16(bt_uuid_t src, void *dst)
-{
-	att_put_u16(src.value.u16, dst);
-}
-
-static inline void att_put_uuid128(bt_uuid_t src, void *dst)
-{
-	att_put_u128(src.value.u128, dst);
-}
-
-static inline void att_put_uuid(bt_uuid_t src, void *dst)
-{
-	if (src.type == BT_UUID16)
-		att_put_uuid16(src, dst);
-	else
-		att_put_uuid128(src, dst);
-}
-
-static inline bt_uuid_t att_get_uuid16(const void *ptr)
-{
-	bt_uuid_t uuid;
-
-	bt_uuid16_create(&uuid, att_get_u16(ptr));
-
-	return uuid;
-}
-
-static inline bt_uuid_t att_get_uuid128(const void *ptr)
-{
-	bt_uuid_t uuid;
-	uint128_t value;
-
-	value  = att_get_u128(ptr);
-	bt_uuid128_create(&uuid, value);
-
-	return uuid;
-}
-
 struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len);
 void att_data_list_free(struct att_data_list *list);
 
-- 
1.8.3.1

