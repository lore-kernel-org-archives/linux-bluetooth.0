Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 5/6] android/bluetooth: Use system id for default adapter name
Date: Tue, 13 May 2014 19:09:20 +0200
Message-Id: <1400000961-24376-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com>
References: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 2a7c0e6..e8d6762 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -53,8 +53,6 @@
 #include "utils.h"
 #include "bluetooth.h"
 
-#define DEFAULT_ADAPTER_NAME "BlueZ for Android"
-
 #define DUT_MODE_FILE "/sys/kernel/debug/bluetooth/hci%u/dut_mode"
 
 #define SETTINGS_FILE ANDROID_STORAGEDIR"/settings"
@@ -189,7 +187,11 @@ static void store_adapter_config(void)
 	ba2str(&adapter.bdaddr, addr);
 
 	g_key_file_set_string(key_file, "General", "Address", addr);
-	g_key_file_set_string(key_file, "General", "Name", adapter.name);
+
+	if (adapter.name)
+		g_key_file_set_string(key_file, "General", "Name",
+				adapter.name);
+
 	g_key_file_set_integer(key_file, "General", "DiscoverableTimeout",
 						adapter.discoverable_timeout);
 
@@ -2413,7 +2415,6 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	if (!bacmp(&adapter.bdaddr, BDADDR_ANY)) {
 		bacpy(&adapter.bdaddr, &rp->bdaddr);
-		adapter.name = g_strdup(DEFAULT_ADAPTER_NAME);
 		store_adapter_config();
 	} else if (bacmp(&adapter.bdaddr, &rp->bdaddr)) {
 		error("Bluetooth address mismatch");
@@ -2421,7 +2422,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 		goto failed;
 	}
 
-	if (g_strcmp0(adapter.name, (const char *) rp->name))
+	if (adapter.name && g_strcmp0(adapter.name, (const char *) rp->name))
 		set_adapter_name((uint8_t *)adapter.name, strlen(adapter.name));
 
 	set_adapter_class();
@@ -4043,6 +4044,11 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 		return false;
 	}
 
+	if (!adapter.name) {
+		adapter.name = g_strdup(bt_config_get_system_id());
+		set_adapter_name((uint8_t *)adapter.name, strlen(adapter.name));
+	}
+
 	hal_ipc = ipc;
 
 	ipc_register(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, cmd_handlers,
-- 
1.9.1

