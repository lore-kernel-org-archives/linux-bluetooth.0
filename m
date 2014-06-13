Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/11] android/hidhost: Add support for re-connecting HoG
Date: Fri, 13 Jun 2014 14:33:57 +0300
Message-Id: <1402659239-26558-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402659239-26558-1-git-send-email-luiz.dentz@gmail.com>
References: <1402659239-26558-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Once HoG disconnects scanning should be turned on so that once the
device starts advertising again it should connected automatically.
---
 android/hidhost.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/android/hidhost.c b/android/hidhost.c
index b8b36a9..846dd57 100644
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

