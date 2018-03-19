Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] Add support for requiring min key size for access GATT characteristics
Date: Mon, 19 Mar 2018 16:06:30 +0100
Message-Id: <20180319150630.2425-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to configure bluetoothd to require minimum encryption key
size when accessing GATT server characteristics. It is a global
configuration option affecting whole GATT database.
---
 peripheral/gatt.c        |  2 +-
 src/adapter.c            | 44 +++++++++++++++++++++++++++++++-------------
 src/device.c             | 14 ++++++++++++--
 src/device.h             |  1 +
 src/hcid.h               |  2 ++
 src/main.c               | 10 ++++++++++
 src/main.conf            |  5 +++++
 src/shared/gatt-server.c | 43 ++++++++++++++++++++++++++++++++++++-------
 src/shared/gatt-server.h |  6 +++++-
 tools/btgatt-server.c    |  2 +-
 unit/test-gatt.c         |  2 +-
 11 files changed, 105 insertions(+), 26 deletions(-)

diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index 5ae19a8e5..08541c424 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -128,7 +128,7 @@ static struct gatt_conn *gatt_conn_new(int fd)
 
 	bt_att_set_security(conn->att, BT_SECURITY_MEDIUM);
 
-	conn->gatt = bt_gatt_server_new(gatt_db, conn->att, mtu);
+	conn->gatt = bt_gatt_server_new(gatt_db, conn->att, mtu, 0);
 	if (!conn->gatt) {
 		fprintf(stderr, "Failed to create GATT server\n");
 		bt_att_unref(conn->att);
diff --git a/src/adapter.c b/src/adapter.c
index 6d7d61504..c8e365479 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3441,25 +3441,26 @@ failed:
 	return ltk;
 }
 
-static GSList *get_ltk_info(GKeyFile *key_file, const char *peer,
+struct smp_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer,
+							uint8_t bdaddr_type)
+{
+	DBG("%s", peer);
+
+	return get_ltk(key_file, peer, bdaddr_type, "LongTermKey");
+}
+
+struct smp_ltk_info *get_slave_ltk_info(GKeyFile *key_file, const char *peer,
 							uint8_t bdaddr_type)
 {
 	struct smp_ltk_info *ltk;
-	GSList *l = NULL;
 
 	DBG("%s", peer);
 
-	ltk = get_ltk(key_file, peer, bdaddr_type, "LongTermKey");
-	if (ltk)
-		l = g_slist_append(l, ltk);
-
 	ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
-	if (ltk) {
+	if (ltk)
 		ltk->master = false;
-		l = g_slist_append(l, ltk);
-	}
 
-	return l;
+	return ltk;
 }
 
 static struct irk_info *get_irk_info(GKeyFile *key_file, const char *peer,
@@ -4019,7 +4020,9 @@ static void load_devices(struct btd_adapter *adapter)
 		char filename[PATH_MAX];
 		GKeyFile *key_file;
 		struct link_key_info *key_info;
-		GSList *list, *ltk_info;
+		struct smp_ltk_info *ltk_info;
+		struct smp_ltk_info *slave_ltk_info;
+		GSList *list;
 		struct irk_info *irk_info;
 		struct conn_param *param;
 		uint8_t bdaddr_type;
@@ -4044,7 +4047,13 @@ static void load_devices(struct btd_adapter *adapter)
 		bdaddr_type = get_le_addr_type(key_file);
 
 		ltk_info = get_ltk_info(key_file, entry->d_name, bdaddr_type);
-		ltks = g_slist_concat(ltks, ltk_info);
+		if (ltk_info)
+			ltks = g_slist_append(ltks, ltk_info);
+
+		slave_ltk_info = get_slave_ltk_info(key_file, entry->d_name,
+								bdaddr_type);
+		if (slave_ltk_info)
+			ltks = g_slist_append(ltks, slave_ltk_info);
 
 		irk_info = get_irk_info(key_file, entry->d_name, bdaddr_type);
 		if (irk_info)
@@ -4079,9 +4088,16 @@ device_exist:
 			device_set_bonded(device, BDADDR_BREDR);
 		}
 
