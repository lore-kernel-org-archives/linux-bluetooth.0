Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 5/5] android/gatt: Register SDP records for services
Date: Thu, 10 Jul 2014 16:30:36 +0200
Message-Id: <1405002636-10737-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1405002636-10737-1-git-send-email-szymon.janc@tieto.com>
References: <1405002636-10737-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c    | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 android/hal-msg.h |   4 ++
 2 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6f04439..696b772 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -177,6 +177,11 @@ struct app_connection {
 	bool wait_execute_write;
 };
 
+struct service_sdp {
+	int32_t service_handle;
+	uint32_t sdp_handle;
+};
+
 static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
 static bool scanning = false;
@@ -186,6 +191,8 @@ static struct queue *gatt_apps = NULL;
 static struct queue *gatt_devices = NULL;
 static struct queue *app_connections = NULL;
 
+static struct queue *services_sdp = NULL;
+
 static struct queue *listen_apps = NULL;
 static struct gatt_db *gatt_db = NULL;
 
@@ -4883,6 +4890,84 @@ static uint32_t add_sdp_record(const bt_uuid_t *uuid, uint16_t start,
 	return rec->handle;
 }
 
+static bool match_service_sdp(const void *data, const void *user_data)
+{
+	const struct service_sdp *s = data;
+
+	return s->service_handle == PTR_TO_INT(user_data);
+}
+
+static struct service_sdp *new_service_sdp_record(int32_t service_handle)
+{
+	bt_uuid_t uuid;
+	struct service_sdp *s;
+	uint16_t end_handle;
+
+	end_handle = gatt_db_get_end_handle(gatt_db, service_handle);
+	if (!end_handle)
+		return NULL;
+
+	if (!gatt_db_get_service_uuid(gatt_db, service_handle, &uuid))
+		return NULL;
+
+	s = new0(struct service_sdp, 1);
+	if (!s)
+		return NULL;
+
+	s->service_handle = service_handle;
+	s->sdp_handle = add_sdp_record(&uuid, service_handle, end_handle, NULL);
+	if (!s->sdp_handle) {
+		free(s);
+		return NULL;
+	}
+
+	return s;
+}
+
+static void free_service_sdp_record(void *data)
+{
+	struct service_sdp *s = data;
+
+	if (!s)
+		return;
+
+	bt_adapter_remove_record(s->sdp_handle);
+	free(s);
+}
+
+static bool add_service_sdp_record(int32_t service_handle)
+{
+	struct service_sdp *s;
+
+	s = queue_find(services_sdp, match_service_sdp,
+						INT_TO_PTR(service_handle));
+	if (s)
+		return true;
+
+	s = new_service_sdp_record(service_handle);
+	if (!s)
+		return false;
+
+	if (!queue_push_tail(services_sdp, s)) {
+		free_service_sdp_record(s);
+		return false;
+	}
+
+	return true;
+}
+
+static void remove_service_sdp_record(int32_t service_handle)
+{
+	struct service_sdp *s;
+
+	s = queue_remove_if(services_sdp, match_service_sdp,
+						INT_TO_PTR(service_handle));
+	if (!s)
+		return;
+
+	free_service_sdp_record(s);
+}
+
 static void handle_server_start_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_start_service *cmd = buf;
@@ -4900,10 +4985,26 @@ static void handle_server_start_service(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	/* TODO: support BR/EDR (cmd->transport) */
+	switch (cmd->transport) {
+	case GATT_SERVER_TRANSPORT_BREDR:
+	case GATT_SERVER_TRANSPORT_LE_BREDR:
+		if (!add_service_sdp_record(cmd->service_handle)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+		break;
+	case GATT_SERVER_TRANSPORT_LE:
+		break;
+	default:
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	if (!gatt_db_service_set_active(gatt_db, cmd->service_handle, true)) {
-		/* we ignore service now */
+		/*
+		 * no need to clean SDP since this can fail only if service
+		 * handle is invalid in which case add_sdp_record() also fails
+		 */
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -4942,10 +5043,14 @@ static void handle_server_stop_service(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (!gatt_db_service_set_active(gatt_db, cmd->service_handle, false))
+	if (!gatt_db_service_set_active(gatt_db, cmd->service_handle, false)) {
 		status = HAL_STATUS_FAILED;
-	else
-		status = HAL_STATUS_SUCCESS;
+		goto failed;
+	}
+
+	remove_service_sdp_record(cmd->service_handle);
+
+	status = HAL_STATUS_SUCCESS;
 
 	queue_foreach(gatt_devices, notify_service_change,
 					UINT_TO_PTR(cmd->service_handle));
@@ -4984,6 +5089,8 @@ static void handle_server_delete_service(const void *buf, uint16_t len)
 		goto failed;
 	}
 
+	remove_service_sdp_record(cmd->service_handle);
+
 	status = HAL_STATUS_SUCCESS;
 
 failed:
@@ -6316,10 +6423,11 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	gatt_apps = queue_new();
 	app_connections = queue_new();
 	listen_apps = queue_new();
+	services_sdp = queue_new();
 	gatt_db = gatt_db_new();
 
 	if (!gatt_devices || !gatt_apps || !listen_apps || !app_connections ||
-								!gatt_db) {
+						!services_sdp || !gatt_db) {
 		error("gatt: Failed to allocate memory for queues");
 		goto failed;
 	}
@@ -6358,6 +6466,9 @@ failed:
 	queue_destroy(listen_apps, NULL);
 	listen_apps = NULL;
 
+	queue_destroy(services_sdp, NULL);
+	services_sdp = NULL;
+
 	gatt_db_destroy(gatt_db);
 	gatt_db = NULL;
 
@@ -6393,6 +6504,9 @@ void bt_gatt_unregister(void)
 	queue_destroy(gatt_devices, destroy_device);
 	gatt_devices = NULL;
 
+	queue_destroy(services_sdp, free_service_sdp_record);
+	services_sdp = NULL;
+
 	queue_destroy(listen_apps, NULL);
 	listen_apps = NULL;
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 7f13e84..8adb9f1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -826,6 +826,10 @@ struct hal_cmd_gatt_server_add_descriptor {
 	int32_t permissions;
 } __attribute__((packed));
 
+#define GATT_SERVER_TRANSPORT_LE		0x00
+#define GATT_SERVER_TRANSPORT_BREDR		0x01
+#define GATT_SERVER_TRANSPORT_LE_BREDR		0x02
+
 #define HAL_OP_GATT_SERVER_START_SERVICE	0x1f
 struct hal_cmd_gatt_server_start_service {
 	int32_t server_if;
-- 
1.9.1

