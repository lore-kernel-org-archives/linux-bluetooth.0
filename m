Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 9/9] android/gatt: Simplify matching functions
Date: Fri, 28 Mar 2014 19:54:45 +0100
Message-Id: <1396032885-32077-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should match uuid from element_id struct to avoid uuid creation every
time match function is being called.
---
 android/gatt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f5e44be..b8c52c0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -220,11 +220,9 @@ static bool match_srvc_by_element_id(const void *data, const void *user_data)
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
@@ -289,11 +287,9 @@ static bool match_char_by_element_id(const void *data, const void *user_data)
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

