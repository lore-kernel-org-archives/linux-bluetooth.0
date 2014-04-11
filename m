Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/6] android/bluetooth: Send adapter properties in single notification
Date: Fri, 11 Apr 2014 09:41:23 +0200
Message-Id: <1397202087-1203-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
References: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reduces number of IPC calls while enabling Bluetooth.
---
 android/bluetooth.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 70b0849..f7bf979 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2781,16 +2781,74 @@ static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
 
 static void get_adapter_properties(void)
 {
-	/* TODO should be done in single notification */
-	get_adapter_address();
-	get_adapter_name();
-	get_adapter_uuids();
-	get_adapter_class();
-	get_adapter_type();
-	get_adapter_service_rec();
-	get_adapter_scan_mode();
-	get_adapter_bonded_devices();
-	get_adapter_discoverable_timeout();
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_adapter_props_changed *ev = (void *) buf;
+	uint8_t bonded[g_slist_length(bonded_devices) * sizeof(bdaddr_t)];
+	uint128_t uuids[g_slist_length(adapter.uuids)];
+	uint8_t android_bdaddr[6];
+	uint8_t type, mode;
+	int size, i;
+	GSList *l;
+
+	size = sizeof(*ev);
+
+	ev->status = HAL_STATUS_SUCCESS;
+	ev->num_props = 0;
+
+	bdaddr2android(&adapter.bdaddr, &android_bdaddr);
+	size += fill_hal_prop(buf + size, HAL_PROP_ADAPTER_ADDR,
+					sizeof(android_bdaddr), android_bdaddr);
+	ev->num_props++;
+
+	if (adapter.name) {
+		size += fill_hal_prop(buf + size, HAL_PROP_ADAPTER_NAME,
+					strlen(adapter.name), adapter.name);
+		ev->num_props++;
+	}
+
+	size += fill_hal_prop(buf + size, HAL_PROP_ADAPTER_CLASS,
+				sizeof(adapter.dev_class), &adapter.dev_class);
+	ev->num_props++;
+
+	type = settings2type();
+	if (type) {
+		size += fill_hal_prop(buf + size, HAL_PROP_ADAPTER_TYPE,
+							sizeof(type), &type);
+		ev->num_props++;
+	}
+
+	mode = settings2scan_mode();
+	size += fill_hal_prop(buf + size, HAL_PROP_ADAPTER_SCAN_MODE,
+							sizeof(mode), &mode);
+	ev->num_props++;
+
+	size += fill_hal_prop(buf + size, HAL_PROP_ADAPTER_DISC_TIMEOUT,
+					sizeof(adapter.discoverable_timeout),
+					&adapter.discoverable_timeout);
+	ev->num_props++;
+
+	for (i = 0, l = bonded_devices; l; l = g_slist_next(l), i++) {
+		struct device *dev = l->data;
+
+		bdaddr2android(&dev->bdaddr, bonded + (i * sizeof(bdaddr_t)));
+	}
+
+	size += fill_hal_prop(buf + size, HAL_PROP_ADAPTER_BONDED_DEVICES,
+						sizeof(bonded), bonded);
+	ev->num_props++;
+
+	for (i = 0, l = adapter.uuids; l; l = g_slist_next(l), i++) {
+		uuid_t *uuid = l->data;
+
+		memcpy(&uuids[i], &uuid->value.uuid128, sizeof(uint128_t));
+	}
+
+	size += fill_hal_prop(buf + size, HAL_PROP_ADAPTER_UUIDS, sizeof(uuids),
+									uuids);
+	ev->num_props++;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_PROPS_CHANGED, size, buf);
 }
 
 static void cancel_pending_confirm_name(gpointer data, gpointer user_data)
-- 
1.9.1

