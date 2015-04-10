Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/9] unit/test-gdbus-client: Use tester framework
Date: Fri, 10 Apr 2015 17:05:57 +0300
Message-Id: <1428674761-24609-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
References: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am              |   2 +-
 unit/test-gdbus-client.c | 261 +++++++++++++----------------------------------
 2 files changed, 70 insertions(+), 193 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b0292e7..0acc042 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -354,7 +354,7 @@ unit_tests += unit/test-gdbus-client
 
 unit_test_gdbus_client_SOURCES = unit/test-gdbus-client.c
 unit_test_gdbus_client_LDADD = gdbus/libgdbus-internal.la \
-				@GLIB_LIBS@ @DBUS_LIBS@
+				src/libshared-glib.la @GLIB_LIBS@ @DBUS_LIBS@
 
 unit_tests += unit/test-gobex-header unit/test-gobex-packet unit/test-gobex \
 			unit/test-gobex-transfer unit/test-gobex-apparam
diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index ad426fe..5d8bbf2 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -29,12 +29,13 @@
 
 #include "gdbus/gdbus.h"
 
+#include "src/shared/tester.h"
+
 #define SERVICE_NAME "org.bluez.unit.test-gdbus-client"
 #define SERVICE_NAME1 "org.bluez.unit.test-gdbus-client1"
 #define SERVICE_PATH "/org/bluez/unit/test_gdbus_client"
 
 struct context {
-	GMainLoop *main_loop;
 	DBusConnection *dbus_conn;
 	GDBusClient *dbus_client;
 	GDBusProxy *proxy;
@@ -60,25 +61,16 @@ static struct context *create_context(void)
 	struct context *context = g_new0(struct context, 1);
 	DBusError err;
 
-	context->main_loop = g_main_loop_new(NULL, FALSE);
-	if (context->main_loop == NULL) {
-		g_free(context);
-		return NULL;
-	}
-
 	dbus_error_init(&err);
 
 	context->dbus_conn = g_dbus_setup_private(DBUS_BUS_SESSION,
 							SERVICE_NAME, &err);
 	if (context->dbus_conn == NULL) {
 		if (dbus_error_is_set(&err)) {
-			if (g_test_verbose())
-				g_printerr("D-Bus setup failed: %s\n",
-								err.message);
+			tester_debug("D-Bus setup failed: %s", err.message);
 			dbus_error_free(&err);
 		}
 
-		g_main_loop_unref(context->main_loop);
 		g_free(context);
 		return NULL;
 	}
@@ -97,17 +89,20 @@ static void destroy_context(struct context *context)
 	if (context == NULL)
 		return;
 
+	tester_test_passed();
+
 	if (context->timeout_source > 0)
 		g_source_remove(context->timeout_source);
 
 	g_dbus_detach_object_manager(context->dbus_conn);
 
+	g_dbus_unregister_interface(context->dbus_conn,
+					SERVICE_PATH, SERVICE_NAME);
+
 	dbus_connection_flush(context->dbus_conn);
 	dbus_connection_close(context->dbus_conn);
 	dbus_connection_unref(context->dbus_conn);
 
-	g_main_loop_unref(context->main_loop);
-
 	g_free(context->data);
 	g_free(context);
 }
@@ -116,8 +111,7 @@ static gboolean timeout_handler(gpointer user_data)
 {
 	struct context *context = user_data;
 
-	if (g_test_verbose())
-		g_print("timeout triggered\n");
+	tester_debug("timeout triggered");
 
 	context->timeout_source = 0;
 
@@ -130,8 +124,7 @@ static void connect_handler(DBusConnection *connection, void *user_data)
 {
 	struct context *context = user_data;
 
-	if (g_test_verbose())
-		g_print("service connected\n");
+	tester_debug("service connected");
 
 	g_dbus_client_unref(context->dbus_client);
 }
@@ -140,13 +133,12 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 {
 	struct context *context = user_data;
 
-	if (g_test_verbose())
-		g_print("service disconnected\n");
+	tester_debug("service disconnected");
 
-	g_main_loop_quit(context->main_loop);
+	destroy_context(context);
 }
 
-static void simple_client(void)
+static void simple_client(const void *data)
 {
 	struct context *context = create_context();
 
@@ -160,13 +152,9 @@ static void simple_client(void)
 						connect_handler, context);
 	g_dbus_client_set_disconnect_watch(context->dbus_client,
 						disconnect_handler, context);
-
-	g_main_loop_run(context->main_loop);
-
-	destroy_context(context);
 }
 
