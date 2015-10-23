Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH BlueZ v2] core/device: Fix build on some platforms
Date: Thu, 22 Oct 2015 22:52:23 -0700
Message-Id: <1445579543-5054-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

due to type promotions in C this code was failing on some platforms.

src/device.c:2016:8: error: format specifies type 'unsigned short' but the
      argument has type 'uint8_t' (aka 'unsigned char') [-Werror,-Wformat]
  properties, uuid_str);
  ^~~~~~~~~~
/build/falco/usr/include/bits/stdio2.h:39:7: note: expanded from macro 'sprintf'
                           __VA_ARGS__)
                           ^
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 906a1a7..eb1850e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2015,7 +2015,7 @@ static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
 
 	sprintf(handle, "%04hx", handle_num);
 	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
-	sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%s", value_handle,
+	sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hhx:%s", value_handle,
 							properties, uuid_str);
 	g_key_file_set_string(key_file, "Attributes", handle, value);
 
-- 
2.5.0

