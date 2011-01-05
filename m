Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] telephony-ofono: handle ofono appearing/disappearing from bus
Date: Wed,  5 Jan 2011 17:59:45 +0200
Message-Id: <1294243187-1849-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
References: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |   31 ++++++++++++++++++++++++++-----
 1 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 00b24f9..b6bea91 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -1187,10 +1187,28 @@ done:
 	remove_pending(call);
 }
 
+static void handle_service_connect(DBusConnection *conn, void *user_data)
+{
+	DBG("telephony-ofono: %s found", OFONO_BUS_NAME);
+
+	send_method_call(OFONO_BUS_NAME, OFONO_PATH,
+				OFONO_MANAGER_INTERFACE, "GetModems",
+				get_modems_reply, NULL, DBUS_TYPE_INVALID);
+}
+
+static void handle_service_disconnect(DBusConnection *conn, void *user_data)
+{
+	DBG("telephony-ofono: %s exitted", OFONO_BUS_NAME);
+
+	if (modem_obj_path)
+		modem_removed(modem_obj_path);
+}
+
 int telephony_init(void)
 {
 	const char *battery_cap = "battery";
 	int ret;
+	guint watch;
 
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 
@@ -1205,11 +1223,14 @@ int telephony_init(void)
 	add_watch(OFONO_BUS_NAME, NULL, OFONO_VCMANAGER_INTERFACE,
 			"CallRemoved", handle_vcmanager_call_removed);
 
-	ret = send_method_call(OFONO_BUS_NAME, OFONO_PATH,
-				OFONO_MANAGER_INTERFACE, "GetModems",
-				get_modems_reply, NULL, DBUS_TYPE_INVALID);
-	if (ret < 0)
-		return ret;
+	watch = g_dbus_add_service_watch(connection, OFONO_BUS_NAME,
+						handle_service_connect,
+						handle_service_disconnect,
+						NULL, NULL);
+	if (watch == 0)
+		return -ENOMEM;
+
+	watches = g_slist_prepend(watches, GUINT_TO_POINTER(watch));
 
 	ret = send_method_call("org.freedesktop.Hal",
 				"/org/freedesktop/Hal/Manager",
-- 
1.7.1

