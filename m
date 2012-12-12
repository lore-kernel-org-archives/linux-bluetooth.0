Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/11] obexd: Port bluetooth plugin to use external profile support
Date: Wed, 12 Dec 2012 13:52:06 +0200
Message-Id: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This changes obexd to use ProfileManager.RegisterProfile
---
 obexd/plugins/bluetooth.c | 696 ++++++++++++++--------------------------------
 1 file changed, 212 insertions(+), 484 deletions(-)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 1448d0e..fc88a1e 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -43,270 +43,33 @@
 #include "transport.h"
 #include "service.h"
 #include "log.h"
+#include "uuid.h"
 
 #define BT_RX_MTU 32767
 #define BT_TX_MTU 32767
 
-#define TIMEOUT 60*1000 /* Timeout for user response (miliseconds) */
-
-struct pending_request {
-	DBusPendingCall *call;
-	struct bluetooth_service *service;
-	char *adapter_path;
-	char address[18];
-	unsigned int watch;
-	GIOChannel *io;
-};
-
-struct bluetooth_service {
+struct bluetooth_profile {
 	struct obex_server *server;
 	struct obex_service_driver *driver;
-	uint32_t handle;
+	char *uuid;
+	char *path;
 };
 
-struct adapter_any {
-	char *path;		/* Adapter ANY path */
-	GSList *services;	/* List of services to register records */
-};
+static GSList *profiles = NULL;
 
 static DBusConnection *connection = NULL;
-static struct adapter_any *any = NULL;
-
-static void add_record_reply(DBusPendingCall *call, void *user_data)
-{
-	struct bluetooth_service *service = user_data;
-	DBusMessage *reply = dbus_pending_call_steal_reply(call);
-	DBusError derr;
-	uint32_t handle;
-
-	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		error("bluetooth: Replied with an error: %s, %s",
-				derr.name, derr.message);
-		dbus_error_free(&derr);
-		handle = 0;
-	} else {
-		dbus_message_get_args(reply, NULL,
-				DBUS_TYPE_UINT32, &handle,
-				DBUS_TYPE_INVALID);
-
-		service->handle = handle;
-
-		DBG("Registered: %s, handle: 0x%x",
-				service->driver->name, service->handle);
-	}
-
-	dbus_message_unref(reply);
-}
-
-static int add_record(const char *path, const char *xml,
-			struct bluetooth_service *service)
-{
-	DBusMessage *msg;
-	DBusPendingCall *call;
-	int ret = 0;
-
-	msg = dbus_message_new_method_call("org.bluez", path,
-					"org.bluez.Service", "AddRecord");
-
-	dbus_message_append_args(msg, DBUS_TYPE_STRING, &xml,
-			DBUS_TYPE_INVALID);
-
-	if (dbus_connection_send_with_reply(connection,
-				msg, &call, -1) == FALSE) {
-		ret = -1;
-		goto failed;
-	}
-
-	dbus_pending_call_set_notify(call, add_record_reply, service, NULL);
-	dbus_pending_call_unref(call);
-
-failed:
-	dbus_message_unref(msg);
-	return ret;
-}
-
-static struct bluetooth_service *find_service(
-					struct obex_service_driver *driver)
-{
-	GSList *l;
-
-	for (l = any->services; l; l = l->next) {
-		struct bluetooth_service *service = l->data;
-
-		if (service->driver == driver)
-			return service;
-	}
-
-	return NULL;
-}
-
-static void register_record(struct obex_server *server)
-{
-	const GSList *l;
-
-	if (connection == NULL)
-		return;
-
-	for (l = server->drivers; l; l = l->next) {
-		struct obex_service_driver *driver = l->data;
-		struct bluetooth_service *service;
-		char *xml;
-
-		service = find_service(driver);
-		if (service == NULL) {
-			service = g_new0(struct bluetooth_service, 1);
-			service->driver = driver;
-			service->server = server;
-			any->services = g_slist_append(any->services, service);
-		}
-
-		/* Service already has a record registered */
-		if (service->handle != 0)
-			continue;
-
-		/* Adapter ANY is not available yet: Add record later */
-		if (any->path == NULL)
-			continue;
-
-		if (driver->port != 0)
-			xml = g_markup_printf_escaped(driver->record,
-							driver->channel,
-							driver->name,
-							driver->port);
-		else
-			xml = g_markup_printf_escaped(driver->record,
-							driver->channel,
-							driver->name);
-
-		add_record(any->path, xml, service);
-		g_free(xml);
-	}
-}
-
-static void find_adapter_any_reply(DBusPendingCall *call, void *user_data)
-{
-	DBusMessage *reply = dbus_pending_call_steal_reply(call);
-	const char *path;
-	GSList *l;
-	DBusError derr;
-
-	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		error("bluetooth: Replied with an error: %s, %s",
-				derr.name, derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	dbus_message_get_args(reply, NULL,
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_INVALID);
-	any->path = g_strdup(path);
-
-	for (l = any->services; l; l = l->next) {
-		struct bluetooth_service *service = l->data;
-		struct obex_service_driver *driver = service->driver;
-		char *xml;
-
-		if (driver->port != 0)
-			xml = g_markup_printf_escaped(driver->record,
-							driver->channel,
-							driver->name,
-							driver->port);
-		else
-			xml = g_markup_printf_escaped(driver->record,
-							driver->channel,
-							driver->name);
-
-		add_record(any->path, xml, service);
-		g_free(xml);
-	}
-
-done:
-	dbus_message_unref(reply);
-}
-
-static DBusPendingCall *find_adapter(const char *pattern,
-				DBusPendingCallNotifyFunction function,
-				void *user_data)
-{
-	DBusMessage *msg;
-	DBusPendingCall *call;
-
-	DBG("FindAdapter(%s)", pattern);
-
-	msg = dbus_message_new_method_call("org.bluez", "/",
-					"org.bluez.Manager", "FindAdapter");
-	if (!msg)
-		return NULL;
-
-	dbus_message_append_args(msg, DBUS_TYPE_STRING, &pattern,
-			DBUS_TYPE_INVALID);
-
-	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
-		dbus_message_unref(msg);
-		return NULL;
-	}
-
-	dbus_pending_call_set_notify(call, function, user_data, NULL);
-
-	dbus_message_unref(msg);
-
-	return call;
-}
-
-static void name_acquired(DBusConnection *conn, void *user_data)
-{
-	DBusPendingCall *call;
-
-	call = find_adapter("any", find_adapter_any_reply, NULL);
-	if (call)
-		dbus_pending_call_unref(call);
-}
-
-static void name_released(DBusConnection *conn, void *user_data)
-{
-	GSList *l;
-
-	/* reset handles so the services got register next time */
-	for (l = any->services; l; l = l->next) {
-		struct bluetooth_service *service = l->data;
-
-		service->handle = 0;
-	}
-
-	g_free(any->path);
-	any->path = NULL;
-
-}
-
-static void service_cancel(struct pending_request *pending)
-{
-	DBusMessage *msg;
-
-	msg = dbus_message_new_method_call("org.bluez",
-					pending->adapter_path,
-					"org.bluez.Service",
-					"CancelAuthorization");
-
-	g_dbus_send_message(connection, msg);
-}
 