-		if (ltk_info) {
+		if (ltk_info || slave_ltk_info) {
 			device_set_paired(device, bdaddr_type);
 			device_set_bonded(device, bdaddr_type);
+
+			if (ltk_info)
+				device_set_ltk_enc_size(device,
+							ltk_info->enc_size);
+			else if (slave_ltk_info)
+				device_set_ltk_enc_size(device,
+						slave_ltk_info->enc_size);
 		}
 
 free:
@@ -7464,6 +7480,8 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 		device_set_bonded(device, addr->type);
 	}
 
+	device_set_ltk_enc_size(device, ev->key.enc_size);
+
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
 }
 
diff --git a/src/device.c b/src/device.c
index 7c7196ca1..64b05d2f4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -243,6 +243,7 @@ struct btd_device {
 
 	struct csrk_info *local_csrk;
 	struct csrk_info *remote_csrk;
+	uint8_t ltk_enc_size;
 
 	sdp_list_t	*tmp_records;
 
@@ -1460,6 +1461,11 @@ bool device_is_disconnecting(struct btd_device *device)
 	return device->disconn_timer > 0;
 }
 
+void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size)
+{
+	device->ltk_enc_size = enc_size;
+}
+
 static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 {
 	char addr[18];
@@ -4834,11 +4840,15 @@ static void gatt_server_init(struct btd_device *device, struct gatt_db *db)
 
 	gatt_server_cleanup(device);
 
-	device->server = bt_gatt_server_new(db, device->att, device->att_mtu);
-	if (!device->server)
+	device->server = bt_gatt_server_new(db, device->att, device->att_mtu,
+						main_opts.min_enc_key_size);
+	if (!device->server) {
 		error("Failed to initialize bt_gatt_server");
+		return;
+	}
 
 	bt_gatt_server_set_debug(device->server, gatt_debug, NULL, NULL);
+	bt_gatt_server_set_enc_key_size(device->server, device->ltk_enc_size);
 }
 
 static bool local_counter(uint32_t *sign_cnt, void *user_data)
diff --git a/src/device.h b/src/device.h
index bc046f780..306c813fc 100644
--- a/src/device.h
+++ b/src/device.h
@@ -130,6 +130,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type);
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type);
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
 bool device_is_disconnecting(struct btd_device *device);
+void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size);
 
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
 					void *user_data);
diff --git a/src/hcid.h b/src/hcid.h
index 62e2bd606..2c2b89d9c 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -54,6 +54,8 @@ struct main_opts {
 
 	bt_mode_t	mode;
 	bt_gatt_cache_t gatt_cache;
+
+	uint8_t		min_enc_key_size;
 };
 
 extern struct main_opts main_opts;
diff --git a/src/main.c b/src/main.c
index 21f0b14a4..29a78e64c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -407,6 +407,16 @@ static void parse_config(GKeyFile *config)
 
 	main_opts.gatt_cache = parse_gatt_cache(str);
 
+	val = g_key_file_get_integer(config, "GATT",
+						"MinEncKeySize", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("min_enc_key_size=%d", val);
+		main_opts.min_enc_key_size = val;
+	}
+
 	g_free(str);
 }
 
diff --git a/src/main.conf b/src/main.conf
index 21986b386..cbae32ec5 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -77,6 +77,11 @@
 # Default: always
 #Cache = always
 
+# Minimum required Encryption Key Size for accessing secured characteristics.
+# Possible values: 0 and 7-16. 0 means don't care.
+# Defaults to 0
+# MinEncKeySize = 0
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index faa56abeb..cf88d72df 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -103,6 +103,9 @@ struct bt_gatt_server {
 	unsigned int prep_write_id;
 	unsigned int exec_write_id;
 
+	uint8_t min_enc_size;
+	uint8_t enc_size;
+
 	struct queue *prep_queue;
 	unsigned int max_prep_queue_len;
 
@@ -379,6 +382,12 @@ done:
 	process_read_by_type(op);
 }
 
