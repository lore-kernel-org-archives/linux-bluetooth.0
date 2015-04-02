Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] lib/uuid: Modify bt_uuid_to_le return value to uuid len
Date: Thu,  2 Apr 2015 13:15:26 +0200
Message-Id: <1427973328-22329-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1427973328-22329-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427973328-22329-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch modifies return value of bt_uuid_to_le function to uuid
length in case of successful conversion.
---
 lib/uuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index d2ad66d..b962adf 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -343,7 +343,7 @@ int bt_uuid_to_le(const bt_uuid_t *src, void *dst)
 	switch (src->type) {
 	case BT_UUID16:
 		bt_put_le16(src->value.u16, dst);
-		return 0;
+		return sizeof(src->value.u16);
 	case BT_UUID32:
 		bt_uuid32_to_uuid128(src, &uuid);
 		src = &uuid;
@@ -351,7 +351,7 @@ int bt_uuid_to_le(const bt_uuid_t *src, void *dst)
 	case BT_UUID128:
 		/* Convert from 128-bit BE to LE */
 		bswap_128(&src->value.u128, dst);
-		return 0;
+		return sizeof(src->value.u128);
 	case BT_UUID_UNSPEC:
 	default:
 		return -EINVAL;
-- 
2.1.0

