Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] core/device: Convert temporary flag to bool
Date: Tue, 17 Mar 2015 11:13:13 +0200
Message-Id: <1426583595-28502-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426583595-28502-1-git-send-email-luiz.dentz@gmail.com>
References: <1426583595-28502-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/sixaxis.c |  2 +-
 src/adapter.c     | 12 ++++++------
 src/device.c      | 20 ++++++++++----------
 src/device.h      |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index c93f5d4..fcc93bc 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -302,7 +302,7 @@ static bool setup_device(int fd, int index, struct btd_adapter *adapter)
 	btd_device_device_set_name(device, devices[index].name);
 	btd_device_set_pnpid(device, devices[index].source, devices[index].vid,
 				devices[index].pid, devices[index].version);
-	btd_device_set_temporary(device, FALSE);
+	btd_device_set_temporary(device, false);
 
 	return true;
 }
diff --git a/src/adapter.c b/src/adapter.c
index 3744c2b..09219e5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2305,7 +2305,7 @@ static DBusMessage *remove_device(DBusConnection *conn,
 
 	device = list->data;
 
-	btd_device_set_temporary(device, TRUE);
+	btd_device_set_temporary(device, true);
 
 	if (!btd_device_is_connected(device)) {
 		btd_adapter_remove_device(adapter, device);
@@ -2948,7 +2948,7 @@ static void load_devices(struct btd_adapter *adapter)
 		if (!device)
 			goto free;
 
-		btd_device_set_temporary(device, FALSE);
+		btd_device_set_temporary(device, false);
 		adapter->devices = g_slist_append(adapter->devices, device);
 
 		/* TODO: register services from pre-loaded list of primaries */
@@ -6045,7 +6045,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 		device_set_bonded(device, BDADDR_BREDR);
 
 		if (device_is_temporary(device))
-			btd_device_set_temporary(device, FALSE);
+			btd_device_set_temporary(device, false);
 	}
 
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
@@ -6163,7 +6163,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 		device_set_bonded(device, addr->type);
 
 		if (device_is_temporary(device))
-			btd_device_set_temporary(device, FALSE);
+			btd_device_set_temporary(device, false);
 	}
 
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
@@ -6265,7 +6265,7 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 								key->type);
 
 	if (device_is_temporary(device))
-		btd_device_set_temporary(device, FALSE);
+		btd_device_set_temporary(device, false);
 }
 
 static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
@@ -6353,7 +6353,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 	store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
 
 	if (device_is_temporary(device))
-		btd_device_set_temporary(device, FALSE);
+		btd_device_set_temporary(device, false);
 }
 
 static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
diff --git a/src/device.c b/src/device.c
index 6100341..14bfe7b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -205,7 +205,7 @@ struct btd_device {
 	GSList		*services;		/* List of btd_service */
 	GSList		*pending;		/* Pending services */
 	GSList		*watches;		/* List of disconnect_data */
-	gboolean	temporary;
+	bool		temporary;
 	guint		disconn_timer;
 	guint		discov_timer;
 	struct browse_req *browse;		/* service discover request */
@@ -1137,7 +1137,7 @@ int device_block(struct btd_device *device, gboolean update_only)
 
 	store_device_info(device);
 
-	btd_device_set_temporary(device, FALSE);
+	btd_device_set_temporary(device, false);
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Blocked");
@@ -1336,7 +1336,7 @@ static void device_profile_connected(struct btd_device *dev,
 	DBG("%s %s (%d)", profile->name, strerror(-err), -err);
 
 	if (!err)
-		btd_device_set_temporary(dev, FALSE);
+		btd_device_set_temporary(dev, false);
 
 	if (dev->pending == NULL)
 		return;
@@ -1516,7 +1516,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	if (!btd_adapter_get_powered(dev->adapter))
 		return btd_error_not_ready(msg);
 
-	btd_device_set_temporary(dev, FALSE);
+	btd_device_set_temporary(dev, false);
 
 	if (!state->svc_resolved)
 		goto resolve_services;
@@ -1609,7 +1609,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 		if (dev->le_state.connected)
 			return dbus_message_new_method_return(msg);
 
-		btd_device_set_temporary(dev, FALSE);
+		btd_device_set_temporary(dev, false);
 
 		if (dev->disable_auto_connect) {
 			dev->disable_auto_connect = FALSE;
@@ -1975,7 +1975,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	uint8_t io_cap;
 	int err;
 
-	btd_device_set_temporary(device, FALSE);
+	btd_device_set_temporary(device, false);
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
@@ -2947,7 +2947,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	}
 
 	device->adapter = adapter;
-	device->temporary = TRUE;
+	device->temporary = true;
 
 	gatt_db_register(device->db, gatt_service_added, gatt_service_removed,
 								device, NULL);
@@ -3942,7 +3942,7 @@ static void register_gatt_services(struct btd_device *device)
 	 */
 	gatt_db_foreach_service(device->db, NULL, add_primary, &services);
 
-	btd_device_set_temporary(device, FALSE);
+	btd_device_set_temporary(device, false);
 
 	if (req)
 		update_gatt_uuids(req, device->primaries, services);
@@ -4464,7 +4464,7 @@ gboolean device_is_temporary(struct btd_device *device)
 	return device->temporary;
 }
 
-void btd_device_set_temporary(struct btd_device *device, gboolean temporary)
+void btd_device_set_temporary(struct btd_device *device, bool temporary)
 {
 	if (!device)
 		return;
@@ -4631,7 +4631,7 @@ void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type)
 	g_dbus_emit_property_changed(dbus_conn, dev->path,
 						DEVICE_INTERFACE, "Paired");
 
-	btd_device_set_temporary(dev, TRUE);
+	btd_device_set_temporary(dev, true);
 
 	if (btd_device_is_connected(dev))
 		device_request_disconnect(dev, NULL);
diff --git a/src/device.h b/src/device.h
index 8edd0df..b17f53a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -86,7 +86,7 @@ bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
 gboolean device_is_trusted(struct btd_device *device);
 void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type);
 void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type);
-void btd_device_set_temporary(struct btd_device *device, gboolean temporary);
+void btd_device_set_temporary(struct btd_device *device, bool temporary);
 void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
 void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
 void device_set_legacy(struct btd_device *device, bool legacy);
-- 
2.1.0

