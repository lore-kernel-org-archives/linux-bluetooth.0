Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 04/13] peripheral/gatt: Add a way to external services to register services
Date: Thu,  2 Jul 2015 11:33:45 -0300
Message-Id: <1435847634-22831-5-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow profiles implemented using the peripheral/ helpers to
register asynchronously their services. This cannot be done directly
because when gatt_service_start() the GATT database doesn't exist yet.
---
 peripheral/gatt.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 peripheral/gatt.h |  6 ++++++
 2 files changed, 53 insertions(+)

diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index a66292f..a859adc 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -54,6 +54,11 @@ struct gatt_conn {
 	struct bt_gatt_client *client;
 };
 
+struct service_registerer_data {
+	gatt_service_register_t callback;
+	void *user_data;
+};
+
 static struct io *att_io = NULL;
 static struct queue *conn_list = NULL;
 static struct gatt_db *gatt_db = NULL;
@@ -63,6 +68,8 @@ static uint8_t static_addr[6] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 static uint8_t dev_name[20];
 static uint8_t dev_name_len = 0;
 
+static struct queue *registered_services = NULL;
+
 void gatt_set_static_address(uint8_t addr[6])
 {
 	memcpy(static_addr, addr, sizeof(static_addr));
@@ -243,6 +250,21 @@ static void populate_devinfo_service(struct gatt_db *db)
 	gatt_db_service_set_active(service, true);
 }
 
+void gatt_server_init(void)
+{
+	registered_services = queue_new();
+}
+
+static void register_each_service(void *data, void *user_data)
+{
+	struct gatt_db *db = user_data;
+	struct service_registerer_data *registerer = data;
+
+	fprintf(stderr, "registering service %p\n", registerer);
+
+	registerer->callback(db, registerer->user_data);
+}
+
 void gatt_server_start(void)
 {
 	struct sockaddr_l2 addr;
@@ -287,6 +309,8 @@ void gatt_server_start(void)
 	populate_gap_service(gatt_db);
 	populate_devinfo_service(gatt_db);
 
+	queue_foreach(registered_services, register_each_service, gatt_db);
+
 	gatt_cache = gatt_db_new();
 
 	conn_list = queue_new();
@@ -323,10 +347,33 @@ void gatt_server_stop(void)
 
 	queue_destroy(conn_list, gatt_conn_destroy);
 
+	queue_destroy(registered_services, free);
+	registered_services = NULL;
+
 	gatt_db_unref(gatt_cache);
 	gatt_cache = NULL;
 
 	gatt_db_unref(gatt_db);
 	gatt_db = NULL;
+}
+
+int gatt_server_add_service(gatt_service_register_t callback, void *user_data)
+{
+	struct service_registerer_data *registerer;
+
+	fprintf(stderr, "gatt_server_add_service %p data %p\n", callback, user_data);
+
+	registerer = new0(struct service_registerer_data, 1);
+	if (!registerer)
+		return -ENOMEM;
+
+	registerer->callback = callback;
+	registerer->user_data = user_data;
+
+	if (!queue_push_tail(registered_services, registerer)) {
+		free(registerer);
+		return -ENOMEM;
+	}
 
+	return 0;
 }
diff --git a/peripheral/gatt.h b/peripheral/gatt.h
index 5b68f35..5e16875 100644
--- a/peripheral/gatt.h
+++ b/peripheral/gatt.h
@@ -26,5 +26,11 @@
 void gatt_set_static_address(uint8_t addr[6]);
 void gatt_set_device_name(uint8_t name[20], uint8_t len);
 
+void gatt_server_init(void);
+
 void gatt_server_start(void);
 void gatt_server_stop(void);
+
+typedef void (*gatt_service_register_t)(struct gatt_db *db, void *user_data);
+
+int gatt_server_add_service(gatt_service_register_t callback, void *user_data);
-- 
2.4.5

