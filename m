Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 09/28] android/hog: Use gatt_db to search for services and characteristics in db
Date: Wed,  1 Apr 2015 18:40:25 +0200
Message-Id: <1427906444-11769-10-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch services and characteristics are searched in previously
cached database. This required changes in declarations of callbacks.
char_discovered_cb has been rebuilt to be called everytime when some
characteristic is found. Method of discovering report and external
report has been also simplified.

Moreover this patch:

1. Separates callbacks for services discovery:
services_cb: Services which already use database cached by bt_gatt_client
primary_cb: for attrib

2. Instead of using gatt_primary to create new instance of service
service handle will be used. On attach, having service handle we can call
gatt_db_get_attribute.
---
 android/hidhost.c |   2 +-
 android/hog.c     | 299 ++++++++++++++++++++++--------------------------------
 android/hog.h     |   4 +-
 unit/test-hog.c   |   2 +-
 4 files changed, 125 insertions(+), 182 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 47e5840..8513a1d 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -864,7 +864,7 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 	if (!dev->hog) {
 		/* TODO: Get device details */
 		dev->hog = bt_hog_new_default("bluez-input-device", dev->vendor,
-					dev->product, dev->version, NULL, 0);
+					dev->product, dev->version, 0);
 		if (!dev->hog) {
 			error("HoG: unable to create session");
 			goto fail;
diff --git a/android/hog.c b/android/hog.c
index 85a2b6a..5b93cb5 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -86,7 +86,6 @@ struct bt_hog {
 	uint16_t		vendor;
 	uint16_t		product;
 	uint16_t		version;
-	struct gatt_primary	*primary;
 	GAttrib			*attrib;
 	GSList			*reports;
 	struct bt_uhid		*uhid;
@@ -106,6 +105,7 @@ struct bt_hog {
 	struct queue		*bas;
 	GSList			*instances;
 	struct bt_gatt_client	*client;
+	struct gatt_db		*db;
 };
 
 struct report {
@@ -196,71 +196,35 @@ static void external_report_reference_cb(bool success, uint8_t status,
 					const uint8_t *value, uint16_t length,
 					void *user_data);
 
-static void discover_external_cb(uint8_t status, GSList *descs, void *user_data)
+static void discover_external_cb(struct gatt_db_attribute *attrib,
+								void *user_data)
 {
 	struct bt_hog *hog = user_data;
+	bt_uuid_t ext_rep_uuid;
+	const bt_uuid_t *uuid = gatt_db_attribute_get_type(attrib);
+	uint16_t handle = gatt_db_attribute_get_handle(attrib);
 
-	if (status != 0) {
-		error("Discover external descriptors failed: %s",
-							att_ecode2str(status));
-		return;
-	}
-
-	for ( ; descs; descs = descs->next) {
-		struct gatt_desc *desc = descs->data;
+	bt_uuid16_create(&ext_rep_uuid, GATT_EXTERNAL_REPORT_REFERENCE);
 
-		bt_gatt_client_read_value(hog->client, desc->handle,
+	if (!bt_uuid_cmp(&ext_rep_uuid, uuid))
+		bt_gatt_client_read_value(hog->client, handle,
 				external_report_reference_cb, hog, NULL);
-	}
-}
-
-static void discover_external(struct bt_hog *hog, GAttrib *attrib,
-						uint16_t start, uint16_t end,
-						gpointer user_data)
-{
-	bt_uuid_t uuid;
-
-	if (start > end)
-		return;
-
-	bt_uuid16_create(&uuid, GATT_EXTERNAL_REPORT_REFERENCE);
-
-	gatt_discover_desc(attrib, start, end, NULL, discover_external_cb,
-								user_data);
 }
 
-static void discover_report_cb(uint8_t status, GSList *descs, void *user_data)
+static void discover_report_cb(struct gatt_db_attribute *attrib,
+								void *user_data)
 {
 	struct report *report = user_data;
 	struct bt_hog *hog = report->hog;
+	bt_uuid_t rep_ref_uuid;
+	const bt_uuid_t *uuid = gatt_db_attribute_get_type(attrib);
+	uint16_t handle = gatt_db_attribute_get_handle(attrib);
 
-	if (status != 0) {
-		error("Discover report descriptors failed: %s",
-							att_ecode2str(status));
-		return;
-	}
+	bt_uuid16_create(&rep_ref_uuid, GATT_REPORT_REFERENCE);
 
-	for ( ; descs; descs = descs->next) {
-		struct gatt_desc *desc = descs->data;
-
-		switch (desc->uuid16) {
-		case GATT_REPORT_REFERENCE:
-			bt_gatt_client_read_value(hog->client, desc->handle,
+	if (!bt_uuid_cmp(&rep_ref_uuid, uuid))
+		bt_gatt_client_read_value(hog->client, handle,
 					report_reference_cb, report, NULL);
-			break;
-		}
-	}
-}
-
-static void discover_report(struct bt_hog *hog, GAttrib *attrib,
-						uint16_t start, uint16_t end,
-							gpointer user_data)
-{
-	if (start > end)
-		return;
-
-	gatt_discover_desc(attrib, start, end, NULL, discover_report_cb,
-								user_data);
 }
 
 static void report_read_cb(bool success, uint8_t att_ecode,
@@ -282,50 +246,37 @@ static void report_read_cb(bool success, uint8_t att_ecode,
 	report->len = len;
 }
 
-static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
+static struct report *report_new(struct bt_hog *hog, uint16_t value_handle,
+							uint8_t properties)
 {
 	struct report *report;
 
 	report = g_new0(struct report, 1);
 	report->hog = hog;
-	report->decl = g_memdup(chr, sizeof(*chr));
+	report->decl = new0(struct gatt_char, 1);
+	report->decl->value_handle = value_handle;
+	report->decl->properties = properties;
 	hog->reports = g_slist_append(hog->reports, report);
 
-	bt_gatt_client_read_value(hog->client, chr->value_handle,
+	bt_gatt_client_read_value(hog->client, value_handle,
 						report_read_cb, report, NULL);
 
 	return report;
 }
 
-static void external_service_char_cb(uint8_t status, GSList *chars,
-								void *user_data)
+static void external_service_char_cb(void *data, void *user_data)
 {
 	struct bt_hog *hog = user_data;
-	struct gatt_primary *primary = hog->primary;
+	struct gatt_db_attribute *attrib = data;
 	struct report *report;
-	GSList *l;
+	uint16_t value_handle;
+	uint8_t properties;
 
-	if (status != 0) {
-		const char *str = att_ecode2str(status);
-		DBG("Discover external service characteristic failed: %s", str);
-		return;
-	}
-
-	for (l = chars; l; l = g_slist_next(l)) {
-		struct gatt_char *chr, *next;
-		uint16_t start, end;
-
-		chr = l->data;
-		next = l->next ? l->next->data : NULL;
-
-		DBG("0x%04x UUID: %s properties: %02x",
-				chr->handle, chr->uuid, chr->properties);
+	gatt_db_attribute_get_char_data(attrib, NULL, &value_handle,
+							&properties, NULL);
 
-		report = report_new(hog, chr);
-		start = chr->value_handle + 1;
-		end = (next ? next->handle - 1 : primary->range.end);
-		discover_report(hog, hog->attrib, start, end, report);
-	}
+	report = report_new(hog, value_handle, properties);
+	gatt_db_service_foreach_desc(attrib, discover_report_cb, report);
 }
 
 static void external_report_reference_cb(bool success, uint8_t status,
@@ -335,6 +286,7 @@ static void external_report_reference_cb(bool success, uint8_t status,
 	struct bt_hog *hog = user_data;
 	uint16_t uuid16;
 	bt_uuid_t uuid;
+	struct queue *chrs;
 
 	if (!success) {
 		error("Read External Report Reference descriptor failed: %s",
@@ -355,9 +307,19 @@ static void external_report_reference_cb(bool success, uint8_t status,
 	if (uuid16 != HOG_REPORT_UUID)
 		return;
 
+	chrs = queue_new();
+	if (!chrs) {
+		error("Insufficient resources");
+		return;
+	}
+
 	bt_uuid16_create(&uuid, uuid16);
-	gatt_discover_char(hog->attrib, 0x0001, 0xffff, &uuid,
-					external_service_char_cb, hog);
+	gatt_db_read_by_type(hog->db, 0x0001, 0xffff, uuid, chrs);
+
+	if (queue_isempty(chrs))
+		return;
+
+	queue_foreach(chrs, external_service_char_cb, hog);
 }
 
 static int report_cmp(gconstpointer a, gconstpointer b)
@@ -824,21 +786,15 @@ static void proto_mode_read_cb(bool success, uint8_t att_ecode,
 		DBG("HoG is operating in Report Protocol Mode");
 }
 
-static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
+static void char_discovered_cb(struct gatt_db_attribute *attrib,
+								void *user_data)
 {
 	struct bt_hog *hog = user_data;
-	struct gatt_primary *primary = hog->primary;
-	bt_uuid_t report_uuid, report_map_uuid, info_uuid;
-	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
+	bt_uuid_t report_uuid, report_map_uuid, proto_mode_uuid, ctrlpt_uuid;
+	bt_uuid_t info_uuid, uuid;
 	struct report *report;
-	GSList *l;
-	uint16_t info_handle = 0, proto_mode_handle = 0;
-
-	if (status != 0) {
-		const char *str = att_ecode2str(status);
-		DBG("Discover all characteristics failed: %s", str);
-		return;
-	}
+	uint16_t value_handle;
+	uint8_t properties;
 
 	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
 	bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
@@ -846,47 +802,27 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 	bt_uuid16_create(&proto_mode_uuid, HOG_PROTO_MODE_UUID);
 	bt_uuid16_create(&ctrlpt_uuid, HOG_CONTROL_POINT_UUID);
 
-	for (l = chars; l; l = g_slist_next(l)) {
-		struct gatt_char *chr, *next;
-		bt_uuid_t uuid;
-		uint16_t start, end;
-
-		chr = l->data;
-		next = l->next ? l->next->data : NULL;
-
-		DBG("0x%04x UUID: %s properties: %02x",
-				chr->handle, chr->uuid, chr->properties);
-
-		bt_string_to_uuid(&uuid, chr->uuid);
-
-		start = chr->value_handle + 1;
-		end = (next ? next->handle - 1 : primary->range.end);
-
-		if (bt_uuid_cmp(&uuid, &report_uuid) == 0) {
-			report = report_new(hog, chr);
-			discover_report(hog, hog->attrib, start, end, report);
-		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
-			bt_gatt_client_read_long_value(hog->client,
-				chr->value_handle, 0, report_map_read_cb,
-				hog, NULL);
-			discover_external(hog, hog->attrib, start, end, hog);
-		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
-			info_handle = chr->value_handle;
-		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
-			proto_mode_handle = chr->value_handle;
-		else if (bt_uuid_cmp(&uuid, &ctrlpt_uuid) == 0)
-			hog->ctrlpt_handle = chr->value_handle;
-	}
-
-	if (proto_mode_handle) {
-		hog->proto_mode_handle = proto_mode_handle;
-		bt_gatt_client_read_value(hog->client, proto_mode_handle,
+	gatt_db_attribute_get_char_data(attrib, NULL, &value_handle,
+							&properties, &uuid);
+
+	if (!bt_uuid_cmp(&uuid, &report_uuid)) {
+		report = report_new(hog, value_handle, properties);
+		gatt_db_service_foreach_desc(attrib, discover_report_cb,
+									report);
+	} else if (!bt_uuid_cmp(&uuid, &report_map_uuid)) {
+		bt_gatt_client_read_long_value(hog->client, value_handle, 0,
+						report_map_read_cb, hog, NULL);
+		gatt_db_service_foreach_desc(attrib, discover_external_cb, hog);
+	} else if (!bt_uuid_cmp(&uuid, &info_uuid)) {
+		bt_gatt_client_read_value(hog->client, value_handle,
+						info_read_cb, hog, NULL);
+	} else if (!bt_uuid_cmp(&uuid, &proto_mode_uuid)) {
+		hog->proto_mode_handle = value_handle;
+		bt_gatt_client_read_value(hog->client, value_handle,
 						proto_mode_read_cb, hog, NULL);
+	} else if (!bt_uuid_cmp(&uuid, &ctrlpt_uuid)) {
+		hog->ctrlpt_handle = value_handle;
 	}
-
-	if (info_handle)
-		bt_gatt_client_read_value(hog->client, info_handle,
-						info_read_cb, hog, NULL);
 }
 
 static void report_free(void *data)
@@ -894,7 +830,7 @@ static void report_free(void *data)
 	struct report *report = data;
 
 	g_free(report->value);
-	g_free(report->decl);
+	free(report->decl);
 	g_free(report);
 }
 
@@ -912,21 +848,19 @@ static void hog_free(void *data)
 	bt_uhid_unref(hog->uhid);
 	g_slist_free_full(hog->reports, report_free);
 	g_free(hog->name);
-	g_free(hog->primary);
 	g_free(hog);
 }
 
 struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					void *primary, uint16_t service_handle)
+					uint16_t service_handle)
 {
-	return bt_hog_new(-1, name, vendor, product, version, primary,
-								service_handle);
+	return bt_hog_new(-1, name, vendor, product, version, service_handle);
 }
 
 struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					void *primary, uint16_t service_handle)
+					uint16_t service_handle)
 {
 	struct bt_hog *hog;
 
@@ -953,9 +887,6 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 	hog->product = product;
 	hog->version = version;
 
-	if (primary)
-		hog->primary = g_memdup(primary, sizeof(*hog->primary));
-
 	if (service_handle)
 		hog->service_handle = service_handle;
 
@@ -983,24 +914,13 @@ void bt_hog_unref(struct bt_hog *hog)
 	hog_free(hog);
 }
 
-static void find_included_cb(uint8_t status, GSList *services, void *user_data)
+static void find_included_cb(struct gatt_db_attribute *attrib, void *user_data)
 {
-	GSList *l;
-
-	DBG("");
-
-	if (status) {
-		const char *str = att_ecode2str(status);
-		DBG("Find included failed: %s", str);
-		return;
-	}
+	uint16_t start_handle;
 
-	for (l = services; l; l = l->next) {
-		struct gatt_included *include = l->data;
+	gatt_db_attribute_get_incl_data(attrib, NULL, &start_handle, NULL);
 
-		DBG("included: handle %x, uuid %s",
-			include->handle, include->uuid);
-	}
+	DBG("included: handle %x", start_handle);
 }
 
 static void hog_attach_scpp(struct bt_hog *hog, struct gatt_primary *primary)
@@ -1051,28 +971,25 @@ static void hog_attach_bas(struct bt_hog *hog, struct gatt_primary *primary)
 	queue_push_head(hog->bas, instance);
 }
 
-static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
+static void hog_attach_hog(struct bt_hog *hog, uint16_t service_handle)
 {
 	struct bt_hog *instance;
+	struct gatt_db_attribute *attrib;
+
+	attrib = gatt_db_get_attribute(hog->db, service_handle);
 
-	if (!hog->primary) {
-		hog->primary = g_memdup(primary, sizeof(*primary));
-		gatt_discover_char(hog->attrib, primary->range.start,
-						primary->range.end, NULL,
-						char_discovered_cb, hog);
-		gatt_find_included(hog->attrib, primary->range.start,
-				primary->range.end, find_included_cb, hog);
+	if (!hog->service_handle) {
+		hog->service_handle = service_handle;
+		gatt_db_service_foreach_char(attrib, char_discovered_cb, hog);
+		gatt_db_service_foreach_incl(attrib, find_included_cb, hog);
 		return;
 	}
 
 	instance = bt_hog_new(hog->uhid_fd, hog->name, hog->vendor,
-					hog->product, hog->version, primary, 0);
+				hog->product, hog->version, service_handle);
 	if (!instance)
 		return;
 
-	gatt_find_included(hog->attrib, primary->range.start,
-			primary->range.end, find_included_cb, instance);
-
 	bt_hog_attach(instance, hog->attrib, hog->client);
 	hog->instances = g_slist_append(hog->instances, instance);
 }
@@ -1111,17 +1028,38 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 
 		if (strcmp(primary->uuid, BATTERY_UUID) == 0) {
 			hog_attach_bas(hog, primary);
-			continue;
 		}
-
-		if (strcmp(primary->uuid, HOG_UUID) == 0)
-			hog_attach_hog(hog, primary);
 	}
 }
 
+static void service_cb(struct gatt_db_attribute *attrib, void *user_data)
+{
+	struct bt_hog *hog = user_data;
+	bt_uuid_t service_uuid;
+	char uuid[MAX_LEN_UUID_STR + 1];
+	uint16_t service_handle;
+
+	if (!gatt_db_attribute_get_service_data(attrib, &service_handle,
+						NULL, NULL, &service_uuid))
+		return;
+
+	bt_uuid_to_string(&service_uuid, uuid, sizeof(uuid));
+
+	if (!bt_uuid_strcmp(uuid, HOG_UUID))
+		hog_attach_hog(hog, service_handle);
+	else if (!bt_uuid_strcmp(uuid, SCAN_PARAMETERS_UUID))
+		/* TODO */
+		return;
+	else if (!bt_uuid_strcmp(uuid, DEVICE_INFORMATION_UUID))
+		/* TODO */
+		return;
+	else if (!bt_uuid_strcmp(uuid, BATTERY_UUID))
+		/* TODO */
+		return;
+}
+
 bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 {
-	struct gatt_primary *primary = hog->primary;
 	GSList *l;
 
 	if (hog->attrib || hog->client)
@@ -1129,8 +1067,10 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 
 	hog->attrib = g_attrib_ref(gatt);
 	hog->client = bt_gatt_client_ref(client);
+	hog->db = bt_gatt_client_get_db(hog->client);
 
-	if (!primary) {
+	if (!hog->service_handle) {
+		gatt_db_foreach_service(hog->db, NULL, service_cb, hog);
 		gatt_discover_primary(hog->attrib, NULL, primary_cb, hog);
 		return true;
 	}
@@ -1150,9 +1090,11 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 	}
 
 	if (hog->reports == NULL) {
-		gatt_discover_char(hog->attrib, primary->range.start,
-						primary->range.end, NULL,
-						char_discovered_cb, hog);
+		struct gatt_db_attribute *service;
+
+		service = gatt_db_get_attribute(hog->db, hog->service_handle);
+		gatt_db_service_foreach_char(service, char_discovered_cb, hog);
+		gatt_db_service_foreach_incl(service, find_included_cb, hog);
 		return true;
 	}
 
@@ -1199,6 +1141,7 @@ void bt_hog_detach(struct bt_hog *hog)
 	if (hog->dis)
 		bt_dis_detach(hog->dis);
 
+	gatt_db_unref(hog->db);
 	bt_gatt_client_unref(hog->client);
 	g_attrib_unref(hog->attrib);
 	hog->client = NULL;
diff --git a/android/hog.h b/android/hog.h
index 61d756c..cfe6873 100644
--- a/android/hog.h
+++ b/android/hog.h
@@ -25,11 +25,11 @@ struct bt_hog;
 
 struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					void *primary, uint16_t service_handle);
+					uint16_t service_handle);
 
 struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					void *primary, uint16_t service_handle);
+					uint16_t service_handle);
 
 struct bt_hog *bt_hog_ref(struct bt_hog *hog);
 void bt_hog_unref(struct bt_hog *hog);
diff --git a/unit/test-hog.c b/unit/test-hog.c
index c7c64e4..5794c5e 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -196,7 +196,7 @@ static struct context *create_context(gconstpointer data)
 	fd = open("/dev/null", O_WRONLY | O_CLOEXEC);
 	g_assert(fd > 0);
 
-	context->hog = bt_hog_new(fd, name, vendor, product, version, NULL, 0);
+	context->hog = bt_hog_new(fd, name, vendor, product, version, 0);
 	g_assert(context->hog);
 
 	channel = g_io_channel_unix_new(sv[1]);
-- 
1.9.1

