Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/bluetooth: Set default adapter name on first start
Date: Thu,  9 Jan 2014 09:39:19 +0100
Message-Id: <1389256760-10832-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On first start always set name to default name. Adapter name is
updated on start only if current name is different.
---
 android/bluetooth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 9da988b..6aad9b5 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -50,6 +50,8 @@
 #include "utils.h"
 #include "bluetooth.h"
 
+#define DEFAULT_ADAPTER_NAME "BlueZ for Android"
+
 #define DUT_MODE_FILE "/sys/kernel/debug/bluetooth/hci%u/dut_mode"
 
 #define DEVICE_ID_SOURCE	0x0002	/* USB */
@@ -1734,15 +1736,17 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	if (!bacmp(&adapter.bdaddr, BDADDR_ANY)) {
 		bacpy(&adapter.bdaddr, &rp->bdaddr);
-		adapter.name = g_strdup((const char *) rp->name);
+		adapter.name = g_strdup(DEFAULT_ADAPTER_NAME);
 		store_adapter_config();
-		set_adapter_name(rp->name, strlen((char *)rp->name));
 	} else if (bacmp(&adapter.bdaddr, &rp->bdaddr)) {
 		error("Bluetooth address mismatch");
 		err = -ENODEV;
 		goto failed;
 	}
 
+	if (g_strcmp0(adapter.name, (const char *) rp->name))
+		set_adapter_name((uint8_t *)adapter.name, strlen(adapter.name));
+
 	/* Store adapter information */
 	adapter.dev_class = rp->dev_class[0] | (rp->dev_class[1] << 8) |
 						(rp->dev_class[2] << 16);
-- 
1.8.3.2

