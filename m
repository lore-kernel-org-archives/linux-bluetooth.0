Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/9] client: Allow register-application without any UUID
Date: Wed, 28 Jun 2017 15:54:15 +0300
Message-Id: <20170628125423.26208-2-luiz.dentz@gmail.com>
In-Reply-To: <20170628125423.26208-1-luiz.dentz@gmail.com>
References: <20170628125423.26208-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This means that GattProfile1 should not be registered but there could still
be services that needs registered with bluetoothd.
---
 client/gatt.c | 24 +++++++++++++++---------
 client/main.c |  7 +------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 40d3f6a..8b7a9c6 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -726,16 +726,19 @@ void gatt_register_app(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 		return;
 	}
 
-	if (g_dbus_register_interface(conn, APP_PATH,
-					PROFILE_INTERFACE, methods,
-					NULL, properties, NULL, NULL) == FALSE) {
-		rl_printf("Failed to register application object\n");
-		return;
-	}
-
 	for (i = 0; i < w->we_wordc; i++)
 		uuids = g_list_append(uuids, g_strdup(w->we_wordv[i]));
 
+	if (uuids) {
+		if (g_dbus_register_interface(conn, APP_PATH,
+						PROFILE_INTERFACE, methods,
+						NULL, properties, NULL,
+						NULL) == FALSE) {
+			rl_printf("Failed to register application object\n");
+			return;
+		}
+	}
+
 	if (g_dbus_proxy_method_call(l->data, "RegisterApplication",
 						register_app_setup,
 						register_app_reply, w,
@@ -759,11 +762,14 @@ static void unregister_app_reply(DBusMessage *message, void *user_data)
 		return;
 	}
 
+	rl_printf("Application unregistered\n");
+
+	if (!uuids)
+		return;
+
 	g_list_free_full(uuids, g_free);
 	uuids = NULL;
 
-	rl_printf("Application unregistered\n");
-
 	g_dbus_unregister_interface(conn, APP_PATH, PROFILE_INTERFACE);
 }
 
diff --git a/client/main.c b/client/main.c
index 578dde9..31d06b8 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1826,11 +1826,6 @@ static void cmd_register_app(const char *arg)
 		return;
 	}
 
-	if (w.we_wordc == 0) {
-		rl_printf("Missing argument\n");
-		return;
-	}
-
 	gatt_register_app(dbus_conn, default_ctrl->proxy, &w);
 
 	wordfree(&w);
@@ -2142,7 +2137,7 @@ static const struct {
 	{ "write",        "<data=[xx xx ...]>", cmd_write,
 						"Write attribute value" },
 	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value" },
-	{ "register-application", "<UUID ...>", cmd_register_app,
+	{ "register-application", "[UUID ...]", cmd_register_app,
 						"Register profile to connect" },
 	{ "unregister-application", NULL, cmd_unregister_app,
 						"Unregister profile" },
-- 
2.9.4

