Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Avichal Agarwal <avichal.a@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, anupam.r@samsung.com,
        Avichal Agarwal <avichal.a@samsung.com>
Subject: [PATCH v3 Bluez] client/gatt : Add support for Included Service
Date: Thu, 17 May 2018 22:31:16 +0530
Message-id: <1526576476-5447-1-git-send-email-avichal.a@samsung.com>
References: <CGME20180517170131epcas2p334febcfc1f04116a06bf4d0fdc1bc5ce@epcas2p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

included service support implemented at service registration
---
 client/gatt.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 client/gatt.h |   5 ++
 client/main.c |  21 ++++++++
 3 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index d59d1ba..16781a3 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -85,6 +85,7 @@ struct service {
 	char *uuid;
 	bool primary;
 	GList *chrcs;
+	GList *inc;
 };
 
 static GList *local_services;
@@ -127,6 +128,29 @@ static void print_service(struct service *service, const char *description)
 					service->path, service->uuid, text);
 }
 
+static void print_inc_service(struct service *service, const char *description)
+{
+	const char *text;
+
+	text = bt_uuidstr_to_str(service->uuid);
+	if (!text)
+		bt_shell_printf("%s%s%s%s Included Service\n\t%s\n\t%s\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					service->primary ? "Primary" :
+					"Secondary",
+					service->path, service->uuid);
+	else
+		bt_shell_printf("%s%s%s%s Included Service\n\t%s\n\t%s\n\t%s\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					service->primary ? "Primary" :
+					"Secondary",
+					service->path, service->uuid, text);
+}
+
 static void print_service_proxy(GDBusProxy *proxy, const char *description)
 {
 	struct service service;
@@ -1179,11 +1203,19 @@ static void chrc_unregister(void *data)
 						CHRC_INTERFACE);
 }
 
+static void inc_unregister(void *data)
+{
+	char *path = data;
+
+	g_free(path);
+}
+
 static void service_free(void *data)
 {
 	struct service *service = data;
 
 	g_list_free_full(service->chrcs, chrc_unregister);
+	g_list_free_full(service->inc, inc_unregister);
 	g_free(service->path);
 	g_free(service->uuid);
 	g_free(service);
@@ -1212,9 +1244,54 @@ static gboolean service_get_primary(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+
+static gboolean service_get_includes(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	DBusMessageIter array;
+	struct service *service = data;
+	char *inc  = NULL;
+	GList *l;
+
+	if (service->inc) {
+		for (l =  service->inc ; l; l = g_list_next(l)) {
+
+			inc = l->data;
+			dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_OBJECT_PATH_AS_STRING, &array);
+
+			dbus_message_iter_append_basic(&array,
+				DBUS_TYPE_OBJECT_PATH, &inc);
+
+		}
+
+		dbus_message_iter_close_container(iter, &array);
+
+		return TRUE;
+	}
+
+	return FALSE;
+
+}
+
+static gboolean service_exist_includes(const GDBusPropertyTable *property,
+							void *data)
+{
+	struct service *service = data;
+
+	if (service->inc)
+		return TRUE;
+	else
+		return FALSE;
+
+}
+
+
 static const GDBusPropertyTable service_properties[] = {
 	{ "UUID", "s", service_get_uuid },
 	{ "Primary", "b", service_get_primary },
+	{ "Includes", "ao", service_get_includes,
+		NULL,	service_exist_includes },
 	{ }
 };
 
@@ -1260,8 +1337,8 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 
 	local_services = g_list_append(local_services, service);
 
-	bt_shell_prompt_input(service->path, "Primary (yes/no):", service_set_primary,
-			service);
+	bt_shell_prompt_input(service->path, "Primary (yes/no):",
+		 service_set_primary, service);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -1306,6 +1383,78 @@ void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static char *inc_find(struct service  *serv, char *path)
+{
+	GList *lc;
+
+	for (lc = serv->inc; lc; lc =  g_list_next(lc)) {
+		char *incp = lc->data;
+		/* match object path */
+		if (!strcmp(incp, path))
+			return incp;
+	}
+
+	return NULL;
+}
+
+void gatt_register_include(DBusConnection *conn, GDBusProxy *proxy,
+					int argc, char *argv[])
+{
+	struct service *service, *inc_service;
+	char *inc_path;
+
+	if (!local_services) {
+		bt_shell_printf("No service registered\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	service = g_list_last(local_services)->data;
+
+
+	inc_service = service_find(argv[1]);
+	if (!inc_service) {
+		bt_shell_printf("Failed to find  service object\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	inc_path = g_strdup(service->path);
+
+	inc_service->inc = g_list_append(inc_service->inc, inc_path);
+
+	print_service(inc_service, COLORED_NEW);
+	print_inc_service(service, COLORED_NEW);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+void gatt_unregister_include(DBusConnection *conn, GDBusProxy *proxy,
+						int argc, char *argv[])
+{
+	struct service *ser_inc, *service;
+	char *path = NULL;
+
+	service = service_find(argv[1]);
+	if (!service) {
+		bt_shell_printf
+			("Failed to unregister include 	service object\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ser_inc = service_find(argv[2]);
+	if (!ser_inc) {
+		bt_shell_printf("Failed to find  include service object\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	path = inc_find(service, ser_inc->path);
+	if (path) {
+		service->inc = g_list_remove(service->inc, path);
+		inc_unregister(path);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static gboolean chrc_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
diff --git a/client/gatt.h b/client/gatt.h
index 957ae80..d4d7bed 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -65,3 +65,8 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 						int argc, char *argv[]);
 void gatt_unregister_desc(DBusConnection *conn, GDBusProxy *proxy,
 						int argc, char *argv[]);
+
+void gatt_register_include(DBusConnection *conn, GDBusProxy *proxy,
+					int argc, char *argv[]);
+void gatt_unregister_include(DBusConnection *conn, GDBusProxy *proxy,
+						int argc, char *argv[]);
diff --git a/client/main.c b/client/main.c
index 54bd537..a962b4e 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2002,6 +2002,22 @@ static void cmd_register_service(int argc, char *argv[])
 	gatt_register_service(dbus_conn, default_ctrl->proxy, argc, argv);
 }
 
+static void cmd_register_includes(int argc, char *argv[])
+{
+	if (check_default_ctrl() == FALSE)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	gatt_register_include(dbus_conn, default_ctrl->proxy, argc, argv);
+}
+
+static void cmd_unregister_includes(int argc, char *argv[])
+{
+	if (check_default_ctrl() == FALSE)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	gatt_unregister_include(dbus_conn, default_ctrl->proxy, argc, argv);
+}
+
 static void cmd_unregister_service(int argc, char *argv[])
 {
 	if (check_default_ctrl() == FALSE)
@@ -2451,6 +2467,11 @@ static const struct bt_shell_menu gatt_menu = {
 					"Register application service."  },
 	{ "unregister-service", "<UUID/object>", cmd_unregister_service,
 					"Unregister application service" },
+	{ "register-includes", "<UUID>", cmd_register_includes,
+					"Register as Included service in." },
+	{ "unregister-includes", "<Service-UUID><Inc-UUID>",
+			cmd_unregister_includes,
+				 "Unregister Included service." },
 	{ "register-characteristic", "<UUID> <Flags=read,write,notify...> "
 				"[authorize]", cmd_register_characteristic,
 				"Register application characteristic" },
-- 
2.7.4