-static void client_connect_disconnect(void)
+static void client_connect_disconnect(const void *data)
 {
 	struct context *context = create_context();
 
@@ -187,13 +175,6 @@ static void client_connect_disconnect(void)
 
 	context->timeout_source = g_timeout_add_seconds(10, timeout_handler,
 								context);
-
-	g_main_loop_run(context->main_loop);
-
-	g_dbus_unregister_interface(context->dbus_conn,
-					SERVICE_PATH, SERVICE_NAME);
-
-	destroy_context(context);
 }
 
 static void append_variant(DBusMessageIter *iter, int type, void *val)
@@ -256,9 +237,7 @@ static void proxy_get_dict(GDBusProxy *proxy, void *user_data)
 	const char *string;
 	dbus_bool_t boolean;
 
-	if (g_test_verbose())
-		g_print("proxy %s found\n",
-					g_dbus_proxy_get_interface(proxy));
+	tester_debug("proxy %s found", g_dbus_proxy_get_interface(proxy));
 
 	g_assert(g_dbus_proxy_get_property(proxy, "Dict", &iter));
 	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_ARRAY);
@@ -307,7 +286,7 @@ static void proxy_get_dict(GDBusProxy *proxy, void *user_data)
 	g_dbus_client_unref(context->dbus_client);
 }
 
-static void client_get_dict_property(void)
+static void client_get_dict_property(const void *data)
 {
 	struct context *context = create_context();
 	static const GDBusPropertyTable dict_properties[] = {
@@ -330,13 +309,6 @@ static void client_get_dict_property(void)
 						disconnect_handler, context);
 	g_dbus_client_set_proxy_handlers(context->dbus_client, proxy_get_dict,
 						NULL, NULL, context);
-
-	g_main_loop_run(context->main_loop);
-
-	g_dbus_unregister_interface(context->dbus_conn,
-					SERVICE_PATH, SERVICE_NAME);
-
-	destroy_context(context);
 }
 
 static void proxy_get_string(GDBusProxy *proxy, void *user_data)
@@ -345,9 +317,7 @@ static void proxy_get_string(GDBusProxy *proxy, void *user_data)
 	DBusMessageIter iter;
 	const char *string;
 
-	if (g_test_verbose())
-		g_print("proxy %s found\n",
-					g_dbus_proxy_get_interface(proxy));
+	tester_debug("proxy %s found", g_dbus_proxy_get_interface(proxy));
 
 	g_assert(g_dbus_proxy_get_property(proxy, "String", &iter));
 	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_STRING);
@@ -368,7 +338,7 @@ static gboolean get_string(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static void client_get_string_property(void)
+static void client_get_string_property(const void *data)
 {
 	struct context *context = create_context();
 	static const GDBusPropertyTable string_properties[] = {
@@ -392,13 +362,6 @@ static void client_get_string_property(void)
 						disconnect_handler, context);
 	g_dbus_client_set_proxy_handlers(context->dbus_client, proxy_get_string,
 						NULL, NULL, context);
-
-	g_main_loop_run(context->main_loop);
-
-	g_dbus_unregister_interface(context->dbus_conn,
-					SERVICE_PATH, SERVICE_NAME);
-
-	destroy_context(context);
 }
 
 static void proxy_get_boolean(GDBusProxy *proxy, void *user_data)
@@ -407,9 +370,7 @@ static void proxy_get_boolean(GDBusProxy *proxy, void *user_data)
 	DBusMessageIter iter;
 	dbus_bool_t value;
 
-	if (g_test_verbose())
-		g_print("proxy %s found\n",
-					g_dbus_proxy_get_interface(proxy));
+	tester_debug("proxy %s found", g_dbus_proxy_get_interface(proxy));
 
 	g_assert(g_dbus_proxy_get_property(proxy, "Boolean", &iter));
 	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_BOOLEAN);
