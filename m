Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 7/8] shared/gatt-client: Remove GATT structs and iterators
Date: Tue,  2 Dec 2014 16:12:42 -0800
Message-Id: <1417565563-29239-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1417565563-29239-1-git-send-email-armansito@chromium.org>
References: <1417565563-29239-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the high-level structs and iterators used by
shared/gatt-client in favor of gatt-db.
---
 src/shared/gatt-client.c | 88 ------------------------------------------------
 src/shared/gatt-client.h | 74 ++--------------------------------------
 2 files changed, 3 insertions(+), 159 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 4cd8770..463de3b 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1636,94 +1636,6 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 	return true;
 }
 
-bool bt_gatt_service_iter_init(struct bt_gatt_service_iter *iter,
-						struct bt_gatt_client *client)
-{
-	if (!iter || !client)
-		return false;
-
-	if (client->in_init || client->in_svc_chngd)
-		return false;
-
-	memset(iter, 0, sizeof(*iter));
-	iter->client = client;
-	iter->ptr = NULL;
-
-	return true;
-}
-
-bool bt_gatt_service_iter_next(struct bt_gatt_service_iter *iter,
-					const bt_gatt_service_t **service)
-{
-	/* TODO: Remove iterator functions */
-
-	return false;
-}
-
-bool bt_gatt_service_iter_next_by_handle(struct bt_gatt_service_iter *iter,
-					uint16_t start_handle,
-					const bt_gatt_service_t **service)
-{
-	while (bt_gatt_service_iter_next(iter, service)) {
-		if ((*service)->start_handle == start_handle)
-			return true;
-	}
-
-	return false;
-}
-
-bool bt_gatt_service_iter_next_by_uuid(struct bt_gatt_service_iter *iter,
-					const uint8_t uuid[BT_GATT_UUID_SIZE],
-					const bt_gatt_service_t **service)
-{
-	while (bt_gatt_service_iter_next(iter, service)) {
-		if (memcmp((*service)->uuid, uuid, UUID_BYTES) == 0)
-			return true;
-	}
-
-	return false;
-}
-
-bool bt_gatt_characteristic_iter_init(struct bt_gatt_characteristic_iter *iter,
-					const bt_gatt_service_t *service)
-{
-	if (!iter || !service)
-		return false;
-
-	memset(iter, 0, sizeof(*iter));
-	iter->service = (void *) service;
-
-	return true;
-}
-
-bool bt_gatt_characteristic_iter_next(struct bt_gatt_characteristic_iter *iter,
-					const bt_gatt_characteristic_t **chrc)
-{
-	/* TODO: Remove iterator functions */
-
-	return false;
-}
-
-bool bt_gatt_include_service_iter_init(struct bt_gatt_incl_service_iter *iter,
-					const bt_gatt_service_t *service)
-{
-	if (!iter || !service)
-		return false;
-
-	memset(iter, 0, sizeof(*iter));
-	iter->service = (void *) service;
-
-	return true;
-}
-
-bool bt_gatt_include_service_iter_next(struct bt_gatt_incl_service_iter *iter,
-					const bt_gatt_included_service_t **incl)
-{
-	/* TODO: Remove iterator functions */
-
-	return false;
-}
-
 struct read_op {
 	bt_gatt_client_read_callback_t callback;
 	void *user_data;
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index a09c3b8..984c23f 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -40,6 +40,9 @@ typedef void (*bt_gatt_client_destroy_func_t)(void *user_data);
 typedef void (*bt_gatt_client_callback_t)(bool success, uint8_t att_ecode,
 							void *user_data);
 typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
+typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data);
 typedef void (*bt_gatt_client_write_long_callback_t)(bool success,
 					bool reliable_error, uint8_t att_ecode,
 					void *user_data);
@@ -67,75 +70,6 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
 
-typedef struct {
-	bool primary;
-	uint16_t start_handle;
-	uint16_t end_handle;
-	uint8_t uuid[BT_GATT_UUID_SIZE];
-} bt_gatt_service_t;
-
-typedef struct {
-	uint16_t handle;
-	uint8_t uuid[BT_GATT_UUID_SIZE];
-} bt_gatt_descriptor_t;
-
-typedef struct {
-	uint16_t start_handle;
-	uint16_t end_handle;
-	uint16_t value_handle;
-	uint8_t properties;
-	uint8_t uuid[BT_GATT_UUID_SIZE];
-	const bt_gatt_descriptor_t *descs;
-	size_t num_descs;
-} bt_gatt_characteristic_t;
-
-typedef struct {
-	uint16_t handle;
-	uint16_t start_handle;
-	uint16_t end_handle;
-	uint8_t uuid[BT_GATT_UUID_SIZE];
-} bt_gatt_included_service_t;
-
-struct bt_gatt_service_iter {
-	struct bt_gatt_client *client;
-	void *ptr;
-};
-
-struct bt_gatt_characteristic_iter {
-	void *service;
-	size_t pos;
-};
-
-struct bt_gatt_incl_service_iter {
-	void *service;
-	size_t pos;
-};
-
-bool bt_gatt_service_iter_init(struct bt_gatt_service_iter *iter,
-						struct bt_gatt_client *client);
-bool bt_gatt_service_iter_next(struct bt_gatt_service_iter *iter,
-					const bt_gatt_service_t **service);
-bool bt_gatt_service_iter_next_by_handle(struct bt_gatt_service_iter *iter,
-					uint16_t start_handle,
-					const bt_gatt_service_t **service);
-bool bt_gatt_service_iter_next_by_uuid(struct bt_gatt_service_iter *iter,
-					const uint8_t uuid[BT_GATT_UUID_SIZE],
-					const bt_gatt_service_t **service);
-
-bool bt_gatt_characteristic_iter_init(struct bt_gatt_characteristic_iter *iter,
-					const bt_gatt_service_t *service);
-bool bt_gatt_characteristic_iter_next(struct bt_gatt_characteristic_iter *iter,
-					const bt_gatt_characteristic_t **chrc);
-
-bool bt_gatt_include_service_iter_init(struct bt_gatt_incl_service_iter *iter,
-					const bt_gatt_service_t *service);
-bool bt_gatt_include_service_iter_next(struct bt_gatt_incl_service_iter *iter,
-					const bt_gatt_included_service_t **inc);
-
-typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
-					void *user_data);
-
 bool bt_gatt_client_read_value(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bt_gatt_client_read_callback_t callback,
@@ -146,8 +80,6 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 					bt_gatt_client_read_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
-
-
 bool bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 					uint16_t *handles, uint8_t num_handles,
 					bt_gatt_client_read_callback_t callback,
-- 
2.2.0.rc0.207.ga3a616c

