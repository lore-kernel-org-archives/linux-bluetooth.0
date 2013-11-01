Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 5/8] android/daemon: Add debug handlers for unhandled mgmt event
Date: Fri,  1 Nov 2013 15:41:42 +0200
Message-Id: <1383313305-9442-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add debug prints to some mgmt events.
---
 android/adapter.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 5a5fa2e..299a025 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -651,6 +651,24 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
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
+static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	DBG("");
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->index,
@@ -691,6 +709,15 @@ static void register_mgmt_handlers(void)
 
 	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_CONNECTED, adapter->index,
 				mgmt_device_connected_event, NULL, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_CONNECT_FAILED, adapter->index,
+				mgmt_connect_failed_event, NULL, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_AUTH_FAILED, adapter->index,
+				mgmt_auth_failed_event, NULL, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_UNPAIRED, adapter->index,
+				mgmt_device_unpaired_event, NULL, NULL);
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
-- 
1.7.10.4

