Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/7] Register thermometer driver
Date: Mon, 18 Jul 2011 15:10:39 +0200
Message-Id: <1310994642-16375-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1310994642-16375-3-git-send-email-sancane@gmail.com>
References: <1310994642-16375-1-git-send-email-sancane@gmail.com>
 <1310994642-16375-2-git-send-email-sancane@gmail.com>
 <1310994642-16375-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/main.c    |    1 +
 thermometer/manager.c |   40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/thermometer/main.c b/thermometer/main.c
index df3f1ff..29d9478 100644
--- a/thermometer/main.c
+++ b/thermometer/main.c
@@ -32,6 +32,7 @@
 #include <gdbus.h>
 #include <stdint.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "hcid.h"
 #include "manager.h"
diff --git a/thermometer/manager.c b/thermometer/manager.c
index 8ace3f9..988bd57 100644
--- a/thermometer/manager.c
+++ b/thermometer/manager.c
@@ -24,15 +24,51 @@
  */
 
 #include <gdbus.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "log.h"
 #include "manager.h"
 
+#define HEALTH_THERMOMETER_SVC_UUID	0x1809
+#define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
+
+static DBusConnection *connection = NULL;
+
+static int thermometer_driver_probe(struct btd_device *device, GSList *uuids)
+{
+	/* TODO; */
+	return 0;
+}
+
+static void thermometer_driver_remove(struct btd_device *device)
+{
+	/* TODO: */
+}
+
+static struct btd_device_driver thermometer_device_driver = {
+	.name	= "thermometer-device-driver",
+	.uuids	= BTD_UUIDS(HEALTH_THERMOMETER_UUID),
+	.probe	= thermometer_driver_probe,
+	.remove	= thermometer_driver_remove
+};
+
 int thermometer_manager_init(DBusConnection *conn)
 {
-	/*TODO: */
+	int ret;
+
+	ret = btd_register_device_driver(&thermometer_device_driver);
+	if (ret < 0)
+                return ret;
+
+	connection = dbus_connection_ref(conn);
 	return 0;
 }
 
 void thermometer_manager_exit(void)
 {
-	/*TODO: */
+	btd_unregister_device_driver(&thermometer_device_driver);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
\ No newline at end of file
-- 
1.7.6

