Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Bastien Nocera <hadess@hadess.net>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ 3/3] device: add a btd_device_set_trusted() call
Date: Mon, 13 Feb 2012 15:42:48 +0100
Message-Id: <1329144168-19263-4-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1329144168-19263-1-git-send-email-ospite@studenti.unina.it>
References: <1329144168-19263-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new btd_* call to set a device as trusted, meant to be used by
_external_ plugins.
---
 src/device.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h |    8 +++++++
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3466adb..876e958 100644
--- a/src/device.c
+++ b/src/device.c
@@ -49,6 +49,7 @@
 #include "att.h"
 #include "hcid.h"
 #include "adapter.h"
+#include "manager.h"
 #include "gattrib.h"
 #include "attio.h"
 #include "device.h"
@@ -2767,6 +2768,67 @@ GSList *btd_device_get_primaries(struct btd_device *device)
 	return device->primaries;
 }
 
+int btd_device_set_trusted(const char *adapter_address,
+			   const char *device_address,
+			   char *name,
+			   uint16_t vendor_id_source,
+			   uint16_t vendor_id,
+			   uint16_t product_id,
+			   uint16_t version_id,
+			   const char *uuid)
+{
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+	DBusConnection *conn;
+	bdaddr_t src;
+	bdaddr_t dst;
+	int ret = 0;
+
+	str2ba(adapter_address, &src);
+	str2ba(device_address, &dst);
+
+	/* Set the device id */
+	store_device_id(adapter_address, device_address, vendor_id_source, vendor_id,
+			product_id, version_id);
+	/* Don't write a profile here,
+	 * it will be updated when the device connects */
+
+	write_trust(adapter_address, device_address, "[all]", TRUE);
+
+	conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (conn == NULL) {
+		DBG("Failed to get on the bus");
+		ret = -EPERM;
+		goto out;
+	}
+
+	adapter = manager_find_adapter(&src);
+	if (adapter == NULL) {
+		DBG("Failed to get the adapter");
+		ret = -EPERM;
+		goto out_dbus_unref;
+	}
+
+	/* This is needed: adapter_find_device() wouldn't need a Dbus
+	 * connection but it would not be enough as it only searches for
+	 * already existing devices, while adapter_get_device() will create a
+	 * new device if necessary.
+	 */
+	device = adapter_get_device(conn, adapter, device_address);
+	if (device == NULL) {
+		DBG("Failed to get the device");
+		ret = -ENODEV;
+		goto out_dbus_unref;
+	}
+
+	btd_device_add_uuid(device, uuid);
+
+out_dbus_unref:
+	dbus_connection_unref(conn);
+out:
+	return ret;
+}
+
 void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 {
 	GSList *uuid_list;
diff --git a/src/device.h b/src/device.h
index 7cb9bb2..443b95a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -55,6 +55,14 @@ void device_register_services(DBusConnection *conn, struct btd_device *device,
 						GSList *prim_list, int psm);
 GSList *device_services_from_record(struct btd_device *device,
 							GSList *profiles);
+int btd_device_set_trusted(const char *adapter_address,
+			   const char *device_address,
+			   char *name,
+			   uint16_t vendor_id_source,
+			   uint16_t vendor_id,
+			   uint16_t product_id,
+			   uint16_t version_id,
+			   const char *uuid);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
 void device_get_address(struct btd_device *device, bdaddr_t *bdaddr,
-- 
1.7.9

