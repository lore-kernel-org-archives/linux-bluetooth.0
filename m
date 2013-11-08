Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] android: Register DeviceID record when adapter is initialized
Date: Fri, 8 Nov 2013 13:21:24 +0100
Message-ID: <1383913284-4032-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383913284-4032-1-git-send-email-szymon.janc@tieto.com>
References: <1383913284-4032-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register DeviceID SDP record and update local UUIDs after DeviceID
information is passed to kernel.
---
 android/adapter.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 8c4fe76..37ba988 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -47,6 +47,10 @@
 #include "utils.h"
 #include "adapter.h"
 
+#define DEVICE_ID_SOURCE	0x0002	/* USB */
+#define DEVICE_ID_VENDOR	0x1d6b	/* Linux Foundation */
+#define DEVICE_ID_PRODUCT	0x0247	/* BlueZ for Android */
+
 /* Default to DisplayYesNo */
 #define DEFAULT_IO_CAPABILITY 0x01
 /* Default discoverable timeout 120sec as in Android */
@@ -1184,20 +1188,28 @@ static void set_device_id(void)
 {
 	struct mgmt_cp_set_device_id cp;
 	uint8_t major, minor;
+	uint16_t version;
 
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
 		return;
 
+	version = major << 8 | minor;
+
 	memset(&cp, 0, sizeof(cp));
-	cp.source = htobs(0x0002);		/* USB */
-	cp.vendor = htobs(0x1d6b);		/* Linux Foundation */
-	cp.product = htobs(0x0247);		/* BlueZ for Android */
-	cp.version = htobs(major << 8 | minor);
+	cp.source = htobs(DEVICE_ID_SOURCE);
+	cp.vendor = htobs(DEVICE_ID_VENDOR);
+	cp.product = htobs(DEVICE_ID_PRODUCT);
+	cp.version = htobs(version);
 
 	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_DEVICE_ID,
 				adapter->index, sizeof(cp), &cp,
 				NULL, NULL, NULL) == 0)
 		error("Failed to set device id");
+
+	register_device_id(DEVICE_ID_SOURCE, DEVICE_ID_VENDOR,
+						DEVICE_ID_PRODUCT, version);
+
+	bt_adapter_add_record(PNPID_UUID, sdp_record_find(0x10000), 0x00);
 }
 
 static void set_adapter_name_complete(uint8_t status, uint16_t length,
-- 
1.8.4.2

