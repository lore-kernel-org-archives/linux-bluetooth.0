Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 5/8] tools/btgatt-client: Use gatt-db instead of iterators
Date: Tue,  2 Dec 2014 16:12:40 -0800
Message-Id: <1417565563-29239-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1417565563-29239-1-git-send-email-armansito@chromium.org>
References: <1417565563-29239-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btgatt-client now iterates services, characteristics, and descriptors
of the shared/gatt-client using gatt-db instead of the iterators.
---
 tools/btgatt-client.c | 171 +++++++++++++++++++++-----------------------------
 1 file changed, 73 insertions(+), 98 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 6d1b5cb..1d98274 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -41,7 +41,9 @@
 
 #include "monitor/mainloop.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 #include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
 
 #define ATT_CID 4
@@ -170,118 +172,111 @@ static void client_destroy(struct client *cli)
 	bt_gatt_client_unref(cli->gatt);
 }
 
-static void print_uuid(const uint8_t uuid[16])
+static void print_uuid(const bt_uuid_t *uuid)
 {
 	char uuid_str[MAX_LEN_UUID_STR];
-	bt_uuid_t tmp;
+	bt_uuid_t uuid128;
 
-	tmp.type = BT_UUID128;
-	memcpy(tmp.value.u128.data, uuid, 16 * sizeof(uint8_t));
-	bt_uuid_to_string(&tmp, uuid_str, sizeof(uuid_str));
+	bt_uuid_to_uuid128(uuid, &uuid128);
+	bt_uuid_to_string(&uuid128, uuid_str, sizeof(uuid_str));
 
 	printf("%s\n", uuid_str);
 }
 
-static void print_service(const bt_gatt_service_t *service)
+static void print_incl(struct gatt_db_attribute *attr, void *user_data)
 {
-	struct bt_gatt_characteristic_iter iter;
-	struct bt_gatt_incl_service_iter include_iter;
-	const bt_gatt_characteristic_t *chrc;
-	const bt_gatt_included_service_t *incl;
-	size_t i;
-
-	if (!bt_gatt_characteristic_iter_init(&iter, service)) {
-		PRLOG("Failed to initialize characteristic iterator\n");
+	struct client *cli = user_data;
+	uint16_t handle, start, end;
+	struct gatt_db_attribute *service;
+	bt_uuid_t uuid;
+
+	if (!gatt_db_attribute_get_incl_data(attr, &handle, &start, &end))
 		return;
-	}
 
-	if (!bt_gatt_include_service_iter_init(&include_iter, service)) {
-		PRLOG("Failed to initialize include service iterator\n");
+	service = gatt_db_get_attribute(cli->db, start);
+	if (!service)
 		return;
-	}
 
-	printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
-				"end: 0x%04x, type: %s, uuid: ",
-				service->start_handle, service->end_handle,
-				service->primary ? "primary" : "secondary");
-	print_uuid(service->uuid);
+	gatt_db_attribute_get_service_uuid(service, &uuid);
 
-	while (bt_gatt_include_service_iter_next(&include_iter, &incl)) {
-		printf("\t  " COLOR_GREEN "include" COLOR_OFF " - handle: "
+	printf("\t  " COLOR_GREEN "include" COLOR_OFF " - handle: "
 					"0x%04x, - start: 0x%04x, end: 0x%04x,"
-					"uuid: ", incl->handle,
-					incl->start_handle, incl->end_handle);
-		print_uuid(incl->uuid);
-	}
-
-	while (bt_gatt_characteristic_iter_next(&iter, &chrc)) {
-		printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
-				" - start: 0x%04x, end: 0x%04x, "
-				"value: 0x%04x, props: 0x%02x, uuid: ",
-				chrc->start_handle,
-				chrc->end_handle,
-				chrc->value_handle,
-				chrc->properties);
-		print_uuid(chrc->uuid);
-
-		for (i = 0; i < chrc->num_descs; i++) {
-			printf("\t\t  " COLOR_MAGENTA "descr" COLOR_OFF
-						" - handle: 0x%04x, uuid: ",
-						chrc->descs[i].handle);
-			print_uuid(chrc->descs[i].uuid);
-		}
-	}
-
-	printf("\n");
+					"uuid: ", handle, start, end);
+	print_uuid(&uuid);
 }
 
