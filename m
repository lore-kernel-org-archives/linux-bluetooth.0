Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: [RFC PATCH BlueZ RESEND 3/3] Add a btd_device_set_trusted() call
Date: Mon, 10 Oct 2011 17:50:53 +0200
Message-Id: <1318261853-22448-3-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1316454126-32614-1-git-send-email-ospite@studenti.unina.it>
References: <1316454126-32614-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new btd_* call to set a device as trusted, this is going to be
used by the external playstation-peripheral plugin.
---
 src/device.h |    6 +++++
 src/device.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/src/device.h b/src/device.h
index 1ea5ce4..4994d2a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -63,6 +63,12 @@ void device_register_services(DBusConnection *conn, struct btd_device *device,
 						GSList *prim_list, int psm);
 GSList *device_services_from_record(struct btd_device *device,
 							GSList *profiles);
+int btd_device_set_trusted(const char *adapter_address,
+			   const char *device_address,
+			   char *name,
+			   uint16_t vendor_id,
+			   uint16_t product_id,
+			   const char *uuid);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
 void device_get_address(struct btd_device *device, bdaddr_t *bdaddr);
diff --git a/src/device.c b/src/device.c
index 68d504d..2d167d3 100644
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
@@ -2698,6 +2699,75 @@ GSList *btd_device_get_primaries(struct btd_device *device)
 	return device->primaries;
 }
 
+int btd_device_set_trusted(const char *adapter_address,
+			   const char *device_address,
+			   char *name,
+			   uint16_t vendor_id,
+			   uint16_t product_id,
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
+	/* XXX: is this really needed? Association works even without it */
+	write_device_name(&dst, &src, name);
+
+	/* Set the device id */
+	store_device_id(adapter_address, device_address, 0xffff, vendor_id,
+			product_id, 0);
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
+	/* XXX: these two should not be needed either, as the values are reset
+	 * on the actual BT connection. We are just preparing for it now, we
+	 * are still connected via USB. I just wanted confirmation on that.
+	 */
+	device_set_temporary(device, FALSE);
+	device_set_name(device, name);
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
-- 
1.7.6.3

