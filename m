Return-Path: <cyrus@holtmann.org>
From: "Aj, SanthoshX" <santhoshx.aj@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Holtmann, Marcel" <marcel.holtmann@intel.com>,
	"Nair, Rashmi G" <rashmi.g.nair@intel.com>
Subject: [PATCH] Breaks in A2DP playback during device search
Date: Thu, 5 Jan 2012 04:39:18 +0000
Message-ID: <001F63875E1AF5428162B5A2D3ED1BDD8E98@IRSMSX101.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 8ecb4074305613a113d1c8dd220ab856c5f7ebc1 Mon Sep 17 00:00:00 2001
From: Santhosh <santhoshx.aj@intel.com>
Date: Wed, 4 Jan 2012 12:44:37 +0530
Subject: [PATCH] To change the latency of controller
 This change is done to fix the a2dp breaks as the IMC controller
 expects the latency to be set explicitly by calling HCI QoS setup

---
 audio/device.c         |    7 +++
 common/Android.mk      |    3 +-
 common/android_bluez.c |  111 ++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index 9662dec..3e30ea3 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -66,6 +66,9 @@
 #define AVDTP_CONNECT_TIMEOUT 1
 #define HEADSET_CONNECT_TIMEOUT 1
 
+#define QoS_LATENCY_12_MS 0x00002EE0  // 12 ms
+#define QoS_LATENCY_25_MS 0x000061A8  // 25 ms
+
 typedef enum {
 	AUDIO_STATE_DISCONNECTED,
 	AUDIO_STATE_CONNECTING,
@@ -341,6 +344,9 @@ static void device_sink_cb(struct audio_device *dev,
 
 	switch (new_state) {
 	case SINK_STATE_DISCONNECTED:
+#ifdef ANDROID
+		android_set_qos_latency(&dev->dst,QoS_LATENCY_25_MS);
+#endif
 		if (dev->control) {
 			device_remove_control_timer(dev);
 			avrcp_disconnect(dev);
@@ -368,6 +374,7 @@ static void device_sink_cb(struct audio_device *dev,
 			break;
 #ifdef ANDROID
 		android_set_high_priority(&dev->dst);
+		android_set_qos_latency(&dev->dst,QoS_LATENCY_12_MS);
 #endif
 		if (dev->auto_connect) {
 			if (!dev->headset)
diff --git a/common/Android.mk b/common/Android.mk
index 74c0bec..38d6b23 100644
--- a/common/Android.mk
+++ b/common/Android.mk
@@ -13,7 +13,8 @@ LOCAL_SRC_FILES:= \
 
 LOCAL_CFLAGS+= \
 	-O3 \
-	-DNEED_DBUS_WATCH_GET_UNIX_FD
+	-DNEED_DBUS_WATCH_GET_UNIX_FD \
+	-DBOARD_HAVE_BLUETOOTH_IMC
 
 ifeq ($(BOARD_HAVE_BLUETOOTH_BCM),true)
 LOCAL_CFLAGS += \
diff --git a/common/android_bluez.c b/common/android_bluez.c
index be85563..3f3b849 100644
--- a/common/android_bluez.c
+++ b/common/android_bluez.c
@@ -78,28 +78,6 @@ static int write_flush_timeout(int fd, uint16_t handle,
     return 0;
 }
 
-#ifdef BOARD_HAVE_BLUETOOTH_BCM
-static int vendor_high_priority(int fd, uint16_t handle) {
-    unsigned char hci_sleep_cmd[] = {
-        0x01,               // HCI command packet
-        0x57, 0xfc,         // HCI_Write_High_Priority_Connection
-        0x02,               // Length
-        0x00, 0x00          // Handle
-    };
-
-    hci_sleep_cmd[4] = (uint8_t)handle;
-    hci_sleep_cmd[5] = (uint8_t)(handle >> 8);
-
-    int ret = write(fd, hci_sleep_cmd, sizeof(hci_sleep_cmd));
-    if (ret < 0) {
-        error("write(): %s (%d)]", strerror(errno), errno);
-        return -1;
-    } else if (ret != sizeof(hci_sleep_cmd)) {
-        error("write(): unexpected length %d", ret);
-        return -1;
-    }
-    return 0;
-}
 
 static int get_hci_sock() {
     int sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
@@ -167,6 +145,30 @@ out:
     return ret;
 }
 
+
+#ifdef BOARD_HAVE_BLUETOOTH_BCM
+static int vendor_high_priority(int fd, uint16_t handle) {
+    unsigned char hci_sleep_cmd[] = {
+        0x01,               // HCI command packet
+        0x57, 0xfc,         // HCI_Write_High_Priority_Connection
+        0x02,               // Length
+        0x00, 0x00          // Handle
+    };
+
+    hci_sleep_cmd[4] = (uint8_t)handle;
+    hci_sleep_cmd[5] = (uint8_t)(handle >> 8);
+
+    int ret = write(fd, hci_sleep_cmd, sizeof(hci_sleep_cmd));
+    if (ret < 0) {
+        error("write(): %s (%d)]", strerror(errno), errno);
+        return -1;
+    } else if (ret != sizeof(hci_sleep_cmd)) {
+        error("write(): unexpected length %d", ret);
+        return -1;
+    }
+    return 0;
+}
+
 /* Request that the ACL link to a given Bluetooth connection be high priority,
  * for improved coexistance support
  */
@@ -202,3 +204,68 @@ int android_set_high_priority(bdaddr_t *ba) {
 }
 
 #endif
+
+#ifdef BOARD_HAVE_BLUETOOTH_IMC
+
+static int android_hci_qos_setup(int fd, uint16_t handle, uint32_t latency) {
+    unsigned char hci_qos_cmd[] = {
+ 
+	0x01, 					// HCI command packet
+	0x07, 0x08, 			// QoS Setup Command
+	0x14, 					// Length
+	0x00, 0x01, 			// Connection_Handle
+	0x00, 					//Flags
+	0x01, 					//Service_Type
+	0x00, 0x00, 0xE1, 0x00, //Token_Rate
+	0x00, 0x00, 0x00, 0x00, //Peak_Bandwidth
+	0xE0, 0x2E, 0x00, 0x00, //Latency 
+	0x00, 0x00, 0x00, 0x00	//Delay_Variation 
+	};
+
+    hci_qos_cmd[4] = (uint8_t)handle;
+    hci_qos_cmd[5] = (uint8_t)(handle >> 8);
+
+	hci_qos_cmd[16] = (uint8_t)latency;
+    hci_qos_cmd[17] = (uint8_t)(latency >> 8);
+	hci_qos_cmd[18] = (uint8_t)(latency >> 16);
+	hci_qos_cmd[19] = (uint8_t)(latency >> 24);
+	
+	int ret = write(fd, hci_qos_cmd, sizeof(hci_qos_cmd));
+    if (ret < 0) {
+        error("write(): %s (%d)]", strerror(errno), errno);
+        return -1;
+    } else if (ret != sizeof(hci_qos_cmd)) {
+        error("write(): unexpected length %d", ret);
+        return -1;
+    }
+    return 0;
+}
+
+int android_set_qos_latency(bdaddr_t *ba,  uint32_t latency) {
+	int ret;
+   	int fd = get_hci_sock();
+   	int acl_handle;
+	
+   if (fd < 0)
+	   return fd;
+
+   acl_handle = get_acl_handle(fd, ba);
+   if (acl_handle < 0) {
+	   ret = acl_handle;
+	   goto out;
+   }
+    ret = android_hci_qos_setup(fd, acl_handle, latency);
+    if (ret < 0)
+        goto out;
+   
+out:
+	   close(fd);
+   
+	   return ret;
+}
+#else
+int android_set_qos_latency(bdaddr_t *ba,  uint32_t latency) {
+    return 0;
+}
+#endif
+
-- 
1.7.0.4