-static void pending_request_free(struct pending_request *pending)
+static DBusMessage *profile_release(DBusConnection *conn, DBusMessage *msg,
+								void *data)
 {
-	if (pending->call)
-		dbus_pending_call_unref(pending->call);
-	g_io_channel_unref(pending->io);
-	g_free(pending->adapter_path);
-	g_free(pending);
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
 static void connect_event(GIOChannel *io, GError *err, void *user_data)
 {
 	int sk = g_io_channel_unix_get_fd(io);
-	struct bluetooth_service *service = user_data;
-	struct obex_server *server = service->server;
+	struct bluetooth_profile *profile = user_data;
+	struct obex_server *server = profile->server;
 	int type;
 	int omtu = BT_TX_MTU;
 	int imtu = BT_RX_MTU;
@@ -340,281 +103,257 @@ drop:
 	return;
 }
 
-static void service_reply(DBusPendingCall *call, void *user_data)
+static DBusMessage *profile_new_connection(DBusConnection *conn,
+						DBusMessage *msg, void *data)
 {
-	struct pending_request *pending = user_data;
-	GIOChannel *io = pending->io;
-	struct bluetooth_service *service = pending->service;
-	DBusMessage *reply = dbus_pending_call_steal_reply(call);
-	DBusError derr;
-	GError *err = NULL;
+	DBusMessageIter args;
+	const char *device;
+	int fd;
+	GIOChannel *io;
 
-	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		error("bluetooth: RequestAuthorization error: %s, %s",
-				derr.name, derr.message);
+	dbus_message_iter_init(msg, &args);
 
-		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY))
-			service_cancel(pending);
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.InvalidArguments",
+					"Invalid arguments in method call");
 
