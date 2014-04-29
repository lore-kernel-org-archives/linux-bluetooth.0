Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2] android/gatt: Use common code for server and client register
Date: Tue, 29 Apr 2014 16:35:03 +0200
Message-Id: <1398782103-19413-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As clients and servers are stored on a single list we can use common
code in both of register handlers.

We always confirm registration handling with HAL_STATUS_SUCCESS,
regardless of registration result, which is reported by event
notification containing GATT_SUCCESS or GATT_FAILURE status.
---
 android/gatt.c | 117 ++++++++++++++++++++++-----------------------------------
 1 file changed, 44 insertions(+), 73 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 78349ba..4775ecc 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -152,8 +152,6 @@ static struct queue *gatt_apps = NULL;
 static struct queue *gatt_devices = NULL;
 static struct queue *app_connections = NULL;
 
-static int32_t app_id = 1;
-
 static struct queue *listen_clients = NULL;
 
 static void bt_le_discovery_stop_cb(void);
@@ -536,56 +534,58 @@ static void destroy_gatt_app(void *data)
 	free(app);
 }
 
-static void handle_client_register(const void *buf, uint16_t len)
+static int register_app(const uint8_t *uuid, gatt_app_type_t app_type)
 {
-	const struct hal_cmd_gatt_client_register *cmd = buf;
-	struct hal_ev_gatt_client_register_client ev;
-	struct gatt_app *client;
-	uint8_t status;
-
-	DBG("");
-
-	memset(&ev, 0, sizeof(ev));
+	static int32_t application_id = 1;
+	struct gatt_app *app;
 
-	if (queue_find(gatt_apps, match_app_by_uuid, &cmd->uuid)) {
-		error("gatt: client uuid is already on list");
-		status = HAL_STATUS_FAILED;
-		goto failed;
+	if (queue_find(gatt_apps, match_app_by_uuid, (void *) uuid)) {
+		error("gatt: app uuid is already on list");
+		return 0;
 	}
 
-	client = new0(struct gatt_app, 1);
-	client->type = APP_CLIENT;
-	if (!client) {
-		error("gatt: cannot allocate memory for registering client");
-		status = HAL_STATUS_NOMEM;
-		goto failed;
+	app = new0(struct gatt_app, 1);
+	if (!app) {
+		error("gatt: Cannot allocate memory for registering app");
+		return 0;
 	}
 
-	client->notifications = queue_new();
-	if (!client->notifications) {
-		error("gatt: couldn't allocate notifications queue");
-		destroy_gatt_app(client);
-		status = HAL_STATUS_NOMEM;
-		goto failed;
+	app->type = app_type;
+
+	if (app->type == APP_CLIENT) {
+		app->notifications = queue_new();
+		if (!app->notifications) {
+			error("gatt: couldn't allocate notifications queue");
+			destroy_gatt_app(app);
+			return 0;
+		}
 	}
 
-	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
+	memcpy(app->uuid, uuid, sizeof(app->uuid));
 
-	client->id = app_id++;
+	app->id = application_id++;
 
-	if (!queue_push_head(gatt_apps, client)) {
-		error("gatt: Cannot push client on the list");
-		destroy_gatt_app(client);
-		status = HAL_STATUS_NOMEM;
-		goto failed;
+	if (!queue_push_head(gatt_apps, app)) {
+		error("gatt: Cannot push app on the list");
+		destroy_gatt_app(app);
+		return 0;
 	}
 
-	ev.client_if = client->id;
+	return app->id;
+}
 
-	status = HAL_STATUS_SUCCESS;
+static void handle_client_register(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_register *cmd = buf;
+	struct hal_ev_gatt_client_register_client ev;
 
-failed:
-	if (status == HAL_STATUS_SUCCESS)
+	DBG("");
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.client_if = register_app(cmd->uuid, APP_CLIENT);
+
+	if (ev.client_if)
 		ev.status = GATT_SUCCESS;
 	else
 		ev.status = GATT_FAILURE;
@@ -597,7 +597,7 @@ failed:
 			HAL_EV_GATT_CLIENT_REGISTER_CLIENT, sizeof(ev), &ev);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
-									status);
+							HAL_STATUS_SUCCESS);
 }
 
 static void send_client_disconnection_notify(struct app_connection *connection,
@@ -3096,45 +3096,16 @@ static void handle_server_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_register *cmd = buf;
 	struct hal_ev_gatt_server_register ev;
-	struct gatt_app *server;
-	uint32_t status;
 
 	DBG("");
 
 	memset(&ev, 0, sizeof(ev));
 
-	if (queue_find(gatt_apps, match_app_by_uuid, &cmd->uuid)) {
-		error("gatt: Server uuid is already on list");
-		status = HAL_STATUS_FAILED;
-		goto failed;
-	}
-
-	server = new0(struct gatt_app, 1);
-	server->type = APP_SERVER;
-	if (!server) {
-		error("gatt: Cannot allocate memory for registering server");
-		status = HAL_STATUS_NOMEM;
-		goto failed;
-	}
+	ev.server_if = register_app(cmd->uuid, APP_SERVER);
 
-	memcpy(server->uuid, cmd->uuid, sizeof(server->uuid));
-
-	server->id = app_id++;
-
-	if (!queue_push_head(gatt_apps, server)) {
-		error("gatt: Cannot push server on the list");
-		free(server);
-		status = HAL_STATUS_FAILED;
-		goto failed;
-	}
-
-	ev.status = GATT_SUCCESS;
-	ev.server_if = server->id;
-
-	status = HAL_STATUS_SUCCESS;
-
-failed:
-	if (status != HAL_STATUS_SUCCESS)
+	if (ev.server_if)
+		ev.status = GATT_SUCCESS;
+	else
 		ev.status = GATT_FAILURE;
 
 	memcpy(ev.uuid, cmd->uuid, sizeof(ev.uuid));
@@ -3143,7 +3114,7 @@ failed:
 				HAL_EV_GATT_SERVER_REGISTER, sizeof(ev), &ev);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_REGISTER,
-									status);
+							HAL_STATUS_SUCCESS);
 }
 
 static void handle_server_unregister(const void *buf, uint16_t len)
-- 
1.9.1