@@ -430,7 +391,7 @@ static gboolean get_boolean(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static void client_get_boolean_property(void)
+static void client_get_boolean_property(const void *data)
 {
 	struct context *context = create_context();
 	static const GDBusPropertyTable boolean_properties[] = {
@@ -454,13 +415,6 @@ static void client_get_boolean_property(void)
 						NULL, NULL, context);
 	g_dbus_client_set_disconnect_watch(context->dbus_client,
 						disconnect_handler, context);
-
-	g_main_loop_run(context->main_loop);
-
-	g_dbus_unregister_interface(context->dbus_conn,
-					SERVICE_PATH, SERVICE_NAME);
-
-	destroy_context(context);
 }
 
 static void proxy_get_array(GDBusProxy *proxy, void *user_data)
@@ -469,9 +423,7 @@ static void proxy_get_array(GDBusProxy *proxy, void *user_data)
 	DBusMessageIter iter, entry;
 	const char *value1, *value2;
 
-	if (g_test_verbose())
-		g_print("proxy %s found\n",
-					g_dbus_proxy_get_interface(proxy));
+	tester_debug("proxy %s found", g_dbus_proxy_get_interface(proxy));
 
 	g_assert(g_dbus_proxy_get_property(proxy, "Array", &iter));
 	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_ARRAY);
@@ -507,7 +459,7 @@ static gboolean get_array(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static void client_get_array_property(void)
+static void client_get_array_property(const void *data)
 {
 	struct context *context = create_context();
 	static const GDBusPropertyTable array_properties[] = {
@@ -530,13 +482,6 @@ static void client_get_array_property(void)
 						NULL, NULL, context);
 	g_dbus_client_set_disconnect_watch(context->dbus_client,
 						disconnect_handler, context);
-
-	g_main_loop_run(context->main_loop);
-
-	g_dbus_unregister_interface(context->dbus_conn,
-					SERVICE_PATH, SERVICE_NAME);
-
-	destroy_context(context);
 }
 
 static void proxy_get_uint64(GDBusProxy *proxy, void *user_data)
@@ -545,9 +490,7 @@ static void proxy_get_uint64(GDBusProxy *proxy, void *user_data)
 	DBusMessageIter iter;
 	guint64 value;
 
-	if (g_test_verbose())
-		g_print("proxy %s found\n",
-					g_dbus_proxy_get_interface(proxy));
+	tester_debug("proxy %s found", g_dbus_proxy_get_interface(proxy));
 
 	g_assert(g_dbus_proxy_get_property(proxy, "Number", &iter));
 	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_UINT64);
@@ -568,7 +511,7 @@ static gboolean get_uint64(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static void client_get_uint64_property(void)
+static void client_get_uint64_property(const void *data)
 {
 	struct context *context = create_context();
 	static const GDBusPropertyTable uint64_properties[] = {
@@ -592,13 +535,6 @@ static void client_get_uint64_property(void)
 						NULL, NULL, context);
 	g_dbus_client_set_disconnect_watch(context->dbus_client,
 						disconnect_handler, context);
-
-	g_main_loop_run(context->main_loop);
-
-	g_dbus_unregister_interface(context->dbus_conn,
-					SERVICE_PATH, SERVICE_NAME);
-
-	destroy_context(context);
 }
 
 static void property_set_success(const DBusError *err, void *user_data)
@@ -611,9 +547,7 @@ static void proxy_set_string(GDBusProxy *proxy, void *user_data)
 	DBusMessageIter iter;
 	const char *string;
 
-	if (g_test_verbose())
-		g_print("proxy %s found\n",
-					g_dbus_proxy_get_interface(proxy));
+	tester_debug("proxy %s found", g_dbus_proxy_get_interface(proxy));
 
 	g_assert(g_dbus_proxy_get_property(proxy, "String", &iter));
 	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_STRING);
