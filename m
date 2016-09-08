Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] core/device: Fix using not initialised uuid value.
Date: Thu,  8 Sep 2016 11:29:20 +0200
Message-Id: <1473326960-18003-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index 9586022..788554a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2058,6 +2058,7 @@ static void store_incl(struct gatt_db_attribute *attr, void *user_data)
 
 	sprintf(handle, "%04hx", handle_num);
 
+	gatt_db_attribute_get_service_uuid(service, &uuid);
 	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
 	sprintf(value, GATT_INCLUDE_UUID_STR ":%04hx:%04hx:%s", start,
 								end, uuid_str);
-- 
2.5.5

