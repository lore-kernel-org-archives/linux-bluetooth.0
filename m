Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 07/13] core: Support per-client CCC state
Date: Tue, 10 Feb 2015 20:54:20 -0800
Message-Id: <1423630466-26327-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1423630466-26327-1-git-send-email-armansito@chromium.org>
References: <1423630466-26327-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added support to btd_gatt_server to track the states of CCC descriptors
on a per-client device basis. Added a new API for creating a CCC entry
for a given GATT service.
---
 src/gatt-server.c | 260 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/gatt-server.h |   3 +
 2 files changed, 258 insertions(+), 5 deletions(-)

diff --git a/src/gatt-server.c b/src/gatt-server.c
index 14e335e..f9ff92d 100644
--- a/src/gatt-server.c
+++ b/src/gatt-server.c
@@ -48,8 +48,141 @@ struct btd_gatt_server {
 	struct btd_adapter *adapter;
 	struct gatt_db *db;
 	GIOChannel *le_io;
+	struct queue *device_states;
 };
 
+struct device_state {
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
+	struct queue *ccc_states;
+};
+
+struct ccc_state {
+	uint16_t handle;
+	uint8_t value[2];
+};
+
+struct device_info {
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
+};
+
+static bool dev_state_match(const void *a, const void *b)
+{
+	const struct device_state *dev_state = a;
+	const struct device_info *dev_info = b;
+
+	return bacmp(&dev_state->bdaddr, &dev_info->bdaddr) == 0 &&
+				dev_state->bdaddr_type == dev_info->bdaddr_type;
+}
+
+static struct device_state *find_device_state(struct btd_gatt_server *server,
+							bdaddr_t *bdaddr,
+							uint8_t bdaddr_type)
+{
+	struct device_info dev_info;
+
+	memset(&dev_info, 0, sizeof(dev_info));
+
+	bacpy(&dev_info.bdaddr, bdaddr);
+	dev_info.bdaddr_type = bdaddr_type;
+
+	return queue_find(server->device_states, dev_state_match, &dev_info);
+}
+
+static bool ccc_state_match(const void *a, const void *b)
+{
+	const struct ccc_state *ccc = a;
+	uint16_t handle = PTR_TO_UINT(b);
+
+	return ccc->handle == handle;
+}
+
+static struct ccc_state *find_ccc_state(struct device_state *dev_state,
+								uint16_t handle)
+{
+	return queue_find(dev_state->ccc_states, ccc_state_match,
+							UINT_TO_PTR(handle));
+}
+
+static struct device_state *device_state_create(bdaddr_t *bdaddr,
+							uint8_t bdaddr_type)
+{
+	struct device_state *dev_state;
+
+	dev_state = new0(struct device_state, 1);
+	if (!dev_state)
+		return NULL;
+
+	dev_state->ccc_states = queue_new();
+	if (!dev_state->ccc_states) {
+		free(dev_state);
+		return NULL;
+	}
+
+	bacpy(&dev_state->bdaddr, bdaddr);
+	dev_state->bdaddr_type = bdaddr_type;
+
+	return dev_state;
+}
+
+static struct device_state *get_device_state(struct btd_gatt_server *server,
+							bdaddr_t *bdaddr,
+							uint8_t bdaddr_type)
+{
+	struct device_state *dev_state;
+
+	/*
+	 * Find and return a device state. If a matching state doesn't exist,
+	 * then create a new one.
+	 */
+	dev_state = find_device_state(server, bdaddr, bdaddr_type);
+	if (dev_state)
+		return dev_state;
+
+	dev_state = device_state_create(bdaddr, bdaddr_type);
+	if (!dev_state)
+		return NULL;
+
+	queue_push_tail(server->device_states, dev_state);
+
+	return dev_state;
+}
+
+static struct ccc_state *get_ccc_state(struct btd_gatt_server *server,
+							bdaddr_t *bdaddr,
+							uint8_t bdaddr_type,
+							uint16_t handle)
+{
+	struct device_state *dev_state;
+	struct ccc_state *ccc;
+
+	dev_state = get_device_state(server, bdaddr, bdaddr_type);
+	if (!dev_state)
+		return NULL;
+
+	ccc = find_ccc_state(dev_state, handle);
+	if (ccc)
+		return ccc;
+
+	ccc = new0(struct ccc_state, 1);
+	if (!ccc)
+		return NULL;
+
+	ccc->handle = handle;
+	queue_push_tail(dev_state->ccc_states, ccc);
+
+	return ccc;
+}
+
+static void device_state_free(void *data)
+{
+	struct device_state *state = data;
+
+	queue_destroy(state->ccc_states, free);
+	free(state);
+}
+
 static void gatt_server_free(void *data)
 {
 	struct btd_gatt_server *server = data;
@@ -59,6 +192,8 @@ static void gatt_server_free(void *data)
 		g_io_channel_unref(server->le_io);
 	}
 