@@ -634,8 +568,7 @@ static void property_string_changed(GDBusProxy *proxy, const char *name,
 	struct context *context = user_data;
 	const char *string;
 
-	if (g_test_verbose())
-		g_print("property %s changed\n", name);
+	tester_debug("property %s changed", name);
 
 	g_assert(g_strcmp0(name, "String") == 0);
 	g_assert(dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_STRING);
@@ -667,7 +600,7 @@ static void set_string(const GDBusPropertyTable *property,
 	g_dbus_pending_property_success(id);
 }
 
-static void client_set_string_property(void)
+static void client_set_string_property(const void *data)
 {
 	struct context *context = create_context();
 	static const GDBusPropertyTable string_properties[] = {
@@ -692,13 +625,6 @@ static void client_set_string_property(void)
 	g_dbus_client_set_proxy_handlers(context->dbus_client, proxy_set_string,
 						NULL, property_string_changed,
 						context);
-
-	g_main_loop_run(context->main_loop);
-
-	g_dbus_unregister_interface(context->dbus_conn,
-					SERVICE_PATH, SERVICE_NAME);
-
-	destroy_context(context);
 }
 
 static gboolean string_exists(const GDBusPropertyTable *property, void *data)
@@ -712,8 +638,7 @@ static gboolean timeout_test(gpointer user_data)
 {
 	struct context *context = user_data;
 
-	if (g_test_verbose())
-		g_print("timeout triggered\n");
+	tester_debug("timeout triggered");
 
 	context->timeout_source = 0;
 
@@ -742,16 +667,14 @@ static void proxy_string_changed(GDBusProxy *proxy, void *user_data)
 	struct context *context = user_data;
 	DBusMessageIter iter;
 
-	if (g_test_verbose())
-		g_print("proxy %s found\n",
-					g_dbus_proxy_get_interface(proxy));
+	tester_debug("proxy %s found", g_dbus_proxy_get_interface(proxy));
 
 	g_assert(!g_dbus_proxy_get_property(proxy, "String", &iter));
 
 	g_idle_add(emit_string_change, context);
 }
 
-static void client_string_changed(void)
+static void client_string_changed(const void *data)
 {
 	struct context *context = create_context();
 	static const GDBusPropertyTable string_properties[] = {
@@ -776,13 +699,6 @@ static void client_string_changed(void)
 						proxy_string_changed, NULL,
 						property_string_changed,
 						context);
-
-	g_main_loop_run(context->main_loop);
-
-	g_dbus_unregister_interface(context->dbus_conn,
-					SERVICE_PATH, SERVICE_NAME);
-
-	destroy_context(context);
 }
 
 static void property_check_order(const DBusError *err, void *user_data)
@@ -807,9 +723,7 @@ static void proxy_check_order(GDBusProxy *proxy, void *user_data)
 	struct context *context = user_data;
 	const char *string;
 
-	if (g_test_verbose())
-		g_print("proxy %s found\n",
-					g_dbus_proxy_get_interface(proxy));
+	tester_debug("proxy %s found", g_dbus_proxy_get_interface(proxy));
 
 	context->proxy = proxy;
 	string = "value1";
@@ -819,7 +733,7 @@ static void proxy_check_order(GDBusProxy *proxy, void *user_data)
 					NULL));
 }
 
