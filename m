Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 03/15] shared/gatt: Modify gatt_db_read_by_type to return handles only
Date: Wed, 14 May 2014 12:18:07 +0200
Message-Id: <1400062699-2372-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now read_by_type function will just return handles of found attributes.
---
 src/shared/gatt-db.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 41db7d2..d5fa17d 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -564,7 +564,6 @@ static void read_by_type(void *data, void *user_data)
 	struct read_by_type_data *search_data = user_data;
 	struct gatt_db_service *service = data;
 	struct gatt_db_attribute *attribute;
-	struct gatt_db_handle_value *value;
 	int i;
 
 	if (!service->active)
@@ -584,18 +583,8 @@ static void read_by_type(void *data, void *user_data)
 		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
 			continue;
 
-		value = malloc0(sizeof(struct gatt_db_handle_value) +
-							attribute->value_len);
-		if (!value)
-			return;
-
-		value->handle = attribute->handle;
-		value->length = attribute->value_len;
-		if (attribute->value_len)
-			memcpy(value->value, attribute->value, value->length);
-
-		if (!queue_push_tail(search_data->queue, value))
-			free(value);
+		queue_push_tail(search_data->queue,
+						UINT_TO_PTR(attribute->handle));
 	}
 }
 
-- 
1.9.0

