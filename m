Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 3/6] tools/btgatt-server: Populate the database.
Date: Fri, 14 Nov 2014 12:20:25 -0800
Message-Id: <1415996428-17528-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1415996428-17528-1-git-send-email-armansito@chromium.org>
References: <1415996428-17528-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch populates the GATT database with the GAP and GATT services.
---
 tools/btgatt-server.c | 257 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 257 insertions(+)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index c724ab5..6a63018 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -42,12 +42,18 @@
 
 #define ATT_CID 4
 
+#define UUID_GAP 0x1800
+
 #define PRLOG(...) \
 	do { \
 		printf(__VA_ARGS__); \
 		print_prompt(); \
 	} while (0)
 
+#ifndef MIN
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
 #define COLOR_OFF	"\x1B[0m"
 #define COLOR_RED	"\x1B[0;91m"
 #define COLOR_GREEN	"\x1B[0;92m"
@@ -57,12 +63,19 @@
 #define COLOR_BOLDGRAY	"\x1B[1;30m"
 #define COLOR_BOLDWHITE	"\x1B[1;37m"
 
+static const char test_device_name[] = "Very Long Test Device Name For Testing "
+				"ATT Protocol Operations On GATT Server";
 static bool verbose = false;
 
 struct server {
 	int fd;
 	struct gatt_db *db;
 	struct bt_gatt_server *gatt;
+
+	uint8_t *device_name;
+	size_t name_len;
+
+	bool svc_chngd_enabled;
 };
 
 static void print_prompt(void)
@@ -93,10 +106,241 @@ static void gatt_debug_cb(const char *str, void *user_data)
 	PRLOG(COLOR_GREEN "%s%s\n" COLOR_OFF, prefix, str);
 }
 
