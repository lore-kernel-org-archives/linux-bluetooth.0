Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 12/14] core: adapter: Send UUIDs changed for GATT services
Date: Wed, 11 Feb 2015 19:17:42 -0800
Message-Id: <1423711064-7390-13-git-send-email-armansito@chromium.org>
In-Reply-To: <1423711064-7390-1-git-send-email-armansito@chromium.org>
References: <1423711064-7390-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btd_adapter now sends a PropertiesChanged signal for the "UUIDs"
property when its associated gatt_db is modified.
---
 src/adapter.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c903274..b6057d9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -226,6 +226,8 @@ struct btd_adapter {
 	unsigned int pair_device_id;
 	guint pair_device_timeout;
 
+	unsigned int db_id;		/* Service event handler for GATT db */
+
 	bool is_default;		/* true if adapter is default one */
 };
 
@@ -4555,6 +4557,7 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 static void adapter_remove(struct btd_adapter *adapter)
 {
 	GSList *l;
+	struct gatt_db *db;
 
 	DBG("Removing adapter %s", adapter->path);
 
@@ -4580,6 +4583,11 @@ static void adapter_remove(struct btd_adapter *adapter)
 	adapter->devices = NULL;
 
 	unload_drivers(adapter);
+
+	db = btd_gatt_database_get_db(adapter);
+	gatt_db_unregister(db, adapter->db_id);
+	adapter->db_id = 0;
+
 	btd_gatt_database_unregister_adapter(adapter);
 
 	g_slist_free(adapter->pin_callbacks);
@@ -6589,9 +6597,18 @@ static int set_did(struct btd_adapter *adapter, uint16_t vendor,
 	return -EIO;
 }
 
+static void services_modified(struct gatt_db_attribute *attrib, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE, "UUIDs");
+}
+
 static int adapter_register(struct btd_adapter *adapter)
 {
 	struct agent *agent;
+	struct gatt_db *db;
 
 	if (powering_down)
 		return -EBUSY;
@@ -6625,6 +6642,11 @@ static int adapter_register(struct btd_adapter *adapter)
 	if (!btd_gatt_database_register_adapter(adapter))
 		error("Failed to register adapter with GATT server");
 
+	db = btd_gatt_database_get_db(adapter);
+	adapter->db_id = gatt_db_register(db, services_modified,
+							services_modified,
+							adapter, NULL);
+
 	load_config(adapter);
 	fix_storage(adapter);
 	load_drivers(adapter);
-- 
2.2.0.rc0.207.ga3a616c

