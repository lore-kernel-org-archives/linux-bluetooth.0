Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/14] client: Call bt_shell_noninteractive_quit when done with command
Date: Mon, 26 Feb 2018 17:53:33 +0200
Message-Id: <20180226155336.25875-12-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This ensures that the commands don't stay hanging since bt_shell no
longer quits immediatelly after executing a command.
---
 client/advertising.c |  84 +++++++++++++++++++---------
 client/gatt.c        | 113 ++++++++++++++++++++++++-------------
 client/main.c        | 153 ++++++++++++++++++++++++++++++++++-----------------
 3 files changed, 235 insertions(+), 115 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 3cfc318ba..2be96483a 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -190,6 +190,7 @@ static void register_reply(DBusMessage *message, void *user_data)
 		ad.registered = true;
 		bt_shell_printf("Advertising object registered\n");
 		print_ad();
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	} else {
 		bt_shell_printf("Failed to register advertisement: %s\n", error.name);
 		dbus_error_free(&error);
@@ -197,6 +198,7 @@ static void register_reply(DBusMessage *message, void *user_data)
 		if (g_dbus_unregister_interface(conn, AD_PATH,
 						AD_IFACE) == FALSE)
 			bt_shell_printf("Failed to unregister advertising object\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
@@ -441,7 +443,7 @@ void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *type)
 {
 	if (ad.registered) {
 		bt_shell_printf("Advertisement is already registered\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	g_free(ad.type);
@@ -450,14 +452,14 @@ void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *type)
 	if (g_dbus_register_interface(conn, AD_PATH, AD_IFACE, ad_methods,
 					NULL, ad_props, NULL, NULL) == FALSE) {
 		bt_shell_printf("Failed to register advertising object\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	if (g_dbus_proxy_method_call(manager, "RegisterAdvertisement",
 					register_setup, register_reply,
 					conn, NULL) == FALSE) {
 		bt_shell_printf("Failed to register advertising\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
@@ -481,10 +483,12 @@ static void unregister_reply(DBusMessage *message, void *user_data)
 		if (g_dbus_unregister_interface(conn, AD_PATH,
 							AD_IFACE) == FALSE)
 			bt_shell_printf("Failed to unregister advertising object\n");
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	} else {
 		bt_shell_printf("Failed to unregister advertisement: %s\n",
 								error.name);
 		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
@@ -494,7 +498,7 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 		ad_release(conn);
 
 	if (!ad.registered)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	g_free(ad.type);
 	ad.type = NULL;
@@ -503,7 +507,7 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 					unregister_setup, unregister_reply,
 					conn, NULL) == FALSE) {
 		bt_shell_printf("Failed to unregister advertisement method\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
@@ -518,7 +522,7 @@ void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[])
 {
 	if (argc < 2 || !strlen(argv[1])) {
 		print_ad_uuids();
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
 	ad_clear_uuids();
@@ -526,27 +530,33 @@ void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[])
 	ad.uuids = g_strdupv(&argv[1]);
 	if (!ad.uuids) {
 		bt_shell_printf("Failed to parse input\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	ad.uuids_len = g_strv_length(ad.uuids);
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceUUIDs");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_disable_uuids(DBusConnection *conn)
 {
 	if (!ad.uuids)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	ad_clear_uuids();
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceUUIDs");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void ad_clear_service(void)
 {
 	g_free(ad.service.uuid);
 	memset(&ad.service, 0, sizeof(ad.service));
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
@@ -560,7 +570,7 @@ void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
 			bt_shell_hexdump(ad.service.data.data,
 						ad.service.data.len);
 		}
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
 	ad_clear_service();
@@ -590,20 +600,26 @@ void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
 	}
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceData");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_disable_service(DBusConnection *conn)
 {
 	if (!ad.service.uuid)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	ad_clear_service();
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceData");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void ad_clear_manufacturer(void)
 {
 	memset(&ad.manufacturer, 0, sizeof(ad.manufacturer));
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
@@ -621,7 +637,7 @@ void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 						ad.manufacturer.data.len);
 		}
 
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
 	ad_clear_manufacturer();
@@ -629,7 +645,7 @@ void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 	val = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || val > UINT16_MAX) {
 		bt_shell_printf("Invalid manufacture id\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	ad.manufacturer.id = val;
@@ -639,14 +655,14 @@ void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 		if (i >= G_N_ELEMENTS(data->data)) {
 			bt_shell_printf("Too much data\n");
 			ad_clear_manufacturer();
-			return;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
 		val = strtol(argv[i], &endptr, 0);
 		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
 			bt_shell_printf("Invalid value at index %d\n", i);
 			ad_clear_manufacturer();
-			return;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
 		data->data[data->len] = val;
@@ -655,23 +671,27 @@ void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
 							"ManufacturerData");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_disable_manufacturer(DBusConnection *conn)
 {
 	if (!ad.manufacturer.id && !ad.manufacturer.data.len)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	ad_clear_manufacturer();
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
 							"ManufacturerData");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value)
 {
 	if (!value) {
 		bt_shell_printf("Tx Power: %s\n", ad.tx_power ? "on" : "off");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
 	if (ad.tx_power == *value)
@@ -680,12 +700,14 @@ void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value)
 	ad.tx_power = *value;
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Includes");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_advertise_name(DBusConnection *conn, bool value)
 {
 	if (ad.name == value)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	ad.name = value;
 
@@ -695,6 +717,8 @@ void ad_advertise_name(DBusConnection *conn, bool value)
 	}
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Includes");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_advertise_local_name(DBusConnection *conn, const char *name)
@@ -705,7 +729,7 @@ void ad_advertise_local_name(DBusConnection *conn, const char *name)
 		else
 			bt_shell_printf("Name: %s\n", ad.name ? "on" : "off");
 
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
 	if (ad.local_name && !strcmp(name, ad.local_name))
@@ -715,12 +739,14 @@ void ad_advertise_local_name(DBusConnection *conn, const char *name)
 	ad.local_name = strdup(name);
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "LocalName");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_advertise_appearance(DBusConnection *conn, bool value)
 {
 	if (ad.appearance == value)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	ad.appearance = value;
 
@@ -728,6 +754,8 @@ void ad_advertise_appearance(DBusConnection *conn, bool value)
 		ad.local_appearance = UINT16_MAX;
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Includes");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_advertise_local_appearance(DBusConnection *conn, long int *value)
@@ -741,15 +769,17 @@ void ad_advertise_local_appearance(DBusConnection *conn, long int *value)
 			bt_shell_printf("Apperance: %s\n",
 					ad.appearance ? "on" : "off");
 
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
 	if (ad.local_appearance == *value)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	ad.local_appearance = *value;
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Appearance");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_advertise_duration(DBusConnection *conn, long int *value)
@@ -757,15 +787,17 @@ void ad_advertise_duration(DBusConnection *conn, long int *value)
 	if (!value) {
 		if (ad.duration)
 			bt_shell_printf("Duration: %u sec\n", ad.duration);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
 	if (ad.duration == *value)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	ad.duration = *value;
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Duration");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_advertise_timeout(DBusConnection *conn, long int *value)
@@ -773,13 +805,15 @@ void ad_advertise_timeout(DBusConnection *conn, long int *value)
 	if (!value) {
 		if (ad.timeout)
 			bt_shell_printf("Timeout: %u sec\n", ad.timeout);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
 	if (ad.timeout == *value)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	ad.timeout = *value;
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Timeout");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
diff --git a/client/gatt.c b/client/gatt.c
index b640b6eb9..91cfb019f 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -367,6 +367,7 @@ static void list_attributes(const char *path, GList *source)
 void gatt_list_attributes(const char *path)
 {
 	list_attributes(path, services);
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static GDBusProxy *select_attribute(const char *path)
@@ -488,14 +489,14 @@ static void read_reply(DBusMessage *message, void *user_data)
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to read: %s\n", error.name);
 		dbus_error_free(&error);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	dbus_message_iter_init(message, &iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
 		bt_shell_printf("Invalid response to read\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	dbus_message_iter_recurse(&iter, &array);
@@ -503,10 +504,12 @@ static void read_reply(DBusMessage *message, void *user_data)
 
 	if (len < 0) {
 		bt_shell_printf("Unable to parse value\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_hexdump(value, len);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void read_setup(DBusMessageIter *iter, void *user_data)
@@ -528,7 +531,7 @@ static void read_attribute(GDBusProxy *proxy)
 	if (g_dbus_proxy_method_call(proxy, "ReadValue", read_setup, read_reply,
 							NULL, NULL) == FALSE) {
 		bt_shell_printf("Failed to read\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Attempting to read %s\n", g_dbus_proxy_get_path(proxy));
@@ -547,6 +550,7 @@ void gatt_read_attribute(GDBusProxy *proxy)
 
 	bt_shell_printf("Unable to read attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void write_reply(DBusMessage *message, void *user_data)
@@ -558,8 +562,10 @@ static void write_reply(DBusMessage *message, void *user_data)
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to write: %s\n", error.name);
 		dbus_error_free(&error);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void write_setup(DBusMessageIter *iter, void *user_data)
@@ -598,13 +604,13 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 
 		if (i >= G_N_ELEMENTS(value)) {
 			bt_shell_printf("Too much data\n");
-			return;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
 		val = strtol(entry, &endptr, 0);
 		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
 			bt_shell_printf("Invalid value at index %d\n", i);
-			return;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
 		value[i] = val;
@@ -619,7 +625,7 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 						io_get_fd(write_io.io));
 		if (io_send(write_io.io, &iov, 1) < 0) {
 			bt_shell_printf("Failed to write: %s", strerror(errno));
-			return;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 		return;
 	}
@@ -627,7 +633,7 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup,
 					write_reply, &iov, NULL) == FALSE) {
 		bt_shell_printf("Failed to write\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Attempting to write %s\n", g_dbus_proxy_get_path(proxy));
@@ -646,6 +652,8 @@ void gatt_write_attribute(GDBusProxy *proxy, const char *arg)
 
 	bt_shell_printf("Unable to write attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static bool pipe_read(struct io *io, void *user_data)
@@ -729,7 +737,7 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 		bt_shell_printf("Failed to acquire write: %s\n", error.name);
 		dbus_error_free(&error);
 		write_io.proxy = NULL;
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	if (write_io.io)
@@ -739,12 +747,13 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 					DBUS_TYPE_UINT16, &write_io.mtu,
 					DBUS_TYPE_INVALID) == false)) {
 		bt_shell_printf("Invalid AcquireWrite response\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("AcquireWrite success: fd %d MTU %u\n", fd, write_io.mtu);
 
 	write_io.io = pipe_io_new(fd, NULL);
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void acquire_setup(DBusMessageIter *iter, void *user_data)
@@ -769,13 +778,13 @@ void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
 	if (strcmp(iface, "org.bluez.GattCharacteristic1")) {
 		bt_shell_printf("Unable to acquire write: %s not a characteristic\n",
 						g_dbus_proxy_get_path(proxy));
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "AcquireWrite", acquire_setup,
 				acquire_write_reply, NULL, NULL) == FALSE) {
 		bt_shell_printf("Failed to AcquireWrite\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	write_io.proxy = proxy;
@@ -785,10 +794,12 @@ void gatt_release_write(GDBusProxy *proxy, const char *arg)
 {
 	if (proxy != write_io.proxy || !write_io.io) {
 		bt_shell_printf("Write not acquired\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	write_io_destroy();
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void acquire_notify_reply(DBusMessage *message, void *user_data)
@@ -802,7 +813,7 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 		bt_shell_printf("Failed to acquire notify: %s\n", error.name);
 		dbus_error_free(&error);
 		write_io.proxy = NULL;
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	if (notify_io.io) {
@@ -816,12 +827,14 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 					DBUS_TYPE_UINT16, &notify_io.mtu,
 					DBUS_TYPE_INVALID) == false)) {
 		bt_shell_printf("Invalid AcquireNotify response\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("AcquireNotify success: fd %d MTU %u\n", fd, notify_io.mtu);
 
 	notify_io.io = pipe_io_new(fd, NULL);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void gatt_acquire_notify(GDBusProxy *proxy, const char *arg)
@@ -832,13 +845,13 @@ void gatt_acquire_notify(GDBusProxy *proxy, const char *arg)
 	if (strcmp(iface, "org.bluez.GattCharacteristic1")) {
 		bt_shell_printf("Unable to acquire notify: %s not a characteristic\n",
 						g_dbus_proxy_get_path(proxy));
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "AcquireNotify", acquire_setup,
 				acquire_notify_reply, NULL, NULL) == FALSE) {
 		bt_shell_printf("Failed to AcquireNotify\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	notify_io.proxy = proxy;
@@ -848,10 +861,12 @@ void gatt_release_notify(GDBusProxy *proxy, const char *arg)
 {
 	if (proxy != notify_io.proxy || !notify_io.io) {
 		bt_shell_printf("Notify not acquired\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	notify_io_destroy();
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void notify_reply(DBusMessage *message, void *user_data)
@@ -865,10 +880,12 @@ static void notify_reply(DBusMessage *message, void *user_data)
 		bt_shell_printf("Failed to %s notify: %s\n",
 				enable ? "start" : "stop", error.name);
 		dbus_error_free(&error);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Notify %s\n", enable == TRUE ? "started" : "stopped");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void notify_attribute(GDBusProxy *proxy, bool enable)
@@ -883,8 +900,10 @@ static void notify_attribute(GDBusProxy *proxy, bool enable)
 	if (g_dbus_proxy_method_call(proxy, method, NULL, notify_reply,
 				GUINT_TO_POINTER(enable), NULL) == FALSE) {
 		bt_shell_printf("Failed to %s notify\n", enable ? "start" : "stop");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void gatt_notify_attribute(GDBusProxy *proxy, bool enable)
@@ -899,6 +918,8 @@ void gatt_notify_attribute(GDBusProxy *proxy, bool enable)
 
 	bt_shell_printf("Unable to notify attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void register_app_setup(DBusMessageIter *iter, void *user_data)
@@ -927,10 +948,12 @@ static void register_app_reply(DBusMessage *message, void *user_data)
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to register application: %s\n", error.name);
 		dbus_error_free(&error);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Application registered\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void gatt_add_manager(GDBusProxy *proxy)
@@ -997,7 +1020,7 @@ void gatt_register_app(DBusConnection *conn, GDBusProxy *proxy,
 	l = g_list_find_custom(managers, proxy, match_proxy);
 	if (!l) {
 		bt_shell_printf("Unable to find GattManager proxy\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	for (i = 0; i < argc; i++)
@@ -1009,7 +1032,7 @@ void gatt_register_app(DBusConnection *conn, GDBusProxy *proxy,
 						NULL, properties, NULL,
 						NULL) == FALSE) {
 			bt_shell_printf("Failed to register application object\n");
-			return;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 	}
 
@@ -1019,7 +1042,7 @@ void gatt_register_app(DBusConnection *conn, GDBusProxy *proxy,
 						NULL) == FALSE) {
 		bt_shell_printf("Failed register application\n");
 		g_dbus_unregister_interface(conn, APP_PATH, PROFILE_INTERFACE);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
@@ -1033,18 +1056,20 @@ static void unregister_app_reply(DBusMessage *message, void *user_data)
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to unregister application: %s\n", error.name);
 		dbus_error_free(&error);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Application unregistered\n");
 
 	if (!uuids)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	g_list_free_full(uuids, g_free);
 	uuids = NULL;
 
 	g_dbus_unregister_interface(conn, APP_PATH, PROFILE_INTERFACE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void unregister_app_setup(DBusMessageIter *iter, void *user_data)
@@ -1061,7 +1086,7 @@ void gatt_unregister_app(DBusConnection *conn, GDBusProxy *proxy)
 	l = g_list_find_custom(managers, proxy, match_proxy);
 	if (!l) {
 		bt_shell_printf("Unable to find GattManager proxy\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	if (g_dbus_proxy_method_call(l->data, "UnregisterApplication",
@@ -1069,7 +1094,7 @@ void gatt_unregister_app(DBusConnection *conn, GDBusProxy *proxy)
 						unregister_app_reply, conn,
 						NULL) == FALSE) {
 		bt_shell_printf("Failed unregister profile\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
@@ -1190,7 +1215,7 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 					service_free) == FALSE) {
 		bt_shell_printf("Failed to register service object\n");
 		service_free(service);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	print_service(service, COLORED_NEW);
@@ -1199,6 +1224,8 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 
 	bt_shell_prompt_input(service->path, "Primary (yes/no):", service_set_primary,
 			service);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static struct service *service_find(const char *pattern)
@@ -1228,7 +1255,7 @@ void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
 	service = service_find(argv[1]);
 	if (!service) {
 		bt_shell_printf("Failed to unregister service object\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	local_services = g_list_remove(local_services, service);
@@ -1237,6 +1264,8 @@ void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
 
 	g_dbus_unregister_interface(service->conn, service->path,
 						SERVICE_INTERFACE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static gboolean chrc_get_uuid(const GDBusPropertyTable *property,
@@ -1672,7 +1701,7 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 
 	if (!local_services) {
 		bt_shell_printf("No service registered\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	service = g_list_last(local_services)->data;
@@ -1688,7 +1717,7 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 					chrc, chrc_free) == FALSE) {
 		bt_shell_printf("Failed to register characteristic object\n");
 		chrc_free(chrc);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	service->chrcs = g_list_append(service->chrcs, chrc);
@@ -1696,6 +1725,8 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 	print_chrc(chrc, COLORED_NEW);
 
 	bt_shell_prompt_input(chrc->path, "Enter value:", chrc_set_value, chrc);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static struct chrc *chrc_find(const char *pattern)
@@ -1731,12 +1762,14 @@ void gatt_unregister_chrc(DBusConnection *conn, GDBusProxy *proxy,
 	chrc = chrc_find(argv[1]);
 	if (!chrc) {
 		bt_shell_printf("Failed to unregister characteristic object\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	chrc->service->chrcs = g_list_remove(chrc->service->chrcs, chrc);
 
 	chrc_unregister(chrc);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
@@ -1859,14 +1892,14 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 
 	if (!local_services) {
 		bt_shell_printf("No service registered\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	service = g_list_last(local_services)->data;
 
 	if (!service->chrcs) {
 		bt_shell_printf("No characteristic registered\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	desc = g_new0(struct desc, 1);
@@ -1880,7 +1913,7 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 					desc, desc_free) == FALSE) {
 		bt_shell_printf("Failed to register descriptor object\n");
 		desc_free(desc);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	desc->chrc->descs = g_list_append(desc->chrc->descs, desc);
@@ -1888,6 +1921,8 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 	print_desc(desc, COLORED_NEW);
 
 	bt_shell_prompt_input(desc->path, "Enter value:", desc_set_value, desc);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static struct desc *desc_find(const char *pattern)
@@ -1928,10 +1963,12 @@ void gatt_unregister_desc(DBusConnection *conn, GDBusProxy *proxy,
 	desc = desc_find(argv[1]);
 	if (!desc) {
 		bt_shell_printf("Failed to unregister descriptor object\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	desc->chrc->descs = g_list_remove(desc->chrc->descs, desc);
 
 	desc_unregister(desc);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
diff --git a/client/main.c b/client/main.c
index 962f3383b..85c1889fd 100644
--- a/client/main.c
+++ b/client/main.c
@@ -827,6 +827,8 @@ static void cmd_list(int argc, char *argv[])
 		struct adapter *adapter = list->data;
 		print_adapter(adapter->proxy, NULL);
 	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_show(int argc, char *argv[])
@@ -852,7 +854,7 @@ static void cmd_show(int argc, char *argv[])
 	}
 
 	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	dbus_message_iter_get_basic(&iter, &address);
 
@@ -875,6 +877,8 @@ static void cmd_show(int argc, char *argv[])
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "Discovering");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_select(int argc, char *argv[])
@@ -884,14 +888,16 @@ static void cmd_select(int argc, char *argv[])
 	adapter = find_ctrl_by_address(ctrl_list, argv[1]);
 	if (!adapter) {
 		bt_shell_printf("Controller %s not available\n", argv[1]);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	if (default_ctrl && default_ctrl->proxy == adapter->proxy)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	default_ctrl = adapter;
 	print_adapter(adapter->proxy, NULL);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_devices(int argc, char *argv[])
@@ -899,13 +905,15 @@ static void cmd_devices(int argc, char *argv[])
 	GList *ll;
 
 	if (check_default_ctrl() == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	for (ll = g_list_first(default_ctrl->devices);
 			ll; ll = g_list_next(ll)) {
 		GDBusProxy *proxy = ll->data;
 		print_device(proxy, NULL);
 	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_paired_devices(int argc, char *argv[])
@@ -913,7 +921,7 @@ static void cmd_paired_devices(int argc, char *argv[])
 	GList *ll;
 
 	if (check_default_ctrl() == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	for (ll = g_list_first(default_ctrl->devices);
 			ll; ll = g_list_next(ll)) {
@@ -930,16 +938,21 @@ static void cmd_paired_devices(int argc, char *argv[])
 
 		print_device(proxy, NULL);
 	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void generic_callback(const DBusError *error, void *user_data)
 {
 	char *str = user_data;
 
-	if (dbus_error_is_set(error))
+	if (dbus_error_is_set(error)) {
 		bt_shell_printf("Failed to set %s: %s\n", str, error->name);
-	else
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	} else {
 		bt_shell_printf("Changing %s succeeded\n", str);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
 }
 
 static void cmd_system_alias(int argc, char *argv[])
@@ -1016,6 +1029,8 @@ static void cmd_pairable(int argc, char *argv[])
 		return;
 
 	g_free(str);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void cmd_discoverable(int argc, char *argv[])
@@ -1038,6 +1053,8 @@ static void cmd_discoverable(int argc, char *argv[])
 		return;
 
 	g_free(str);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void cmd_agent(int argc, char *argv[])
@@ -1047,7 +1064,7 @@ static void cmd_agent(int argc, char *argv[])
 
 	if (!parse_argument(argc, argv, agent_arguments, "capability",
 						&enable, &capability))
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	if (enable == TRUE) {
 		g_free(auto_register_agent);
@@ -1067,6 +1084,8 @@ static void cmd_agent(int argc, char *argv[])
 		else
 			bt_shell_printf("Agent registration disabled\n");
 	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_default_agent(int argc, char *argv[])
@@ -1085,10 +1104,11 @@ static void start_discovery_reply(DBusMessage *message, void *user_data)
 		bt_shell_printf("Failed to %s discovery: %s\n",
 				enable == TRUE ? "start" : "stop", error.name);
 		dbus_error_free(&error);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_printf("Discovery %s\n", enable == TRUE ? "started" : "stopped");
+	bt_shell_printf("Discovery %s\n", enable ? "started" : "stopped");
+	/* Leave the discovery running even on noninteractive mode */
 }
 
 static void append_variant(DBusMessageIter *iter, int type, void *val)
@@ -1235,12 +1255,14 @@ static void set_discovery_filter_reply(DBusMessage *message, void *user_data)
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("SetDiscoveryFilter failed: %s\n", error.name);
 		dbus_error_free(&error);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	filter.set = true;
 
 	bt_shell_printf("SetDiscoveryFilter success\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void set_discovery_filter(void)
@@ -1252,7 +1274,7 @@ static void set_discovery_filter(void)
 		set_discovery_filter_setup, set_discovery_filter_reply,
 		&filter, NULL) == FALSE) {
 		bt_shell_printf("Failed to set discovery filter\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	filter.set = true;
@@ -1280,7 +1302,7 @@ static void cmd_scan(int argc, char *argv[])
 				GUINT_TO_POINTER(enable), NULL) == FALSE) {
 		bt_shell_printf("Failed to %s discovery\n",
 					enable == TRUE ? "start" : "stop");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
@@ -1305,7 +1327,7 @@ static void cmd_scan_filter_uuids(int argc, char *argv[])
 	filter.uuids = g_strdupv(&argv[1]);
 	if (!filter.uuids) {
 		bt_shell_printf("Failed to parse input\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	filter.uuids_len = g_strv_length(filter.uuids);
@@ -1515,10 +1537,10 @@ static void cmd_info(int argc, char *argv[])
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	dbus_message_iter_get_basic(&iter, &address);
 
@@ -1548,6 +1570,8 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "ServiceData");
 	print_property(proxy, "RSSI");
 	print_property(proxy, "TxPower");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void pair_reply(DBusMessage *message, void *user_data)
@@ -1559,10 +1583,12 @@ static void pair_reply(DBusMessage *message, void *user_data)
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to pair: %s\n", error.name);
 		dbus_error_free(&error);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Pairing successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_pair(int argc, char *argv[])
@@ -1571,12 +1597,12 @@ static void cmd_pair(int argc, char *argv[])
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	if (g_dbus_proxy_method_call(proxy, "Pair", NULL, pair_reply,
 							NULL, NULL) == FALSE) {
 		bt_shell_printf("Failed to pair\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Attempting to pair with %s\n", argv[1]);
@@ -1590,7 +1616,7 @@ static void cmd_trust(int argc, char *argv[])
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	trusted = TRUE;
 
@@ -1602,6 +1628,8 @@ static void cmd_trust(int argc, char *argv[])
 		return;
 
 	g_free(str);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void cmd_untrust(int argc, char *argv[])
@@ -1612,7 +1640,7 @@ static void cmd_untrust(int argc, char *argv[])
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	trusted = FALSE;
 
@@ -1624,6 +1652,8 @@ static void cmd_untrust(int argc, char *argv[])
 		return;
 
 	g_free(str);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void cmd_block(int argc, char *argv[])
@@ -1634,7 +1664,7 @@ static void cmd_block(int argc, char *argv[])
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	blocked = TRUE;
 
@@ -1646,6 +1676,8 @@ static void cmd_block(int argc, char *argv[])
 		return;
 
 	g_free(str);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void cmd_unblock(int argc, char *argv[])
@@ -1656,7 +1688,7 @@ static void cmd_unblock(int argc, char *argv[])
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	blocked = FALSE;
 
@@ -1668,6 +1700,8 @@ static void cmd_unblock(int argc, char *argv[])
 		return;
 
 	g_free(str);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void remove_device_reply(DBusMessage *message, void *user_data)
@@ -1679,10 +1713,11 @@ static void remove_device_reply(DBusMessage *message, void *user_data)
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to remove device: %s\n", error.name);
 		dbus_error_free(&error);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Device has been removed\n");
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void remove_device_setup(DBusMessageIter *iter, void *user_data)
@@ -1707,6 +1742,7 @@ static void remove_device(GDBusProxy *proxy)
 						path, g_free) == FALSE) {
 		bt_shell_printf("Failed to remove device\n");
 		g_free(path);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
@@ -1748,12 +1784,13 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to connect: %s\n", error.name);
 		dbus_error_free(&error);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Connection successful\n");
 
 	set_default_device(proxy, NULL);
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_connect(int argc, char *argv[])
@@ -1766,13 +1803,13 @@ static void cmd_connect(int argc, char *argv[])
 	proxy = find_proxy_by_address(default_ctrl->devices, argv[1]);
 	if (!proxy) {
 		bt_shell_printf("Device %s not available\n", argv[1]);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Connect", NULL, connect_reply,
 							proxy, NULL) == FALSE) {
 		bt_shell_printf("Failed to connect\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Attempting to connect to %s\n", argv[1]);
@@ -1788,7 +1825,7 @@ static void disconn_reply(DBusMessage *message, void *user_data)
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to disconnect: %s\n", error.name);
 		dbus_error_free(&error);
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Successful disconnected\n");
@@ -1797,6 +1834,8 @@ static void disconn_reply(DBusMessage *message, void *user_data)
 		return;
 
 	set_default_device(NULL, NULL);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_disconn(int argc, char *argv[])
@@ -1810,7 +1849,7 @@ static void cmd_disconn(int argc, char *argv[])
 	if (g_dbus_proxy_method_call(proxy, "Disconnect", NULL, disconn_reply,
 							proxy, NULL) == FALSE) {
 		bt_shell_printf("Failed to disconnect\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	if (argc < 2 || strlen(argv[1]) == 0) {
@@ -1831,9 +1870,11 @@ static void cmd_list_attributes(int argc, char *argv[])
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	gatt_list_attributes(g_dbus_proxy_get_path(proxy));
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_set_alias(int argc, char *argv[])
@@ -1853,6 +1894,8 @@ static void cmd_set_alias(int argc, char *argv[])
 		return;
 
 	g_free(name);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void cmd_select_attribute(int argc, char *argv[])
@@ -1865,8 +1908,12 @@ static void cmd_select_attribute(int argc, char *argv[])
 	}
 
 	proxy = gatt_select_attribute(default_attr, argv[1]);
-	if (proxy)
+	if (proxy) {
 		set_default_attribute(proxy);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static struct GDBusProxy *find_attribute(int argc, char *argv[])
@@ -1897,10 +1944,10 @@ static void cmd_attribute_info(int argc, char *argv[])
 
 	proxy = find_attribute(argc, argv);
 	if (!proxy)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	dbus_message_iter_get_basic(&iter, &uuid);
 
@@ -1932,13 +1979,15 @@ static void cmd_attribute_info(int argc, char *argv[])
 		print_property(proxy, "Characteristic");
 		print_property(proxy, "Value");
 	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_read(int argc, char *argv[])
 {
 	if (!default_attr) {
 		bt_shell_printf("No attribute selected\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	gatt_read_attribute(default_attr);
@@ -1948,7 +1997,7 @@ static void cmd_write(int argc, char *argv[])
 {
 	if (!default_attr) {
 		bt_shell_printf("No attribute selected\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	gatt_write_attribute(default_attr, argv[1]);
@@ -1958,7 +2007,7 @@ static void cmd_acquire_write(int argc, char *argv[])
 {
 	if (!default_attr) {
 		bt_shell_printf("No attribute selected\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	gatt_acquire_write(default_attr, argv[1]);
@@ -1968,7 +2017,7 @@ static void cmd_release_write(int argc, char *argv[])
 {
 	if (!default_attr) {
 		bt_shell_printf("No attribute selected\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	gatt_release_write(default_attr, argv[1]);
@@ -1978,7 +2027,7 @@ static void cmd_acquire_notify(int argc, char *argv[])
 {
 	if (!default_attr) {
 		bt_shell_printf("No attribute selected\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	gatt_acquire_notify(default_attr, argv[1]);
@@ -1988,7 +2037,7 @@ static void cmd_release_notify(int argc, char *argv[])
 {
 	if (!default_attr) {
 		bt_shell_printf("No attribute selected\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	gatt_release_notify(default_attr, argv[1]);
@@ -2003,7 +2052,7 @@ static void cmd_notify(int argc, char *argv[])
 
 	if (!default_attr) {
 		bt_shell_printf("No attribute selected\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	gatt_notify_attribute(default_attr, enable ? true : false);
@@ -2012,7 +2061,7 @@ static void cmd_notify(int argc, char *argv[])
 static void cmd_register_app(int argc, char *argv[])
 {
 	if (check_default_ctrl() == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	gatt_register_app(dbus_conn, default_ctrl->proxy, argc, argv);
 }
@@ -2020,7 +2069,7 @@ static void cmd_register_app(int argc, char *argv[])
 static void cmd_unregister_app(int argc, char *argv[])
 {
 	if (check_default_ctrl() == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	gatt_unregister_app(dbus_conn, default_ctrl->proxy);
 }
@@ -2028,7 +2077,7 @@ static void cmd_unregister_app(int argc, char *argv[])
 static void cmd_register_service(int argc, char *argv[])
 {
 	if (check_default_ctrl() == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	gatt_register_service(dbus_conn, default_ctrl->proxy, argc, argv);
 }
@@ -2036,7 +2085,7 @@ static void cmd_register_service(int argc, char *argv[])
 static void cmd_unregister_service(int argc, char *argv[])
 {
 	if (check_default_ctrl() == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	gatt_unregister_service(dbus_conn, default_ctrl->proxy, argc, argv);
 }
@@ -2044,7 +2093,7 @@ static void cmd_unregister_service(int argc, char *argv[])
 static void cmd_register_characteristic(int argc, char *argv[])
 {
 	if (check_default_ctrl() == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	gatt_register_chrc(dbus_conn, default_ctrl->proxy, argc, argv);
 }
@@ -2052,7 +2101,7 @@ static void cmd_register_characteristic(int argc, char *argv[])
 static void cmd_unregister_characteristic(int argc, char *argv[])
 {
 	if (check_default_ctrl() == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	gatt_unregister_chrc(dbus_conn, default_ctrl->proxy, argc, argv);
 }
@@ -2060,7 +2109,7 @@ static void cmd_unregister_characteristic(int argc, char *argv[])
 static void cmd_register_descriptor(int argc, char *argv[])
 {
 	if (check_default_ctrl() == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	gatt_register_desc(dbus_conn, default_ctrl->proxy, argc, argv);
 }
@@ -2068,7 +2117,7 @@ static void cmd_register_descriptor(int argc, char *argv[])
 static void cmd_unregister_descriptor(int argc, char *argv[])
 {
 	if (check_default_ctrl() == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	gatt_unregister_desc(dbus_conn, default_ctrl->proxy, argc, argv);
 }
@@ -2184,7 +2233,7 @@ static void cmd_advertise(int argc, char *argv[])
 
 	if (!default_ctrl || !default_ctrl->ad_proxy) {
 		bt_shell_printf("LEAdvertisingManager not found\n");
-		return;
+		bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	if (enable == TRUE)
@@ -2271,7 +2320,7 @@ static void cmd_advertise_appearance(int argc, char *argv[])
 	value = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
 		bt_shell_printf("Invalid argument\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	ad_advertise_local_appearance(dbus_conn, &value);
@@ -2290,7 +2339,7 @@ static void cmd_advertise_duration(int argc, char *argv[])
 	value = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
 		bt_shell_printf("Invalid argument\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	ad_advertise_duration(dbus_conn, &value);
@@ -2309,7 +2358,7 @@ static void cmd_advertise_timeout(int argc, char *argv[])
 	value = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
 		bt_shell_printf("Invalid argument\n");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	ad_advertise_timeout(dbus_conn, &value);
-- 
2.14.3

