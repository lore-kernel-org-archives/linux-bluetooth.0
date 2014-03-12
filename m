Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/4] android/bluetooth: Refactor start/stop discovery
Date: Wed, 12 Mar 2014 15:43:52 +0100
Message-Id: <1394635435-26646-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394635435-26646-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394635435-26646-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pass discovery type to discovery stop/start routine so it can be used
also for LE only scan.
---
 android/bluetooth.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index f2b9321..e614883 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -80,6 +80,10 @@
 #define BASELEN_REMOTE_DEV_PROP (sizeof(struct hal_ev_remote_device_props) \
 					+ sizeof(struct hal_property))
 
+#define SCAN_TYPE_BREDR (1 << BDADDR_BREDR)
+#define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
+#define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE)
+
 struct device {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
@@ -2417,17 +2421,26 @@ static void get_adapter_properties(void)
 	get_adapter_discoverable_timeout();
 }
 
-static bool start_discovery(void)
+static uint8_t get_adapter_discovering_type()
 {
-	struct mgmt_cp_start_discovery cp;
+	uint8_t type;
 
 	if (adapter.current_settings & MGMT_SETTING_BREDR)
-		cp.type = 1 << BDADDR_BREDR;
+		type = SCAN_TYPE_BREDR;
 	else
-		cp.type = 0;
+		type = 0;
 
 	if (adapter.current_settings & MGMT_SETTING_LE)
-		cp.type |= (1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM);
+		type |= SCAN_TYPE_LE;
+
+	return type;
+}
+
+static bool start_discovery(uint8_t type)
+{
+	struct mgmt_cp_start_discovery cp;
+
+	cp.type = get_adapter_discovering_type() & type;
 
 	DBG("type=0x%x", cp.type);
 
@@ -2439,17 +2452,11 @@ static bool start_discovery(void)
 	return false;
 }
 
-static bool stop_discovery(void)
+static bool stop_discovery(uint8_t type)
 {
 	struct mgmt_cp_stop_discovery cp;
 
-	if (adapter.current_settings & MGMT_SETTING_BREDR)
-		cp.type = 1 << BDADDR_BREDR;
-	else
-		cp.type = 0;
-
-	if (adapter.current_settings & MGMT_SETTING_LE)
-		cp.type |= (1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM);
+	cp.type = get_adapter_discovering_type() & type;
 
 	DBG("type=0x%x", cp.type);
 
@@ -3140,7 +3147,7 @@ static void handle_start_discovery_cmd(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	if (!start_discovery()) {
+	if (!start_discovery(SCAN_TYPE_DUAL)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
@@ -3165,7 +3172,7 @@ static void handle_cancel_discovery_cmd(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	if (!stop_discovery()) {
+	if (!stop_discovery(SCAN_TYPE_DUAL)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
-- 
1.9.0

