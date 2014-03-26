Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Fix incorrect usage of bt_uuid_to_uuid128
Date: Wed, 26 Mar 2014 17:08:06 +0100
Message-Id: <1395850086-26154-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6354ac6..04e9729 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -970,7 +970,7 @@ static void cache_all_srvc_chars(GSList *characteristics, struct queue *q)
 		memcpy(&ch->ch, characteristics->data, sizeof(ch->ch));
 
 		bt_string_to_uuid(&uuid, ch->ch.uuid);
-		bt_uuid_to_uuid128(&ch->id.uuid, &uuid);
+		bt_uuid_to_uuid128(&uuid, &ch->id.uuid);
 
 		/* For now we increment inst_id and use it as characteristic
 		 * handle
-- 
1.8.5.2

