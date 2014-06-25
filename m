Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] android/hidhost: Add hid_device_new helper function
Date: Wed, 25 Jun 2014 12:09:25 +0300
Message-Id: <1403687366-18493-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hidhost.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index fdbe885..0c0d69d 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -155,6 +155,18 @@ static void hid_device_remove(struct hid_device *dev)
 	hid_device_free(dev);
 }
 
+static struct hid_device *hid_device_new(const bdaddr_t *addr)
+{
+	struct hid_device *dev;
+
+	dev = g_new0(struct hid_device, 1);
+	bacpy(&dev->dst, addr);
+	dev->state = HAL_HIDHOST_STATE_DISCONNECTED;
+	devices = g_slist_append(devices, dev);
+
+	return dev;
+}
+
 static bool hex2buf(const uint8_t *hex, uint8_t *buf, int buf_size)
 {
 	int i, j;
@@ -771,9 +783,7 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 	}
 
 	if (!dev) {
-		dev = g_new0(struct hid_device, 1);
-		bacpy(&dev->dst, addr);
-		devices = g_slist_append(devices, dev);
+		dev = hid_device_new(addr);
 		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTING);
 	}
 
@@ -839,15 +849,11 @@ static void bt_hid_connect(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	dev = g_new0(struct hid_device, 1);
-	bacpy(&dev->dst, &dst);
-	dev->state = HAL_HIDHOST_STATE_DISCONNECTED;
+	dev = hid_device_new(&dst);
 
 	ba2str(&dev->dst, addr);
 	DBG("connecting to %s", addr);
 
-	devices = g_slist_append(devices, dev);
-
 	if (bt_is_device_le(&dst)) {
 		if (!hog_connect(dev)) {
 			status = HAL_STATUS_FAILED;
@@ -1394,8 +1400,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		if (l)
 			return;
 
-		dev = g_new0(struct hid_device, 1);
-		bacpy(&dev->dst, &dst);
+		dev = hid_device_new(&dst);
 		dev->ctrl_io = g_io_channel_ref(chan);
 
 		sdp_uuid16_create(&uuid, PNP_INFO_SVCLASS_ID);
@@ -1406,8 +1411,6 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 			return;
 		}
 
-		devices = g_slist_append(devices, dev);
-
 		dev->ctrl_watch = g_io_add_watch(dev->ctrl_io,
 					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 					ctrl_watch_cb, dev);
-- 
1.9.3

