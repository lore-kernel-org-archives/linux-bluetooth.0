Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 06/15] shared/gatt-db: Add UUID arg to foreach_service
Date: Mon,  8 Dec 2014 16:40:46 -0800
Message-Id: <1418085655-7304-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1418085655-7304-1-git-send-email-armansito@chromium.org>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the "uuid" argument to gatt_db_foreach_service, which
invokes the callback for a service only if "uuid" is NULL or if it
matches the GATT service UUID.
---
 src/shared/gatt-db.c  | 19 ++++++++++++++++---
 src/shared/gatt-db.h  |  6 ++++--
 tools/btgatt-client.c |  9 ++++-----
 tools/btgatt-server.c |  2 +-
 unit/test-gatt.c      |  4 ++--
 5 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 379b4ad..98fb8a0 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -996,14 +996,17 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 	queue_foreach(db->services, find_information, &data);
 }
 
-void gatt_db_foreach_service(struct gatt_db *db, gatt_db_attribute_cb_t func,
-							void *user_data)
+void gatt_db_foreach_service(struct gatt_db *db, const bt_uuid_t *uuid,
+						gatt_db_attribute_cb_t func,
+						void *user_data)
 {
-	gatt_db_foreach_service_in_range(db, func, user_data, 0x0001, 0xffff);
+	gatt_db_foreach_service_in_range(db, uuid, func, user_data, 0x0001,
+									0xffff);
 }
 
 struct foreach_data {
 	gatt_db_attribute_cb_t func;
+	const bt_uuid_t *uuid;
 	void *user_data;
 	uint16_t start, end;
 };
@@ -1013,16 +1016,25 @@ static void foreach_service_in_range(void *data, void *user_data)
 	struct gatt_db_service *service = data;
 	struct foreach_data *foreach_data = user_data;
 	uint16_t svc_start;
+	bt_uuid_t uuid;
 
 	svc_start = get_handle_at_index(service, 0);
 
 	if (svc_start > foreach_data->end || svc_start < foreach_data->start)
 		return;
 
+	if (foreach_data->uuid) {
+		gatt_db_attribute_get_service_uuid(service->attributes[0],
+									&uuid);
+		if (bt_uuid_cmp(&uuid, foreach_data->uuid))
+			return;
+	}
+
 	foreach_data->func(service->attributes[0], foreach_data->user_data);
 }
 
 void gatt_db_foreach_service_in_range(struct gatt_db *db,
+						const bt_uuid_t *uuid,
 						gatt_db_attribute_cb_t func,
 						void *user_data,
 						uint16_t start_handle,
@@ -1034,6 +1046,7 @@ void gatt_db_foreach_service_in_range(struct gatt_db *db,
 		return;
 
 	data.func = func;
+	data.uuid = uuid;
 	data.user_data = user_data;
 	data.start = start_handle;
 	data.end = end_handle;
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index b9f12e3..e5fe6bb 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -105,9 +105,11 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 typedef void (*gatt_db_attribute_cb_t)(struct gatt_db_attribute *attrib,
 							void *user_data);
 
-void gatt_db_foreach_service(struct gatt_db *db, gatt_db_attribute_cb_t func,
-							void *user_data);
+void gatt_db_foreach_service(struct gatt_db *db, const bt_uuid_t *uuid,
+						gatt_db_attribute_cb_t func,
+						void *user_data);
 void gatt_db_foreach_service_in_range(struct gatt_db *db,
+						const bt_uuid_t *uuid,
 						gatt_db_attribute_cb_t func,
 						void *user_data,
 						uint16_t start_handle,
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index fe94ae8..015142d 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -288,15 +288,14 @@ static void print_services(struct client *cli)
 {
 	printf("\n");
 
-	gatt_db_foreach_service(cli->db, print_service, cli);
+	gatt_db_foreach_service(cli->db, NULL, print_service, cli);
 }
 
 static void print_services_by_uuid(struct client *cli, const bt_uuid_t *uuid)
 {
 	printf("\n");
 
-	/* TODO: Filter by UUID */
-	gatt_db_foreach_service(cli->db, print_service, cli);
+	gatt_db_foreach_service(cli->db, uuid, print_service, cli);
 }
 
 static void print_services_by_handle(struct client *cli, uint16_t handle)
@@ -304,7 +303,7 @@ static void print_services_by_handle(struct client *cli, uint16_t handle)
 	printf("\n");
 
 	/* TODO: Filter by handle */
-	gatt_db_foreach_service(cli->db, print_service, cli);
+	gatt_db_foreach_service(cli->db, NULL, print_service, cli);
 }
 
 static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
@@ -331,7 +330,7 @@ static void service_changed_cb(uint16_t start_handle, uint16_t end_handle,
 	printf("\nService Changed handled - start: 0x%04x end: 0x%04x\n",
 						start_handle, end_handle);
 
-	gatt_db_foreach_service_in_range(cli->db, print_service, cli,
+	gatt_db_foreach_service_in_range(cli->db, NULL, print_service, cli,
 						start_handle, end_handle);
 	print_prompt();
 }
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index a2a0ec9..1a9b9fb 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -969,7 +969,7 @@ static void print_service(struct gatt_db_attribute *attr, void *user_data)
 
 static void cmd_services(struct server *server, char *cmd_str)
 {
-	gatt_db_foreach_service(server->db, print_service, server);
+	gatt_db_foreach_service(server->db, NULL, print_service, server);
 }
 
 static void cmd_help(struct server *server, char *cmd_str);
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 3ce3d80..2f3f26a 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -414,7 +414,7 @@ static void match_services(struct gatt_db_attribute *client_serv_attr,
 	serv_test_data.match = client_serv_attr;
 	serv_test_data.found = false;
 
-	gatt_db_foreach_service(source_db,
+	gatt_db_foreach_service(source_db, NULL,
 					find_matching_service, &serv_test_data);
 
 	g_assert(serv_test_data.found);
@@ -434,7 +434,7 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 	g_assert(context->client);
 	g_assert(context->client_db);
 
-	gatt_db_foreach_service(context->client_db, match_services,
+	gatt_db_foreach_service(context->client_db, NULL, match_services,
 						context->data->source_db);
 
 	if (context->data->step) {
-- 
2.2.0.rc0.207.ga3a616c