-		dbus_error_free(&derr);
-		g_io_channel_shutdown(io, TRUE, NULL);
-		goto done;
-	}
+	dbus_message_iter_get_basic(&args, &device);
 
-	DBG("RequestAuthorization succeeded");
+	dbus_message_iter_next(&args);
 
-	if (!bt_io_accept(io, connect_event, service, NULL, &err)) {
-		error("%s", err->message);
-		g_error_free(err);
-		g_io_channel_shutdown(io, TRUE, NULL);
-	}
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_UNIX_FD)
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.InvalidArguments",
+					"Invalid arguments in method call");
 
-done:
-	g_source_remove(pending->watch);
-	pending_request_free(pending);
-	dbus_message_unref(reply);
-}
+	dbus_message_iter_get_basic(&args, &fd);
 
-static gboolean service_error(GIOChannel *io, GIOCondition cond,
-			void *user_data)
-{
-	struct pending_request *pending = user_data;
+	io = g_io_channel_unix_new(fd);
+	if (io == NULL)
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.InvalidArguments",
+					"Invalid arguments in method call");
 
-	service_cancel(pending);
+	DBG("device %s", device);
 
-	dbus_pending_call_cancel(pending->call);
+	connect_event(io, NULL, data);
 
-	pending_request_free(pending);
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
 
