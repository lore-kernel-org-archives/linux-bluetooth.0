Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/gatt: Implement get device type command
Date: Sat, 26 Apr 2014 17:26:14 +0200
Message-Id: <1398525974-3672-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1398525974-3672-1-git-send-email-szymon.janc@tieto.com>
References: <1398525974-3672-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c    | 13 +++++++++++--
 android/hal-msg.h |  4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8c7909a..0355af1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2972,10 +2972,19 @@ failed:
 
 static void handle_client_get_device_type(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_get_device_type *cmd = buf;
+	struct hal_rsp_gatt_client_get_device_type rsp;
+	bdaddr_t bdaddr;
+
 	DBG("");
 
-	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_GET_DEVICE_TYPE, HAL_STATUS_FAILED);
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+
+	rsp.type = bt_get_device_android_type(&bdaddr);
+
+	ipc_send_rsp_full(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_GET_DEVICE_TYPE,
+					sizeof(rsp), &rsp, -1);
 }
 
 static void handle_client_set_adv_data(const void *buf, uint16_t len)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 52ecafb..9d28866 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -730,6 +730,10 @@ struct hal_cmd_gatt_client_get_device_type {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+struct hal_rsp_gatt_client_get_device_type {
+	uint8_t type;
+} __attribute__((packed));
+
 #define HAL_OP_GATT_CLIENT_SET_ADV_DATA		0x015
 struct hal_cmd_gatt_client_set_adv_data {
 	int32_t  server_if;
-- 
1.9.0

