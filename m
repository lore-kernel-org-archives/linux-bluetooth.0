Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 3/3] shared/gatt-db: enable foreach early termination
Date: Fri, 12 Dec 2014 10:44:24 -0800
Message-Id: <1418409864-26119-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418409864-26119-1-git-send-email-jamuraa@chromium.org>
References: <1418409864-26119-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds early termination to the iteration callbacks used in
gatt-db.  Returning false from a callback will terminate the iteration.
---
 src/shared/gatt-client.c |  9 ++++-----
 src/shared/gatt-db.c     | 10 ++++++----
 src/shared/gatt-db.h     |  2 +-
 tools/btgatt-client.c    | 32 ++++++++++++++++++++++----------
 tools/btgatt-server.c    | 24 ++++++++++++++++--------
 unit/test-gatt.c         | 35 ++++++++++++++++++++---------------
 6 files changed, 69 insertions(+), 43 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 696cd13..0e11656 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -137,20 +137,19 @@ static void notify_data_unref(void *data)
 	free(notify_data);
 }
 
-static void find_ccc(struct gatt_db_attribute *attr, void *user_data)
+static bool find_ccc(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct gatt_db_attribute **ccc_ptr = user_data;
 	bt_uuid_t uuid;
 
-	if (*ccc_ptr)
-		return;
-
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 
 	if (bt_uuid_cmp(&uuid, gatt_db_attribute_get_type(attr)))
-		return;
+		return true;
 
 	*ccc_ptr = attr;
+
+	return false;
 }
 
 static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 0682248..a1461ba 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1029,8 +1029,8 @@ static bool foreach_service_in_range(void *data, void *user_data)
 			return true;
 	}
 
-	foreach_data->func(service->attributes[0], foreach_data->user_data);
-	return true;
+	return foreach_data->func(service->attributes[0],
+						foreach_data->user_data);
 }
 
 void gatt_db_foreach_service_in_range(struct gatt_db *db,
@@ -1076,7 +1076,8 @@ void gatt_db_service_foreach(struct gatt_db_attribute *attrib,
 		if (uuid && bt_uuid_cmp(uuid, &attr->uuid))
 			continue;
 
-		func(attr, user_data);
+		if (!func(attr, user_data))
+			return;
 	}
 }
 
@@ -1116,7 +1117,8 @@ void gatt_db_service_foreach_desc(struct gatt_db_attribute *attrib,
 			!bt_uuid_cmp(&included_service_uuid, &attr->uuid))
 			return;
 
-		func(attr, user_data);
+		if (!func(attr, user_data))
+			return;
 	}
 }
 
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index e5fe6bb..4ecaf6a 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -102,7 +102,7 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 							struct queue *queue);
 
 
-typedef void (*gatt_db_attribute_cb_t)(struct gatt_db_attribute *attrib,
+typedef bool (*gatt_db_attribute_cb_t)(struct gatt_db_attribute *attrib,
 							void *user_data);
 
 void gatt_db_foreach_service(struct gatt_db *db, const bt_uuid_t *uuid,
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 015142d..5da72f8 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -114,14 +114,18 @@ static void log_service_event(struct gatt_db_attribute *attr, const char *str)
 								start, end);
 }
 
-static void service_added_cb(struct gatt_db_attribute *attr, void *user_data)
+static bool service_added_cb(struct gatt_db_attribute *attr, void *user_data)
 {
 	log_service_event(attr, "Service Added");
+
+	return true;
 }
 
-static void service_removed_cb(struct gatt_db_attribute *attr, void *user_data)
+static bool service_removed_cb(struct gatt_db_attribute *attr, void *user_data)
 {
 	log_service_event(attr, "Service Removed");
+
+	return true;
 }
 
 static struct client *client_create(int fd, uint16_t mtu)
@@ -211,7 +215,7 @@ static void print_uuid(const bt_uuid_t *uuid)
 	printf("%s\n", uuid_str);
 }
 
-static void print_incl(struct gatt_db_attribute *attr, void *user_data)
+static bool print_incl(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct client *cli = user_data;
 	uint16_t handle, start, end;
@@ -219,11 +223,11 @@ static void print_incl(struct gatt_db_attribute *attr, void *user_data)
 	bt_uuid_t uuid;
 
 	if (!gatt_db_attribute_get_incl_data(attr, &handle, &start, &end))
-		return;
+		return true;
 
 	service = gatt_db_get_attribute(cli->db, start);
 	if (!service)
-		return;
+		return true;
 
 	gatt_db_attribute_get_service_uuid(service, &uuid);
 
@@ -231,17 +235,21 @@ static void print_incl(struct gatt_db_attribute *attr, void *user_data)
 					"0x%04x, - start: 0x%04x, end: 0x%04x,"
 					"uuid: ", handle, start, end);
 	print_uuid(&uuid);
