Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 14/14] core: gatt: Use "claimed" instead of "active"
Date: Wed,  7 Jan 2015 21:48:28 -0800
Message-Id: <1420696108-29699-15-git-send-email-armansito@chromium.org>
In-Reply-To: <1420696108-29699-1-git-send-email-armansito@chromium.org>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using the "active" state of a gatt-db service to mark a service as
claimed by a profile somewhat abuses the API and has the additional
side-effect of sending a service_removed event. This causes errors in
the way btd_device manages profile/service lifetime. To fix this, this
patch uses the new "claimed" state to mark a service as claimed.

Also included is a minor fix to btd_gatt_client_* APIs that early return
if the client is not yet ready.
---
 src/device.c      | 7 +++++--
 src/gatt-client.c | 9 ++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index a9dc22d..9e40467 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2478,7 +2478,7 @@ static void dev_probe_gatt(struct btd_profile *p, void *user_data)
 	}
 
 	/* Mark service as claimed */
-	gatt_db_service_set_active(data->cur_attr, false);
+	gatt_db_service_set_claimed(data->cur_attr, true);
 
 	data->dev->services = g_slist_append(data->dev->services, service);
 }
@@ -2504,8 +2504,11 @@ static void dev_probe_gatt_profile(struct gatt_db_attribute *attr,
 						g_strdup(data->cur_uuid));
 
 	/* Don't probe the profiles if a matching service already exists. */
-	if (find_service_with_uuid(data->dev->services, data->cur_uuid))
+	if (find_service_with_uuid(data->dev->services, data->cur_uuid)) {
+		/* Mark the service as claimed by the existing profile. */
+		gatt_db_service_set_claimed(data->cur_attr, true);
 		return;
+	}
 
 	btd_profile_foreach(dev_probe_gatt, data);
 
diff --git a/src/gatt-client.c b/src/gatt-client.c
index d792670..3e23fbd 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -52,6 +52,7 @@
 
 struct btd_gatt_client {
 	struct btd_device *device;
+	bool ready;
 	char devaddr[18];
 	struct gatt_db *db;
 	struct bt_gatt_client *gatt;
@@ -1369,7 +1370,7 @@ static void export_service(struct gatt_db_attribute *attr, void *user_data)
 	struct btd_gatt_client *client = user_data;
 	struct service *service;
 
-	if (!gatt_db_service_get_active(attr))
+	if (gatt_db_service_get_claimed(attr))
 		return;
 
 	service = service_create(attr, client);
@@ -1457,13 +1458,15 @@ void btd_gatt_client_ready(struct btd_gatt_client *client)
 	bt_gatt_client_unref(client->gatt);
 	client->gatt = bt_gatt_client_ref(gatt);
 
+	client->ready = true;
+
 	create_services(client);
 }
 
 void btd_gatt_client_service_added(struct btd_gatt_client *client,
 					struct gatt_db_attribute *attrib)
 {
-	if (!client)
+	if (!client || !attrib || !client->ready)
 		return;
 
 	export_service(attrib, client);
@@ -1482,7 +1485,7 @@ void btd_gatt_client_service_removed(struct btd_gatt_client *client,
 {
 	uint16_t start_handle, end_handle;
 
-	if (!client || !attrib)
+	if (!client || !attrib || !client->ready)
 		return;
 
 	gatt_db_attribute_get_service_handles(attrib, &start_handle,
-- 
2.2.0.rc0.207.ga3a616c

