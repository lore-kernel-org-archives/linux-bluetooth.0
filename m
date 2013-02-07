Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/14] neard: Refactor message processing
Date: Thu, 7 Feb 2013 09:13:52 +0100
Message-ID: <1360224844-12280-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This refactor code for message processing for future feature addition.
nokia.com:bt and EIR processing is now separated from performing
actions based on received data.
---
 plugins/neard.c | 308 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 157 insertions(+), 151 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 6272144..7df4544 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -55,6 +55,26 @@ static gboolean agent_register_postpone = FALSE;
 /* For NFC mimetype limits max OOB EIR size */
 #define NFC_OOB_EIR_MAX UINT8_MAX
 
+struct oob_params {
+	bdaddr_t address;
+	uint32_t class;
+	char *name;
+	GSList *services;
+	uint8_t *hash;
+	uint8_t *randomizer;
+	uint8_t *pin;
+	int pin_len;
+};
+
+static void free_oob_params(struct oob_params *params)
+{
+	g_slist_free_full(params->services, g_free);
+	g_free(params->name);
+	g_free(params->hash);
+	g_free(params->randomizer);
+	g_free(params->pin);
+}
+
 static DBusMessage *error_reply(DBusMessage *msg, int error)
 {
 	const char *name;
@@ -268,14 +288,9 @@ static int check_device(struct btd_device *device)
 	return 0;
 }
 
-/* returns 1 if action (pairing or reading local data) is not needed */
-static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
-							bdaddr_t *remote)
+static int process_eir(uint8_t *eir, size_t size, struct oob_params *remote)
 {
 	struct eir_data eir_data;
-	char remote_address[18];
-	struct btd_device *device;
-	int err;
 
 	DBG("size %zu", size);
 
@@ -284,48 +299,25 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 	if (eir_parse_oob(&eir_data, eir, size) < 0)
 		return -EINVAL;
 
-	ba2str(&eir_data.addr, remote_address);
-
-	DBG("hci%u remote:%s", btd_adapter_get_index(adapter), remote_address);
-
-	device = adapter_get_device(adapter, &eir_data.addr, BDADDR_BREDR);
-
-	err = check_device(device);
-	if (err < 0) {
-		eir_data_free(&eir_data);
-		return err;
-	}
+	bacpy(&remote->address, &eir_data.addr);
 
-	/* store OOB data */
-	if (eir_data.class != 0)
-		device_set_class(device, eir_data.class);
+	remote->class = eir_data.class;
 
-	/* TODO handle incomplete name? */
-	if (eir_data.name) {
-		adapter_store_cached_name(adapter_get_address(adapter),
-					&eir_data.addr, eir_data.name);
-		device_set_name(device, eir_data.name);
-	}
+	remote->name = eir_data.name;
+	eir_data.name = NULL;
 
-	if (eir_data.hash)
-		btd_adapter_add_remote_oob_data(adapter, &eir_data.addr,
-					eir_data.hash, eir_data.randomizer);
+	remote->services = eir_data.services;
+	eir_data.services = NULL;
 
-	/* TODO handle UUIDs? */
+	remote->hash = eir_data.hash;
+	eir_data.hash = NULL;
 
-	if (remote)
-		bacpy(remote, &eir_data.addr);
-
-	/*
-	 * In RequestOOB reply append local hash and randomizer only if
-	 * received EIR also contained it.
-	 */
-	if (!remote && !eir_data.hash)
-		err = -EALREADY;
+	remote->randomizer = eir_data.randomizer;
+	eir_data.randomizer = NULL;
 
 	eir_data_free(&eir_data);
 
-	return err;
+	return 0;
 }
 
 /*
@@ -350,16 +342,8 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
  * N bytes - name
  */
 
