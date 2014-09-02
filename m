Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 16/16] android/hidhost: Remove reconnect logic
Date: Tue,  2 Sep 2014 12:10:01 +0200
Message-Id: <1409652601-28689-17-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT can handle reconnect now, so lets remove that part of code from
here
---
 android/hidhost.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 3dc3c25..82cc32e 100644
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
-- 
1.8.4

