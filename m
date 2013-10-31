Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] android: Add device discovery mgmt event handling
Date: Thu, 31 Oct 2013 15:25:31 +0100
Message-Id: <1383229534-17157-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383229534-17157-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383229534-17157-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch provides basic handling of device found events from management
interface. Temporary device adress list is being used to determine which
devices has already been reported and device property changed event should
be sent instead of device found event.

---
 android/Android.mk  |   2 +
 android/Makefile.am |   2 +
 android/adapter.c   | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index e47f4a9..ef9ebf3 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -32,6 +32,8 @@ LOCAL_SRC_FILES := \
 	../src/sdpd-service.c \
 	../src/sdpd-request.c \
 	../src/sdpd-server.c \
+	../src/glib-helper.c \
+	../src/eir.c \
 	../lib/sdp.c \
 	../lib/bluetooth.c \
 	../lib/hci.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 05a124e..989b54d 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -7,6 +7,8 @@ android_bluetoothd_SOURCES =	android/main.c \
 				android/utils.h \
 				src/sdpd-database.c src/sdpd-server.c \
 				src/sdpd-service.c src/sdpd-request.c \
+				src/glib-helper.h src/glib-helper.c \
+				src/eir.h src/eir.c \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				android/adapter.h android/adapter.c \
diff --git a/android/adapter.c b/android/adapter.c
index a12ccb3..154dd06 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -29,6 +29,8 @@
 #include "lib/sdp.h"
 #include "lib/mgmt.h"
 #include "src/shared/mgmt.h"
+#include "src/glib-helper.h"
+#include "src/eir.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "ipc.h"
@@ -58,6 +60,7 @@ struct bt_adapter {
 };
 
 static struct bt_adapter *adapter;
+static GSList *found_devices = NULL;
 
 static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
@@ -373,14 +376,113 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 
 	DBG("new discovering state %u", ev->discovering);
 
-	cp.state = adapter->discovering ? HAL_DISCOVERY_STATE_STARTED :
-						HAL_DISCOVERY_STATE_STOPPED;
+	if (adapter->discovering) {
+		cp.state = HAL_DISCOVERY_STATE_STARTED;
+	} else {
+		g_slist_free_full(found_devices, g_free);
+		found_devices = NULL;
+
+		cp.state = HAL_DISCOVERY_STATE_STOPPED;
+	}
 
 	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
 						HAL_EV_DISCOVERY_STATE_CHANGED,
 						sizeof(cp), &cp, -1);
 }
 
+static int bdaddr_cmp(gconstpointer a, gconstpointer b)
+{
+	const bdaddr_t *bda = a;
+	const bdaddr_t *bdb = b;
+
+	return bacmp(bdb, bda);
+}
+
+static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
+					int8_t rssi, bool confirm,
+					const uint8_t *data, uint8_t data_len)
+{
+	bool is_new_dev = false;
+	struct eir_data eir;
+	GSList *l;
+	bdaddr_t *remote = NULL;
+	int err;
+
+	memset(&eir, 0, sizeof(eir));
+
+	err = eir_parse(&eir, data, data_len);
+	if (err < 0) {
+		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
+		return;
+	}
+
+	l = g_slist_find_custom(found_devices, bdaddr, bdaddr_cmp);
+	if (l)
+		remote = l->data;
+
+	if (!remote) {
+		char addr[18];
+
+		remote = g_new0(bdaddr_t, 1);
+		bacpy(remote, bdaddr);
+
+		found_devices = g_slist_prepend(found_devices, remote);
+		is_new_dev = true;
+
+		ba2str(remote, addr);
+		DBG("New device found: %s", addr);
+	}
+
+	if (is_new_dev) {
+		/* TODO: notify device found */
+	} else {
+		/* TODO: notify device state changed */
+	}
+
+	/* TODO: name confirmation */
+
+	eir_data_free(&eir);
+}
+
+static void mgmt_device_found_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_device_found *ev = param;
+	const uint8_t *eir;
+	uint16_t eir_len;
+	uint32_t flags;
+	bool confirm_name;
+	char addr[18];
+
+	if (length < sizeof(*ev)) {
+		error("Too short device found event (%u bytes)", length);
+		return;
+	}
+
+	eir_len = btohs(ev->eir_len);
+	if (length != sizeof(*ev) + eir_len) {
+		error("Device found event size mismatch (%u != %zu)",
+					length, sizeof(*ev) + eir_len);
+		return;
+	}
+
+	if (eir_len == 0)
+		eir = NULL;
+	else
+		eir = ev->eir;
+
+	flags = btohl(ev->flags);
+
+	ba2str(&ev->addr.bdaddr, addr);
+	DBG("hci%u addr %s, rssi %d flags 0x%04x eir_len %u eir %u",
+				index, addr, ev->rssi, flags, eir_len, *eir);
+
+	confirm_name = flags & MGMT_DEV_FOUND_CONFIRM_NAME;
+
+	update_found_device(&ev->addr.bdaddr, ev->addr.type, ev->rssi,
+						confirm_name, eir, eir_len);
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->index,
@@ -415,6 +517,9 @@ static void register_mgmt_handlers(void)
 							mgmt_discovering_event,
 							NULL, NULL);
 
+	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_FOUND,
+					adapter->index, mgmt_device_found_event,
+					NULL, NULL);
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
-- 
1.8.4.1

