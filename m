Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] android/hal-bluetooth: Add support for enabling HCI snoop dump
Date: Fri, 20 Dec 2013 11:25:37 +0100
Message-Id: <1387535140-6223-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
References: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to enable HCI SNOOP dump from HAL. This requires that
service named 'bluetoothd_snoop' be available in Android system.
---
 android/cutils/properties.h |  1 +
 android/hal-bluetooth.c     | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/android/cutils/properties.h b/android/cutils/properties.h
index 7951585..256bf13 100644
--- a/android/cutils/properties.h
+++ b/android/cutils/properties.h
@@ -14,6 +14,7 @@
  * limitations under the License.
  */
 
+#include <unistd.h>
 #include <stdio.h>
 #include <string.h>
 #include <sys/socket.h>
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 11f2a9f..905b293 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -20,12 +20,16 @@
 #include <stdbool.h>
 #include <string.h>
 
+#include <cutils/properties.h>
+
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
 #include "hal-ipc.h"
 #include "hal-utils.h"
 
+#define SNOOP_SERVICE_NAME "bluetoothd_snoop"
+
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
 #define enum_prop_to_hal(prop, hal_prop, type) do { \
@@ -791,6 +795,23 @@ static int le_test_mode(uint16_t opcode, uint8_t *buf, uint8_t len)
 }
 #endif
 
+#if PLATFORM_SDK_VERSION > 18
+static int config_hci_snoop_log(uint8_t enable)
+{
+	if (enable && property_set("ctl.start", SNOOP_SERVICE_NAME) < 0) {
+		error("Failed to start service %s", SNOOP_SERVICE_NAME);
+		return BT_STATUS_FAIL;
+	}
+
+	if (!enable && property_set("ctl.stop", SNOOP_SERVICE_NAME) < 0) {
+		error("Failed to stop service %s", SNOOP_SERVICE_NAME);
+		return BT_STATUS_FAIL;
+	}
+
+	return BT_STATUS_SUCCESS;
+}
+#endif
+
 static const bt_interface_t bluetooth_if = {
 	.size = sizeof(bt_interface_t),
 	.init = init,
@@ -818,6 +839,9 @@ static const bt_interface_t bluetooth_if = {
 #if PLATFORM_SDK_VERSION > 17
 	.le_test_mode = le_test_mode,
 #endif
+#if PLATFORM_SDK_VERSION > 18
+	.config_hci_snoop_log = config_hci_snoop_log,
+#endif
 };
 
 static const bt_interface_t *get_bluetooth_interface(void)
-- 
1.8.3.2

