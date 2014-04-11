Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/6] android/bluetooth: Send device properties in single notification
Date: Fri, 11 Apr 2014 09:41:24 +0200
Message-Id: <1397202087-1203-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
References: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reduces number of IPC calls while enabling Bluetooth.
---
 android/bluetooth.c | 64 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index f7bf979..401c35d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3373,16 +3373,60 @@ static uint8_t get_device_timestamp(struct device *dev)
 
 static void get_remote_device_props(struct device *dev)
 {
-	/* TODO should be done in single notification */
-	get_device_friendly_name(dev);
-	get_device_name(dev);
-	get_device_uuids(dev);
-	get_device_class(dev);
-	get_device_type(dev);
-	get_device_service_rec(dev);
-	get_device_rssi(dev);
-	get_device_version_info(dev);
-	get_device_timestamp(dev);
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_remote_device_props *ev = (void *) buf;
+	uint128_t uuids[g_slist_length(dev->uuids)];
+	uint8_t android_type;
+	int size, i;
+	GSList *l;
+
+	memset(buf, 0, sizeof(buf));
+
+	size = sizeof(*ev);
+
+	ev->status = HAL_STATUS_SUCCESS;
+	bdaddr2android(&dev->bdaddr, ev->bdaddr);
+
+	android_type = get_device_android_type(dev);
+	size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_TYPE,
+					sizeof(android_type), &android_type);
+	ev->num_props++;
+
+	size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_CLASS,
+					sizeof(dev->class), &dev->class);
+	ev->num_props++;
+
+	if (dev->rssi) {
+		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_RSSI,
+						sizeof(dev->rssi), &dev->rssi);
+		ev->num_props++;
+	}
+
+	size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_NAME,
+						strlen(dev->name), dev->name);
+	ev->num_props++;
+
+	if (dev->friendly_name) {
+		size += fill_hal_prop(buf + size,
+					HAL_PROP_DEVICE_FRIENDLY_NAME,
+					strlen(dev->friendly_name),
+					dev->friendly_name);
+		ev->num_props++;
+	}
+
+	for (i = 0, l = dev->uuids; l; l = g_slist_next(l), i++)
+		memcpy(&uuids[i], l->data, sizeof(uint128_t));
+
+	size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_UUIDS, sizeof(uuids),
+									uuids);
+	ev->num_props++;
+
+	size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_TIMESTAMP,
+				sizeof(dev->timestamp), &dev->timestamp);
+	ev->num_props++;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+					HAL_EV_REMOTE_DEVICE_PROPS, size, buf);
 }
 
 static void send_bonded_devices_props(void)
-- 
1.9.1