+	/* TODO: Persistently store CCC states before freeing them */
+	queue_destroy(server->device_states, device_state_free);
 	gatt_db_unref(server->db);
 	btd_adapter_unref(server->adapter);
 	free(server);
@@ -266,6 +401,10 @@ bool btd_gatt_server_register_adapter(struct btd_adapter *adapter)
 	if (!server->db)
 		goto fail;
 
+	server->device_states = queue_new();
+	if (!server->device_states)
+		goto fail;
+
 	addr = btd_adapter_get_address(adapter);
 	server->le_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, addr,
@@ -299,18 +438,129 @@ void btd_gatt_server_unregister_adapter(struct btd_adapter *adapter)
 	queue_remove_all(servers, match_adapter, adapter, gatt_server_free);
 }
 
-struct gatt_db *btd_gatt_server_get_db(struct btd_adapter *adapter)
+static struct btd_gatt_server *get_server(struct btd_adapter *adapter)
 {
-	struct btd_gatt_server *server;
-
 	if (!servers) {
 		error("GATT server not initialized");
 		return false;
 	}
 
-	server = queue_find(servers, match_adapter, adapter);
-	if (!server)
+	return queue_find(servers, match_adapter, adapter);
+}
+
+struct gatt_db *btd_gatt_server_get_db(struct btd_adapter *adapter)
+{
+	struct btd_gatt_server *server;
+
+	server = get_server(adapter);
+	if (!server) {
+		error("Adapter not registered");
 		return false;
+	}
 
 	return server->db;
 }
+
+static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t bdaddr_type, void *user_data)
+{
+	struct btd_gatt_server *server = user_data;
+	struct ccc_state *ccc;
+	uint16_t handle;
+	uint8_t ecode = 0;
+	const uint8_t *value = NULL;
+	size_t len = 0;
+
+	handle = gatt_db_attribute_get_handle(attrib);
+
+	DBG("CCC read called for handle: 0x%04x", handle);
+
+	if (offset > 2) {
+		ecode = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
+	ccc = get_ccc_state(server, bdaddr, bdaddr_type, handle);
+	if (!ccc) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto done;
+	}
+
+	len -= offset;
+	value = len ? &ccc->value[offset] : NULL;
+
+done:
+	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
+}
+
+static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					uint8_t bdaddr_type, void *user_data)
+{
+	struct btd_gatt_server *server = user_data;
+	struct ccc_state *ccc;
+	uint16_t handle;
+	uint8_t ecode = 0;
+
+	handle = gatt_db_attribute_get_handle(attrib);
+
+	DBG("CCC read called for handle: 0x%04x", handle);
+
+	if (!value || len != 2) {
+		ecode = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		goto done;
+	}
+
+	if (offset > 2) {
+		ecode = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
+	ccc = get_ccc_state(server, bdaddr, bdaddr_type, handle);
+	if (!ccc) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto done;
+	}
+
+	/*
+	 * TODO: Perform this after checking with a callback to the upper
+	 * layer.
+	 */
+	ccc->value[0] = value[0];
+	ccc->value[1] = value[1];
+
+done:
+	gatt_db_attribute_write_result(attrib, id, ecode);
+}
+
+struct gatt_db_attribute *btd_gatt_server_add_ccc(struct btd_adapter *adapter,
+							uint16_t service_handle)
+{
+	struct btd_gatt_server *server;
+	struct gatt_db_attribute *service;
+	bt_uuid_t uuid;
+
+	if (!adapter || !service_handle)
+		return NULL;
+
+	server = get_server(adapter);
+	if (!server) {
+		error("Adapter not registered");
+		return NULL;
+	}
+
+	service = gatt_db_get_attribute(server->db, service_handle);
+	if (!service) {
+		error("No service exists with handle: 0x%04x", service_handle);
+		return NULL;
+	}
+
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	return gatt_db_service_add_descriptor(service, &uuid,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+				gatt_ccc_read_cb, gatt_ccc_write_cb, server);
+}
diff --git a/src/gatt-server.h b/src/gatt-server.h
index f97ad05..9be2471 100644
--- a/src/gatt-server.h
+++ b/src/gatt-server.h
@@ -24,3 +24,6 @@ bool btd_gatt_server_register_adapter(struct btd_adapter *adapter);
 void btd_gatt_server_unregister_adapter(struct btd_adapter *adapter);
 
 struct gatt_db *btd_gatt_server_get_db(struct btd_adapter *adapter);
+
+struct gatt_db_attribute *btd_gatt_server_add_ccc(struct btd_adapter *adapter,
+						uint16_t service_handle);
-- 
2.2.0.rc0.207.ga3a616c

