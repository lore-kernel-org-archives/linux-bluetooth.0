Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 7/7] core/gatt: Check if attribute is valid
Date: Thu, 19 Mar 2015 16:21:27 +0200
Message-Id: <1426774887-25646-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426774887-25646-1-git-send-email-luiz.dentz@gmail.com>
References: <1426774887-25646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks the return of gatt_db_get_attribute and fail if return NULL.
---
 src/gatt-client.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 8f67db3..608f96d 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1339,8 +1339,15 @@ static struct characteristic *characteristic_create(
 	gatt_db_attribute_get_char_data(attr, &chrc->handle,
 							&chrc->value_handle,
 							&chrc->props, &uuid);
+
 	chrc->attr = gatt_db_get_attribute(service->client->db,
 							chrc->value_handle);
+	if (!chrc->attr) {
+		error("Attribute 0x%04x not found", chrc->value_handle);
+		characteristic_free(chrc);
+		return NULL;
+	}
+
 	bt_uuid_to_uuid128(&uuid, &chrc->uuid);
 
 	chrc->path = g_strdup_printf("%s/char%04x", service->path,
-- 
2.1.0