+
+	return true;
 }
 
-static void print_desc(struct gatt_db_attribute *attr, void *user_data)
+static bool print_desc(struct gatt_db_attribute *attr, void *user_data)
 {
 	printf("\t\t  " COLOR_MAGENTA "descr" COLOR_OFF
 					" - handle: 0x%04x, uuid: ",
 					gatt_db_attribute_get_handle(attr));
 	print_uuid(gatt_db_attribute_get_type(attr));
+
+	return true;
 }
 
-static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
+static bool print_chrc(struct gatt_db_attribute *attr, void *user_data)
 {
 	uint16_t handle, value_handle;
 	uint8_t properties;
@@ -251,7 +259,7 @@ static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
 								&value_handle,
 								&properties,
 								&uuid))
-		return;
+		return true;
 
 	printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
 					" - start: 0x%04x, value: 0x%04x, "
@@ -260,9 +268,11 @@ static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
 	print_uuid(&uuid);
 
 	gatt_db_service_foreach_desc(attr, print_desc, NULL);
+
+	return true;
 }
 
-static void print_service(struct gatt_db_attribute *attr, void *user_data)
+static bool print_service(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct client *cli = user_data;
 	uint16_t start, end;
@@ -271,7 +281,7 @@ static void print_service(struct gatt_db_attribute *attr, void *user_data)
 
 	if (!gatt_db_attribute_get_service_data(attr, &start, &end, &primary,
 									&uuid))
-		return;
+		return true;
 
 	printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
 				"end: 0x%04x, type: %s, uuid: ",
@@ -282,6 +292,8 @@ static void print_service(struct gatt_db_attribute *attr, void *user_data)
 	gatt_db_service_foreach_char(attr, print_chrc, NULL);
 
 	printf("\n");
+
+	return true;
 }
 
 static void print_services(struct client *cli)
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 1a9b9fb..4533636 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -894,7 +894,7 @@ static void print_uuid(const bt_uuid_t *uuid)
 	printf("%s\n", uuid_str);
 }
 
-static void print_incl(struct gatt_db_attribute *attr, void *user_data)
+static bool print_incl(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct server *server = user_data;
 	uint16_t handle, start, end;
@@ -902,11 +902,11 @@ static void print_incl(struct gatt_db_attribute *attr, void *user_data)
 	bt_uuid_t uuid;
 
 	if (!gatt_db_attribute_get_incl_data(attr, &handle, &start, &end))
-		return;
+		return true;
 
 	service = gatt_db_get_attribute(server->db, start);
 	if (!service)
-		return;
+		return true;
 
 	gatt_db_attribute_get_service_uuid(service, &uuid);
 
@@ -914,17 +914,21 @@ static void print_incl(struct gatt_db_attribute *attr, void *user_data)
 					"0x%04x, - start: 0x%04x, end: 0x%04x,"
 					"uuid: ", handle, start, end);
 	print_uuid(&uuid);
+
+	return true;
 }
 
-static void print_desc(struct gatt_db_attribute *attr, void *user_data)
+static bool print_desc(struct gatt_db_attribute *attr, void *user_data)
 {
 	printf("\t\t  " COLOR_MAGENTA "descr" COLOR_OFF
 					" - handle: 0x%04x, uuid: ",
 					gatt_db_attribute_get_handle(attr));
 	print_uuid(gatt_db_attribute_get_type(attr));
+
+	return true;
 }
 
-static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
+static bool print_chrc(struct gatt_db_attribute *attr, void *user_data)
 {
 	uint16_t handle, value_handle;
 	uint8_t properties;
@@ -934,7 +938,7 @@ static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
 								&value_handle,
 								&properties,
 								&uuid))
-		return;
+		return true;
 
 	printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
 					" - start: 0x%04x, value: 0x%04x, "
@@ -943,9 +947,11 @@ static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
 	print_uuid(&uuid);
 
 	gatt_db_service_foreach_desc(attr, print_desc, NULL);
+
+	return true;
 }
 
