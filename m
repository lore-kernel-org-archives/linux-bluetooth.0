Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] android/handsfree: Add support for new API for handsfree init
Date: Wed,  5 Nov 2014 16:38:45 +0200
Message-Id: <1415198333-7775-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add max_client parameter to IPC following new parameter for HF init().
---
 android/hal-handsfree.c | 15 ++++++++++++++-
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  1 +
 android/handsfree.c     |  5 ++++-
 android/handsfree.h     |  3 ++-
 android/main.c          |  3 ++-
 6 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 0c51789..c575d2b 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -226,7 +226,7 @@ static uint8_t get_mode(void)
 	return HAL_MODE_HANDSFREE_HSP_ONLY;
 }
 
-static bt_status_t init(bthf_callbacks_t *callbacks)
+static bt_status_t init_real(bthf_callbacks_t *callbacks, int max_hf_clients)
 {
 	struct hal_cmd_register_module cmd;
 	int ret;
@@ -243,6 +243,7 @@ static bt_status_t init(bthf_callbacks_t *callbacks)
 
 	cmd.service_id = HAL_SERVICE_ID_HANDSFREE;
 	cmd.mode = get_mode();
+	cmd.max_clients = max_hf_clients;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
@@ -255,6 +256,18 @@ static bt_status_t init(bthf_callbacks_t *callbacks)
 	return ret;
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static bt_status_t init(bthf_callbacks_t *callbacks, int max_hf_clients)
+{
+	return init_real(callbacks, max_hf_clients);
+}
+#else
+static bt_status_t init(bthf_callbacks_t *callbacks)
+{
+	return init_real(callbacks, 1);
+}
+#endif
+
 static bt_status_t handsfree_connect(bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_handsfree_connect cmd;
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 1bb591a..a9d4c8b 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -128,6 +128,7 @@ Core Service (ID 0)
 
 		Command parameters: Service id (1 octet)
 		                    Mode (1 octet)
+		                    Max Clients (4 octets)
 		Response parameters: <none>
 
 		In case a command is sent for an undeclared service ID, it will
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 1876d6b..b5a4125 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -64,6 +64,7 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 struct hal_cmd_register_module {
 	uint8_t service_id;
 	uint8_t mode;
+	int32_t max_clients;
 } __attribute__((packed));
 
 #define HAL_OP_UNREGISTER_MODULE	0x02
diff --git a/android/handsfree.c b/android/handsfree.c
index 3aa4522..3bf42f1 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2901,7 +2901,8 @@ static bool bt_sco_register(ipc_disconnect_cb disconnect)
 	return true;
 }
 
-bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
+bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode,
+								int max_clients)
 {
 	DBG("mode 0x%x", mode);
 
@@ -2920,6 +2921,8 @@ bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 	if (mode == HAL_MODE_HANDSFREE_HSP_ONLY)
 		goto done;
 
+	/* TODO: Handle max_clients argument */
+
 	hfp_ag_features = HFP_AG_FEATURES;
 
 	if (mode == HAL_MODE_HANDSFREE_HFP_WBS)
diff --git a/android/handsfree.h b/android/handsfree.h
index e5eff47..d4fd649 100644
--- a/android/handsfree.h
+++ b/android/handsfree.h
@@ -21,5 +21,6 @@
  *
  */
 
-bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
+bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode,
+							int max_clients);
 void bt_handsfree_unregister(void);
diff --git a/android/main.c b/android/main.c
index b5f6937..58dd9ab 100644
--- a/android/main.c
+++ b/android/main.c
@@ -209,7 +209,8 @@ static void service_register(const void *buf, uint16_t len)
 
 		break;
 	case HAL_SERVICE_ID_HANDSFREE:
-		if (!bt_handsfree_register(hal_ipc, &adapter_bdaddr, m->mode)) {
+		if (!bt_handsfree_register(hal_ipc, &adapter_bdaddr, m->mode,
+							m->max_clients)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
-- 
1.9.1

