Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 15/17] core: gatt: Handle Service Changed.
Date: Fri, 19 Dec 2014 13:36:03 -0800
Message-Id: <1419024965-10375-16-git-send-email-armansito@chromium.org>
In-Reply-To: <1419024965-10375-1-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling for Service Changed events. All exported
objects that match attributes within the changed handle range are
unregistered and new ones get exported based on the newly discovered
services.
---
 src/gatt-client.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index a2e73ac..16a3b3b 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1628,6 +1628,11 @@ static void unregister_service(void *data)
 
 static void notify_chrcs(struct service *service)
 {
+
+	if (service->chrcs_ready ||
+				!queue_isempty(service->pending_ext_props))
+		return;
+
 	service->chrcs_ready = true;
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), service->path,
@@ -1684,8 +1689,7 @@ static void read_ext_props_cb(bool success, uint8_t att_ecode,
 
 	queue_remove(service->pending_ext_props, chrc);
 
-	if (queue_isempty(service->pending_ext_props))
-		notify_chrcs(service);
+	notify_chrcs(service);
 }
 
 static void read_ext_props(void *data, void *user_data)
@@ -1864,13 +1868,36 @@ void btd_gatt_client_ready(struct btd_gatt_client *client)
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