-	return FALSE;
+static DBusMessage *profile_request_disconnection(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static void find_adapter_reply(DBusPendingCall *call, void *user_data)
+static DBusMessage *profile_cancel(DBusConnection *conn,
+						DBusMessage *msg, void *data)
 {
-	struct pending_request *pending = user_data;
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static const GDBusMethodTable profile_methods[] = {
+	{ GDBUS_METHOD("Release",
+			NULL, NULL,
+			profile_release) },
+	{ GDBUS_METHOD("NewConnection",
+			GDBUS_ARGS({ "device", "o" }, { "fd", "h" },
+			{ "options", "a{sv}" }), NULL,
+			profile_new_connection) },
+	{ GDBUS_METHOD("RequestDisconnection",
+			GDBUS_ARGS({ "device", "o" }), NULL,
+			profile_request_disconnection) },
+	{ GDBUS_METHOD("Cancel",
+			NULL, NULL,
+			profile_cancel) },
+	{ }
+};
+
+static void register_profile_reply(DBusPendingCall *call, void *user_data)
+{
+	struct bluetooth_profile *profile = user_data;
 	DBusMessage *reply = dbus_pending_call_steal_reply(call);
-	DBusMessage *msg;
-	DBusPendingCall *pcall;
-	const char *path, *paddr = pending->address;
 	DBusError derr;
+	GError *err = NULL;
 
 	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		error("Replied with an error: %s, %s",
-				derr.name, derr.message);
-		dbus_error_free(&derr);
-		goto failed;
+	if (!dbus_set_error_from_message(&derr, reply)) {
+		DBG("Profile %s registered", profile->path);
+		goto done;
 	}
 
-	dbus_message_get_args(reply, NULL,
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_INVALID);
+	g_free(profile->path);
+	profile->path = NULL;
 
-	DBG("FindAdapter -> %s", path);
-	pending->adapter_path = g_strdup(path);
+	error("bluetooth: RequestProfile error: %s, %s", derr.name,
+								derr.message);
+	dbus_error_free(&derr);
+done:
 	dbus_message_unref(reply);
+}
 
-	msg = dbus_message_new_method_call("org.bluez", path,
-			"org.bluez.Service", "RequestAuthorization");
-
-	dbus_message_append_args(msg, DBUS_TYPE_STRING, &paddr,
-			DBUS_TYPE_UINT32, &pending->service->handle,
-			DBUS_TYPE_INVALID);
-
-	if (!dbus_connection_send_with_reply(connection,
-					msg, &pcall, TIMEOUT)) {
-		dbus_message_unref(msg);
-		goto failed;
-	}
+static void unregister_profile(struct bluetooth_profile *profile)
+{
+	g_dbus_unregister_interface(connection, profile->path,
+						"org.bluez.Profile1");
+	g_free(profile->path);
+	profile->path = NULL;
+}
 
-	dbus_message_unref(msg);
+static void profile_free(void *data)
+{
+	struct bluetooth_profile *profile = data;
 
-	DBG("RequestAuthorization(%s, %x)", paddr,
-			pending->service->handle);
+	if (profile->path != NULL)
+		unregister_profile(profile);
 
-	if (!dbus_pending_call_set_notify(pcall, service_reply, pending,
-								NULL)) {
-		dbus_pending_call_unref(pcall);
-		goto failed;
-	}
+	g_free(profile->uuid);
+	g_free(profile);
+}
 
-	dbus_pending_call_unref(pending->call);
-	pending->call = pcall;
+static void append_variant(DBusMessageIter *iter, int type, void *val)
+{
+	DBusMessageIter value;
+	char sig[2] = { type, '\0' };
 
-	/* Catches errors before authorization response comes */
-	pending->watch = g_io_add_watch(pending->io,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					service_error, pending);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
 
-	return;
+	dbus_message_iter_append_basic(&value, type, val);
 
-failed:
-	g_io_channel_shutdown(pending->io, TRUE, NULL);
-	pending_request_free(pending);
+	dbus_message_iter_close_container(iter, &value);
 }
 
-static int request_service_authorization(struct bluetooth_service *service,
-							GIOChannel *io,
-							const char *source,
-							const char *address)
-{
-	struct pending_request *pending;
 
-	if (connection == NULL || any->path == NULL)
-		return -1;
+void dict_append_entry(DBusMessageIter *dict,
+			const char *key, int type, void *val)
+{
+	DBusMessageIter entry;
 
-	pending = g_new0(struct pending_request, 1);
-	pending->call = find_adapter(source, find_adapter_reply, pending);
-	if (!pending->call) {
-		g_free(pending);
-		return -ENOMEM;
+	if (type == DBUS_TYPE_STRING) {
+		const char *str = *((const char **) val);
+		if (str == NULL)
+			return;
 	}
 
-	pending->service = service;
-	pending->io = g_io_channel_ref(io);
-	memcpy(pending->address, address, sizeof(pending->address));
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+							NULL, &entry);
 
-	return 0;
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
 }
 
-static void confirm_connection(GIOChannel *io, const char *source,
-					const char *address, void *user_data)
+static int register_profile(struct bluetooth_profile *profile)
 {
+	DBusMessage *msg;
+	DBusMessageIter iter, opt;
+	DBusPendingCall *call;
+	dbus_bool_t auto_connect = FALSE;
+	int ret = 0;
 
-	struct obex_service_driver *driver = user_data;
-	struct bluetooth_service *service;
-	GError *err = NULL;
+	profile->path = g_strconcat("/org/bluez/obex/", profile->uuid, NULL);
+	g_strdelimit(profile->path, "-", '_');
 
-	service = find_service(driver);
-	if (service == NULL) {
-		error("bluetooth: Unable to find service");
-		goto drop;
+	if (!g_dbus_register_interface(connection, profile->path,
+					"org.bluez.Profile1", profile_methods,
+					NULL, NULL,
+					profile, NULL)) {
+		error("D-Bus failed to register %s", profile->path);
+		g_free(profile->path);
+		profile->path = NULL;
+		return -1;
 	}
 
-	if (driver->secure) {
-		if (request_service_authorization(service, io, source,
-								address) < 0)
-			goto drop;
+	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
+						"org.bluez.ProfileManager1",
+						"RegisterProfile");
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+							&profile->path);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
+							&profile->uuid);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&opt);
+	dict_append_entry(&opt, "AutoConnect", DBUS_TYPE_BOOLEAN,
+								&auto_connect);
+	dbus_message_iter_close_container(&iter, &opt);
 
-		return;
-	}
-
-	if (!bt_io_accept(io, connect_event, service, NULL, &err)) {
-		error("%s", err->message);
-		g_error_free(err);
-		goto drop;
+	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
+		ret = -1;
+		unregister_profile(profile);
+		goto failed;
 	}
 
-	return;
+	dbus_pending_call_set_notify(call, register_profile_reply, profile,
+									NULL);
+	dbus_pending_call_unref(call);
 
-drop:
-	g_io_channel_shutdown(io, TRUE, NULL);
+failed:
+	dbus_message_unref(msg);
+	return ret;
 }
 