-static void client_check_order(void)
+static void client_check_order(const void *data)
 {
 	struct context *context = create_context();
 	static const GDBusPropertyTable string_properties[] = {
@@ -844,32 +758,22 @@ static void client_check_order(void)
 	g_dbus_client_set_proxy_handlers(context->dbus_client,
 						proxy_check_order, NULL, NULL,
 						context);
-
-	g_main_loop_run(context->main_loop);
-
-	g_dbus_unregister_interface(context->dbus_conn,
-					SERVICE_PATH, SERVICE_NAME);
-
-	destroy_context(context);
 }
 
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	struct context *context = user_data;
 
-	if (g_test_verbose())
-		g_print("proxy removed\n");
+	tester_debug("proxy removed");
 
-	g_main_loop_quit(context->main_loop);
+	destroy_context(context);
 }
 
 static void proxy_set_removed(GDBusProxy *proxy, void *user_data)
 {
 	struct context *context = user_data;
 
-	if (g_test_verbose())
-		g_print("proxy %s found\n",
-					g_dbus_proxy_get_interface(proxy));
+	tester_debug("proxy %s found", g_dbus_proxy_get_interface(proxy));
 
 	g_assert(g_dbus_proxy_set_removed_watch(proxy, proxy_removed, context));
 
@@ -880,7 +784,7 @@ static void proxy_set_removed(GDBusProxy *proxy, void *user_data)
 								SERVICE_NAME);
 }
 
-static void client_proxy_removed(void)
+static void client_proxy_removed(const void *data)
 {
 	struct context *context = create_context();
 	static const GDBusPropertyTable string_properties[] = {
@@ -902,13 +806,9 @@ static void client_proxy_removed(void)
 	g_dbus_client_set_proxy_handlers(context->dbus_client,
 						proxy_set_removed, NULL, NULL,
 						context);
-
-	g_main_loop_run(context->main_loop);
-
-	destroy_context(context);
 }
 
-static void client_no_object_manager(void)
+static void client_no_object_manager(const void *data)
 {
 	struct context *context = create_context();
 	DBusConnection *conn;
@@ -945,17 +845,6 @@ static void client_no_object_manager(void)
 						NULL, NULL, context);
 
 	g_assert(!g_dbus_proxy_get_property(context->proxy, "String", &iter));
-
-	g_main_loop_run(context->main_loop);
-
-	g_dbus_proxy_unref(context->proxy);
-	g_dbus_unregister_interface(conn, SERVICE_PATH, SERVICE_NAME1);
-
-	dbus_connection_flush(conn);
-	dbus_connection_close(conn);
-	dbus_connection_unref(conn);
-
-	destroy_context(context);
 }
 
 static void proxy_force_disconnect(GDBusProxy *proxy, void *user_data)
@@ -963,9 +852,7 @@ static void proxy_force_disconnect(GDBusProxy *proxy, void *user_data)
 	struct context *context = user_data;
 	DBusConnection *conn = context->data;
 
-	if (g_test_verbose())
-		g_print("proxy %s found\n",
-					g_dbus_proxy_get_interface(proxy));
+	tester_debug("proxy %s found", g_dbus_proxy_get_interface(proxy));
 
 	g_assert(g_dbus_proxy_set_removed_watch(proxy, proxy_removed, context));
 
@@ -977,7 +864,7 @@ static void proxy_force_disconnect(GDBusProxy *proxy, void *user_data)
 	context->data = NULL;
 }
 
-static void client_force_disconnect(void)
+static void client_force_disconnect(const void *data)
 {
 	struct context *context = create_context();
 	DBusConnection *conn;
@@ -1007,14 +894,6 @@ static void client_force_disconnect(void)
 	g_dbus_client_set_proxy_handlers(context->dbus_client,
 					proxy_force_disconnect, NULL, NULL,
 					context);
-
-	g_main_loop_run(context->main_loop);
-
-	g_dbus_unregister_interface(conn, SERVICE_PATH, SERVICE_NAME1);
-	g_dbus_detach_object_manager(conn);
-	dbus_connection_unref(conn);
-
-	destroy_context(context);
 }
 
 static void client_ready_watch(GDBusClient *client, void *user_data)