-struct nokia_com_bt {
-	bdaddr_t address;
-	uint32_t cod;
-	uint8_t pin[16];
-	int pin_len;
-	char *name;
-};
-
 static int process_nokia_long (void *data, size_t size, uint8_t marker,
-						struct nokia_com_bt *nokia)
+						struct oob_params *remote)
 {
 	struct {
 		bdaddr_t address;
@@ -373,26 +357,26 @@ static int process_nokia_long (void *data, size_t size, uint8_t marker,
 		return -EINVAL;
 
 	/* address is not reverted */
-	baswap(&nokia->address, &n->address);
+	baswap(&remote->address, &n->address);
 
-	nokia->cod = n->class[0] | (n->class[1] << 8) | (n->class[2] << 16);
+	remote->class = n->class[0] | (n->class[1] << 8) | (n->class[2] << 16);
 
 	if (n->name_len > 0)
-		nokia->name = g_strndup((char *)n->name, n->name_len);
+		remote->name = g_strndup((char *)n->name, n->name_len);
 
 	if (marker == 0x01) {
-		memcpy(nokia->pin, n->authentication, 4);
-		nokia->pin_len = 4;
+		remote->pin = g_memdup(n->authentication, 4);
+		remote->pin_len = 4;
 	} else if (marker == 0x02) {
-		memcpy(nokia->pin, n->authentication, 16);
-		nokia->pin_len = 16;
+		remote->pin = g_memdup(n->authentication, 16);
+		remote->pin_len = 16;
 	}
 
 	return 0;
 }
 
 static int process_nokia_short (void *data, size_t size,
-						struct nokia_com_bt *nokia)
+						struct oob_params *remote)
 {
 	struct {
 		bdaddr_t address;
@@ -406,21 +390,21 @@ static int process_nokia_short (void *data, size_t size,
 		return -EINVAL;
 
 	/* address is not reverted */
-	baswap(&nokia->address, &n->address);
+	baswap(&remote->address, &n->address);
 
-	nokia->cod = n->class[0] | (n->class[1] << 8) | (n->class[2] << 16);
+	remote->class = n->class[0] | (n->class[1] << 8) | (n->class[2] << 16);
 
 	if (n->name_len > 0)
-		nokia->name = g_strndup((char *)n->name, n->name_len);
+		remote->name = g_strndup((char *)n->name, n->name_len);
 
-	memcpy(nokia->pin, n->authentication, 4);
-	nokia->pin_len = 4;
+	remote->pin = g_memdup(n->authentication, 4);
+	remote->pin_len = 4;
 
 	return 0;
 }
 
 static int process_nokia_extra_short (void *data, size_t size,
-						struct nokia_com_bt *nokia)
+						struct oob_params *remote)
 {
 	struct {
 		bdaddr_t address;
@@ -432,95 +416,42 @@ static int process_nokia_extra_short (void *data, size_t size,
 	if (size != sizeof(*n) + n->name_len)
 		return -EINVAL;
 
-	bacpy(&nokia->address, &n->address);
+	bacpy(&remote->address, &n->address);
 
-	nokia->cod = n->class[0] | (n->class[1] << 8) | (n->class[2] << 16);
+	remote->class = n->class[0] | (n->class[1] << 8) | (n->class[2] << 16);
 
 	if (n->name_len > 0)
-		nokia->name = g_strndup((char *)n->name, n->name_len);
+		remote->name = g_strndup((char *)n->name, n->name_len);
 
 	return 0;
 }
 
-/* returns 1 if pairing is not needed */
-static int process_nokia_com_bt(struct btd_adapter *adapter, void *data,
-						size_t size, bdaddr_t *remote)
+static int process_nokia_com_bt(uint8_t *data, size_t size,
+						struct oob_params *remote)
 {
-	uint8_t *marker;
-	struct nokia_com_bt nokia;
-	struct btd_device *device;
-	int ret;
-	char remote_address[18];
-
-	/* Support this only for PushOOB */
-	if (!remote)
-		return -EOPNOTSUPP;
+	uint8_t marker;
 
-	marker = data++;
-	size --;
+	marker = *data++;
+	size--;
 
-	DBG("marker: 0x%.2x  size: %zu", *marker, size);
+	DBG("marker: 0x%.2x  size: %zu", marker, size);
 
-	memset(&nokia, 0, sizeof(nokia));
-
-	switch (*marker) {
+	switch (marker) {
 	case 0x00:
 	case 0x01:
 	case 0x02:
-		ret = process_nokia_long(data, size, *marker, &nokia);
-		break;
+		return process_nokia_long(data, size, marker, remote);
 	case 0x10:
-		ret = process_nokia_extra_short(data, size, &nokia);
-		break;
+		return process_nokia_extra_short(data, size, remote);
 	case 0x24:
-		ret = process_nokia_short(data, size, &nokia);
-		break;
+		return process_nokia_short(data, size, remote);
 	default:
-		info("Not supported Nokia NFC extension (0x%.2x)", *marker);
-		ret = -EPROTONOSUPPORT;
-		break;
-	}
-
-	if (ret < 0)
-		return ret;
-
-	ba2str(&nokia.address, remote_address);
-	DBG("hci%u remote:%s", btd_adapter_get_index(adapter), remote_address);
-
-	device = adapter_get_device(adapter, &nokia.address, BDADDR_BREDR);
-
-	ret = check_device(device);
-	if (ret != 0) {
-		g_free(nokia.name);
-		return ret;
-	}
-
-	DBG("hci%u remote:%s", btd_adapter_get_index(adapter), remote_address);
-
-	if (nokia.name) {
-		adapter_store_cached_name(adapter_get_address(adapter), remote,
-								nokia.name);
-		device_set_name(device, nokia.name);
-		g_free(nokia.name);
+		info("Not supported Nokia NFC extension (0x%.2x)", marker);
+		return -EPROTONOSUPPORT;
 	}
-
-	if (nokia.cod != 0)
-		device_set_class(device, nokia.cod);
-
-	if (nokia.pin_len > 0) {
-		/* TODO
-		 * Handle PIN, for now only discovery mode and 'common' PINs
-		 * that might be provided by agent will work correctly.
-		 */
-	}
-
-	bacpy(remote, &nokia.address);
-
-	return 0;
 }
 
-static int process_params(DBusMessage *msg, struct btd_adapter *adapter,
-							bdaddr_t *remote)
+static int process_message(DBusMessage *msg, struct oob_params *remote)
 {
 	DBusMessageIter iter;
 	DBusMessageIter dict;
@@ -538,8 +469,8 @@ static int process_params(DBusMessage *msg, struct btd_adapter *adapter,
 
 	type = dbus_message_iter_get_arg_type(&dict);
 	if (type != DBUS_TYPE_DICT_ENTRY) {
-		if (!remote && type == DBUS_TYPE_INVALID)
-			return -EALREADY;
+		if (type == DBUS_TYPE_INVALID)
+			return -ENOENT;
 
 		return -EINVAL;
 	}
@@ -566,7 +497,7 @@ static int process_params(DBusMessage *msg, struct btd_adapter *adapter,
 		dbus_message_iter_recurse(&value, &array);
 		dbus_message_iter_get_fixed_array(&array, &eir, &size);
 
-		return process_eir(adapter, eir, size, remote);
+		return process_eir(eir, size, remote);
 	} else if (strcasecmp(key, "nokia.com:bt") == 0) {
 		DBusMessageIter array;
 		uint8_t *data;
@@ -575,7 +506,7 @@ static int process_params(DBusMessage *msg, struct btd_adapter *adapter,
 		dbus_message_iter_recurse(&value, &array);
 		dbus_message_iter_get_fixed_array(&array, &data, &size);
 
-		return process_nokia_com_bt(adapter, data, size, remote);
+		return process_nokia_com_bt(data, size, remote);
 	}
 
 	return -EINVAL;
@@ -598,12 +529,39 @@ static int check_adapter(struct btd_adapter *adapter)
 	return 0;
 }
 
+static void store_params(struct btd_adapter *adapter, struct btd_device *device,
+						struct oob_params *params)
+{
+	if (params->class != 0)
+		device_set_class(device, params->class);
+
+	if (params->name) {
+		adapter_store_cached_name(adapter_get_address(adapter),
+						&params->address, params->name);
+		device_set_name(device, params->name);
+	}
+
+	/* TODO handle UUIDs? */
+
+	if (params->hash) {
+		btd_adapter_add_remote_oob_data(adapter, &params->address,
+							params->hash,
+							params->randomizer);
+	} else if (params->pin_len) {
+		/* TODO
+		 * Handle PIN, for now only discovery mode and 'common' PINs
+		 * that might be provided by agent will work correctly.
+		 */
+	}
+}
+
 static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 {
 	struct btd_adapter *adapter;
 	struct agent *agent;
 	struct oob_handler *handler;
-	bdaddr_t remote;
+	struct oob_params remote;
+	struct btd_device *device;
 	uint8_t io_cap;
 	int err;
 
@@ -615,15 +573,6 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 	if (err < 0)
 		return error_reply(msg, -err);
 
-	err = process_params(msg, adapter, &remote);
-
-	/* already paired, reply immediately */
-	if (err == -EALREADY)
-		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-
-	if (err < 0)
-		return error_reply(msg, -err);
-
 	agent = adapter_get_agent(adapter);
 	if (!agent)
 		return error_reply(msg, ENONET);
@@ -631,13 +580,43 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 	io_cap = agent_get_io_capability(agent);
 	agent_unref(agent);
 
-	err = adapter_create_bonding(adapter, &remote, BDADDR_BREDR, io_cap);
+	memset(&remote, 0, sizeof(remote));
+
+	err = process_message(msg, &remote);
+	if (err < 0)
+		return error_reply(msg, -err);
+
+	if (bacmp(&remote.address, BDADDR_ANY) == 0) {
+		free_oob_params(&remote);
+
+		return error_reply(msg, EINVAL);
+	}
+
+	device = adapter_get_device(adapter, &remote.address, BDADDR_BREDR);
+
+	err = check_device(device);
+	if (err < 0) {
+		free_oob_params(&remote);
+
+		/* already paired, reply immediately */
+		if (err == -EALREADY)
+			return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+		return error_reply(msg, -err);
+	}
+
+	store_params(adapter, device, &remote);
+
+	free_oob_params(&remote);
+
+	err = adapter_create_bonding(adapter, device_get_address(device),
+							BDADDR_BREDR, io_cap);
 	if (err < 0)
 		return error_reply(msg, -err);
 
 	handler = g_new0(struct oob_handler, 1);
 	handler->bonding_cb = bonding_complete;
-	bacpy(&handler->remote_addr, &remote);
+	bacpy(&handler->remote_addr, device_get_address(device));
 	handler->user_data = dbus_message_ref(msg);
 
 	btd_adapter_set_oob_handler(adapter, handler);
@@ -650,6 +629,8 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 {
 	struct btd_adapter *adapter;
 	struct oob_handler *handler;
+	struct oob_params remote;
+	struct btd_device *device;
 	int err;
 
 	DBG("");
@@ -660,13 +641,38 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 	if (err < 0)
 		return error_reply(msg, -err);
 
-	err = process_params(msg, adapter, NULL);
-	if (err == -EALREADY)
-		return create_request_oob_reply(adapter, NULL, NULL, msg);
+	memset(&remote, 0, sizeof(remote));
 
+	err = process_message(msg, &remote);
 	if (err < 0)
 		return error_reply(msg, -err);
 
+	if (bacmp(&remote.address, BDADDR_ANY) == 0)
+		goto read_local;
+
+	device = adapter_get_device(adapter, &remote.address, BDADDR_BREDR);
+
+	err = check_device(device);
+	if (err < 0) {
+		free_oob_params(&remote);
+
+		if (err == -EALREADY)
+			return create_request_oob_reply(adapter, NULL, NULL,
+									msg);
+
+		return error_reply(msg, -err);
+	}
+
+	store_params(adapter, device, &remote);
+
+	if (!remote.hash) {
+		free_oob_params(&remote);
+		return create_request_oob_reply(adapter, NULL, NULL, msg);
+	}
+
+read_local:
+	free_oob_params(&remote);
+
 	err = btd_adapter_read_local_oob_data(adapter);
 	if (err < 0)
 		return error_reply(msg, -err);
-- 
1.8.1.1

