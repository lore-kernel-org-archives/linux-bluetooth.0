Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 3/8] android/bluetooth: Refactor start/stop discovery
Date: Thu, 13 Mar 2014 19:46:10 +0100
Message-ID: <1394736375-22599-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

Pass discovery type to discovery stop/start routine so it can be used
also for LE only scan.
---
 android/bluetooth.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index acd2dd2..8f66dd1 100644
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
@@ -2448,17 +2452,26 @@ static void get_adapter_properties(void)
 	get_adapter_discoverable_timeout();
 }
 
-static bool start_discovery(void)
+static uint8_t get_adapter_discovering_type(void)
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
 
@@ -2478,17 +2491,11 @@ static void cancel_pending_confirm_name(gpointer data, gpointer user_data)
 	dev->confirm_id = 0;
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
 
@@ -3182,7 +3189,7 @@ static void handle_start_discovery_cmd(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	if (!start_discovery()) {
+	if (!start_discovery(SCAN_TYPE_DUAL)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
@@ -3207,7 +3214,7 @@ static void handle_cancel_discovery_cmd(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	if (!stop_discovery()) {
+	if (!stop_discovery(SCAN_TYPE_DUAL)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
-- 
1.8.4

