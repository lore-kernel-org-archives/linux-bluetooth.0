Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 06/15] shared/gatt: Moify gatt_db_find_information to return list of handles
Date: Wed, 14 May 2014 12:18:10 +0200
Message-Id: <1400062699-2372-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now this function will return list of found handles.
---
 src/shared/gatt-db.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d5fa17d..cb63754 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -614,7 +614,6 @@ static void find_information(void *data, void *user_data)
 	struct find_information_data *search_data = user_data;
 	struct gatt_db_service *service = data;
 	struct gatt_db_attribute *attribute;
-	struct gatt_db_find_information *value;
 	int i;
 
 	if (!service->active)
@@ -636,14 +635,8 @@ static void find_information(void *data, void *user_data)
 		if (attribute->handle > search_data->end_handle)
 			return;
 
-		value = new0(struct gatt_db_find_information, 1);
-		if (!value)
-			return;
-
-		value->handle = attribute->handle;
-		value->uuid = attribute->uuid;
-		if (!queue_push_tail(search_data->queue, value))
-			free(value);
+		queue_push_tail(search_data->queue,
+						UINT_TO_PTR(attribute->handle));
 	}
 }
 
-- 
1.9.0

