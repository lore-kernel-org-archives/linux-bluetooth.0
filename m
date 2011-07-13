Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 3/3] Add Link Loss device driver skeleton
Date: Wed, 13 Jul 2011 09:37:57 -0300
Message-Id: <1310560677-2773-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310560677-2773-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310560677-2773-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/manager.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/proximity/manager.c b/proximity/manager.c
index 795bdee..4b07108 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -26,19 +26,43 @@
 #include <config.h>
 #endif
 
+#include <glib.h>
 #include <gdbus.h>
 
+#include "adapter.h"
+#include "device.h"
 #include "monitor.h"
 #include "manager.h"
 
+#define LINK_LOSS_UUID "00001803-0000-1000-8000-00805f9b34fb"
+
 static DBusConnection *connection = NULL;
 
+static int attio_device_probe(struct btd_device *device, GSList *uuids)
+{
+	return 0;
+}
+
+static void attio_device_remove(struct btd_device *device)
+{
+}
+
+static struct btd_device_driver monitor_driver = {
+	.name = "Proximity GATT Driver",
+	.uuids = BTD_UUIDS(LINK_LOSS_UUID),
+	.probe = attio_device_probe,
+	.remove = attio_device_remove,
+};
+
 int proximity_manager_init(DBusConnection *conn)
 {
 	int ret;
 	/* TODO: Add Proximity Monitor/Reporter config */
 
 	/* TODO: Register Proximity Monitor/Reporter drivers */
+	ret = btd_register_device_driver(&monitor_driver);
+	if (ret < 0)
+		return ret;
 
 	connection = dbus_connection_ref(conn);
 
@@ -55,5 +79,6 @@ int proximity_manager_init(DBusConnection *conn)
 void proximity_manager_exit(void)
 {
 	monitor_unregister(connection);
+	btd_unregister_device_driver(&monitor_driver);
 	dbus_connection_unref(connection);
 }
-- 
1.7.6

