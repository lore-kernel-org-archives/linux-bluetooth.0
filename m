Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 08/10] gatt: Primary service interval may not change
Date: Mon, 20 Aug 2012 14:22:53 -0300
Message-Id: <1345483375-27621-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch address the "Service Changed" scenario on which the start
and end Primary Service attribute handle interval doesn't change.
---
 attrib/gatt.h       |    1 +
 profiles/gatt/gas.c |    4 ++--
 src/device.c        |   15 +++++++++++++++
 src/device.h        |    2 ++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/attrib/gatt.h b/attrib/gatt.h
index 7690fba..a15e92f 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -57,6 +57,7 @@ typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
 
 struct gatt_primary {
 	char uuid[MAX_LEN_UUID_STR + 1];
+	gboolean changed;
 	struct att_range range;
 };
 
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 3e3c3db..de23a13 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -154,7 +154,7 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	gas->changed.start = start;
 	gas->changed.end = end;
 
-	device_browse_primary(gas->device, NULL, NULL, FALSE);
+	btd_device_gatt_set_service_changed(gas->device, start, end);
 }
 
 static void gatt_service_changed_cb(guint8 status, const guint8 *pdu,
@@ -185,7 +185,7 @@ static void gatt_service_changed_cb(guint8 status, const guint8 *pdu,
 
 	DBG("GATT Service Changed start: 0x%04X end: 0x%04X", start, end);
 
-	device_browse_primary(gas->device, NULL, NULL, FALSE);
+	btd_device_gatt_set_service_changed(gas->device, start, end);
 }
 
 static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
diff --git a/src/device.c b/src/device.c
index 8626ad6..c4b5554 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2938,6 +2938,21 @@ GSList *btd_device_get_primaries(struct btd_device *device)
 	return device->primaries;
 }
 
+void btd_device_gatt_set_service_changed(struct btd_device *device,
+						uint16_t start, uint16_t end)
+{
+	GSList *l;
+
+	for (l = device->primaries; l; l = g_slist_next(l)) {
+		struct gatt_primary *prim = l->data;
+
+		if (start <= prim->range.end && end >= prim->range.start)
+			prim->changed = TRUE;
+	}
+
+	device_browse_primary(device, NULL, NULL, FALSE);
+}
+
 void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 {
 	GSList *uuid_list;
diff --git a/src/device.h b/src/device.h
index 85d265a..a65de26 100644
--- a/src/device.h
+++ b/src/device.h
@@ -53,6 +53,8 @@ void device_probe_drivers(struct btd_device *device, GSList *profiles);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
 GSList *btd_device_get_primaries(struct btd_device *device);
+void btd_device_gatt_set_service_changed(struct btd_device *device,
+						uint16_t start, uint16_t end);
 void device_register_services(DBusConnection *conn, struct btd_device *device,
 						GSList *prim_list, int psm);
 GSList *device_services_from_record(struct btd_device *device,
-- 
1.7.8.6

