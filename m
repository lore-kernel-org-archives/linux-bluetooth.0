Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 6/7] tools/btgatt-server: Add Heart Rate service simulation.
Date: Thu, 13 Nov 2014 18:49:52 -0800
Message-Id: <1415933393-28902-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1415933393-28902-1-git-send-email-armansito@chromium.org>
References: <1415933393-28902-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a Heart Rate service to the database which simulates a
fake Heart Rate service implementation. The service can be enabled by
default by passing the '-r' flag to the executable.
---
 tools/btgatt-server.c | 211 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 204 insertions(+), 7 deletions(-)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 4fcf10e..76ebc9a 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -23,6 +23,7 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <stdint.h>
+#include <time.h>
 #include <stdlib.h>
 #include <getopt.h>
 #include <unistd.h>
@@ -38,12 +39,18 @@
 #include "src/shared/util.h"
 #include "src/shared/att.h"
 #include "src/shared/queue.h"
+#include "src/shared/timeout.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-server.h"
 
-#define ATT_CID 4
+#define UUID_GAP			0x1800
+#define UUID_GATT			0x1801
+#define UUID_HEART_RATE			0x180d
+#define UUID_HEART_RATE_MSRMT		0x2a37
+#define UUID_HEART_RATE_BODY		0x2a38
+#define UUID_HEART_RATE_CTRL		0x2a39
 
-#define UUID_GAP 0x1800
+#define ATT_CID 4
 
 #define PRLOG(...) \
 	do { \
@@ -77,6 +84,13 @@ struct server {
 	size_t name_len;
 
 	bool svc_chngd_enabled;
+
+	uint16_t hr_msrmt_handle;
+	uint16_t hr_energy_expended;
+	bool hr_visible;
+	bool hr_msrmt_enabled;
+	int hr_ee_count;
+	unsigned int hr_timeout_id;
 };
 
 static void print_prompt(void)
@@ -248,6 +262,127 @@ done:
 	gatt_db_attribute_write_result(attrib, id, ecode);
 }
 
+static void hr_msrmt_ccc_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	struct server *server = user_data;
+	uint8_t value[2];
+
+	value[0] = server->hr_msrmt_enabled ? 0x01 : 0x00;
+	value[1] = 0x00;
+
+	gatt_db_attribute_read_result(attrib, id, 0, value, 2);
+}
+
+static bool hr_msrmt_cb(void *user_data)
+{
+	struct server *server = user_data;
+	bool expended_present = !(server->hr_ee_count % 10);
+	uint16_t len = 2;
+	uint8_t pdu[4];
+	uint32_t cur_ee;
+
+	pdu[0] = 0x06;
+	pdu[1] = 90 + (rand() % 40);
+
+	if (expended_present) {
+		pdu[0] |= 0x08;
+		put_le16(server->hr_energy_expended, pdu + 2);
+		len += 2;
+	}
+
+	bt_gatt_server_send_notification(server->gatt,
+						server->hr_msrmt_handle,
+						pdu, len);
+
+
+	cur_ee = server->hr_energy_expended;
+	server->hr_energy_expended = MIN(UINT16_MAX, cur_ee + 10);
+	server->hr_ee_count++;
+
+	return true;
+}
+
+static void update_hr_msrmt_simulation(struct server *server)
+{
+	if (!server->hr_msrmt_enabled || !server->hr_visible) {
+		timeout_remove(server->hr_timeout_id);
+		return;
+	}
+
+	server->hr_timeout_id = timeout_add(1000, hr_msrmt_cb, server, NULL);
+}
+
+static void hr_msrmt_ccc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	struct server *server = user_data;
+	uint8_t ecode = 0;
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
+		server->hr_msrmt_enabled = false;
+	else if (value[0] == 0x01) {
+		if (server->hr_msrmt_enabled) {
+			PRLOG("HR Measurement Already Enabled\n");
+			goto done;
+		}
+
+		server->hr_msrmt_enabled = true;
+	} else
+		ecode = 0x80;
+
+	PRLOG("HR: Measurement Enabled: %s\n",
+				server->hr_msrmt_enabled ? "true" : "false");
+
+	update_hr_msrmt_simulation(server);
+
+done:
+	gatt_db_attribute_write_result(attrib, id, ecode);
+}
+
+static void hr_control_point_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	struct server *server = user_data;
+	uint8_t ecode = 0;
+
+	if (!value || len != 1) {
+		ecode = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		goto done;
+	}
+
+	if (offset) {
+		ecode = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
+	if (value[0] == 1) {
+		PRLOG("HR: Energy Expended value reset\n");
+		server->hr_energy_expended = 0;
+	}
+
+done:
+	gatt_db_attribute_write_result(attrib, id, ecode);
+}
+
 static void confirm_write(struct gatt_db_attribute *attr, int err,
 							void *user_data)
 {
@@ -315,7 +450,7 @@ static void populate_gatt_service(struct server *server)
 	struct gatt_db_attribute *service;
 
 	/* Add the GATT service */
-	bt_uuid16_create(&uuid, 0x1801);
+	bt_uuid16_create(&uuid, UUID_GATT);
 	service = gatt_db_add_service(server->db, &uuid, true, 4);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
@@ -333,13 +468,64 @@ static void populate_gatt_service(struct server *server)
 	gatt_db_service_set_active(service, true);
 }
 
