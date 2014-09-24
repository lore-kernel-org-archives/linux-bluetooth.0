Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCH] core: add D-Bus property for TxPower
Date: Wed, 24 Sep 2014 15:57:40 -0700
Message-Id: <1411599462-8680-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is presented as a raw property rather than a parsed "PathLoss"
property because in the case of many devices, this specific field will
not be present and instead the TX power will have to be parsed from
manufacturer-specific data anyway.

It's better therefore to document the Path Loss equation rather than
hide it.
---
 doc/device-api.txt | 12 ++++++++++++
 src/adapter.c      |  6 ++++--
 src/device.c       | 41 +++++++++++++++++++++++++++++++++++++++++
 src/device.h       |  1 +
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 86d8af8..68388e9 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -193,3 +193,15 @@ Properties	string Address [readonly]
 
 			Received Signal Strength Indicator of the remote
 			device (inquiry or advertising).
+
+		int16 TxPower [readonly, optional]
+
+			Transmission power claimed by the remote device
+			(inquiry or advertising). Many devices may not make
+			this available at all, or may incorporate this data
+			into a manufacturer or service-specific field instead.
+
+			However the remote transmission power is obtained,
+			path loss can be calculated by the equation:
+
+				Path Loss = Tx Power - RSSI
diff --git a/src/adapter.c b/src/adapter.c
index 92ee1a0..1b44dc5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1585,16 +1585,17 @@ static int compare_sender(gconstpointer a, gconstpointer b)
 	return g_strcmp0(client->owner, sender);
 }
 
-static void invalidate_rssi(gpointer a)
+static void invalidate_inquiry_data(gpointer a)
 {
 	struct btd_device *dev = a;
 
 	device_set_rssi(dev, 0);
+	device_set_tx_power(dev, 127);
 }
 
 static void discovery_cleanup(struct btd_adapter *adapter)
 {
-	g_slist_free_full(adapter->discovery_found, invalidate_rssi);
+	g_slist_free_full(adapter->discovery_found, invalidate_inquiry_data);
 	adapter->discovery_found = NULL;
 }
 
@@ -4715,6 +4716,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	device_set_legacy(dev, legacy);
 	device_set_rssi(dev, rssi);
+	device_set_tx_power(dev, eir_data.tx_power);
 
 	if (eir_data.appearance != 0)
 		device_set_appearance(dev, eir_data.appearance);
diff --git a/src/device.c b/src/device.c
index 875a5c5..d4ebf4f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -219,6 +219,7 @@ struct btd_device {
 
 	bool		legacy;
 	int8_t		rssi;
+	int8_t		tx_power;
 
 	GIOChannel	*att_io;
 	guint		cleanup_id;
@@ -812,6 +813,28 @@ static gboolean dev_property_exists_rssi(const GDBusPropertyTable *property,
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
@@ -1957,6 +1980,8 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Blocked", "b", dev_property_get_blocked, dev_property_set_blocked },
 	{ "LegacyPairing", "b", dev_property_get_legacy },
 	{ "RSSI", "n", dev_property_get_rssi, NULL, dev_property_exists_rssi },
+	{ "TxPower", "n", dev_property_get_tx_power, NULL,
+						dev_property_exists_tx_power },
 	{ "Connected", "b", dev_property_get_connected },
 	{ "UUIDs", "as", dev_property_get_uuids },
 	{ "Modalias", "s", dev_property_get_modalias, NULL,
@@ -4107,6 +4132,22 @@ void device_set_rssi(struct btd_device *device, int8_t rssi)
 						DEVICE_INTERFACE, "RSSI");
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
index 2e0473e..b568593 100644
--- a/src/device.h
+++ b/src/device.h
@@ -88,6 +88,7 @@ void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
 void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
 void device_set_legacy(struct btd_device *device, bool legacy);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
+void device_set_tx_power(struct btd_device *device, int8_t tx_power);
 bool btd_device_is_connected(struct btd_device *dev);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
-- 
2.1.0.rc2.206.gedb03e5

