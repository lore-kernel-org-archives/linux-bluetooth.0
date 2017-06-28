Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 9/9] client: Add unregister-descriptor command
Date: Wed, 28 Jun 2017 15:54:23 +0300
Message-Id: <20170628125423.26208-10-luiz.dentz@gmail.com>
In-Reply-To: <20170628125423.26208-1-luiz.dentz@gmail.com>
References: <20170628125423.26208-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds unregister-descriptor which can be used to unregister
descriptors registered with register-descriptor:

unregister-descriptor /org/bluez/app/service0xf48150/chrc0xf49a40/desc0xf4d350
[DEL] Descriptor
	/org/bluez/app/service0xf48150/chrc0xf49a40/desc0xf4d350
	8260c653-1a54-426b-9e36-e84c238bc669
	Vendor specific
---
 client/gatt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 client/gatt.h |  2 ++
 client/main.c | 25 +++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 7cfdc54..47bf0ae 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1461,3 +1461,49 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 
 	rl_prompt_input(desc->path, "Enter value:", desc_set_value, desc);
 }
+
+static struct desc *desc_find(const char *pattern)
+{
+	GList *l, *lc, *ld;
+	struct service *service;
+	struct chrc *chrc;
+	struct desc *desc;
+
+	for (l = local_services; l; l = g_list_next(l)) {
+		service = l->data;
+
+		for (lc = service->chrcs; lc; lc = g_list_next(lc)) {
+			chrc = lc->data;
+
+			for (ld = chrc->descs; ld; ld = g_list_next(ld)) {
+				desc = ld->data;
+
+				/* match object path */
+				if (!strcmp(desc->path, pattern))
+					return desc;
+
+				/* match UUID */
+				if (!strcmp(desc->uuid, pattern))
+					return desc;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+void gatt_unregister_desc(DBusConnection *conn, GDBusProxy *proxy,
+								wordexp_t *w)
+{
+	struct desc *desc;
+
+	desc = desc_find(w->we_wordv[0]);
+	if (!desc) {
+		rl_printf("Failed to unregister descriptor object\n");
+		return;
+	}
+
+	desc->chrc->descs = g_list_remove(desc->chrc->descs, desc);
+
+	desc_unregister(desc);
+}
diff --git a/client/gatt.h b/client/gatt.h
index 4d1e63f..8031a46 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -54,3 +54,5 @@ void gatt_unregister_chrc(DBusConnection *conn, GDBusProxy *proxy,
 								wordexp_t *w);
 
 void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w);
+void gatt_unregister_desc(DBusConnection *conn, GDBusProxy *proxy,
+								wordexp_t *w);
diff --git a/client/main.c b/client/main.c
index 88dbdb3..985859c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1949,6 +1949,28 @@ static void cmd_register_descriptor(const char *arg)
 	wordfree(&w);
 }
 
+static void cmd_unregister_descriptor(const char *arg)
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
+	gatt_unregister_desc(dbus_conn, default_ctrl->proxy, &w);
+
+	wordfree(&w);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -2264,6 +2286,9 @@ static const struct {
 	{ "register-descriptor", "<UUID> <Flags=read,write...>",
 					cmd_register_descriptor,
 					"Register application descriptor" },
+	{ "unregister-descriptor", "<UUID/object>",
+					cmd_unregister_descriptor,
+					"Unregister application descriptor" },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit, "Quit program" },
-- 
2.9.4