-static void print_services(struct client *cli)
+static void print_desc(struct gatt_db_attribute *attr, void *user_data)
 {
-	struct bt_gatt_service_iter iter;
-	const bt_gatt_service_t *service;
+	printf("\t\t  " COLOR_MAGENTA "descr" COLOR_OFF
+					" - handle: 0x%04x, uuid: ",
+					gatt_db_attribute_get_handle(attr));
+	print_uuid(gatt_db_attribute_get_type(attr));
+}
 
-	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
-		PRLOG("Failed to initialize service iterator\n");
+static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
+{
+	uint16_t handle, value_handle;
+	uint8_t properties;
+	bt_uuid_t uuid;
+
+	if (!gatt_db_attribute_get_char_data(attr, &handle,
+								&value_handle,
+								&properties,
+								&uuid))
 		return;
-	}
 
-	printf("\n");
+	printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
+					" - start: 0x%04x, value: 0x%04x, "
+					"props: 0x%02x, uuid: ",
+					handle, value_handle, properties);
+	print_uuid(&uuid);
 
-	while (bt_gatt_service_iter_next(&iter, &service))
-		print_service(service);
+	gatt_db_service_foreach_desc(attr, print_desc, NULL);
 }
 
-static void print_services_by_uuid(struct client *cli, const bt_uuid_t *uuid)
+static void print_service(struct gatt_db_attribute *attr, void *user_data)
 {
-	struct bt_gatt_service_iter iter;
-	const bt_gatt_service_t *service;
+	struct client *cli = user_data;
+	uint16_t start, end;
+	bool primary;
+	bt_uuid_t uuid;
 
-	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
-		PRLOG("Failed to initialize service iterator\n");
+	if (!gatt_db_attribute_get_service_data(attr, &start, &end, &primary,
+									&uuid))
 		return;
-	}
 
+	printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
+				"end: 0x%04x, type: %s, uuid: ",
+				start, end, primary ? "primary" : "secondary");
+	print_uuid(&uuid);
+
+	gatt_db_service_foreach_incl(attr, print_incl, cli);
+	gatt_db_service_foreach_char(attr, print_chrc, NULL);
+
+	printf("\n");
+}
+
+static void print_services(struct client *cli)
+{
 	printf("\n");
 
-	while (bt_gatt_service_iter_next_by_uuid(&iter, uuid->value.u128.data,
-								&service))
-		print_service(service);
+	gatt_db_foreach_service(cli->db, print_service, cli);
 }
 
-static void print_services_by_handle(struct client *cli, uint16_t handle)
+static void print_services_by_uuid(struct client *cli, const bt_uuid_t *uuid)
 {
-	struct bt_gatt_service_iter iter;
-	const bt_gatt_service_t *service;
+	printf("\n");
 
-	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
-		PRLOG("Failed to initialize service iterator\n");
-		return;
-	}
+	/* TODO: Filter by UUID */
+	gatt_db_foreach_service(cli->db, print_service, cli);
+}
 
+static void print_services_by_handle(struct client *cli, uint16_t handle)
+{
 	printf("\n");
 
-	while (bt_gatt_service_iter_next_by_handle(&iter, handle, &service))
-		print_service(service);
+	/* TODO: Filter by handle */
+	gatt_db_foreach_service(cli->db, print_service, cli);
 }
 
 static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
@@ -304,32 +299,12 @@ static void service_changed_cb(uint16_t start_handle, uint16_t end_handle,
 								void *user_data)
 {
 	struct client *cli = user_data;
-	struct bt_gatt_service_iter iter;
-	const bt_gatt_service_t *service;
-
-	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
-		PRLOG("Failed to initialize service iterator\n");
-		return;
-	}
 
 	printf("\nService Changed handled - start: 0x%04x end: 0x%04x\n",
 						start_handle, end_handle);
 
-	if (!bt_gatt_service_iter_next_by_handle(&iter, start_handle,
-								&service)) {
-		print_prompt();
-		return;
-	}
-
-	print_service(service);
-
-	while (bt_gatt_service_iter_next(&iter, &service)) {
-		if (service->start_handle >= end_handle)
-			break;
-
-		print_service(service);
-	}
-
+	gatt_db_foreach_service_in_range(cli->db, print_service, cli,
+						start_handle, end_handle);
 	print_prompt();
 }
 
-- 
2.2.0.rc0.207.ga3a616c