@@ -1035,10 +914,10 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	 */
 	g_assert(context->client_ready == FALSE);
 
-	g_main_loop_quit(context->main_loop);
+	destroy_context(context);
 }
 
-static void client_ready(void)
+static void client_ready(const void *data)
 {
 	struct context *context = create_context();
 	static const GDBusPropertyTable string_properties[] = {
@@ -1061,53 +940,51 @@ static void client_ready(void)
 								context);
 	g_dbus_client_set_proxy_handlers(context->dbus_client,
 						proxy_added, NULL, NULL, context);
-
-	g_main_loop_run(context->main_loop);
-
-	destroy_context(context);
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
+	tester_init(&argc, &argv);
 
-	g_test_add_func("/gdbus/simple_client", simple_client);
+	tester_add("/gdbus/simple_client", NULL, NULL, simple_client, NULL);
 
-	g_test_add_func("/gdbus/client_connect_disconnect",
-						client_connect_disconnect);
+	tester_add("/gdbus/client_connect_disconnect", NULL, NULL,
+					client_connect_disconnect, NULL);
 
-	g_test_add_func("/gdbus/client_get_string_property",
-						client_get_string_property);
+	tester_add("/gdbus/client_get_string_property", NULL, NULL,
+					client_get_string_property, NULL);
 
-	g_test_add_func("/gdbus/client_get_boolean_property",
-						client_get_boolean_property);
+	tester_add("/gdbus/client_get_boolean_property", NULL, NULL,
+					client_get_boolean_property, NULL);
 
-	g_test_add_func("/gdbus/client_get_uint64_property",
-						client_get_uint64_property);
+	tester_add("/gdbus/client_get_uint64_property", NULL, NULL,
+					client_get_uint64_property, NULL);
 
-	g_test_add_func("/gdbus/client_get_array_property",
-						client_get_array_property);
+	tester_add("/gdbus/client_get_array_property", NULL, NULL,
+					client_get_array_property, NULL);
 
-	g_test_add_func("/gdbus/client_get_dict_property",
-						client_get_dict_property);
+	tester_add("/gdbus/client_get_dict_property", NULL, NULL,
+					client_get_dict_property, NULL);
 
-	g_test_add_func("/gdbus/client_set_string_property",
-						client_set_string_property);
+	tester_add("/gdbus/client_set_string_property", NULL, NULL,
+					client_set_string_property, NULL);
 
-	g_test_add_func("/gdbus/client_string_changed",
-						client_string_changed);
+	tester_add("/gdbus/client_string_changed", NULL, NULL,
+					client_string_changed, NULL);
 
-	g_test_add_func("/gdbus/client_check_order", client_check_order);
+	tester_add("/gdbus/client_check_order", NULL, NULL, client_check_order,
+					NULL);
 
-	g_test_add_func("/gdbus/client_proxy_removed", client_proxy_removed);
+	tester_add("/gdbus/client_proxy_removed", NULL, NULL,
+					client_proxy_removed, NULL);
 
-	g_test_add_func("/gdbus/client_no_object_manager",
-						client_no_object_manager);
+	tester_add("/gdbus/client_no_object_manager", NULL, NULL,
+					client_no_object_manager, NULL);
 
-	g_test_add_func("/gdbus/client_force_disconnect",
-						client_force_disconnect);
+	tester_add("/gdbus/client_force_disconnect", NULL, NULL,
+					client_force_disconnect, NULL);
 
-	g_test_add_func("/gdbus/client_ready", client_ready);
+	tester_add("/gdbus/client_ready", NULL, NULL, client_ready, NULL);
 
-	return g_test_run();
+	return tester_run();
 }
-- 
2.1.0

