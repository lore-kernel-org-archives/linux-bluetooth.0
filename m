Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 4/8] android/bluetooth: Move start discovery function up in the file
Date: Thu, 13 Mar 2014 19:46:11 +0100
Message-ID: <1394736375-22599-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

This is needed for next patch
---
 android/bluetooth.c | 62 ++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 8f66dd1..a28fb01 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -999,6 +999,37 @@ static void clear_device_found(gpointer data, gpointer user_data)
 	dev->found = false;
 }
 
+static uint8_t get_adapter_discovering_type(void)
+{
+	uint8_t type;
+
+	if (adapter.current_settings & MGMT_SETTING_BREDR)
+		type = SCAN_TYPE_BREDR;
+	else
+		type = 0;
+
+	if (adapter.current_settings & MGMT_SETTING_LE)
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
+
+	DBG("type=0x%x", cp.type);
+
+	if (mgmt_send(mgmt_if, MGMT_OP_START_DISCOVERY, adapter.index,
+				sizeof(cp), &cp, NULL, NULL, NULL) > 0)
+		return true;
+
+	error("Failed to start discovery");
+	return false;
+}
+
 static void mgmt_discovering_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -2452,37 +2483,6 @@ static void get_adapter_properties(void)
 	get_adapter_discoverable_timeout();
 }
 
-static uint8_t get_adapter_discovering_type(void)
-{
-	uint8_t type;
-
-	if (adapter.current_settings & MGMT_SETTING_BREDR)
-		type = SCAN_TYPE_BREDR;
-	else
-		type = 0;
-
-	if (adapter.current_settings & MGMT_SETTING_LE)
-		type |= SCAN_TYPE_LE;
-
-	return type;
-}
-
-static bool start_discovery(uint8_t type)
-{
-	struct mgmt_cp_start_discovery cp;
-
-	cp.type = get_adapter_discovering_type() & type;
-
-	DBG("type=0x%x", cp.type);
-
-	if (mgmt_send(mgmt_if, MGMT_OP_START_DISCOVERY, adapter.index,
-					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
-		return true;
-
-	error("Failed to start discovery");
-	return false;
-}
-
 static void cancel_pending_confirm_name(gpointer data, gpointer user_data)
 {
 	struct device *dev = data;
-- 
1.8.4