-static void confirm_rfcomm(GIOChannel *io, void *user_data)
+static const char *service2uuid(uint16_t service)
 {
-	GError *err = NULL;
-	char source[18];
-	char address[18];
-	uint8_t channel;
-
-	bt_io_get(io, &err,
-			BT_IO_OPT_SOURCE, source,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_CHANNEL, &channel,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		g_io_channel_shutdown(io, TRUE, NULL);
-		return;
+	switch (service) {
+	case OBEX_OPP:
+		return OBEX_OPP_UUID;
+	case OBEX_FTP:
+		return OBEX_FTP_UUID;
+	case OBEX_PBAP:
+		return OBEX_PSE_UUID;
 	}
 
-	info("bluetooth: New connection from: %s, channel %u", address,
-								channel);
-
-	confirm_connection(io, source, address, user_data);
+	return NULL;
 }
 
-static void confirm_l2cap(GIOChannel *io, void *user_data)
+static void name_acquired(DBusConnection *conn, void *user_data)
 {
-	GError *err = NULL;
-	char source[18];
-	char address[18];
-	uint16_t psm;
-
-	bt_io_get(io, &err,
-			BT_IO_OPT_SOURCE, source,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_PSM, &psm,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		g_io_channel_shutdown(io, TRUE, NULL);
-		return;
-	}
+	GSList *l;
 
-	info("bluetooth: New connection from: %s, psm %u", address, psm);
+	DBG("org.bluez appeared");
 
-	confirm_connection(io, source, address, user_data);
+	for (l = profiles; l; l = l->next) {
+		struct bluetooth_profile *profile = l->data;
+		const char *uuid;
+
+		if (profile->path != NULL)
+			continue;
+
+		if (register_profile(profile) < 0) {
+			error("bluetooth: Failed to register profile %s",
+							profile->path);
+			g_free(profile->path);
+			profile->path = NULL;
+		}
+	}
 }
 
-static GSList *start(struct obex_server *server,
-				struct obex_service_driver *service)
+static void name_released(DBusConnection *conn, void *user_data)
 {
-	BtIOSecLevel sec_level;
-	GSList *l = NULL;
-	GIOChannel *io;
-	GError *err = NULL;
-	uint16_t psm;
-
-	if (service->secure == TRUE)
-		sec_level = BT_IO_SEC_MEDIUM;
-	else
-		sec_level = BT_IO_SEC_LOW;
-
-	io = bt_io_listen(NULL, confirm_rfcomm,
-				service, NULL, &err,
-				BT_IO_OPT_CHANNEL, service->channel,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
-				BT_IO_OPT_INVALID);
-	if (io == NULL) {
-		error("bluetooth: unable to listen in channel %d: %s",
-				service->channel, err->message);
-		g_error_free(err);
-	} else {
-		l = g_slist_prepend(l, io);
-		DBG("listening on channel %d", service->channel);
-	}
+	GSList *l;
 
-	if (service->port == 0)
-		return l;
-
-	psm = service->port == OBEX_PORT_RANDOM ? 0 : service->port;
-
-	io = bt_io_listen(NULL, confirm_l2cap,
-			service, NULL, &err,
-			BT_IO_OPT_PSM, psm,
-			BT_IO_OPT_MODE, BT_IO_MODE_ERTM,
-			BT_IO_OPT_OMTU, BT_TX_MTU,
-			BT_IO_OPT_IMTU, BT_RX_MTU,
-			BT_IO_OPT_SEC_LEVEL, sec_level,
-			BT_IO_OPT_INVALID);
-	if (io == NULL) {
-		error("bluetooth: unable to listen in psm %d: %s",
-				service->port, err->message);
-		g_error_free(err);
-		service->port = 0;
-	} else {
-		l = g_slist_prepend(l, io);
-		bt_io_get(io, &err, BT_IO_OPT_PSM, &service->port,
-							BT_IO_OPT_INVALID);
-		DBG("listening on psm %d", service->port);
-	}
+	DBG("org.bluez disappered");
+
+	for (l = profiles; l; l = l->next) {
+		struct bluetooth_profile *profile = l->data;
+		const char *uuid;
 
-	return l;
+		if (profile->path == NULL)
+			continue;
+
+		unregister_profile(profile);
+	}
 }
 
 static void *bluetooth_start(struct obex_server *server, int *err)
@@ -623,34 +362,29 @@ static void *bluetooth_start(struct obex_server *server, int *err)
 	const GSList *l;
 
 	for (l = server->drivers; l; l = l->next) {
-		struct obex_service_driver *service = l->data;
-		GSList *l;
+		struct obex_service_driver *driver = l->data;
+		struct bluetooth_profile *profile;
+		const char *uuid;
 
-		l = start(server, service);
-		if (l == NULL)
+		uuid = service2uuid(driver->service);
+		if (uuid == NULL)
 			continue;
 
-		ios = g_slist_concat(ios, l);
-	}
-
-	register_record(server);
-
-	return ios;
-}
+		profile = g_new0(struct bluetooth_profile, 1);
+		profile->driver = driver;
+		profile->server = server;
+		profile->uuid = g_strdup(uuid);
 
-static void stop(gpointer data)
-{
-	GIOChannel *io = data;
+		profiles = g_slist_prepend(profiles, profile);
+	}
 
-	g_io_channel_shutdown(io, TRUE, NULL);
-	g_io_channel_unref(io);
+	return profiles;
 }
 
 static void bluetooth_stop(void *data)
 {
-	GSList *ios = data;
-
-	g_slist_free_full(ios, stop);
+	g_slist_free_full(profiles, profile_free);
+	profiles = NULL;
 }
 
 static int bluetooth_getpeername(GIOChannel *io, char **name)
@@ -682,8 +416,6 @@ static unsigned int listener_id = 0;
 
 static int bluetooth_init(void)
 {
-	any = g_new0(struct adapter_any, 1);
-
 	connection = g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
 	if (connection == NULL)
 		return -EPERM;
@@ -698,11 +430,7 @@ static void bluetooth_exit(void)
 {
 	g_dbus_remove_watch(connection, listener_id);
 
-	if (any) {
-		g_slist_free_full(any->services, g_free);
-		g_free(any->path);
-		g_free(any);
-	}
+	g_slist_free_full(profiles, profile_free);
 
 	if (connection)
 		dbus_connection_unref(connection);
-- 
1.7.11.7

