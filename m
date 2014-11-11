Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 6/8] tools/btgatt-server: Add "heart-rate" command.
Date: Tue, 11 Nov 2014 13:39:45 -0800
Message-Id: <1415741987-22272-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1415741987-22272-1-git-send-email-armansito@chromium.org>
References: <1415741987-22272-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the "heart-rate" command which can be used to hide
or unhide the Heart Rate service. This is useful for testing service
changed events.
---
 tools/btgatt-server.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 1315a62..5421be7 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -83,8 +83,10 @@ struct server {
 	uint8_t *device_name;
 	size_t name_len;
 
+	uint16_t gatt_svc_chngd_handle;
 	bool svc_chngd_enabled;
 
+	uint16_t hr_handle;
 	uint16_t hr_msrmt_handle;
 	uint16_t hr_energy_expended;
 	bool hr_visible;
@@ -414,7 +416,7 @@ done:
 static void populate_db(struct server *server)
 {
 	bt_uuid_t uuid;
-	struct gatt_db_attribute *attr, *hr_msrmt;
+	struct gatt_db_attribute *attr, *hr_msrmt, *svc_chngd;
 
 	/* Add the GAP service */
 	bt_uuid16_create(&uuid, UUID_GAP);
@@ -448,10 +450,12 @@ static void populate_db(struct server *server)
 	attr = gatt_db_add_service(server->db, &uuid, true, 4);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
-	gatt_db_service_add_characteristic(attr, &uuid, BT_ATT_PERM_READ,
+	svc_chngd = gatt_db_service_add_characteristic(attr, &uuid,
+			BT_ATT_PERM_READ,
 			BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_INDICATE,
 			gatt_service_changed_cb,
 			NULL, server);
+	server->gatt_svc_chngd_handle = gatt_db_attribute_get_handle(svc_chngd);
 
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 	gatt_db_service_add_descriptor(attr, &uuid,
@@ -464,6 +468,7 @@ static void populate_db(struct server *server)
 	/* Add Heart Rate Service */
 	bt_uuid16_create(&uuid, UUID_HEART_RATE);
 	attr = gatt_db_add_service(server->db, &uuid, true, 8);
+	server->hr_handle = gatt_db_attribute_get_handle(attr);
 
 	bt_uuid16_create(&uuid, UUID_HEART_RATE_MSRMT);
 	hr_msrmt = gatt_db_service_add_characteristic(attr, &uuid,
@@ -799,6 +804,56 @@ done:
 	free(value);
 }
 
+static void heart_rate_usage(void)
+{
+	printf("Usage: heart-rate on|off\n");
+}
+
+static void cmd_heart_rate(struct server *server, char *cmd_str)
+{
+	bool enable;
+	uint8_t pdu[4];
+	struct gatt_db_attribute *attr;
+
+	if (!cmd_str) {
+		heart_rate_usage();
+		return;
+	}
+
+	if (strcmp(cmd_str, "on") == 0)
+		enable = true;
+	else if (strcmp(cmd_str, "off") == 0)
+		enable = false;
+	else {
+		heart_rate_usage();
+		return;
+	}
+
+	if (enable == server->hr_visible) {
+		printf("Heart Rate Service already %s\n",
+						enable ? "visible" : "hidden");
+		return;
+	}
+
+	server->hr_visible = enable;
+	attr = gatt_db_get_attribute(server->db, server->hr_handle);
+	gatt_db_service_set_active(attr, server->hr_visible);
+	update_hr_msrmt_simulation(server);
+
+	if (!server->svc_chngd_enabled)
+		return;
+
+	put_le16(server->hr_handle, pdu);
+	put_le16(server->hr_handle + 7, pdu + 2);
+
+	server->hr_msrmt_enabled = false;
+	update_hr_msrmt_simulation(server);
+
+	bt_gatt_server_send_indication(server->gatt,
+						server->gatt_svc_chngd_handle,
+						pdu, 4, conf_cb, NULL, NULL);
+}
+
 static void cmd_help(struct server *server, char *cmd_str);
 
 typedef void (*command_func_t)(struct server *server, char *cmd_str);
@@ -810,6 +865,7 @@ static struct {
 } command[] = {
 	{ "help", cmd_help, "\tDisplay help message" },
 	{ "notify", cmd_notify, "\tSend handle-value notification" },
+	{ "heart-rate", cmd_heart_rate, "\tHide/Unhide Heart Rate Service" },
 	{ }
 };
 
-- 
2.1.0.rc2.206.gedb03e5

