Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/bluetooth: Set major and minor class od device
Date: Thu,  9 Jan 2014 09:39:20 +0100
Message-Id: <1389256760-10832-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1389256760-10832-1-git-send-email-szymon.janc@tieto.com>
References: <1389256760-10832-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently this is hardcoded to Phone/Smartphone.
---
 android/bluetooth.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 6aad9b5..a43eecb 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -58,6 +58,9 @@
 #define DEVICE_ID_VENDOR	0x1d6b	/* Linux Foundation */
 #define DEVICE_ID_PRODUCT	0x0247	/* BlueZ for Android */
 
+#define ADAPTER_MAJOR_CLASS 0x02 /* Phone */
+#define ADAPTER_MINOR_CLASS 0x03 /* Smartphone */
+
 /* Default to DisplayYesNo */
 #define DEFAULT_IO_CAPABILITY 0x01
 
@@ -1703,6 +1706,26 @@ static void load_devices_info(bt_bluetooth_ready cb)
 	g_key_file_free(key_file);
 }
 
+static void set_adapter_class(void)
+{
+	struct mgmt_cp_set_dev_class cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	/*
+	 * kernel assign the major and minor numbers straight to dev_class[0]
+	 * and dev_class[1] without considering the proper bit shifting.
+	 */
+	cp.major = ADAPTER_MAJOR_CLASS & 0x1f;
+	cp.minor = ADAPTER_MINOR_CLASS << 2;
+
+	if (mgmt_send(mgmt_if, MGMT_OP_SET_DEV_CLASS, adapter.index,
+					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
+		return;
+
+	error("Failed to set class of device");
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -1747,6 +1770,8 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	if (g_strcmp0(adapter.name, (const char *) rp->name))
 		set_adapter_name((uint8_t *)adapter.name, strlen(adapter.name));
 
+	set_adapter_class();
+
 	/* Store adapter information */
 	adapter.dev_class = rp->dev_class[0] | (rp->dev_class[1] << 8) |
 						(rp->dev_class[2] << 16);
-- 
1.8.3.2

