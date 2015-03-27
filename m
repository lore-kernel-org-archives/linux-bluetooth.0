Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] attrib-server: Use bt_uuid_to_le instead of local function
Date: Fri, 27 Mar 2015 16:39:18 +0100
Message-Id: <1427470759-30114-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch use lib/uuid library for uuids instead of local function.
---
 src/attrib-server.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index fe127e6..0f2cced 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -98,15 +98,6 @@ static bt_uuid_t ccc_uuid = {
 			.value.u16 = GATT_CLIENT_CHARAC_CFG_UUID
 };
 
-static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
-{
-	if (src->type == BT_UUID16)
-		put_le16(src->value.u16, dst);
-	else
-		/* Convert from 128-bit BE to LE */
-		bswap_128(&src->value.u128, dst);
-}
-
 static void attrib_free(void *data)
 {
 	struct attribute *a = data;
@@ -697,7 +688,7 @@ static uint16_t find_info(struct gatt_channel *channel, uint16_t start,
 		put_le16(a->handle, value);
 
 		/* Attribute Value */
-		put_uuid_le(&a->uuid, &value[2]);
+		bt_uuid_to_le(&a->uuid, &value[2]);
 	}
 
 	length = enc_find_info_resp(format, adl, pdu, len);
-- 
2.1.0

