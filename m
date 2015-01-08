Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 08/14] core: gatt: Handle Service Changed.
Date: Wed,  7 Jan 2015 21:48:22 -0800
Message-Id: <1420696108-29699-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1420696108-29699-1-git-send-email-armansito@chromium.org>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling for Service Changed events. All exported
objects that match attributes within the changed handle range are
unregistered and new ones get exported based on the newly discovered
services.
---
 src/device.c      |  4 ++--
 src/gatt-client.c | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index e22f92d..1236698 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2703,7 +2703,7 @@ static void gatt_service_added(struct gatt_db_attribute *attr, void *user_data)
 	if (l)
 		service_accept(l->data);
 
-	store_services(device);
+	store_device_info(device);
 
 	btd_gatt_client_service_added(device->client_dbus, attr);
 }
@@ -2776,7 +2776,7 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
 
 	g_free(prim);
 
-	store_services(device);
+	store_device_info(device);
 
 	btd_gatt_client_service_removed(device->client_dbus, attr);
 }
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 77e3539..d792670 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1220,6 +1220,11 @@ static void unregister_service(void *data)
 
 static void notify_chrcs(struct service *service)
 {
+
+	if (service->chrcs_ready ||
+				!queue_isempty(service->pending_ext_props))
+		return;
+
 	service->chrcs_ready = true;
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), service->path,
@@ -1276,8 +1281,7 @@ static void read_ext_props_cb(bool success, uint8_t att_ecode,
 
 	queue_remove(service->pending_ext_props, chrc);
 
-	if (queue_isempty(service->pending_ext_props))
-		notify_chrcs(service);
+	notify_chrcs(service);
 }
 
 static void read_ext_props(void *data, void *user_data)
@@ -1459,13 +1463,36 @@ void btd_gatt_client_ready(struct btd_gatt_client *client)
 void btd_gatt_client_service_added(struct btd_gatt_client *client,
 					struct gatt_db_attribute *attrib)
 {
-	/* TODO */
+	if (!client)
+		return;
+
+	export_service(attrib, client);
+}
+
+static bool match_service_handle(const void *a, const void *b)
+{
+	const struct service *service = a;
+	uint16_t start_handle = PTR_TO_UINT(b);
+
+	return service->start_handle == start_handle;
 }
 
 void btd_gatt_client_service_removed(struct btd_gatt_client *client,
 					struct gatt_db_attribute *attrib)
 {
-	/* TODO */
+	uint16_t start_handle, end_handle;
+
+	if (!client || !attrib)
+		return;
+
+	gatt_db_attribute_get_service_handles(attrib, &start_handle,
+								&end_handle);
+
+	DBG("GATT Services Removed - start: 0x%04x, end: 0x%04x", start_handle,
+								end_handle);
+	queue_remove_all(client->services, match_service_handle,
+						UINT_TO_PTR(start_handle),
+						unregister_service);
 }
 
 void btd_gatt_client_disconnected(struct btd_gatt_client *client)
-- 
2.2.0.rc0.207.ga3a616c

