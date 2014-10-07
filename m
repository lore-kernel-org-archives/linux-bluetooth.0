Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] shared/gatt: Distinguish Primary from Secondary services
Date: Tue,  7 Oct 2014 09:19:20 +0200
Message-Id: <1412666365-9562-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412666365-9562-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412666365-9562-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add flag primary to distinguish service as primary or secondary.
---
 src/shared/gatt-client.c | 7 +++++--
 src/shared/gatt-client.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 03d722f..724fde2 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -202,7 +202,8 @@ static void mark_notify_data_invalid_if_in_range(void *data, void *user_data)
 
 static bool service_list_add_service(struct service_list **head,
 						struct service_list **tail,
-						uint16_t start, uint16_t end,
+						bool primary, uint16_t start,
+						uint16_t end,
 						uint8_t uuid[BT_GATT_UUID_SIZE])
 {
 	struct service_list *list;
@@ -211,6 +212,7 @@ static bool service_list_add_service(struct service_list **head,
 	if (!list)
 		return false;
 
+	list->service.primary = primary;
 	list->service.start_handle = start;
 	list->service.end_handle = end;
 	memcpy(list->service.uuid, uuid, UUID_BYTES);
@@ -668,7 +670,8 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 
 		/* Store the service */
 		if (!service_list_add_service(&op->result_head,
-					&op->result_tail, start, end, uuid)) {
+					&op->result_tail, true, start, end,
+					uuid)) {
 			util_debug(client->debug_callback, client->debug_data,
 						"Failed to store service");
 			success = false;
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 6807f6b..22d4dc0 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -75,6 +75,7 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 					bt_gatt_client_destroy_func_t destroy);
 
 typedef struct {
+	bool primary;
 	uint16_t start_handle;
 	uint16_t end_handle;
 	uint8_t uuid[BT_GATT_UUID_SIZE];
-- 
1.9.3

