Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 6/6] android/hidhost: Remove reconnect logic
Date: Wed,  3 Sep 2014 08:58:07 +0200
Message-Id: <1409727487-19074-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409727487-19074-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409727487-19074-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT can handle reconnect now, so lets remove that part of code from
here
---
 android/hidhost.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 3dc3c25..652b118 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -109,7 +109,6 @@ struct hid_device {
 	struct bt_uhid	*uhid;
 	uint8_t		last_hid_msg;
 	struct bt_hog	*hog;
-	guint		reconnect_id;
 	int sec_level;
 };
 
@@ -125,9 +124,6 @@ static void hid_device_free(void *data)
 {
 	struct hid_device *dev = data;
 
-	if (dev->reconnect_id > 0)
-		g_source_remove(dev->reconnect_id);
-
 	if (dev->ctrl_watch > 0)
 		g_source_remove(dev->ctrl_watch);
 
@@ -768,19 +764,6 @@ fail:
 	hid_device_remove(dev);
 }
 
-static gboolean hog_reconnect(void *user_data)
-{
-	struct hid_device *dev = user_data;
-
-	DBG("");
-
-	dev->reconnect_id = 0;
-
-	bt_gatt_connect_app(hog_app, &dev->dst);
-
-	return FALSE;
-}
-
 static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 {
 	GSList *l;
@@ -792,11 +775,10 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 	if (err < 0) {
 		if (!dev)
 			return;
-		if (dev->hog && !dev->reconnect_id) {
+		if (dev->hog) {
 			bt_hid_notify_state(dev,
 						HAL_HIDHOST_STATE_DISCONNECTED);
 			bt_hog_detach(dev->hog);
-			dev->reconnect_id = g_idle_add(hog_reconnect, dev);
 			return;
 		}
 		goto fail;
@@ -829,6 +811,9 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTED);
 
+	if (!bt_gatt_add_autoconnect(hog_app, &dev->dst))
+		error("hidhost: Could not add to autoconnect list");
+
 	return;
 
 fail:
@@ -1497,6 +1482,9 @@ static void hid_unpaired_cb(const bdaddr_t *addr, uint8_t type)
 	ba2str(addr, address);
 	DBG("Unpaired device %s", address);
 
+	if (hog_app)
+		bt_gatt_remove_autoconnect(hog_app, addr);
+
 	hid_device_remove(dev);
 }
 
-- 
1.8.4

