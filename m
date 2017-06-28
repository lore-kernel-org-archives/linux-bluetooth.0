Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/9] client: Add unregister-characteristic command
Date: Wed, 28 Jun 2017 15:54:19 +0300
Message-Id: <20170628125423.26208-6-luiz.dentz@gmail.com>
In-Reply-To: <20170628125423.26208-1-luiz.dentz@gmail.com>
References: <20170628125423.26208-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds unregister-characteristic which can be used to unregister
characteristics registered with register-characteristic:

unregister-characteristic /org/bluez/app/service0xc80150/chrc0xc99960
[DEL] Characteristic
	/org/bluez/app/service0xc80150/chrc0xc99960
	00002a06-0000-1000-8000-00805f9b34fb
	Alert Level
---
 client/gatt.c | 41 +++++++++++++++++++++++++++++++++++++++++
 client/gatt.h |  2 ++
 client/main.c | 25 +++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 2e56e0c..342b60f 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1187,3 +1187,44 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 
 	print_chrc(chrc, COLORED_NEW);
 }
+
+static struct chrc *chrc_find(const char *pattern)
+{
+	GList *l, *lc;
+	struct service *service;
+	struct chrc *chrc;
+
+	for (l = local_services; l; l = g_list_next(l)) {
+		service = l->data;
+
+		for (lc = service->chrcs; lc; lc =  g_list_next(lc)) {
+			chrc = lc->data;
+
+			/* match object path */
+			if (!strcmp(chrc->path, pattern))
+				return chrc;
+
+			/* match UUID */
+			if (!strcmp(chrc->uuid, pattern))
+				return chrc;
+		}
+	}
+
+	return NULL;
+}
+
+void gatt_unregister_chrc(DBusConnection *conn, GDBusProxy *proxy,
+								wordexp_t *w)
+{
+	struct chrc *chrc;
+
+	chrc = chrc_find(w->we_wordv[0]);
+	if (!chrc) {
+		rl_printf("Failed to unregister characteristic object\n");
+		return;
+	}
+
+	chrc->service->chrcs = g_list_remove(chrc->service->chrcs, chrc);
+
+	chrc_unregister(chrc);
+}
diff --git a/client/gatt.h b/client/gatt.h
index 4ecf642..0acce4d 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -50,3 +50,5 @@ void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
 								wordexp_t *w);
 
 void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w);
+void gatt_unregister_chrc(DBusConnection *conn, GDBusProxy *proxy,
+								wordexp_t *w);
diff --git a/client/main.c b/client/main.c
index 76a731f..7eeeefa 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1905,6 +1905,28 @@ static void cmd_register_characteristic(const char *arg)
 	wordfree(&w);
 }
 
+static void cmd_unregister_characteristic(const char *arg)
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
+	if (w.we_wordc < 1) {
+		rl_printf("Missing arguments\n");
+		return;
+	}
+
+	gatt_unregister_chrc(dbus_conn, default_ctrl->proxy, &w);
+
+	wordfree(&w);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -2214,6 +2236,9 @@ static const struct {
 	{ "register-characteristic", "<UUID> <Flags=read,write,notify...>",
 					cmd_register_characteristic,
 					"Register application characteristic" },
+	{ "unregister-characteristic", "<UUID/object>",
+				cmd_unregister_characteristic,
+				"Unregister application characteristic" },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit, "Quit program" },
-- 
2.9.4

