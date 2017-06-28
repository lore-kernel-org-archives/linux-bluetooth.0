Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/9] client: Add unregister-service command
Date: Wed, 28 Jun 2017 15:54:17 +0300
Message-Id: <20170628125423.26208-4-luiz.dentz@gmail.com>
In-Reply-To: <20170628125423.26208-1-luiz.dentz@gmail.com>
References: <20170628125423.26208-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds unregister-service which can be used to unregister an
application service registered with register-service:

register-service 00001820-0000-1000-8000-00805f9b34fb
[NEW] Primary Service
	/org/bluez/app/service0x92a150
	00001820-0000-1000-8000-00805f9b34fb
	Internet Protocol Support
[bluetooth]# unregister-service /org/bluez/app/service0x92a150
[DEL] Primary Service
	/org/bluez/app/service0x92a150
	00001820-0000-1000-8000-00805f9b34fb
	Internet Protocol Support
---
 client/gatt.c | 40 +++++++++++++++++++++++++++++++++++++++-
 client/gatt.h |  2 ++
 client/main.c | 24 ++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/client/gatt.c b/client/gatt.c
index 282f07e..92ace0e 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -890,7 +890,45 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 		return;
 	}
 
-	rl_printf("Service registered at %s\n", service->path);
+	print_service(service, COLORED_NEW);
 
 	local_services = g_list_append(local_services, service);
 }
+
+static struct service *service_find(const char *pattern)
+{
+	GList *l;
+
+	for (l = local_services; l; l = g_list_next(l)) {
+		struct service *service = l->data;
+
+		/* match object path */
+		if (!strcmp(service->path, pattern))
+			return service;
+
+		/* match UUID */
+		if (!strcmp(service->uuid, pattern))
+			return service;
+	}
+
+	return NULL;
+}
+
+void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
+								wordexp_t *w)
+{
+	struct service *service;
+
+	service = service_find(w->we_wordv[0]);
+	if (!service) {
+		rl_printf("Failed to unregister service object\n");
+		return;
+	}
+
+	local_services = g_list_remove(local_services, service);
+
+	print_service(service, COLORED_DEL);
+
+	g_dbus_unregister_interface(service->conn, service->path,
+						SERVICE_INTERFACE);
+}
diff --git a/client/gatt.h b/client/gatt.h
index 7f116df..4b9edd5 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -46,3 +46,5 @@ void gatt_unregister_app(DBusConnection *conn, GDBusProxy *proxy);
 
 void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 								wordexp_t *w);
+void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
+								wordexp_t *w);
diff --git a/client/main.c b/client/main.c
index 2bcf02c..16bc125 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1861,6 +1861,28 @@ static void cmd_register_service(const char *arg)
 	wordfree(&w);
 }
 
+static void cmd_unregister_service(const char *arg)
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
+		return;
+	}
+
+	gatt_unregister_service(dbus_conn, default_ctrl->proxy, &w);
+
+	wordfree(&w);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -2165,6 +2187,8 @@ static const struct {
 						"Unregister profile" },
 	{ "register-service", "<UUID> <primary=yes/no>", cmd_register_service,
 					"Register application service" },
+	{ "unregister-service", "<UUID/object>", cmd_unregister_service,
+					"Unregister application service" },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit, "Quit program" },
-- 
2.9.4

