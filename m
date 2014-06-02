Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] android/hidhost: Add support for HoG
Date: Mon,  2 Jun 2014 20:50:07 +0300
Message-Id: <1401731407-10352-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1401731407-10352-1-git-send-email-luiz.dentz@gmail.com>
References: <1401731407-10352-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables using hidhost HAL for LE devices since this is how HoG is
implemented in Android.
---
 android/hidhost.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/android/hidhost.c b/android/hidhost.c
index 4a158c6..b47c1cb 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -48,6 +48,9 @@
 #include "hal-msg.h"
 #include "ipc-common.h"
 #include "ipc.h"
+#include "bluetooth.h"
+#include "gatt.h"
+#include "hog.h"
 #include "hidhost.h"
 #include "utils.h"
 
@@ -77,11 +80,14 @@
 /* HID Virtual Cable Unplug */
 #define HID_VIRTUAL_CABLE_UNPLUG	0x05
 
+#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
+
 static bdaddr_t adapter_addr;
 
 static GIOChannel *ctrl_io = NULL;
 static GIOChannel *intr_io = NULL;
 static GSList *devices = NULL;
+static unsigned int hog_app = 0;
 
 static struct ipc *hal_ipc = NULL;
 
@@ -102,6 +108,7 @@ struct hid_device {
 	guint		intr_watch;
 	struct bt_uhid	*uhid;
 	uint8_t		last_hid_msg;
+	struct bt_hog	*hog;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -131,6 +138,9 @@ static void hid_device_free(void *data)
 	if (dev->uhid)
 		bt_uhid_unref(dev->uhid);
 
+	if (dev->hog)
+		bt_hog_unref(dev->hog);
+
 	g_free(dev->rd_data);
 	g_free(dev);
 }
@@ -722,6 +732,63 @@ fail:
 	hid_device_remove(dev);
 }
 
+static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
+{
+	GSList *l;
+	struct hid_device *dev;
+
+	l = g_slist_find_custom(devices, addr, device_cmp);
+	dev = l ? l->data : NULL;
+
+	if (err < 0) {
+		if (!dev)
+			return;
+		goto fail;
+	}
+
+	if (!dev) {
+		dev = g_new0(struct hid_device, 1);
+		bacpy(&dev->dst, addr);
+		devices = g_slist_append(devices, dev);
+		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTING);
+	}
+
+	if (!dev->hog) {
+		/* TODO: Get device details and primary */
+		dev->hog = bt_hog_new("bluez-input-device", dev->vendor,
+					dev->product, dev->version, NULL);
+		if (!dev->hog) {
+			error("HoG: unable to create session");
+			goto fail;
+		}
+	}
+
+	if (!bt_hog_attach(dev->hog, attrib)) {
+		error("HoG: unable to attach");
+		goto fail;
+	}
+
+	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTED);
+
+	return;
+
+fail:
+	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
+	hid_device_remove(dev);
+}
+
+static bool hog_connect(struct hid_device *dev)
+{
+	if (!hog_app) {
+		hog_app = bt_gatt_register_app(HOG_UUID, GATT_CLIENT,
+								hog_conn_cb);
+		if (!hog_app)
+			return false;
+	}
+
+	return bt_gatt_connect_app(hog_app, &dev->dst);
+}
+
 static void bt_hid_connect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_hidhost_connect *cmd = buf;
@@ -748,6 +815,14 @@ static void bt_hid_connect(const void *buf, uint16_t len)
 	ba2str(&dev->dst, addr);
 	DBG("connecting to %s", addr);
 
+	if (bt_is_device_le(&dst)) {
+		if (!hog_connect(dev)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+		goto done;
+	}
+
 	sdp_uuid16_create(&uuid, PNP_INFO_SVCLASS_ID);
 	if (bt_search_service(&adapter_addr, &dev->dst, &uuid,
 				hid_sdp_did_search_cb, dev, NULL, 0) < 0) {
@@ -757,6 +832,7 @@ static void bt_hid_connect(const void *buf, uint16_t len)
 		goto failed;
 	}
 
+done:
 	devices = g_slist_append(devices, dev);
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTING);
 
@@ -786,6 +862,13 @@ static void bt_hid_disconnect(const void *buf, uint16_t len)
 	}
 
 	dev = l->data;
+	if (dev->hog) {
+		if (!bt_gatt_disconnect_app(hog_app, &dst)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+		goto done;
+	}
 
 	/* Wait either channels to HUP */
 	if (dev->intr_io)
@@ -796,6 +879,8 @@ static void bt_hid_disconnect(const void *buf, uint16_t len)
 
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTING);
 
+
+done:
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-- 
1.9.0

