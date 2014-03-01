Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/7] android: Add flags parameter to register service command
Date: Sat,  1 Mar 2014 22:28:03 +0100
Message-Id: <1393709289-6395-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to configure daemon services.
---
 android/hal-a2dp.c      | 1 +
 android/hal-avrcp.c     | 1 +
 android/hal-bluetooth.c | 1 +
 android/hal-handsfree.c | 1 +
 android/hal-hidhost.c   | 1 +
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 1 +
 android/hal-pan.c       | 1 +
 8 files changed, 14 insertions(+)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index c898995..87d89a2 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -109,6 +109,7 @@ static bt_status_t init(btav_callbacks_t *callbacks)
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_A2DP;
+	cmd.flags = 0;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 46e25a0..4907f4a 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -220,6 +220,7 @@ static bt_status_t init(btrc_callbacks_t *callbacks)
 				sizeof(ev_handlers) / sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_AVRCP;
+	cmd.flags = 0;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 6871f5d..4b31ff1 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -442,6 +442,7 @@ static int init(bt_callbacks_t *callbacks)
 	}
 
 	cmd.service_id = HAL_SERVICE_ID_SOCKET;
+	cmd.flags = 0;
 
 	status = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 1b150c3..422f52c 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -212,6 +212,7 @@ static bt_status_t init(bthf_callbacks_t *callbacks)
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_HANDSFREE;
+	cmd.flags = 0;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index c758d2a..fe1b4df 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -354,6 +354,7 @@ static bt_status_t init(bthh_callbacks_t *callbacks)
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_HIDHOST;
+	cmd.flags = 0;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 1a19c80..f68324d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -124,12 +124,16 @@ Core Service (ID 0)
 	Opcode 0x01 - Register module command/response
 
 		Command parameters: Service id (1 octet)
+		                    Flags (1 octet)
 		Response parameters: <none>
 
 		In case a command is sent for an undeclared service ID, it will
 		be rejected. Also there will be no notifications for undeclared
 		service ID.
 
+		Flags parameter values should be defined as needed by
+		respective services.
+
 		In case of an error, the error response will be returned.
 
 	Opcode 0x02 - Unregister module command/response
@@ -749,6 +753,9 @@ Bluetooth Handsfree HAL (ID 5)
 
 Android HAL name: "handsfree" (BT_PROFILE_HANDSFREE_ID)
 
+	Service flags:               0x01 = Disable HSP AG
+	                             0x02 = Disable HFP AG
+
 	Opcode 0x00 - Error response
 
 		Response parameters: Status (1 octet)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 1e12868..e66043e 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -57,6 +57,7 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 #define HAL_OP_REGISTER_MODULE		0x01
 struct hal_cmd_register_module {
 	uint8_t service_id;
+	uint8_t flags;
 } __attribute__((packed));
 
 #define HAL_OP_UNREGISTER_MODULE	0x02
diff --git a/android/hal-pan.c b/android/hal-pan.c
index 5ee49ef..e6a351d 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -157,6 +157,7 @@ static bt_status_t pan_init(const btpan_callbacks_t *callbacks)
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_PAN;
+	cmd.flags = 0;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
-- 
1.8.5.3

