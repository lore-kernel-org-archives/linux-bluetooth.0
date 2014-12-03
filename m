Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 4/8] tools/btgatt-server: Add the "services" command
Date: Tue,  2 Dec 2014 16:12:39 -0800
Message-Id: <1417565563-29239-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1417565563-29239-1-git-send-email-armansito@chromium.org>
References: <1417565563-29239-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the "services" command which displayes the currently
stored services in the server database.
---
 tools/btgatt-server.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 87b8067..a2a0ec9 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -883,6 +883,95 @@ static void cmd_heart_rate(struct server *server, char *cmd_str)
 						pdu, 4, conf_cb, NULL, NULL);
 }
 
+static void print_uuid(const bt_uuid_t *uuid)
+{
+	char uuid_str[MAX_LEN_UUID_STR];
+	bt_uuid_t uuid128;
+
+	bt_uuid_to_uuid128(uuid, &uuid128);
+	bt_uuid_to_string(&uuid128, uuid_str, sizeof(uuid_str));
+
+	printf("%s\n", uuid_str);
+}
+
+static void print_incl(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct server *server = user_data;
+	uint16_t handle, start, end;
+	struct gatt_db_attribute *service;
+	bt_uuid_t uuid;
+
+	if (!gatt_db_attribute_get_incl_data(attr, &handle, &start, &end))
+		return;
+
+	service = gatt_db_get_attribute(server->db, start);
+	if (!service)
+		return;
+
+	gatt_db_attribute_get_service_uuid(service, &uuid);
+
+	printf("\t  " COLOR_GREEN "include" COLOR_OFF " - handle: "
+					"0x%04x, - start: 0x%04x, end: 0x%04x,"
+					"uuid: ", handle, start, end);
+	print_uuid(&uuid);
+}
+
+static void print_desc(struct gatt_db_attribute *attr, void *user_data)
+{
+	printf("\t\t  " COLOR_MAGENTA "descr" COLOR_OFF
+					" - handle: 0x%04x, uuid: ",
+					gatt_db_attribute_get_handle(attr));
+	print_uuid(gatt_db_attribute_get_type(attr));
+}
+
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
+		return;
+
+	printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
+					" - start: 0x%04x, value: 0x%04x, "
+					"props: 0x%02x, uuid: ",
+					handle, value_handle, properties);
+	print_uuid(&uuid);
+
+	gatt_db_service_foreach_desc(attr, print_desc, NULL);
+}
+
+static void print_service(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct server *server = user_data;
+	uint16_t start, end;
+	bool primary;
+	bt_uuid_t uuid;
+
+	if (!gatt_db_attribute_get_service_data(attr, &start, &end, &primary,
+									&uuid))
+		return;
+
+	printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
+				"end: 0x%04x, type: %s, uuid: ",
+				start, end, primary ? "primary" : "secondary");
+	print_uuid(&uuid);
+
+	gatt_db_service_foreach_incl(attr, print_incl, server);
+	gatt_db_service_foreach_char(attr, print_chrc, NULL);
+
+	printf("\n");
+}
+
+static void cmd_services(struct server *server, char *cmd_str)
+{
+	gatt_db_foreach_service(server->db, print_service, server);
+}
+
 static void cmd_help(struct server *server, char *cmd_str);
 
 typedef void (*command_func_t)(struct server *server, char *cmd_str);
@@ -895,6 +984,7 @@ static struct {
 	{ "help", cmd_help, "\tDisplay help message" },
 	{ "notify", cmd_notify, "\tSend handle-value notification" },
 	{ "heart-rate", cmd_heart_rate, "\tHide/Unhide Heart Rate Service" },
+	{ "services", cmd_services, "\tEnumerate all services" },
 	{ }
 };
 
-- 
2.2.0.rc0.207.ga3a616c

