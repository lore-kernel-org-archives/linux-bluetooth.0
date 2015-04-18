Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH 2/3] core: Add implementation of TxPower
Date: Fri, 17 Apr 2015 18:09:31 -0700
Message-Id: <1429319372-25172-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1429319372-25172-1-git-send-email-jpawlowski@google.com>
References: <1429319372-25172-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds 'TxPower' property to Device interface.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 src/adapter.c |  9 +++++++--
 src/device.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |  1 +
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5af8489..8ee5b5b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1680,16 +1680,18 @@ static int compare_sender(gconstpointer a, gconstpointer b)
 	return g_strcmp0(client->owner, sender);
 }
 
-static void invalidate_rssi(gpointer a)
+static void invalidate_rssi_and_tx_power(gpointer a)
 {
 	struct btd_device *dev = a;
 
 	device_set_rssi(dev, 0);
+	device_set_tx_power(dev, 127);
 }
 
 static void discovery_cleanup(struct btd_adapter *adapter)
 {
-	g_slist_free_full(adapter->discovery_found, invalidate_rssi);
+	g_slist_free_full(adapter->discovery_found,
+						invalidate_rssi_and_tx_power);
 	adapter->discovery_found = NULL;
 }
 
@@ -5449,6 +5451,9 @@ static void update_found_devices(struct btd_adapter *adapter,
 	else
 		device_set_rssi(dev, rssi);
 
+	if (eir_data.tx_power != 127)
+		device_set_tx_power(dev, eir_data.tx_power);
+
 	if (eir_data.appearance != 0)
 		device_set_appearance(dev, eir_data.appearance);
 
diff --git a/src/device.c b/src/device.c
index 3552999..03d8494 100644
--- a/src/device.c
+++ b/src/device.c
@@ -257,6 +257,7 @@ struct btd_device {
 
 	bool		legacy;
 	int8_t		rssi;
+	int8_t		tx_power;
 
 	GIOChannel	*att_io;
 	guint		store_id;
@@ -925,6 +926,28 @@ static gboolean dev_property_exists_rssi(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_tx_power(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *dev = data;
+	dbus_int16_t val = dev->tx_power;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16, &val);
+
+	return TRUE;
+}
+
+static gboolean dev_property_exists_tx_power(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *dev = data;
+
+	if (dev->tx_power == 127)
+		return FALSE;
+
+	return TRUE;
+}
+
 static gboolean dev_property_get_trusted(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -2294,6 +2317,8 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Blocked", "b", dev_property_get_blocked, dev_property_set_blocked },
 	{ "LegacyPairing", "b", dev_property_get_legacy },
 	{ "RSSI", "n", dev_property_get_rssi, NULL, dev_property_exists_rssi },
+	{ "TxPower", "n", dev_property_get_tx_power, NULL,
+						dev_property_exists_tx_power },
 	{ "Connected", "b", dev_property_get_connected },
 	{ "UUIDs", "as", dev_property_get_uuids },
 	{ "Modalias", "s", dev_property_get_modalias, NULL,
@@ -3046,6 +3071,8 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	if (device == NULL)
 		return NULL;
 
+	device->tx_power = 127;
+
 	device->db = gatt_db_new();
 	if (!device->db) {
 		g_free(device);
@@ -4724,6 +4751,22 @@ void device_set_rssi(struct btd_device *device, int8_t rssi)
 	device_set_rssi_with_delta(device, rssi, RSSI_THRESHOLD);
 }
 
+void device_set_tx_power(struct btd_device *device, int8_t tx_power)
+{
+	if (!device)
+		return;
+
+	if (device->tx_power == tx_power)
+		return;
+
+	DBG("tx_power %d", tx_power);
+
+	device->tx_power = tx_power;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "TxPower");
+}
+
 static gboolean start_discovery(gpointer user_data)
 {
 	struct btd_device *device = user_data;
diff --git a/src/device.h b/src/device.h
index b91916d..1955f54 100644
--- a/src/device.h
+++ b/src/device.h
@@ -95,6 +95,7 @@ void device_set_legacy(struct btd_device *device, bool legacy);
 void device_set_rssi_with_delta(struct btd_device *device, int8_t rssi,
 							int8_t delta_threshold);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
+void device_set_tx_power(struct btd_device *device, int8_t tx_power);
 bool btd_device_is_connected(struct btd_device *dev);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
-- 
2.2.0.rc0.207.ga3a616c

