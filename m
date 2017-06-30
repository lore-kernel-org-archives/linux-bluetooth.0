Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/8] client: Add register-service command
Date: Fri, 30 Jun 2017 13:18:29 +0300
Message-Id: <20170630101834.23095-4-luiz.dentz@gmail.com>
In-Reply-To: <20170630101834.23095-1-luiz.dentz@gmail.com>
References: <20170630101834.23095-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds register-service command which can be used to add GATT services
to the application:

[bluetooth]# register-service 00001820-0000-1000-8000-00805f9b34fb
[NEW] Primary Service
	/org/bluez/app/service0x8c2610
	00001820-0000-1000-8000-00805f9b34fb
	Internet Protocol Support
[/org/bluez/app/service0x8c2610] Primary (yes/no): yes
[bluetooth]# register-application
[CHG] Controller 00:1B:DC:07:31:88 UUIDs: 00001112-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:1B:DC:07:31:88 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:1B:DC:07:31:88 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:1B:DC:07:31:88 UUIDs: 0000112d-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:1B:DC:07:31:88 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:1B:DC:07:31:88 UUIDs: 00001820-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:1B:DC:07:31:88 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:1B:DC:07:31:88 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:1B:DC:07:31:88 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:1B:DC:07:31:88 UUIDs: 0000110b-0000-1000-8000-00805f9b34fb

Note: register-application still has to be called at the end to register
with bluetoothd as everything is done with ObjectManager.
---
 client/gatt.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 client/gatt.h |   3 ++
 client/main.c |  25 ++++++++++
 3 files changed, 155 insertions(+), 22 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 8b7a9c6..82e7851 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -45,22 +45,55 @@
 
 #define APP_PATH "/org/bluez/app"
 #define PROFILE_INTERFACE "org.bluez.GattProfile1"
+#define SERVICE_INTERFACE "org.bluez.GattService1"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
 #define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
 
+struct service {
+	DBusConnection *conn;
+	char *path;
+	char *uuid;
+	bool primary;
+};
+
+static GList *local_services;
 static GList *services;
 static GList *characteristics;
 static GList *descriptors;
 static GList *managers;
 static GList *uuids;
 
-static void print_service(GDBusProxy *proxy, const char *description)
+static void print_service(struct service *service, const char *description)
+{
+	const char *text;
+
+	text = uuidstr_to_str(service->uuid);
+	if (!text)
+		rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					service->primary ? "Primary" :
+					"Secondary",
+					service->path, service->uuid);
+	else
+		rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n\t%s\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					service->primary ? "Primary" :
+					"Secondary",
+					service->path, service->uuid, text);
+}
+
+static void print_service_proxy(GDBusProxy *proxy, const char *description)
 {
+	struct service service;
 	DBusMessageIter iter;
-	const char *uuid, *text;
+	const char *uuid;
 	dbus_bool_t primary;
 
 	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
@@ -73,30 +106,18 @@ static void print_service(GDBusProxy *proxy, const char *description)
 
 	dbus_message_iter_get_basic(&iter, &primary);
 
-	text = uuidstr_to_str(uuid);
-	if (!text)
-		rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n",
-					description ? "[" : "",
-					description ? : "",
-					description ? "] " : "",
-					primary ? "Primary" : "Secondary",
-					g_dbus_proxy_get_path(proxy),
-					uuid);
-	else
-		rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n\t%s\n",
-					description ? "[" : "",
-					description ? : "",
-					description ? "] " : "",
-					primary ? "Primary" : "Secondary",
-					g_dbus_proxy_get_path(proxy),
-					uuid, text);
+	service.path = (char *) g_dbus_proxy_get_path(proxy);
+	service.uuid = (char *) uuid;
+	service.primary = primary;
+
+	print_service(&service, description);
 }
 
 void gatt_add_service(GDBusProxy *proxy)
 {
 	services = g_list_append(services, proxy);
 
-	print_service(proxy, COLORED_NEW);
+	print_service_proxy(proxy, COLORED_NEW);
 }
 
 void gatt_remove_service(GDBusProxy *proxy)
@@ -109,7 +130,7 @@ void gatt_remove_service(GDBusProxy *proxy)
 
 	services = g_list_delete_link(services, l);
 
