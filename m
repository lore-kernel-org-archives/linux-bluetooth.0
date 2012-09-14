Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] hog: Fix segfault when discovering descriptors
Date: Fri, 14 Sep 2012 10:56:50 -0300
Message-Id: <1347631010-3055-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Invalid memory was being accessed when discovering the External Report
Reference descriptor.
---
 profiles/input/hog_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 664c52b..03af931 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -479,7 +479,7 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
 			gatt_read_char(hogdev->attrib, chr->value_handle, 0,
 						report_map_read_cb, hogdev);
-			discover_descriptor(hogdev->attrib, chr, next, NULL);
+			discover_descriptor(hogdev->attrib, chr, next, hogdev);
 		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
 			info_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
-- 
1.7.11.4

