Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] lib/uuid: Fix bt_uuid_to_le
Date: Mon, 30 Mar 2015 16:50:26 +0300
Message-Id: <1427723426-4316-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_uuid_to_le is currently broken if the src uuid is type 32 bits since
it does the conversion to 128 bits but still uses the original value to
swap instead of the coverted one.
---
 lib/uuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index 4f34b17..fd61968 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -301,7 +301,8 @@ int bt_uuid_to_le(const bt_uuid_t *src, void *dst)
 		bt_put_le16(src->value.u16, dst);
 		return 0;
 	case BT_UUID32:
-		bt_uuid_to_uuid128(src, &uuid);
+		bt_uuid32_to_uuid128(src, &uuid);
+		src = &uuid;
 		/* Fallthrough */
 	case BT_UUID128:
 		/* Convert from 128-bit BE to LE */
-- 
2.1.0

