Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 1/4] android: Add and remove sdp records and uuids
Date: Fri, 8 Nov 2013 13:21:21 +0100
Message-ID: <1383913284-4032-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383913284-4032-1-git-send-email-szymon.janc@tieto.com>
References: <1383913284-4032-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

This is api for adding and removing sdp records and uuids
via mgmt interface. Local profiles have to store handle to
own records to remove them in cleanup. Additionally list of
uuids is created in bt_adapter struct.
---
 android/Android.mk |   1 +
 android/adapter.c  | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/adapter.h  |   4 +++
 3 files changed, 106 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 51037a7..9f89dfd 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -39,6 +39,7 @@ LOCAL_SRC_FILES := \
 	../lib/sdp.c \
 	../lib/bluetooth.c \
 	../lib/hci.c \
+	../lib/uuid.c \
 	../btio/btio.c \
 	../src/sdp-client.c \
 
diff --git a/android/adapter.c b/android/adapter.c
index 65b3170..60b2635 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -39,6 +39,7 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "lib/uuid.h"
+#include "src/sdpd.h"
 #include "src/sdp-client.h"
 #include "log.h"
 #include "hal-msg.h"
@@ -74,6 +75,7 @@ struct bt_adapter {
 
 	bool discovering;
 	uint32_t discoverable_timeout;
+	GSList *uuids;
 };
 
 struct browse_req {
@@ -986,6 +988,105 @@ static void load_link_keys(GSList *keys)
 	}
 }
 
+static void remove_uuid_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to remove UUID: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	mgmt_dev_class_changed_event(adapter->index, length, param, NULL);
+}
+
+static void remove_uuid(const uint8_t *uuid)
+{
+	struct mgmt_cp_remove_uuid cp;
+
+	memcpy(cp.uuid, uuid, sizeof(uint128_t));
+
+
+	mgmt_send(adapter->mgmt, MGMT_OP_REMOVE_UUID,
+				adapter->index, sizeof(cp), &cp,
+				remove_uuid_complete, NULL, NULL);
+}
+
+static void add_uuid_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to add UUID: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	mgmt_dev_class_changed_event(adapter->index, length, param, NULL);
+}
+
+static void add_uuid(uint8_t svc_hint, const uint8_t *uuid)
+{
+	struct mgmt_cp_add_uuid cp;
+
+	memcpy(cp.uuid, uuid, sizeof(uint128_t));
+	cp.svc_hint = svc_hint;
+
+	mgmt_send(adapter->mgmt, MGMT_OP_ADD_UUID,
+				adapter->index, sizeof(cp), &cp,
+				add_uuid_complete, NULL, NULL);
+}
+
+static int uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const bt_uuid_t *uuid_a = a;
+	const bt_uuid_t *uuid_b = b;
+
+	return bt_uuid_cmp(uuid_a, uuid_b);
+}
+
+int bt_adapter_add_record(const char *uuid, sdp_record_t *rec,
+							uint8_t svc_hint)
+{
+	bt_uuid_t *new_uuid;
+
+	new_uuid = g_new0(bt_uuid_t, 1);
+	bt_string_to_uuid(new_uuid, uuid);
+	if (new_uuid->type != BT_UUID128) {
+		g_free(new_uuid);
+		return -1;
+	}
+
+	if (g_slist_find_custom(adapter->uuids, new_uuid, uuid_cmp)) {
+		DBG("UUID %s already added", uuid);
+		g_free(new_uuid);
+		return -1;
+	}
+
+	adapter->uuids = g_slist_prepend(adapter->uuids, new_uuid);
+	add_uuid(svc_hint, new_uuid->value.u128.data);
+
+	return add_record_to_server(&adapter->bdaddr, rec);
+}
+
+void bt_adapter_remove_record(const char *uuid, int handle)
+{
+	bt_uuid_t bt_uuid;
+	GSList *uuid_found;
+
+	bt_string_to_uuid(&bt_uuid, uuid);
+
+	uuid_found = g_slist_find_custom(adapter->uuids, &bt_uuid, uuid_cmp);
+
+	if (uuid_found) {
+		remove_uuid(bt_uuid.value.u128.data);
+		g_free(uuid_found->data);
+		adapter->uuids = g_slist_remove(adapter->uuids,
+							uuid_found->data);
+	}
+
+	remove_record_from_server(handle);
+}
+
 static void set_mode_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
diff --git a/android/adapter.h b/android/adapter.h
index c62b859..0d93917 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -32,3 +32,7 @@ const bdaddr_t *bt_adapter_get_address(void);
 
 bool bt_adapter_register(int sk);
 void bt_adapter_unregister(void);
+
+int bt_adapter_add_record(const char *uuid, sdp_record_t *rec,
+							uint8_t svc_hint);
+void bt_adapter_remove_record(const char *uuid, int handle);
-- 
1.8.4.2

