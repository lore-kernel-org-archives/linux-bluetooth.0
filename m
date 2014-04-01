Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/gatt: Fix matching characteristict
Date: Tue,  1 Apr 2014 17:50:56 +0200
Message-Id: <1396367456-11085-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1396367456-11085-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396367456-11085-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes searching for characteristic within service.
Characteristics should be matched by element id (uuid, instance) not
only instance id. Also redundant helper to match characteristic by
instance is removed.
---
 android/gatt.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e2feb20..f11e31f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -268,14 +268,6 @@ static bool match_char_by_higher_inst_id(const void *data,
 	return inst_id < ch->id.instance;
 }
 
-static bool match_char_by_instance(const void *data, const void *user_data)
-{
-	const struct characteristic *ch = data;
-	uint8_t inst_id = PTR_TO_INT(user_data);
-
-	return inst_id == ch->id.instance;
-}
-
 static bool match_notification(const void *a, const void *b)
 {
 	const struct notification_data *a1 = a;
@@ -1740,8 +1732,8 @@ static void handle_client_register_for_notification(const void *buf,
 		goto failed;
 	}
 
-	c = queue_find(service->chars, match_char_by_instance,
-					INT_TO_PTR(cmd->char_id.inst_id));
+	hal_gatt_id_to_element_id(&cmd->char_id, &match_id);
+	c = queue_find(service->chars, match_char_by_element_id, &match_id);
 	if (!c) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
-- 
1.9.1