+void bt_gatt_server_set_enc_key_size(struct bt_gatt_server *server,
+								uint8_t size)
+{
+	server->enc_size = size;
+}
+
 static uint8_t check_permissions(struct bt_gatt_server *server,
 				struct gatt_db_attribute *attr, uint32_t mask)
 {
@@ -398,14 +407,32 @@ static uint8_t check_permissions(struct bt_gatt_server *server,
 		return 0;
 
 	security = bt_att_get_security(server->att);
-	if (perm & BT_ATT_PERM_SECURE && security < BT_ATT_SECURITY_FIPS)
-		return BT_ATT_ERROR_AUTHENTICATION;
+	if (perm & BT_ATT_PERM_SECURE) {
+		if (security < BT_ATT_SECURITY_FIPS)
+			return BT_ATT_ERROR_AUTHENTICATION;
+
+		if (server->min_enc_size &&
+				server->min_enc_size > server->enc_size)
+			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE;
+	}
+
+	if (perm & BT_ATT_PERM_AUTHEN) {
+		if (security < BT_ATT_SECURITY_HIGH)
+			return BT_ATT_ERROR_AUTHENTICATION;
 
-	if (perm & BT_ATT_PERM_AUTHEN && security < BT_ATT_SECURITY_HIGH)
-		return BT_ATT_ERROR_AUTHENTICATION;
+		if (server->min_enc_size &&
+				server->min_enc_size > server->enc_size)
+			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE;
+	}
 
-	if (perm & BT_ATT_PERM_ENCRYPT && security < BT_ATT_SECURITY_MEDIUM)
-		return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION;
+	if (perm & BT_ATT_PERM_ENCRYPT) {
+		if (security < BT_ATT_SECURITY_MEDIUM)
+			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION;
+
+		if (server->min_enc_size &&
+				server->min_enc_size > server->enc_size)
+			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE;
+	}
 
 	return 0;
 }
@@ -1481,7 +1508,8 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 }
 
 struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
-					struct bt_att *att, uint16_t mtu)
+					struct bt_att *att, uint16_t mtu,
+					uint8_t min_enc_size)
 {
 	struct bt_gatt_server *server;
 
@@ -1494,6 +1522,7 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 	server->mtu = MAX(mtu, BT_ATT_DEFAULT_LE_MTU);
 	server->max_prep_queue_len = DEFAULT_MAX_PREP_QUEUE_LEN;
 	server->prep_queue = queue_new();
+	server->min_enc_size = min_enc_size;
 
 	if (!gatt_server_register_att_handlers(server)) {
 		bt_gatt_server_free(server);
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
index 74a6c721e..6bf178a9b 100644
--- a/src/shared/gatt-server.h
+++ b/src/shared/gatt-server.h
@@ -26,7 +26,8 @@
 struct bt_gatt_server;
 
 struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
-					struct bt_att *att, uint16_t mtu);
+					struct bt_att *att, uint16_t mtu,
+					uint8_t min_enc_size);
 uint16_t bt_gatt_server_get_mtu(struct bt_gatt_server *server);
 
 struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server);
@@ -51,3 +52,6 @@ bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
 					bt_gatt_server_conf_func_t callback,
 					void *user_data,
 					bt_gatt_server_destroy_func_t destroy);
+
+void bt_gatt_server_set_enc_key_size(struct bt_gatt_server *server,
+								uint8_t size);
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index fadaff2ad..89812bd75 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -583,7 +583,7 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 		goto fail;
 	}
 
-	server->gatt = bt_gatt_server_new(server->db, server->att, mtu);
+	server->gatt = bt_gatt_server_new(server->db, server->att, mtu, 0);
 	if (!server->gatt) {
 		fprintf(stderr, "Failed to create GATT server\n");
 		goto fail;
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 5d79e94c0..c7e28f865 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -667,7 +667,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 		g_assert(context->server_db);
 
 		context->server = bt_gatt_server_new(context->server_db,
-							context->att, mtu);
+							context->att, mtu, 0);
 		g_assert(context->server);
 
 		bt_gatt_server_set_debug(context->server, print_debug,
-- 
2.14.3

