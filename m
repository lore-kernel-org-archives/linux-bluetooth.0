Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 3/4] tools/btgatt-client: Observe service events.
Date: Wed,  3 Dec 2014 11:32:27 -0800
Message-Id: <1417635148-32546-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1417635148-32546-1-git-send-email-armansito@chromium.org>
References: <1417635148-32546-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

tools/btgatt-client now registers service added/removed callbacks in
which it logs a message about the affected service.
---
 tools/btgatt-client.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 2a2067b..fe94ae8 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -99,6 +99,31 @@ static void ready_cb(bool success, uint8_t att_ecode, void *user_data);
 static void service_changed_cb(uint16_t start_handle, uint16_t end_handle,
 							void *user_data);
 
+static void log_service_event(struct gatt_db_attribute *attr, const char *str)
+{
+	char uuid_str[MAX_LEN_UUID_STR];
+	bt_uuid_t uuid;
+	uint16_t start, end;
+
+	gatt_db_attribute_get_service_uuid(attr, &uuid);
+	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+
+	gatt_db_attribute_get_service_handles(attr, &start, &end);
+
+	PRLOG("%s - UUID: %s start: 0x%04x end: 0x%04x\n", str, uuid_str,
+								start, end);
+}
+
+static void service_added_cb(struct gatt_db_attribute *attr, void *user_data)
+{
+	log_service_event(attr, "Service Added");
+}
+
+static void service_removed_cb(struct gatt_db_attribute *attr, void *user_data)
+{
+	log_service_event(attr, "Service Removed");
+}
+
 static struct client *client_create(int fd, uint16_t mtu)
 {
 	struct client *cli;
@@ -150,6 +175,9 @@ static struct client *client_create(int fd, uint16_t mtu)
 		return NULL;
 	}
 
+	gatt_db_register(cli->db, service_added_cb, service_removed_cb,
+								NULL, NULL);
+
 	if (verbose) {
 		bt_att_set_debug(att, att_debug_cb, "att: ", NULL);
 		bt_gatt_client_set_debug(cli->gatt, gatt_debug_cb, "gatt: ",
-- 
2.2.0.rc0.207.ga3a616c