-static void print_service(struct gatt_db_attribute *attr, void *user_data)
+static bool print_service(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct server *server = user_data;
 	uint16_t start, end;
@@ -954,7 +960,7 @@ static void print_service(struct gatt_db_attribute *attr, void *user_data)
 
 	if (!gatt_db_attribute_get_service_data(attr, &start, &end, &primary,
 									&uuid))
-		return;
+		return true;
 
 	printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
 				"end: 0x%04x, type: %s, uuid: ",
@@ -965,6 +971,8 @@ static void print_service(struct gatt_db_attribute *attr, void *user_data)
 	gatt_db_service_foreach_char(attr, print_chrc, NULL);
 
 	printf("\n");
+
+	return true;
 }
 
 static void cmd_services(struct server *server, char *cmd_str)
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 5f5ad1b..9e072a8 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -313,19 +313,18 @@ static bool matching_desc_data(struct gatt_db_attribute *a,
 	return a_handle == b_handle && !bt_uuid_cmp(a_uuid, b_uuid);
 }
 
-static void find_matching_desc(struct gatt_db_attribute *source_desc_attr,
+static bool find_matching_desc(struct gatt_db_attribute *source_desc_attr,
 								void *user_data)
 {
 	struct db_attribute_test_data *desc_test_data = user_data;
 
-	if (desc_test_data->found)
-		return;
-
 	desc_test_data->found = matching_desc_data(desc_test_data->match,
 							source_desc_attr);
+
+	return !desc_test_data->found;
 }
 
-static void match_descs(struct gatt_db_attribute *client_desc_attr,
+static bool match_descs(struct gatt_db_attribute *client_desc_attr,
 								void *user_data)
 {
 	struct gatt_db_attribute *source_char_attr = user_data;
@@ -338,6 +337,8 @@ static void match_descs(struct gatt_db_attribute *client_desc_attr,
 							&desc_test_data);
 
 	g_assert(desc_test_data.found);
+
+	return true;
 }
 
 static bool matching_char_data(struct gatt_db_attribute *a,
@@ -357,23 +358,23 @@ static bool matching_char_data(struct gatt_db_attribute *a,
 						!bt_uuid_cmp(&a_uuid, &b_uuid);
 }
 
-static void find_matching_char(struct gatt_db_attribute *source_char_attr,
+static bool find_matching_char(struct gatt_db_attribute *source_char_attr,
 								void *user_data)
 {
 	struct db_attribute_test_data *char_test_data = user_data;
 
-	if (char_test_data->found)
-		return;
-
 	if (matching_char_data(char_test_data->match, source_char_attr)) {
 
 		gatt_db_service_foreach_desc(char_test_data->match, match_descs,
 							source_char_attr);
 		char_test_data->found = true;
+		return false;
 	}
+
+	return true;
 }
 
-static void match_chars(struct gatt_db_attribute *client_char_attr,
+static bool match_chars(struct gatt_db_attribute *client_char_attr,
 								void *user_data)
 {
 	struct gatt_db_attribute *source_serv_attr = user_data;
@@ -386,6 +387,8 @@ static void match_chars(struct gatt_db_attribute *client_char_attr,
 							&char_test_data);
 
 	g_assert(char_test_data.found);
+
+	return true;
 }
 
 static bool matching_service_data(struct gatt_db_attribute *a,
@@ -404,22 +407,22 @@ static bool matching_service_data(struct gatt_db_attribute *a,
 						!bt_uuid_cmp(&a_uuid, &b_uuid);
 }
 
-static void find_matching_service(struct gatt_db_attribute *source_serv_attr,
+static bool find_matching_service(struct gatt_db_attribute *source_serv_attr,
 								void *user_data)
 {
 	struct db_attribute_test_data *serv_test_data = user_data;
 
-	if (serv_test_data->found)
-		return;
-
 	if (matching_service_data(serv_test_data->match, source_serv_attr)) {
 		gatt_db_service_foreach_char(serv_test_data->match, match_chars,
 							source_serv_attr);
 		serv_test_data->found = true;
+		return false;
 	}
+
+	return true;
 }
 
-static void match_services(struct gatt_db_attribute *client_serv_attr,
+static bool match_services(struct gatt_db_attribute *client_serv_attr,
 								void *user_data)
 {
 	struct gatt_db *source_db = user_data;
@@ -432,6 +435,8 @@ static void match_services(struct gatt_db_attribute *client_serv_attr,
 					find_matching_service, &serv_test_data);
 
 	g_assert(serv_test_data.found);
+
+	return true;
 }
 
 static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
-- 
2.2.0.rc0.207.ga3a616c

