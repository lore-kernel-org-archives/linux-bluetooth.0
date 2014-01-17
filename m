Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 2/6] android/hal: Update property used for start/stop services
Date: Fri, 17 Jan 2014 16:30:42 +0100
Message-Id: <1389972646-3761-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1389972646-3761-1-git-send-email-szymon.janc@tieto.com>
References: <1389972646-3761-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 13 +++++--------
 android/hal-ipc.c       |  5 ++---
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index be45836..4f0e7b7 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -28,8 +28,6 @@
 #include "hal-ipc.h"
 #include "hal-utils.h"
 
-#define SNOOP_SERVICE_NAME "bluetoothd-snoop"
-
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
 #define enum_prop_to_hal(prop, hal_prop, type) do { \
@@ -820,15 +818,14 @@ static int le_test_mode(uint16_t opcode, uint8_t *buf, uint8_t len)
 
 static int config_hci_snoop_log(uint8_t enable)
 {
+	const char *property;
+
 	DBG("enable %u", enable);
 
-	if (enable && property_set("ctl.start", SNOOP_SERVICE_NAME) < 0) {
-		error("Failed to start service %s", SNOOP_SERVICE_NAME);
-		return BT_STATUS_FAIL;
-	}
+	property = enable ? "bluetooth.start" : "bluetooth.stop";
 
-	if (!enable && property_set("ctl.stop", SNOOP_SERVICE_NAME) < 0) {
-		error("Failed to stop service %s", SNOOP_SERVICE_NAME);
+	if (property_set(property, "snoop") < 0) {
+		error("Failed to set %s=snoop", property);
 		return BT_STATUS_FAIL;
 	}
 
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 97f1bcd..99ba38e 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -34,7 +34,6 @@
 #include "hal-ipc.h"
 
 #define CONNECT_TIMEOUT (5 * 1000)
-#define SERVICE_NAME "bluetoothd"
 
 static int cmd_sk = -1;
 static int notif_sk = -1;
@@ -259,8 +258,8 @@ bool hal_ipc_init(void)
 	}
 
 	/* Start Android Bluetooth daemon service */
-	if (property_set("ctl.start", SERVICE_NAME) < 0) {
-		error("Failed to start service %s", SERVICE_NAME);
+	if (property_set("bluetooth.start", "daemon") < 0) {
+		error("Failed to set bluetooth.start=daemon");
 		close(sk);
 		return false;
 	}
-- 
1.8.3.2

