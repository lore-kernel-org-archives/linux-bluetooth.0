Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/10] android/hidhost: Add support for re-connecting HoG
Date: Thu, 12 Jun 2014 15:33:28 +0300
Message-Id: <1402576409-9352-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402576409-9352-1-git-send-email-luiz.dentz@gmail.com>
References: <1402576409-9352-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Once HoG disconnects scanning should be turned on so that once the
device starts advertising again it should connected automatically.
---
 android/hidhost.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/android/hidhost.c b/android/hidhost.c
index 49f7b77..ce533f7 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -109,6 +109,7 @@ struct hid_device {
 	struct bt_uhid	*uhid;
 	uint8_t		last_hid_msg;
 	struct bt_hog	*hog;
+	guint		reconnect_id;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -123,6 +124,9 @@ static void hid_device_free(void *data)
 {
 	struct hid_device *dev = data;
 
+	if (dev->reconnect_id > 0)
+		g_source_remove(dev->reconnect_id);
+
 	if (dev->ctrl_watch > 0)
 		g_source_remove(dev->ctrl_watch);
 
@@ -732,6 +736,19 @@ fail:
 	hid_device_remove(dev);
 }
 
+static gboolean hog_reconnect(void *user_data)
+{
+	struct hid_device *dev = user_data;
+
+	DBG("");
+
+	dev->reconnect_id = 0;
+
+	bt_gatt_connect_app(hog_app, &dev->dst);
+
+	return FALSE;
+}
+
 static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 {
 	GSList *l;
@@ -743,6 +760,13 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 	if (err < 0) {
 		if (!dev)
 			return;
+		if (dev->hog && !dev->reconnect_id) {
+			bt_hid_notify_state(dev,
+						HAL_HIDHOST_STATE_DISCONNECTED);
+			bt_hog_detach(dev->hog);
+			dev->reconnect_id = g_idle_add(hog_reconnect, dev);
+			return;
+		}
 		goto fail;
 	}
 
-- 
1.9.3

