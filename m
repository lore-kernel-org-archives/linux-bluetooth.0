Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 1/8] core: adapter: Initialize GATT database
Date: Wed, 18 Feb 2015 00:18:32 -0800
Message-Id: <1424247519-21684-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1424247519-21684-1-git-send-email-armansito@chromium.org>
References: <1424247519-21684-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds code that initializes a btd_gatt_database for a
btd_adapter. Also added is the btd_adapter_get_database getter
function.
---
 src/adapter.c | 26 +++++++++++++++-----------
 src/adapter.h |  2 ++
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5a6b45e..8886045 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -68,6 +68,7 @@
 #include "attrib/att.h"
 #include "attrib/gatt.h"
 #include "attrib-server.h"
+#include "gatt-database.h"
 #include "eir.h"
 
 #define ADAPTER_INTERFACE	"org.bluez.Adapter1"
@@ -204,6 +205,8 @@ struct btd_adapter {
 	struct btd_device *connect_le;	/* LE device waiting to be connected */
 	sdp_list_t *services;		/* Services associated to adapter */
 
+	struct btd_gatt_database *database;
+
 	gboolean initialized;
 
 	GSList *pin_callbacks;
@@ -279,7 +282,6 @@ static void dev_class_changed_callback(uint16_t index, uint16_t length,
 {
 	struct btd_adapter *adapter = user_data;
 	const struct mgmt_cod *rp = param;
-	uint8_t appearance[3];
 	uint32_t dev_class;
 
 	if (length < sizeof(*rp)) {
@@ -298,13 +300,6 @@ static void dev_class_changed_callback(uint16_t index, uint16_t length,
 
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
 						ADAPTER_INTERFACE, "Class");
-
-	appearance[0] = rp->val[0];
-	appearance[1] = rp->val[1] & 0x1f;	/* removes service class */
-	appearance[2] = rp->val[2];
-
-	/* TODO: Do this through btd_gatt_database instead */
-	attrib_gap_set(adapter, GATT_CHARAC_APPEARANCE, appearance, 2);
 }
 
 static void set_dev_class_complete(uint8_t status, uint16_t length,
@@ -3176,6 +3171,14 @@ bool btd_adapter_get_connectable(struct btd_adapter *adapter)
 	return false;
 }
 
+struct btd_gatt_database *btd_adapter_get_database(struct btd_adapter *adapter)
+{
+	if (!adapter)
+		return NULL;
+
+	return adapter->database;
+}
+
 uint32_t btd_adapter_get_class(struct btd_adapter *adapter)
 {
 	return adapter->dev_class;
@@ -4586,7 +4589,7 @@ static void adapter_remove(struct btd_adapter *adapter)
 	adapter->devices = NULL;
 
 	unload_drivers(adapter);
-	btd_adapter_gatt_server_stop(adapter);
+	btd_gatt_database_destroy(adapter->database);
 
 	g_slist_free(adapter->pin_callbacks);
 	adapter->pin_callbacks = NULL;
@@ -6628,8 +6631,9 @@ static int adapter_register(struct btd_adapter *adapter)
 		agent_unref(agent);
 	}
 
-	/* TODO: Migrate to use btd_gatt_database */
-	btd_adapter_gatt_server_start(adapter);
+	adapter->database = btd_gatt_database_new(adapter);
+	if (!adapter->database)
+		error("Failed to create GATT database for adapter");
 
 	load_config(adapter);
 	fix_storage(adapter);
diff --git a/src/adapter.h b/src/adapter.h
index 737479f..867f4e3 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -79,6 +79,8 @@ bool btd_adapter_get_pairable(struct btd_adapter *adapter);
 bool btd_adapter_get_powered(struct btd_adapter *adapter);
 bool btd_adapter_get_connectable(struct btd_adapter *adapter);
 
+struct btd_gatt_database *btd_adapter_get_database(struct btd_adapter *adapter);
+
 uint32_t btd_adapter_get_class(struct btd_adapter *adapter);
 const char *btd_adapter_get_name(struct btd_adapter *adapter);
 void btd_adapter_remove_device(struct btd_adapter *adapter,
-- 
2.2.0.rc0.207.ga3a616c

