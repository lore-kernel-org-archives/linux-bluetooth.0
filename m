Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] android/hal-gatt: Add support for server MTU changed callback
Date: Wed, 11 Mar 2015 15:41:22 +0100
Message-Id: <1426084883-10291-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1426084883-10291-1-git-send-email-szymon.janc@tieto.com>
References: <1426084883-10291-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-gatt.c | 13 +++++++++++++
 android/hal-msg.h  |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 438ad61..f7217c7 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -641,6 +641,16 @@ static void handle_server_congestion(void *buf, uint16_t len, int fd)
 #endif
 }
 
+static void handle_server_mtu_changed(void *buf, uint16_t len, int fd)
+{
+#if ANDROID_VERSION >= PLATFORM_VER(5, 1, 0)
+	struct hal_ev_gatt_server_mtu_changed *ev = buf;
+
+	if (cbs->server->mtu_changed_cb)
+		cbs->server->mtu_changed_cb(ev->conn_id, ev->mtu);
+#endif
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -784,6 +794,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_GATT_SERVER_CONGESTION */
 	{ handle_server_congestion, false,
 		sizeof(struct hal_ev_gatt_server_congestion) },
+	/* HAL_EV_GATT_SERVER_MTU_CHANGED */
+	{ handle_server_mtu_changed, false,
+		sizeof(struct hal_ev_gatt_server_mtu_changed) },
 	};
 
 /* Client API */
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0ec07c7..698f45a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -2092,6 +2092,12 @@ struct hal_ev_gatt_server_congestion {
 	uint8_t congested;
 } __attribute__((packed));
 
+#define HAL_EV_GATT_SERVER_MTU_CHANGED		0xb0
+struct hal_ev_gatt_server_mtu_changed {
+	int32_t conn_id;
+	int32_t mtu;
+} __attribute__((packed));
+
 #define HAL_GATT_PERMISSION_READ			0x0001
 #define HAL_GATT_PERMISSION_READ_ENCRYPTED		0x0002
 #define HAL_GATT_PERMISSION_READ_ENCRYPTED_MITM		0x0004
-- 
1.9.3

