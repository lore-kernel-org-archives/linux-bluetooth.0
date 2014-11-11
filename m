Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 5/8] tools/btgatt-server: Add Heart Rate service simulation.
Date: Tue, 11 Nov 2014 13:39:44 -0800
Message-Id: <1415741987-22272-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1415741987-22272-1-git-send-email-armansito@chromium.org>
References: <1415741987-22272-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a Heart Rate service to the database which simulates a
fake Heart Rate service implementation. The service can be enabled by
default by passing the '-r' flag to the executable.
---
 tools/btgatt-server.c | 215 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 207 insertions(+), 8 deletions(-)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 067e258..1315a62 100644
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
@@ -51,6 +58,10 @@
 		print_prompt(); \
 	} while (0)
 
+#ifndef MIN
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
 #define COLOR_OFF	"\x1B[0m"
 #define COLOR_RED	"\x1B[0;91m"
 #define COLOR_GREEN	"\x1B[0;92m"
@@ -73,6 +84,12 @@ struct server {
 	size_t name_len;
 
 	bool svc_chngd_enabled;
+
+	uint16_t hr_msrmt_handle;
+	uint16_t hr_energy_expended;
+	bool hr_visible;
+	bool hr_msrmt_enabled;
+	unsigned int hr_timeout_id;
 };
 
 static void print_prompt(void)
@@ -257,10 +274,147 @@ done:
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
+static int count = 0;
+static bool hr_msrmt_cb(void *user_data)
+{
+	struct server *server = user_data;
+	bool expended_present = !(count % 10);
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
+	count++;
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
+static void hr_body_sensor_location_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	uint8_t value;
+
+	PRLOG("HR: Body Sensor Location Read\n");
+
+	/* Report "Chest" as the location */
+	value = 1;
+
+	gatt_db_attribute_read_result(attrib, id, 0, &value, 1);
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
 static void populate_db(struct server *server)
 {
 	bt_uuid_t uuid;
-	struct gatt_db_attribute *attr;
+	struct gatt_db_attribute *attr, *hr_msrmt;
 
 	/* Add the GAP service */
 	bt_uuid16_create(&uuid, UUID_GAP);
@@ -290,7 +444,7 @@ static void populate_db(struct server *server)
 	gatt_db_service_set_active(attr, true);
 
 	/* Add the GATT service */
-	bt_uuid16_create(&uuid, 0x1801);
+	bt_uuid16_create(&uuid, UUID_GATT);
 	attr = gatt_db_add_service(server->db, &uuid, true, 4);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
@@ -306,9 +460,43 @@ static void populate_db(struct server *server)
 				gatt_svc_chngd_ccc_write_cb, server);
 
 	gatt_db_service_set_active(attr, true);
+
+	/* Add Heart Rate Service */
+	bt_uuid16_create(&uuid, UUID_HEART_RATE);
+	attr = gatt_db_add_service(server->db, &uuid, true, 8);
+
+	bt_uuid16_create(&uuid, UUID_HEART_RATE_MSRMT);
+	hr_msrmt = gatt_db_service_add_characteristic(attr, &uuid,
+						BT_ATT_PERM_NONE,
+						BT_GATT_CHRC_PROP_NOTIFY,
+						NULL, NULL, NULL);
+	server->hr_msrmt_handle = gatt_db_attribute_get_handle(hr_msrmt);
+
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	gatt_db_service_add_descriptor(attr, &uuid,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					hr_msrmt_ccc_read_cb,
+					hr_msrmt_ccc_write_cb, server);
+
+	bt_uuid16_create(&uuid, UUID_HEART_RATE_BODY);
+	gatt_db_service_add_characteristic(attr, &uuid,
+						BT_ATT_PERM_READ,
+						BT_GATT_CHRC_PROP_READ,
+						hr_body_sensor_location_read_cb,
+						NULL, server);
+
+	bt_uuid16_create(&uuid, UUID_HEART_RATE_CTRL);
+	gatt_db_service_add_characteristic(attr, &uuid,
+						BT_ATT_PERM_WRITE,
+						BT_GATT_CHRC_PROP_WRITE,
+						NULL, hr_control_point_write_cb,
+						server);
+
+	if (server->hr_visible)
+		gatt_db_service_set_active(attr, true);
 }
 
-static struct server *server_create(int fd, uint16_t mtu)
+static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 {
 	struct server *server;
 	struct bt_att *att;
@@ -373,15 +561,19 @@ static struct server *server_create(int fd, uint16_t mtu)
 		return NULL;
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
@@ -389,6 +581,7 @@ static struct server *server_create(int fd, uint16_t mtu)
 
 static void server_destroy(struct server *server)
 {
+	timeout_remove(server->hr_timeout_id);
 	bt_gatt_server_unref(server->gatt);
 	gatt_db_destroy(server->db);
 }
@@ -404,6 +597,7 @@ static void usage(void)
 		"\t-s, --security-level <sec>\tSet security level (low|"
 								"medium|high)\n"
 		"\t-v, --verbose\t\t\tEnable extra logging\n"
+		"\t-r, --heart-rate\t\tEnable Heart Rate service"
 		"\t-h, --help\t\t\tDisplay help\n");
 }
 
@@ -412,6 +606,7 @@ static struct option main_options[] = {
 	{ "mtu",		1, 0, 'm' },
 	{ "security-level",	1, 0, 's' },
 	{ "verbose",		0, 0, 'v' },
+	{ "heart-rate",		0, 0, 'r' },
 	{ "help",		0, 0, 'h' },
 	{ }
 };
@@ -697,9 +892,10 @@ int main(int argc, char *argv[])
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
@@ -708,6 +904,9 @@ int main(int argc, char *argv[])
 		case 'v':
 			verbose = true;
 			break;
+		case 'r':
+			hr_visible = true;
+			break;
 		case 's':
 			if (strcmp(optarg, "low") == 0)
 				sec = BT_SECURITY_LOW;
@@ -775,7 +974,7 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	server = server_create(fd, mtu);
+	server = server_create(fd, mtu, hr_visible);
 	if (!server) {
 		close(fd);
 		return EXIT_FAILURE;
-- 
2.1.0.rc2.206.gedb03e5

