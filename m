Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/3] android/bluetooth: Add unpaired device callback
Date: Thu, 28 Aug 2014 10:37:20 +0200
Message-Id: <1409215042-11313-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409215042-11313-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409215042-11313-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT, HID, HOG, might be interested in the fact that some device has
been unpaired in order to clear cache or similar. This patch adds means
to register callback for unpaired event.
---
 android/bluetooth.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 android/bluetooth.h |  3 +++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 984ecba..e2a97a8 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -41,6 +41,7 @@
 #include "lib/uuid.h"
 #include "src/shared/util.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/queue.h"
 #include "src/eir.h"
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
@@ -223,6 +224,8 @@ static struct ipc *hal_ipc = NULL;
 
 static bool kernel_conn_control = false;
 
+static struct queue *unpaired_cb_list;
+
 static void get_device_android_addr(struct device *dev, uint8_t *addr)
 {
 	/*
@@ -1688,6 +1691,19 @@ void bt_auto_connect_remove(const bdaddr_t *addr)
 	error("Failed to remove device");
 }
 
+static bool match_by_value(const void *data, const void *user_data)
+{
+	return data == user_data;
+}
+
+bool bt_unpaired_register(bt_unpaired_device_cb cb)
+{
+	if (queue_find(unpaired_cb_list, match_by_value, cb))
+		return false;
+
+	return queue_push_head(unpaired_cb_list, cb);
+}
+
 static bool rssi_above_threshold(int old, int new)
 {
 	/* only 8 dBm or more */
@@ -4313,6 +4329,14 @@ failed:
 									status);
 }
 
+static void send_unpaired_notification(void *data, void *user_data)
+{
+	bt_unpaired_device_cb cb = data;
+	struct mgmt_addr_info *addr = user_data;
+
+	cb(&addr->bdaddr, addr->type);
+}
+
 static void unpair_device_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -4330,6 +4354,9 @@ static void unpair_device_complete(uint8_t status, uint16_t length,
 
 	update_device_state(dev, rp->addr.type, HAL_STATUS_SUCCESS, false,
 								false, false);
+
+	queue_foreach(unpaired_cb_list, send_unpaired_notification,
+							(void *)&rp->addr);
 }
 
 static void handle_remove_bond_cmd(const void *buf, uint16_t len)
@@ -5114,6 +5141,12 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 
 	DBG("mode 0x%x", mode);
 
+	unpaired_cb_list = queue_new();
+	if (!unpaired_cb_list) {
+		error("Can not allocate queue for unpaired callbacks");
+		return false;
+	}
+
 	missing_settings = adapter.current_settings ^
 					adapter.supported_settings;
 
@@ -5129,7 +5162,7 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 		/* Fail if controller does not support LE */
 		if (!(adapter.supported_settings & MGMT_SETTING_LE)) {
 			error("LE Mode not supported by controller");
-			return false;
+			goto failed;
 		}
 
 		/* If LE it is not yet enabled then enable it */
@@ -5144,7 +5177,7 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 		/* Fail if controller does not support BR/EDR */
 		if (!(adapter.supported_settings & MGMT_SETTING_BREDR)) {
 			error("BR/EDR Mode not supported");
-			return false;
+			goto failed;
 		}
 
 		/* Enable BR/EDR if it is not enabled */
@@ -5162,7 +5195,7 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 		break;
 	default:
 		error("Unknown mode 0x%x", mode);
-		return false;
+		goto failed;
 	}
 
 	hal_ipc = ipc;
@@ -5171,6 +5204,10 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 						G_N_ELEMENTS(cmd_handlers));
 
 	return true;
+
+failed:
+	queue_destroy(unpaired_cb_list, NULL);
+	return false;
 }
 
 void bt_bluetooth_unregister(void)
@@ -5185,4 +5222,6 @@ void bt_bluetooth_unregister(void)
 
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_CORE);
 	hal_ipc = NULL;
+
+	queue_destroy(unpaired_cb_list, NULL);
 }
diff --git a/android/bluetooth.h b/android/bluetooth.h
index ac7f3ad..185477c 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -85,3 +85,6 @@ bool bt_kernel_conn_control(void);
 bool bt_auto_connect_add(const bdaddr_t *addr);
 
 void bt_auto_connect_remove(const bdaddr_t *addr);
+
+typedef void (*bt_unpaired_device_cb)(const bdaddr_t *addr, uint8_t type);
+bool bt_unpaired_register(bt_unpaired_device_cb cb);
-- 
1.8.4