+static void populate_hr_service(struct server *server)
+{
+	bt_uuid_t uuid;
+	struct gatt_db_attribute *service, *hr_msrmt, *body;
+	uint8_t body_loc = 1;  /* "Chest" */
+
+	/* Add Heart Rate Service */
+	bt_uuid16_create(&uuid, UUID_HEART_RATE);
+	service = gatt_db_add_service(server->db, &uuid, true, 8);
+
+	/* HR Measurement Characteristic */
+	bt_uuid16_create(&uuid, UUID_HEART_RATE_MSRMT);
+	hr_msrmt = gatt_db_service_add_characteristic(service, &uuid,
+						BT_ATT_PERM_NONE,
+						BT_GATT_CHRC_PROP_NOTIFY,
+						NULL, NULL, NULL);
+	server->hr_msrmt_handle = gatt_db_attribute_get_handle(hr_msrmt);
+
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	gatt_db_service_add_descriptor(service, &uuid,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					hr_msrmt_ccc_read_cb,
+					hr_msrmt_ccc_write_cb, server);
+
+	/*
+	 * Body Sensor Location Characteristic. Make reads obtain the value from
+	 * the database.
+	 */
+	bt_uuid16_create(&uuid, UUID_HEART_RATE_BODY);
+	body = gatt_db_service_add_characteristic(service, &uuid,
+						BT_ATT_PERM_READ,
+						BT_GATT_CHRC_PROP_READ,
+						NULL, NULL, server);
+	gatt_db_attribute_write(body, 0, (void *) &body_loc, sizeof(body_loc),
+							BT_ATT_OP_WRITE_REQ,
+							NULL, confirm_write,
+							NULL);
+
+	/* HR Control Point Characteristic */
+	bt_uuid16_create(&uuid, UUID_HEART_RATE_CTRL);
+	gatt_db_service_add_characteristic(service, &uuid,
+						BT_ATT_PERM_WRITE,
+						BT_GATT_CHRC_PROP_WRITE,
+						NULL, hr_control_point_write_cb,
+						server);
+
+	if (server->hr_visible)
+		gatt_db_service_set_active(service, true);
+}
+
 static void populate_db(struct server *server)
 {
 	populate_gap_service(server);
 	populate_gatt_service(server);
+	populate_hr_service(server);
 }
 
-static struct server *server_create(int fd, uint16_t mtu)
+static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 {
 	struct server *server;
 	struct bt_att *att;
@@ -390,15 +576,19 @@ static struct server *server_create(int fd, uint16_t mtu)
 		goto fail;
 	}
 
+	server->hr_visible = hr_visible;
+
 	if (verbose) {
 		bt_att_set_debug(att, att_debug_cb, "att: ", NULL);
 		bt_gatt_server_set_debug(server->gatt, gatt_debug_cb,
 							"server: ", NULL);
 	}
 
+	/* Random seed for generating fake Heart Rate measurements */
+	srand(time(NULL));
+
 	/* bt_gatt_server already holds a reference */
 	bt_att_unref(att);
-
 	populate_db(server);
 
 	return server;
@@ -414,6 +604,7 @@ fail:
 
 static void server_destroy(struct server *server)
 {
+	timeout_remove(server->hr_timeout_id);
 	bt_gatt_server_unref(server->gatt);
 	gatt_db_destroy(server->db);
 }
@@ -429,6 +620,7 @@ static void usage(void)
 		"\t-s, --security-level <sec>\tSet security level (low|"
 								"medium|high)\n"
 		"\t-v, --verbose\t\t\tEnable extra logging\n"
+		"\t-r, --heart-rate\t\tEnable Heart Rate service"
 		"\t-h, --help\t\t\tDisplay help\n");
 }
 
@@ -437,6 +629,7 @@ static struct option main_options[] = {
 	{ "mtu",		1, 0, 'm' },
 	{ "security-level",	1, 0, 's' },
 	{ "verbose",		0, 0, 'v' },
+	{ "heart-rate",		0, 0, 'r' },
 	{ "help",		0, 0, 'h' },
 	{ }
 };
@@ -722,9 +915,10 @@ int main(int argc, char *argv[])
 	int dev_id = -1;
 	int fd;
 	sigset_t mask;
+	bool hr_visible = false;
 	struct server *server;
 
-	while ((opt = getopt_long(argc, argv, "+hvs:m:i:",
+	while ((opt = getopt_long(argc, argv, "+hvrs:m:i:",
 						main_options, NULL)) != -1) {
 		switch (opt) {
 		case 'h':
@@ -733,6 +927,9 @@ int main(int argc, char *argv[])
 		case 'v':
 			verbose = true;
 			break;
+		case 'r':
+			hr_visible = true;
+			break;
 		case 's':
 			if (strcmp(optarg, "low") == 0)
 				sec = BT_SECURITY_LOW;
@@ -800,7 +997,7 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	server = server_create(fd, mtu);
+	server = server_create(fd, mtu, hr_visible);
 	if (!server) {
 		close(fd);
 		return EXIT_FAILURE;
-- 
2.1.0.rc2.206.gedb03e5

