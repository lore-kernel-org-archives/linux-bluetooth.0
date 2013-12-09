Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 7/8] android/bluetooth: Add send_device_property helper function
Date: Mon,  9 Dec 2013 16:14:08 +0100
Message-Id: <1386602049-5533-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386602049-5533-1-git-send-email-szymon.janc@tieto.com>
References: <1386602049-5533-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remote device property notification will be send from multiple places
so it make sense to have helper for that. This will be especially
usefull for 'simple' properties.
---
 android/bluetooth.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 7528921..fd69c86 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -557,26 +557,27 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 
 	browse_remote_sdp(&addr->bdaddr);
 }
-
-static uint8_t get_device_name(struct device *dev)
+static  void send_device_property(const bdaddr_t *bdaddr, uint8_t type,
+						uint16_t len, const void *val)
 {
-	struct hal_ev_remote_device_props *ev;
-	size_t ev_len;
-
-	ev_len = BASELEN_REMOTE_DEV_PROP + strlen(dev->name);
-	ev = g_malloc0(ev_len);
+	uint8_t buf[BASELEN_REMOTE_DEV_PROP + len];
+	struct hal_ev_remote_device_props *ev = (void *) buf;
 
 	ev->status = HAL_STATUS_SUCCESS;
-	bdaddr2android(&dev->bdaddr, ev->bdaddr);
+	bdaddr2android(bdaddr, ev->bdaddr);
 	ev->num_props = 1;
-	ev->props[0].type = HAL_PROP_DEVICE_NAME;
-	ev->props[0].len = strlen(dev->name);
-	memcpy(&ev->props[0].val, dev->name, strlen(dev->name));
+	ev->props[0].type = type;
+	ev->props[0].len = len;
+	memcpy(ev->props[0].val, val, len);
 
 	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_REMOTE_DEVICE_PROPS,
-								ev_len, ev);
+							sizeof(buf), buf);
+}
 
-	g_free(ev);
+static uint8_t get_device_name(struct device *dev)
+{
+	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_NAME,
+						strlen(dev->name), dev->name);
 
 	return HAL_STATUS_SUCCESS;
 }
-- 
1.8.3.2

