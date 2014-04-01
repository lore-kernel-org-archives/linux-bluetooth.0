Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 3/3] android/gatt: Simplify matching functions
Date: Tue,  1 Apr 2014 10:03:24 +0200
Message-Id: <1396339404-14418-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396339404-14418-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396339404-14418-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should match uuid from element_id struct to avoid uuid creation every
time.
---
 android/gatt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 37a1986..9dd7fe4 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -229,11 +229,9 @@ static bool match_srvc_by_element_id(const void *data, const void *user_data)
 {
 	const struct element_id *exp_id = user_data;
 	const struct service *service = data;
-	bt_uuid_t uuid;
 
-	bt_string_to_uuid(&uuid, service->primary.uuid);
 	if (service->id.instance == exp_id->instance)
-		return !bt_uuid_cmp(&uuid, &exp_id->uuid);
+		return !bt_uuid_cmp(&service->id.uuid, &exp_id->uuid);
 
 	return false;
 }
@@ -277,11 +275,9 @@ static bool match_char_by_element_id(const void *data, const void *user_data)
 {
 	const struct element_id *exp_id = user_data;
 	const struct characteristic *chars = data;
-	bt_uuid_t uuid;
 
-	bt_string_to_uuid(&uuid, chars->ch.uuid);
 	if (exp_id->instance == chars->id.instance)
-		return !bt_uuid_cmp(&uuid, &exp_id->uuid);
+		return !bt_uuid_cmp(&chars->id.uuid, &exp_id->uuid);
 
 	return false;
 }
-- 
1.9.0

