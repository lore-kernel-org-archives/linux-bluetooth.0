Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 1/6] Move Attrib client to the core
Date: Mon, 28 Mar 2011 19:40:46 -0300
Message-Id: <1301352051-12046-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1301352051-12046-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1301352051-12046-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am      |    4 +-
 attrib/main.c    |   14 +-----------
 attrib/manager.c |   62 ++---------------------------------------------------
 attrib/manager.h |    2 +-
 4 files changed, 7 insertions(+), 75 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index a23cc60..77b9b7d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -89,7 +89,8 @@ endif
 endif
 
 attrib_sources = attrib/att.h attrib/att.c attrib/gatt.h attrib/gatt.c \
-		attrib/gattrib.h attrib/gattrib.c
+		attrib/gattrib.h attrib/gattrib.c attrib/client.h \
+		attrib/client.c
 
 gdbus_sources = gdbus/gdbus.h gdbus/mainloop.c gdbus/watch.c \
 					gdbus/object.c gdbus/polkit.c
@@ -204,7 +205,6 @@ endif
 builtin_modules += attrib
 builtin_sources += attrib/main.c \
 		attrib/manager.h attrib/manager.c \
-		attrib/client.h attrib/client.c \
 		attrib/example.h attrib/example.c
 endif
 
diff --git a/attrib/main.c b/attrib/main.c
index 6c946be..91ddab1 100644
--- a/attrib/main.c
+++ b/attrib/main.c
@@ -28,32 +28,20 @@
 
 #include <errno.h>
 
-#include <gdbus.h>
-
 #include "plugin.h"
 #include "manager.h"
 
-static DBusConnection *connection;
-
 static int attrib_init(void)
 {
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
+	if (attrib_manager_init() < 0)
 		return -EIO;
 
-	if (attrib_manager_init(connection) < 0) {
-		dbus_connection_unref(connection);
-		return -EIO;
-	}
-
 	return 0;
 }
 
 static void attrib_exit(void)
 {
 	attrib_manager_exit();
-
-	dbus_connection_unref(connection);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(attrib, VERSION,
diff --git a/attrib/manager.c b/attrib/manager.c
index a5a7de4..7c05720 100644
--- a/attrib/manager.c
+++ b/attrib/manager.c
@@ -26,66 +26,16 @@
 #include <config.h>
 #endif
 
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
+#include <stdint.h>
+#include <glib.h>
 
-#include "../src/adapter.h"
-#include "../src/device.h"
 #include "hcid.h"
 
 #include "manager.h"
-#include "client.h"
 #include "example.h"
 
-#define GATT_UUID	"00001801-0000-1000-8000-00805f9b34fb"
-
-static DBusConnection *connection;
-
-static int client_probe(struct btd_device *device, GSList *uuids)
+int attrib_manager_init(void)
 {
-	const sdp_record_t *rec;
-	int psm = -1;
-
-	rec = btd_device_get_record(device, GATT_UUID);
-	if (rec) {
-		sdp_list_t *list;
-		if (sdp_get_access_protos(rec, &list) < 0)
-			return -1;
-
-		psm = sdp_get_proto_port(list, L2CAP_UUID);
-
-		sdp_list_foreach(list, (sdp_list_func_t) sdp_list_free, NULL);
-		sdp_list_free(list, NULL);
-
-		if (psm < 0)
-			return -1;
-	}
-
-	return attrib_client_register(device, psm);
-}
-
-static void client_remove(struct btd_device *device)
-{
-	attrib_client_unregister(device);
-}
-
-static struct btd_device_driver client_driver = {
-	.name = "gatt-client",
-	.uuids = BTD_UUIDS(GATT_UUID),
-	.probe = client_probe,
-	.remove = client_remove,
-};
-
-int attrib_manager_init(DBusConnection *conn)
-{
-	connection = dbus_connection_ref(conn);
-
-	attrib_client_init(connection);
-
-	btd_register_device_driver(&client_driver);
-
-
 	if (main_opts.attrib_server)
 		return server_example_init();
 
@@ -94,12 +44,6 @@ int attrib_manager_init(DBusConnection *conn)
 
 void attrib_manager_exit(void)
 {
-	btd_unregister_device_driver(&client_driver);
-
 	if (main_opts.attrib_server)
 		server_example_exit();
-
-	attrib_client_exit();
-
-	dbus_connection_unref(connection);
 }
diff --git a/attrib/manager.h b/attrib/manager.h
index fabf342..19dc539 100644
--- a/attrib/manager.h
+++ b/attrib/manager.h
@@ -22,5 +22,5 @@
  *
  */
 
-int attrib_manager_init(DBusConnection *conn);
+int attrib_manager_init(void);
 void attrib_manager_exit(void);
-- 
1.7.4.1

