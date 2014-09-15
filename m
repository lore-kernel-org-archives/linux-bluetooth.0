Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/11] android/bluetooth: Use model name for default adapter name
Date: Mon, 15 Sep 2014 16:49:09 +0200
Message-Id: <1410792555-24765-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
References: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4646a6c..c7ccf9d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -88,8 +88,6 @@
 /* MPMD bit dependent on HFP AG support */
 #define MPS_MPMD_HFP_AG_DEP (1ULL << 6)
 
-#define DEFAULT_ADAPTER_NAME "BlueZ for Android"
-
 #define DUT_MODE_FILE "/sys/kernel/debug/bluetooth/hci%u/dut_mode"
 
 #define SETTINGS_FILE ANDROID_STORAGEDIR"/settings"
@@ -261,7 +259,11 @@ static void store_adapter_config(void)
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
 
@@ -3401,7 +3403,6 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	if (!bacmp(&adapter.bdaddr, BDADDR_ANY)) {
 		bacpy(&adapter.bdaddr, &rp->bdaddr);
-		adapter.name = g_strdup(DEFAULT_ADAPTER_NAME);
 		store_adapter_config();
 	} else if (bacmp(&adapter.bdaddr, &rp->bdaddr)) {
 		error("Bluetooth address mismatch");
@@ -3409,7 +3410,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 		goto failed;
 	}
 
-	if (g_strcmp0(adapter.name, (const char *) rp->name))
+	if (adapter.name && g_strcmp0(adapter.name, (const char *) rp->name))
 		set_adapter_name((uint8_t *)adapter.name, strlen(adapter.name));
 
 	set_adapter_class();
@@ -5250,6 +5251,12 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 		goto failed;
 	}
 
+	/* Set initial default name */
+	if (!adapter.name) {
+		adapter.name = g_strdup(bt_config_get_model());
+		set_adapter_name((uint8_t *)adapter.name, strlen(adapter.name));
+	}
+
 	hal_ipc = ipc;
 
 	ipc_register(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, cmd_handlers,
-- 
1.9.3

