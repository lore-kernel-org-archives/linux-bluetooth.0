Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/6] android/daemon: Add handlers for auth_failed and connect_failed evt
Date: Fri,  1 Nov 2013 13:30:16 +0200
Message-Id: <1383305418-13619-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383305418-13619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383305418-13619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add debug prints in a case connection is failing
---
 android/adapter.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index df56452..bc4492b 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -643,6 +643,18 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
 }
 
+static void mgmt_connect_failed_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	DBG("");
+}
+
+static void mgmt_auth_failed_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	DBG("");
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->index,
@@ -683,6 +695,12 @@ static void register_mgmt_handlers(void)
 
 	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_CONNECTED, adapter->index,
 				mgmt_device_connected_event, NULL, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_CONNECT_FAILED, adapter->index,
+				mgmt_connect_failed_event, NULL, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_AUTH_FAILED, adapter->index,
+				mgmt_auth_failed_event, NULL, NULL);
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
-- 
1.7.10.4

