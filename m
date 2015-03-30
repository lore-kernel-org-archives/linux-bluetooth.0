Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] lib/uuid: Fix 32 bit bt_uuid to le
Date: Mon, 30 Mar 2015 10:45:38 +0200
Message-Id: <1427705138-21398-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Conversion from be to le can be done using bluetooth funcion.
---
 lib/uuid.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index 15fbd66..2f598b8 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -338,15 +338,13 @@ int bt_uuid_strcmp(const void *a, const void *b)
 
 int bt_uuid_to_le(const bt_uuid_t *src, void *dst)
 {
-	bt_uuid_t uuid;
-
 	switch (src->type) {
 	case BT_UUID16:
 		bt_put_le16(src->value.u16, dst);
 		return 0;
 	case BT_UUID32:
-		bt_uuid_to_uuid128(src, &uuid);
-		/* Fallthrough */
+		bt_put_le32(src->value.u32, dst);
+		return 0;
 	case BT_UUID128:
 		/* Convert from 128-bit BE to LE */
 		bswap_128(&src->value.u128, dst);
-- 
2.1.0

