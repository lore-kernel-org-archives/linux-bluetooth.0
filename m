Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/10] gatt: Update signature of AcquireWrite and AcquireNotify
Date: Mon, 18 Sep 2017 15:40:01 +0300
Message-Id: <20170918124001.2617-11-luiz.dentz@gmail.com>
In-Reply-To: <20170918124001.2617-1-luiz.dentz@gmail.com>
References: <20170918124001.2617-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It should now contain an argument for the options even though there
are not options defined for clients.
---
 client/gatt.c     | 18 ++++++++++++++++--
 mesh/gatt.c       | 23 ++++++++++++++++++++---
 src/gatt-client.c |  6 ++++--
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 1ca1159ad..93aec92e7 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -778,6 +778,20 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 	write_io.io = pipe_io_new(fd, NULL);
 }
 
+static void acquire_setup(DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
 void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
 {
 	const char *iface;
@@ -789,7 +803,7 @@ void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
 		return;
 	}
 
-	if (g_dbus_proxy_method_call(proxy, "AcquireWrite", NULL,
+	if (g_dbus_proxy_method_call(proxy, "AcquireWrite", acquire_setup,
 				acquire_write_reply, NULL, NULL) == FALSE) {
 		rl_printf("Failed to AcquireWrite\n");
 		return;
@@ -852,7 +866,7 @@ void gatt_acquire_notify(GDBusProxy *proxy, const char *arg)
 		return;
 	}
 
-	if (g_dbus_proxy_method_call(proxy, "AcquireNotify", NULL,
+	if (g_dbus_proxy_method_call(proxy, "AcquireNotify", acquire_setup,
 				acquire_notify_reply, NULL, NULL) == FALSE) {
 		rl_printf("Failed to AcquireNotify\n");
 		return;
diff --git a/mesh/gatt.c b/mesh/gatt.c
index f9615b3e2..001eb17a8 100644
--- a/mesh/gatt.c
+++ b/mesh/gatt.c
@@ -386,6 +386,20 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 	pipe_write(write_io, data);
 }
 
+static void acquire_setup(DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
 bool mesh_gatt_write(GDBusProxy *proxy, uint8_t *buf, uint16_t len,
 			GDBusReturnFunction cb, void *user_data)
 {
@@ -424,8 +438,9 @@ bool mesh_gatt_write(GDBusProxy *proxy, uint8_t *buf, uint16_t len,
 		return pipe_write(write_io, data);
 
 	if (g_dbus_proxy_get_property(proxy, "WriteAcquired", &iter)) {
-		if (g_dbus_proxy_method_call(proxy, "AcquireWrite", NULL,
-				acquire_write_reply, data, NULL) == FALSE) {
+		if (g_dbus_proxy_method_call(proxy, "AcquireWrite",
+					acquire_setup, acquire_write_reply,
+					data, NULL) == FALSE) {
 			rl_printf("Failed to AcquireWrite\n");
 			write_data_free(data);
 			return false;
@@ -573,6 +588,7 @@ bool mesh_gatt_notify(GDBusProxy *proxy, bool enable, GDBusReturnFunction cb,
 	struct notify_data *data;
 	DBusMessageIter iter;
 	const char *method;
+	GDBusSetupFunction setup = NULL;
 
 	data = g_new0(struct notify_data, 1);
 	data->proxy = proxy;
@@ -584,6 +600,7 @@ bool mesh_gatt_notify(GDBusProxy *proxy, bool enable, GDBusReturnFunction cb,
 		if (g_dbus_proxy_get_property(proxy, "NotifyAcquired", &iter)) {
 			method = "AcquireNotify";
 			cb = acquire_notify_reply;
+			setup = acquire_setup;
 		} else {
 			method = "StartNotify";
 			cb = notify_reply;
@@ -600,7 +617,7 @@ bool mesh_gatt_notify(GDBusProxy *proxy, bool enable, GDBusReturnFunction cb,
 		}
 	}
 
-	if (g_dbus_proxy_method_call(proxy, method, NULL, cb,
+	if (g_dbus_proxy_method_call(proxy, method, setup, cb,
 					data, NULL) == FALSE) {
 		rl_printf("Failed to %s\n", method);
 		return false;
diff --git a/src/gatt-client.c b/src/gatt-client.c
index d523b883a..32b3a8783 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1624,11 +1624,13 @@ static const GDBusMethodTable characteristic_methods[] = {
 						{ "options", "a{sv}" }),
 					NULL,
 					characteristic_write_value) },
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("AcquireWrite", NULL,
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("AcquireWrite",
+					GDBUS_ARGS({ "options", "a{sv}" }),
 					GDBUS_ARGS({ "fd", "h" },
 						{ "mtu", "q" }),
 					characteristic_acquire_write) },
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("AcquireNotify", NULL,
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("AcquireNotify",
+					GDBUS_ARGS({ "options", "a{sv}" }),
 					GDBUS_ARGS({ "fd", "h" },
 						{ "mtu", "q" }),
 					characteristic_acquire_notify) },
-- 
2.13.5

