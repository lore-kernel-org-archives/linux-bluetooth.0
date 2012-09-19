Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 17/17] dbusoob: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:19 +0200
Message-ID: <1348050139-27883-18-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes local reference to DBusConnection object and uses
btd_get_dbus_connection() call wherever such object is needed instead.

Pointer returned by this call is guaranteed to be valid for entire
bluetoothd lifetime and thus do not need to be refcounted.
---
 plugins/dbusoob.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 11b2594..543b272 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -63,7 +63,6 @@ struct oob_data {
 };
 
 static GSList *oob_requests = NULL;
-static DBusConnection *connection = NULL;
 
 static gint oob_request_cmp(gconstpointer a, gconstpointer b)
 {
@@ -129,7 +128,7 @@ done:
 		return;
 	}
 
-	if (!g_dbus_send_message(connection, reply))
+	if (!g_dbus_send_message(btd_get_dbus_connection(), reply))
 		error("D-Bus send failed");
 }
 
@@ -331,8 +330,10 @@ static int oob_probe(struct btd_adapter *adapter)
 {
 	const char *path = adapter_get_path(adapter);
 
-	if (!g_dbus_register_interface(connection, path, OOB_INTERFACE,
-				oob_methods, NULL, NULL, adapter, NULL)) {
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					path, OOB_INTERFACE,
+					oob_methods, NULL, NULL,
+					adapter, NULL)) {
 			error("OOB interface init failed on path %s", path);
 			return -EIO;
 		}
@@ -344,8 +345,8 @@ static void oob_remove(struct btd_adapter *adapter)
 {
 	read_local_data_complete(adapter, NULL, NULL);
 
-	g_dbus_unregister_interface(connection, adapter_get_path(adapter),
-							OOB_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				adapter_get_path(adapter), OOB_INTERFACE);
 }
 
 static struct btd_adapter_driver oob_driver = {
@@ -358,8 +359,6 @@ static int dbusoob_init(void)
 {
 	DBG("Setup dbusoob plugin");
 
-	connection = btd_get_dbus_connection();
-
 	oob_register_cb(read_local_data_complete);
 
 	return btd_register_adapter_driver(&oob_driver);
-- 
1.7.11.3

