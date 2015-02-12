Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 05/14] core: gatt: Add GATT/GAP services to local db
Date: Wed, 11 Feb 2015 19:17:35 -0800
Message-Id: <1423711064-7390-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1423711064-7390-1-git-send-email-armansito@chromium.org>
References: <1423711064-7390-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the GATT & GAP services to the local GATT database.
---
 src/gatt-database.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 57bdf1a..2da5a09 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -39,6 +39,9 @@
 #define ATT_CID 4
 #endif
 
+#define UUID_GAP	0x1800
+#define UUID_GATT	0x1801
+
 static struct queue *servers = NULL;
 
 struct btd_gatt_database {
@@ -126,6 +129,115 @@ static bool match_adapter(const void *a, const void *b)
 	return server->adapter == adapter;
 }
 
+static void gap_device_name_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct btd_gatt_database *server = user_data;
+	uint8_t error = 0;
+	size_t len = 0;
+	const uint8_t *value = NULL;
+	const char *device_name;
+
+	DBG("GAP Device Name read request\n");
+
+	device_name = btd_adapter_get_name(server->adapter);
+	len = strlen(device_name);
+
+	if (offset > len) {
+		error = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
+	len -= offset;
+	value = len ? (const uint8_t *) &device_name[offset] : NULL;
+
+done:
+	gatt_db_attribute_read_result(attrib, id, error, value, len);
+}
+
+static void gap_appearance_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct btd_gatt_database *server = user_data;
+	uint8_t error = 0;
+	size_t len = 2;
+	const uint8_t *value = NULL;
+	uint8_t appearance[2];
+	uint32_t dev_class;
+
+	DBG("GAP Appearance read request\n");
+
+	dev_class = btd_adapter_get_class(server->adapter);
+
+	if (offset > 2) {
+		error = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
+	appearance[0] = dev_class & 0x00ff;
+	appearance[1] = (dev_class >> 8) & 0x001f;
+
+	len -= offset;
+	value = len ? &appearance[offset] : NULL;
+
+done:
+	gatt_db_attribute_read_result(attrib, id, error, value, len);
+}
+
+static void populate_gap_service(struct btd_gatt_database *server)
+{
+	bt_uuid_t uuid;
+	struct gatt_db_attribute *service;
+
+	/* Add the GAP service */
+	bt_uuid16_create(&uuid, UUID_GAP);
+	service = gatt_db_add_service(server->db, &uuid, true, 5);
+
+	/*
+	 * Device Name characteristic.
+	 */
+	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
+	gatt_db_service_add_characteristic(service, &uuid, BT_ATT_PERM_READ,
+							BT_GATT_CHRC_PROP_READ,
+							gap_device_name_read_cb,
+							NULL, server);
+
+	/*
+	 * Device Appearance characteristic.
+	 */
+	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+	gatt_db_service_add_characteristic(service, &uuid, BT_ATT_PERM_READ,
+							BT_GATT_CHRC_PROP_READ,
+							gap_appearance_read_cb,
+							NULL, server);
+
+	gatt_db_service_set_active(service, true);
+}
+
+static void populate_gatt_service(struct btd_gatt_database *server)
+{
+	bt_uuid_t uuid;
+	struct gatt_db_attribute *service;
+
+	/* Add the GATT service */
+	bt_uuid16_create(&uuid, UUID_GATT);
+	service = gatt_db_add_service(server->db, &uuid, true, 1);
+
+	/* TODO: Add "Service Changed" characteristic and handle CCC */
+
+	gatt_db_service_set_active(service, true);
+}
+
+static void register_core_services(struct btd_gatt_database *server)
+{
+	populate_gap_service(server);
+	populate_gatt_service(server);
+}
+
 bool btd_gatt_database_register_adapter(struct btd_adapter *adapter)
 {
 	struct btd_gatt_database *server;
@@ -169,7 +281,7 @@ bool btd_gatt_database_register_adapter(struct btd_adapter *adapter)
 
 	queue_push_tail(servers, server);
 
-	/* TODO: Set up GAP/GATT services */
+	register_core_services(server);
 
 	return true;
 
-- 
2.2.0.rc0.207.ga3a616c

