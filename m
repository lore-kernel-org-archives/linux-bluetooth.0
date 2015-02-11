Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 09/13] core: Add Service Changed characteristic
Date: Tue, 10 Feb 2015 20:54:22 -0800
Message-Id: <1423630466-26327-10-git-send-email-armansito@chromium.org>
In-Reply-To: <1423630466-26327-1-git-send-email-armansito@chromium.org>
References: <1423630466-26327-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch exports the "Service Changed" characteristic and its CCC
descriptor in btd_gatt_server.
---
 src/gatt-server.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/src/gatt-server.c b/src/gatt-server.c
index 22faece..9af58a0 100644
--- a/src/gatt-server.c
+++ b/src/gatt-server.c
@@ -50,6 +50,10 @@ struct btd_gatt_server {
 	unsigned int db_id;
 	GIOChannel *le_io;
 	struct queue *device_states;
+	struct gatt_db_attribute *svc_chngd;
+	struct gatt_db_attribute *svc_chngd_ccc;
+	uint16_t svc_chngd_start;
+	uint16_t svc_chngd_end;
 };
 
 struct device_state {
@@ -355,16 +359,57 @@ static void populate_gap_service(struct btd_gatt_server *server)
 	gatt_db_service_set_active(service, true);
 }
 
+static void gatt_svc_chngd_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t bdaddr_type, void *user_data)
+{
+	struct btd_gatt_server *server = user_data;
+	uint8_t ecode = 0;
+	size_t len;
+	const uint8_t *value = NULL;
+	uint8_t bytes[4];
+
+	if (server->svc_chngd_start && server->svc_chngd_end) {
+		memset(bytes, 0, sizeof(bytes));
+		put_le16(server->svc_chngd_start, bytes);
+		put_le16(server->svc_chngd_end, bytes + 2);
+		len = 4;
+	} else {
+		len = 0;
+	}
+
+	if (offset > len) {
+		ecode = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
+	len -= offset;
+	value = len ? &bytes[offset] : NULL;
+
+done:
+	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
+}
+
 static void populate_gatt_service(struct btd_gatt_server *server)
 {
 	bt_uuid_t uuid;
 	struct gatt_db_attribute *service;
+	uint16_t start_handle;
 
 	/* Add the GATT service */
 	bt_uuid16_create(&uuid, UUID_GATT);
-	service = gatt_db_add_service(server->db, &uuid, true, 1);
+	service = gatt_db_add_service(server->db, &uuid, true, 4);
+	gatt_db_attribute_get_service_handles(service, &start_handle, NULL);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
+	server->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
+			BT_ATT_PERM_READ,
+			BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_INDICATE,
+			gatt_svc_chngd_read_cb, NULL, server);
 
-	/* TODO: Add "Service Changed" characteristic and handle CCC */
+	server->svc_chngd_ccc = btd_gatt_server_add_ccc(server->adapter,
+								start_handle);
 
 	gatt_db_service_set_active(service, true);
 }
-- 
2.2.0.rc0.207.ga3a616c

