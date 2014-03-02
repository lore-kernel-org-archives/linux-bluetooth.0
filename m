Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 2/8] android/hal: Update services register commands with mode parameter
Date: Mon,  3 Mar 2014 00:50:43 +0100
Message-Id: <1393804249-12392-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
References: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-a2dp.c      | 1 +
 android/hal-avrcp.c     | 1 +
 android/hal-bluetooth.c | 1 +
 android/hal-handsfree.c | 1 +
 android/hal-hidhost.c   | 1 +
 android/hal-msg.h       | 3 +++
 android/hal-pan.c       | 1 +
 7 files changed, 9 insertions(+)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index c898995..ac495a1 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -109,6 +109,7 @@ static bt_status_t init(btav_callbacks_t *callbacks)
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_A2DP;
+	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 46e25a0..a720a1e 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -220,6 +220,7 @@ static bt_status_t init(btrc_callbacks_t *callbacks)
 				sizeof(ev_handlers) / sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_AVRCP;
+	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 6871f5d..832183e 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -442,6 +442,7 @@ static int init(bt_callbacks_t *callbacks)
 	}
 
 	cmd.service_id = HAL_SERVICE_ID_SOCKET;
+	cmd.mode = HAL_MODE_DEFAULT;
 
 	status = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 1b150c3..7a28e0f 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -212,6 +212,7 @@ static bt_status_t init(bthf_callbacks_t *callbacks)
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_HANDSFREE;
+	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index c758d2a..16253e3 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -354,6 +354,7 @@ static bt_status_t init(bthh_callbacks_t *callbacks)
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_HIDHOST;
+	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 7b6e46d..8eb97c3 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -54,9 +54,12 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 
 #define HAL_OP_STATUS			IPC_OP_STATUS
 
+#define HAL_MODE_DEFAULT		0x00
+
 #define HAL_OP_REGISTER_MODULE		0x01
 struct hal_cmd_register_module {
 	uint8_t service_id;
+	uint8_t mode;
 } __attribute__((packed));
 
 #define HAL_OP_UNREGISTER_MODULE	0x02
diff --git a/android/hal-pan.c b/android/hal-pan.c
index 5ee49ef..f383081 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -157,6 +157,7 @@ static bt_status_t pan_init(const btpan_callbacks_t *callbacks)
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_PAN;
+	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
-- 
1.8.5.3

