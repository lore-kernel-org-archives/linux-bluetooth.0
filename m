Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ] core/gatt: Fix not setting auto connect flag
Date: Tue,  1 Sep 2015 17:51:14 +0300
Message-Id: <1441119074-27427-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Profiles registered via org.bluez.GattManager1.RegisterProfile shall
properly register a driver and cause the device to be marked to auto
connect if the device supports the UUID given.
---
 src/device.c        | 14 ++++++++++++--
 src/gatt-database.c |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3dde8b8..bdea55b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2841,10 +2841,20 @@ static void dev_probe_gatt(struct btd_profile *p, void *user_data)
 	struct gatt_probe_data *data = user_data;
 	struct btd_service *service;
 
-	if (p->device_probe == NULL)
+	if (!p->remote_uuid || bt_uuid_strcmp(p->remote_uuid, data->cur_uuid))
 		return;
 
-	if (!p->remote_uuid || bt_uuid_strcmp(p->remote_uuid, data->cur_uuid))
+	/*
+	 * Add device to auto connect list in case the driver has the auto
+	 * connect flag set.
+	 * NOTE: This should work regardless if a service is created and
+	 * probed since external drivers don't need to maintain any
+	 * states they don't implement device_probe callback.
+	 */
+	if (p->auto_connect)
+		device_set_auto_connect(data->dev, TRUE);
+
+	if (p->device_probe == NULL)
 		return;
 
 	service = service_create(data->dev, p);
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 91aba2f..97cef77 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -383,6 +383,7 @@ static void profile_remove(void *data)
 	DBG("Removed \"%s\"", p->name);
 
 	adapter_foreach(adapter_remove_profile, p);
+	btd_profile_unregister(p);
 
 	g_free((void *) p->name);
 	g_free((void *) p->remote_uuid);
@@ -2314,6 +2315,7 @@ static void add_profile(void *data, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
 
+	btd_profile_register(data);
 	adapter_add_profile(adapter, data);
 }
 
-- 
2.4.3

