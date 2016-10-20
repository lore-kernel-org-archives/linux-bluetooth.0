Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: puthik@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: Puthikorn Voravootivat <puthik@chromium.org>
Subject: [PATCH v3 2/2] core: Add implementation of AdvertisingFlags
Date: Wed, 19 Oct 2016 19:03:38 -0700
Message-Id: <1476929018-29947-3-git-send-email-puthik@chromium.org>
In-Reply-To: <1476929018-29947-1-git-send-email-puthik@chromium.org>
References: <1476929018-29947-1-git-send-email-puthik@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Puthikorn Voravootivat <puthik@chromium.org>

This adds 'AdvertisingFlags' property to Device interface.

Bluetooth Core Supplementary Spec v6 Chapter 1.3 defines Bluetooth
Flags as one of the data in advertise data. BlueZ also correctly
parses this data but never exposes it to upper layer.

Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
---
 src/adapter.c |  2 ++
 src/device.c  | 37 +++++++++++++++++++++++++++++++++++++
 src/device.h  |  1 +
 3 files changed, 40 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index b096d48..1abb5c0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5552,6 +5552,8 @@ static void update_found_devices(struct btd_adapter *adapter,
 	if (eir_data.sd_list)
 		device_set_service_data(dev, eir_data.sd_list);
 
+	device_set_flags(dev, eir_data.flags);
+
 	eir_data_free(&eir_data);
 
 	/*
diff --git a/src/device.c b/src/device.c
index fb6104f..d06b5bf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -247,6 +247,8 @@ struct btd_device {
 
 	GIOChannel	*att_io;
 	guint		store_id;
+
+	uint8_t         flags;
 };
 
 static const uint16_t uuid_list[] = {
@@ -939,6 +941,23 @@ dev_property_get_svc_resolved(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean
+dev_property_get_flags(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	uint8_t flags[] = { device->flags };
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&flags, sizeof(flags));
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
 static gboolean dev_property_get_trusted(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -2534,6 +2553,8 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "TxPower", "n", dev_property_get_tx_power, NULL,
 					dev_property_exists_tx_power },
 	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, NULL },
+	{ "AdvertisingFlags", "ay", dev_property_get_flags, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
 
 	{ }
 };
@@ -5221,6 +5242,22 @@ void device_set_tx_power(struct btd_device *device, int8_t tx_power)
 						DEVICE_INTERFACE, "TxPower");
 }
 
+void device_set_flags(struct btd_device *device, uint8_t flags)
+{
+	if (!device)
+		return;
+
+	DBG("flags %d", flags);
+
+	if (device->flags == flags)
+		return;
+
+	device->flags = flags;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "AdvertisingFlags");
+}
+
 static gboolean start_discovery(gpointer user_data)
 {
 	struct btd_device *device = user_data;
diff --git a/src/device.h b/src/device.h
index 387f598..93a159a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -97,6 +97,7 @@ void device_set_rssi_with_delta(struct btd_device *device, int8_t rssi,
 							int8_t delta_threshold);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
 void device_set_tx_power(struct btd_device *device, int8_t tx_power);
+void device_set_flags(struct btd_device *device, uint8_t flags);
 bool btd_device_is_connected(struct btd_device *dev);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
-- 
2.8.0.rc3.226.g39d4020

