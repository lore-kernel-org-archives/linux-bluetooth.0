Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 04/10] android/gatt: Make struct destructors NULL proof
Date: Wed, 11 Feb 2015 15:34:02 +0100
Message-Id: <1423665248-5121-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some destructor functions do check for NULL and for some we need to
check manually. In few cases we forgot to check at all, which may lead to
NULL dereference. With this patch we are consistent about where this
check should be done.
---
 android/gatt.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 33eeba9..7f95226 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -543,6 +543,9 @@ static void destroy_notification(void *data)
 	struct notification_data *notification = data;
 	struct gatt_app *app;
 
+	if (!notification)
+		return;
+
 	if (--notification->ref)
 		return;
 
@@ -670,6 +673,9 @@ static void destroy_gatt_app(void *data)
 {
 	struct gatt_app *app = data;
 
+	if (!app)
+		return;
+
 	/*
 	 * First we want to get all notifications and unregister them.
 	 * We don't pass unregister_notification to queue_destroy,
@@ -707,6 +713,9 @@ static void destroy_pending_request(void *data)
 {
 	struct pending_request *entry = data;
 
+	if (!entry)
+		return;
+
 	free(entry->value);
 	free(entry->filter_value);
 	free(entry);
@@ -883,6 +892,9 @@ static void destroy_connection(void *data)
 {
 	struct app_connection *conn = data;
 
+	if (!conn)
+		return;
+
 	if (conn->timeout_id > 0)
 		g_source_remove(conn->timeout_id);
 
@@ -2167,8 +2179,7 @@ static void handle_client_disconnect(const void *buf, uint16_t len)
 	/* TODO: should we care to match also bdaddr when conn_id is unique? */
 	conn = queue_remove_if(app_connections, match_connection_by_id,
 						INT_TO_PTR(cmd->conn_id));
-	if (conn)
-		destroy_connection(conn);
+	destroy_connection(conn);
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -4207,10 +4218,8 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 	case GATT_CLIENT_TEST_CMD_DISCONNECT:
 		app = queue_find(gatt_apps, match_app_by_id,
 						INT_TO_PTR(test_client_if));
-		if (app)
-			queue_remove_all(app_connections,
-						match_connection_by_app, app,
-						destroy_connection);
+		queue_remove_all(app_connections, match_connection_by_app, app,
+							destroy_connection);
 
 		status = HAL_STATUS_SUCCESS;
 		break;
@@ -4305,8 +4314,7 @@ static void handle_server_disconnect(const void *buf, uint16_t len)
 	/* TODO: should we care to match also bdaddr when conn_id is unique? */
 	conn = queue_remove_if(app_connections, match_connection_by_id,
 						INT_TO_PTR(cmd->conn_id));
-	if (conn)
-		destroy_connection(conn);
+	destroy_connection(conn);
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -4488,8 +4496,7 @@ static void send_dev_complete_response(struct gatt_device *device,
 		adl = att_data_list_alloc(queue_length(temp),
 						sizeof(uint16_t) + length);
 
-		if (val)
-			destroy_pending_request(val);
+		destroy_pending_request(val);
 
 		val = queue_pop_head(temp);
 		while (val) {
-- 
1.9.1

