Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/14] android/gatt: Fix descripors instance IDs
Date: Thu, 11 Sep 2014 08:08:45 +0200
Message-Id: <1410415732-23212-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
References: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

First descriptor should have instance ID with 1.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index f16d365..4ef2b5f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2760,7 +2760,7 @@ static void gatt_discover_desc_cb(guint8 status, GSList *descs,
 		bt_string_to_uuid(&uuid, desc->uuid);
 		bt_uuid_to_uuid128(&uuid, &descr->id.uuid);
 
-		descr->id.instance = i++;
+		descr->id.instance = ++i;
 		descr->handle = desc->handle;
 
 		DBG("attr handle = 0x%04x, uuid: %s", desc->handle, desc->uuid);
-- 
1.9.3

