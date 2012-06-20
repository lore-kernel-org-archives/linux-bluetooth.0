Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] time: Register GATT services per adapter
Date: Wed, 20 Jun 2012 14:14:20 -0400
Message-Id: <1340216061-24778-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1340216061-24778-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1340216061-24778-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following changes to the GATT service registration API, services should
now be registered per adapter.
---
 time/manager.c |   13 +++++++++++--
 time/server.c  |   33 +++++++++++++++++++++------------
 time/server.h  |    4 ++--
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/time/manager.c b/time/manager.c
index 5bda1a3..285c7b1 100644
--- a/time/manager.c
+++ b/time/manager.c
@@ -26,15 +26,24 @@
 #include <config.h>
 #endif
 
+#include "adapter.h"
 #include "manager.h"
 #include "server.h"
 
+struct btd_adapter_driver time_server_driver = {
+	.name = "gatt-time-server",
+	.probe = time_server_init,
+	.remove = time_server_exit,
+};
+
 int time_manager_init(void)
 {
-	return time_server_init();
+	btd_register_adapter_driver(&time_server_driver);
+
+	return 0;
 }
 
 void time_manager_exit(void)
 {
-	time_server_exit();
+	btd_unregister_adapter_driver(&time_server_driver);
 }
diff --git a/time/server.c b/time/server.c
index 13a7bbe..52bd778 100644
--- a/time/server.c
+++ b/time/server.c
@@ -83,13 +83,13 @@ static int encode_current_time(uint8_t value[10])
 static uint8_t current_time_read(struct attribute *a,
 				 struct btd_device *device, gpointer user_data)
 {
+	struct btd_adapter *adapter = user_data;
 	uint8_t value[10];
 
 	if (encode_current_time(value) < 0)
 		return ATT_ECODE_IO;
 
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_update(NULL, a->handle, NULL, value, sizeof(value), NULL);
+	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
 
 	return 0;
 }
@@ -97,6 +97,7 @@ static uint8_t current_time_read(struct attribute *a,
 static uint8_t local_time_info_read(struct attribute *a,
 				struct btd_device *device, gpointer user_data)
 {
+	struct btd_adapter *adapter = user_data;
 	uint8_t value[2];
 
 	DBG("a=%p", a);
@@ -111,44 +112,52 @@ static uint8_t local_time_info_read(struct attribute *a,
 	 * format (offset from UTC in number of 15 minutes increments). */
 	value[1] = (uint8_t) (-1 * timezone / (60 * 15));
 
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_update(NULL, a->handle, NULL, value, sizeof(value), NULL);
+	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
 
 	return 0;
 }
 
-static void register_current_time_service(void)
+static gboolean register_current_time_service(struct btd_adapter *adapter)
 {
 	bt_uuid_t uuid;
 
 	bt_uuid16_create(&uuid, CURRENT_TIME_SVC_UUID);
 
 	/* Current Time service */
-	/* FIXME: Provide the adapter in next function */
-	gatt_service_add(NULL, GATT_PRIM_SVC_UUID, &uuid,
+	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
 				/* CT Time characteristic */
 				GATT_OPT_CHR_UUID, CT_TIME_CHR_UUID,
 				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
 							ATT_CHAR_PROPER_NOTIFY,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-						current_time_read, NULL,
+						current_time_read, adapter,
 
 				/* Local Time Information characteristic */
 				GATT_OPT_CHR_UUID, LOCAL_TIME_INFO_CHR_UUID,
 				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-						local_time_info_read, NULL,
+						local_time_info_read, adapter,
 
 				GATT_OPT_INVALID);
 }
 
-int time_server_init(void)
+int time_server_init(struct btd_adapter *adapter)
 {
-	register_current_time_service();
+	const char *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	if (!register_current_time_service(adapter)) {
+		error("Current Time Service could not be registered");
+		return -EIO;
+	}
 
 	return 0;
 }
 
-void time_server_exit(void)
+void time_server_exit(struct btd_adapter *adapter)
 {
+	const char *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
 }
diff --git a/time/server.h b/time/server.h
index 621bf2b..69cf114 100644
--- a/time/server.h
+++ b/time/server.h
@@ -22,5 +22,5 @@
  *
  */
 
-int time_server_init(void);
-void time_server_exit(void);
+int time_server_init(struct btd_adapter *adapter);
+void time_server_exit(struct btd_adapter *adapter);
-- 
1.7.9.5

