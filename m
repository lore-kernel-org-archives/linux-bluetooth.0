Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android: Fix type of discovery on start/stop discovery
Date: Fri, 7 Mar 2014 11:28:29 +0100
Message-ID: <1394188110-16336-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Discovering type was confused with adapter settings. With this patch it
is fixed
---
 android/bluetooth.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 1101b64..6d08a50 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2408,14 +2408,13 @@ static void get_adapter_properties(void)
 static bool start_discovery(void)
 {
 	struct mgmt_cp_start_discovery cp;
-	uint8_t type = 1 << BDADDR_BREDR;
 
-	if (adapter.current_settings & type)
-		cp.type = type;
+	if (adapter.current_settings & MGMT_SETTING_BREDR)
+		cp.type = 1 << BDADDR_BREDR;
 	else
 		cp.type = 0;
 
-	DBG("type=0x%x", type);
+	DBG("type=0x%x", cp.type);
 
 	if (mgmt_send(mgmt_if, MGMT_OP_START_DISCOVERY, adapter.index,
 					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
@@ -2428,14 +2427,13 @@ static bool start_discovery(void)
 static bool stop_discovery(void)
 {
 	struct mgmt_cp_stop_discovery cp;
-	uint8_t type = 1 << BDADDR_BREDR;
 
-	if (adapter.current_settings & type)
-		cp.type = type;
+	if (adapter.current_settings & MGMT_SETTING_BREDR)
+		cp.type = 1 << BDADDR_BREDR;
 	else
 		cp.type = 0;
 
-	DBG("type=0x%x", type);
+	DBG("type=0x%x", cp.type);
 
 	if (mgmt_send(mgmt_if, MGMT_OP_STOP_DISCOVERY, adapter.index,
 					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
-- 
1.8.4

