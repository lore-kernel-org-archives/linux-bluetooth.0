Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 16/17] core: device: Add function to get GATT service
Date: Fri, 19 Dec 2014 13:36:04 -0800
Message-Id: <1419024965-10375-17-git-send-email-armansito@chromium.org>
In-Reply-To: <1419024965-10375-1-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added btd_device_get_gatt_service which returns a btd_service by UUID
and handle-range.
---
 src/device.c | 27 +++++++++++++++++++++++++++
 src/device.h |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/src/device.c b/src/device.c
index f13d9aa..6488396 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5432,6 +5432,33 @@ struct btd_service *btd_device_get_service(struct btd_device *dev,
 	return NULL;
 }
 
+struct btd_service *btd_device_get_gatt_service(struct btd_device *dev,
+							const char *remote_uuid,
+							uint16_t start_handle,
+							uint16_t end_handle)
+{
+	GSList *l;
+
+	if (!dev)
+		return NULL;
+
+	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
+		struct btd_service *service = l->data;
+		struct btd_profile *p = btd_service_get_profile(service);
+		uint16_t start, end;
+
+		if (!btd_service_get_gatt_handles(service, &start, &end))
+			continue;
+
+		if (g_str_equal(p->remote_uuid, remote_uuid) &&
+							start == start_handle &&
+							end == end_handle)
+			return service;
+	}
+
+	return NULL;
+}
+
 void btd_device_init(void)
 {
 	dbus_conn = btd_get_dbus_connection();
diff --git a/src/device.h b/src/device.h
index a7fefee..f2d67ad 100644
--- a/src/device.h
+++ b/src/device.h
@@ -148,6 +148,10 @@ bool device_remove_svc_complete_callback(struct btd_device *dev,
 
 struct btd_service *btd_device_get_service(struct btd_device *dev,
 						const char *remote_uuid);
+struct btd_service *btd_device_get_gatt_service(struct btd_device *dev,
+							const char *remote_uuid,
+							uint16_t start_handle,
+							uint16_t end_handle);
 
 int device_discover_services(struct btd_device *device);
 int btd_device_connect_services(struct btd_device *dev, GSList *services);
-- 
2.2.0.rc0.207.ga3a616c