-	print_service(proxy, COLORED_DEL);
+	print_service_proxy(proxy, COLORED_DEL);
 }
 
 static void print_characteristic(GDBusProxy *proxy, const char *description)
@@ -272,7 +293,7 @@ static void list_attributes(const char *path, GList *source)
 			continue;
 
 		if (source == services) {
-			print_service(proxy, NULL);
+			print_service_proxy(proxy, NULL);
 			list_attributes(proxy_path, characteristics);
 		} else if (source == characteristics) {
 			print_characteristic(proxy, NULL);
@@ -798,3 +819,87 @@ void gatt_unregister_app(DBusConnection *conn, GDBusProxy *proxy)
 		return;
 	}
 }
+
+static void service_free(void *data)
+{
+	struct service *service = data;
+
+	g_free(service->path);
+	g_free(service->uuid);
+	g_free(service);
+}
+
+static gboolean service_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service *service = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &service->uuid);
+
+	return TRUE;
+}
+
+static gboolean service_get_primary(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service *service = data;
+	dbus_bool_t primary;
+
+	primary = service->primary ? TRUE : FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &primary);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable service_properties[] = {
+	{ "UUID", "s", service_get_uuid },
+	{ "Primary", "b", service_get_primary },
+	{ }
+};
+
+static void service_set_primary(const char *input, void *user_data)
+{
+	struct service *service = user_data;
+
+	if (!strcmp(input, "yes"))
+		service->primary = true;
+	else if (!strcmp(input, "no")) {
+		service->primary = false;
+	} else {
+		rl_printf("Invalid option: %s\n", input);
+		local_services = g_list_remove(local_services, service);
+		print_service(service, COLORED_DEL);
+		g_dbus_unregister_interface(service->conn, service->path,
+						SERVICE_INTERFACE);
+	}
+}
+
+void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
+								wordexp_t *w)
+{
+	struct service *service;
+	bool primary = true;
+
+	service = g_new0(struct service, 1);
+	service->conn = conn;
+	service->uuid = g_strdup(w->we_wordv[0]);
+	service->path = g_strdup_printf("%s/service%p", APP_PATH, service);
+	service->primary = primary;
+
+	if (g_dbus_register_interface(conn, service->path,
+					SERVICE_INTERFACE, NULL, NULL,
+					service_properties, service,
+					service_free) == FALSE) {
+		rl_printf("Failed to register service object\n");
+		service_free(service);
+		return;
+	}
+
+	rl_printf("Service registered at %s\n", service->path);
+
+	local_services = g_list_append(local_services, service);
+
+	rl_prompt_input(service->path, "Primary (yes/no):", service_set_primary,
+			service);
+}
diff --git a/client/gatt.h b/client/gatt.h
index 4c9fd5b..7f116df 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -43,3 +43,6 @@ void gatt_remove_manager(GDBusProxy *proxy);
 
 void gatt_register_app(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w);
 void gatt_unregister_app(DBusConnection *conn, GDBusProxy *proxy);
+
+void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
+								wordexp_t *w);
diff --git a/client/main.c b/client/main.c
index c42bf50..726d749 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1839,6 +1839,29 @@ static void cmd_unregister_app(const char *arg)
 	gatt_unregister_app(dbus_conn, default_ctrl->proxy);
 }
 
+static void cmd_register_service(const char *arg)
+{
+	wordexp_t w;
+
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	if (wordexp(arg, &w, WRDE_NOCMD)) {
+		rl_printf("Invalid argument\n");
+		return;
+	}
+
+	if (w.we_wordc == 0) {
+		rl_printf("Missing argument\n");
+		goto done;
+	}
+
+	gatt_register_service(dbus_conn, default_ctrl->proxy, &w);
+
+done:
+	wordfree(&w);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -2141,6 +2164,8 @@ static const struct {
 						"Register profile to connect" },
 	{ "unregister-application", NULL, cmd_unregister_app,
 						"Unregister profile" },
+	{ "register-service", "<UUID>", cmd_register_service,
+					"Register application service."  },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit, "Quit program" },
-- 
2.9.4

