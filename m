Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH BlueZ 1/2] device: add a device_set_trusted() function
Date: Sun,  3 Feb 2013 17:14:30 +0100
Message-Id: <1359908071-15024-2-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
References: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |   18 ++++++++++++++++++
 src/device.h |    1 +
 2 files changed, 19 insertions(+)

diff --git a/src/device.c b/src/device.c
index 49f8957..87e5eff 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3462,6 +3462,24 @@ void device_set_temporary(struct btd_device *device, gboolean temporary)
 	device->temporary = temporary;
 }
 
+void device_set_trusted(struct btd_device *device, gboolean trusted)
+{
+	if (!device)
+		return;
+
+	if (device->trusted == trusted)
+		return;
+
+	DBG("trusted %d", trusted);
+
+	device->trusted = trusted;
+
+	store_device_info(device);
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "Trusted");
+}
+
 void device_set_bonded(struct btd_device *device, gboolean bonded)
 {
 	if (!device)
diff --git a/src/device.h b/src/device.h
index dc11e2c..d072015 100644
--- a/src/device.h
+++ b/src/device.h
@@ -68,6 +68,7 @@ gboolean device_is_bonded(struct btd_device *device);
 gboolean device_is_trusted(struct btd_device *device);
 void device_set_paired(struct btd_device *device, gboolean paired);
 void device_set_temporary(struct btd_device *device, gboolean temporary);
+void device_set_trusted(struct btd_device *device, gboolean trusted);
 void device_set_bonded(struct btd_device *device, gboolean bonded);
 void device_set_legacy(struct btd_device *device, bool legacy);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
-- 
1.7.10.4

