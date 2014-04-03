Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 2/3] gatt: Fix possibly lost block when bluetoothd exits
Date: Thu,  3 Apr 2014 16:46:51 -0300
Message-Id: <1396554412-2057-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396554412-2057-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
 <1396554412-2057-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a possibly lost memory related to GDBusClient
and GDBusProxy objects when bluetoothd daemon exits and there
is registered external service.
==1503==    by 0x47ECFB: g_dbus_client_new (client.c:1232)
==1503==    by 0x461EC7: register_service (gatt-dbus.c:510)
---
 src/gatt-dbus.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index d3fd717..26437e7 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -96,6 +96,19 @@ static gboolean external_service_destroy(void *user_data)
 	return FALSE;
 }
 
+static void external_service_free(void *user_data)
+{
+	struct external_service *esvc = user_data;
+
+	/*
+	 * Set callback to NULL to avoid potential race condition
+	 * when calling remove_service and GDBusClient unref.
+	 */
+	g_dbus_client_set_disconnect_watch(esvc->client, NULL, NULL);
+
+	external_service_destroy(user_data);
+}
+
 static void remove_service(DBusConnection *conn, void *user_data)
 {
 	struct external_service *esvc = user_data;
@@ -634,6 +647,8 @@ void gatt_dbus_manager_unregister(void)
 	g_hash_table_destroy(proxy_hash);
 	proxy_hash = NULL;
 
+	g_slist_free_full(external_services, external_service_free);
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(), "/org/bluez",
 							GATT_MGR_IFACE);
 }
-- 
1.8.3.1