+static void gap_device_name_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	struct server *server = user_data;
+	uint8_t error = 0;
+	size_t len = 0;
+	const uint8_t *value = NULL;
+
+	PRLOG("GAP Device Name Read called\n");
+
+	len = server->name_len;
+
+	if (offset > len) {
+		error = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
+	len -= offset;
+	value = len ? &server->device_name[offset] : NULL;
+
+done:
+	gatt_db_attribute_read_result(attrib, id, error, value, len);
+}
+
+static void gap_device_name_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	struct server *server = user_data;
+	uint8_t error = 0;
+
+	PRLOG("GAP Device Name Write called\n");
+
+	/* Implement this as a variable length attribute value. */
+	if (offset > server->name_len) {
+		error = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
+	if (offset + len != server->name_len) {
+		uint8_t *name;
+
+		name = realloc(server->device_name, offset + len);
+		if (!name) {
+			error = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+			goto done;
+		}
+
+		server->device_name = name;
+		server->name_len = offset + len;
+	}
+
+	if (value)
+		memcpy(server->device_name + offset, value, len);
+
+done:
+	gatt_db_attribute_write_result(attrib, id, error);
+}
+
+static void gap_device_name_ext_prop_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	uint8_t value[2];
+
+	PRLOG("Device Name Extended Properties Read called\n");
+
+	value[0] = BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE;
+	value[1] = 0;
+
+	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
+}
+
+static void gatt_service_changed_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	PRLOG("Service Changed Read called\n");
+
+	gatt_db_attribute_read_result(attrib, id, 0, NULL, 0);
+}
+
+static void gatt_svc_chngd_ccc_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	struct server *server = user_data;
+	uint8_t value[2];
+
+	PRLOG("Service Changed CCC Read called\n");
+
+	value[0] = server->svc_chngd_enabled ? 0x02 : 0x00;
+	value[1] = 0x00;
+
+	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
+}
+
+static void gatt_svc_chngd_ccc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	struct server *server = user_data;
+	uint8_t ecode = 0;
+
+	PRLOG("Service Changed CCC Write called\n");
+
+	if (!value || len != 2) {
+		ecode = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		goto done;
+	}
+
+	if (offset) {
+		ecode = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
+	if (value[0] == 0x00)
+		server->svc_chngd_enabled = false;
+	else if (value[0] == 0x02)
+		server->svc_chngd_enabled = true;
+	else
+		ecode = 0x80;
+
+	PRLOG("Service Changed Enabled: %s\n",
+				server->svc_chngd_enabled ? "true" : "false");
+
+done:
+	gatt_db_attribute_write_result(attrib, id, ecode);
+}
+
+static void confirm_write(struct gatt_db_attribute *attr, int err,
+							void *user_data)
+{
+	if (!err)
+		return;
+
+	fprintf(stderr, "Error caching attribute %p - err: %d\n", attr, err);
+	exit(1);
+}
+
+static void populate_gap_service(struct server *server)
+{
+	bt_uuid_t uuid;
+	struct gatt_db_attribute *service, *tmp;
+	uint16_t appearance;
+
+	/* Add the GAP service */
+	bt_uuid16_create(&uuid, UUID_GAP);
+	service = gatt_db_add_service(server->db, &uuid, true, 6);
+
+	/*
+	 * Device Name characteristic. Make the value dynamically read and
+	 * written via callbacks.
+	 */
+	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
+	gatt_db_service_add_characteristic(service, &uuid,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					BT_GATT_CHRC_PROP_READ,
+					gap_device_name_read_cb,
+					gap_device_name_write_cb,
+					server);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_EXT_PROPER_UUID);
+	gatt_db_service_add_descriptor(service, &uuid, BT_ATT_PERM_READ,
+					gap_device_name_ext_prop_read_cb,
+					NULL, server);
+
+	/*
+	 * Appearance characteristic. Reads and writes should obtain the value
+	 * from the database.
+	 */
+	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+	tmp = gatt_db_service_add_characteristic(service, &uuid,
+							BT_ATT_PERM_READ,
+							BT_GATT_CHRC_PROP_READ,
+							NULL, NULL, server);
+
+	/*
+	 * Write the appearance value to the database, since we're not using a
+	 * callback.
+	 */
+	put_le16(128, &appearance);
+	gatt_db_attribute_write(tmp, 0, (void *) &appearance,
+							sizeof(appearance),
+							BT_ATT_OP_WRITE_REQ,
+							NULL, confirm_write,
+							NULL);
+
+	gatt_db_service_set_active(service, true);
+}
+
+static void populate_gatt_service(struct server *server)
+{
+	bt_uuid_t uuid;
+	struct gatt_db_attribute *service;
+
+	/* Add the GATT service */
+	bt_uuid16_create(&uuid, 0x1801);
+	service = gatt_db_add_service(server->db, &uuid, true, 4);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
+	gatt_db_service_add_characteristic(service, &uuid, BT_ATT_PERM_READ,
+			BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_INDICATE,
+			gatt_service_changed_cb,
+			NULL, server);
+
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	gatt_db_service_add_descriptor(service, &uuid,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+				gatt_svc_chngd_ccc_read_cb,
+				gatt_svc_chngd_ccc_write_cb, server);
+
+	gatt_db_service_set_active(service, true);
+}
+
+static void populate_db(struct server *server)
+{
+	populate_gap_service(server);
+	populate_gatt_service(server);
+}
+
 static struct server *server_create(int fd, uint16_t mtu)
 {
 	struct server *server;
 	struct bt_att *att;
+	size_t name_len = strlen(test_device_name);
 
 	server = new0(struct server, 1);
 	if (!server) {
@@ -120,6 +364,16 @@ static struct server *server_create(int fd, uint16_t mtu)
 		goto fail;
 	}
 
+	server->name_len = name_len + 1;
+	server->device_name = malloc(name_len + 1);
+	if (!server->device_name) {
+		fprintf(stderr, "Failed to allocate memory for device name\n");
+		goto fail;
+	}
+
+	memcpy(server->device_name, test_device_name, name_len);
+	server->device_name[name_len] = '\0';
+
 	server->fd = fd;
 	server->db = gatt_db_new();
 	if (!server->db) {
@@ -142,10 +396,13 @@ static struct server *server_create(int fd, uint16_t mtu)
 	/* bt_gatt_server already holds a reference */
 	bt_att_unref(att);
 
+	populate_db(server);
+
 	return server;
 
 fail:
 	gatt_db_destroy(server->db);
+	free(server->device_name);
 	bt_att_unref(att);
 	free(server);
 
-- 
2.1.0.rc2.206.gedb03e5

