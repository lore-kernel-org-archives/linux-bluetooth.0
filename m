Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v3 1/5] android: Add and remove sdp records and uuids
Date: Tue, 12 Nov 2013 16:36:22 +0100
Message-ID: <1384270586-9853-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384270586-9853-1-git-send-email-szymon.janc@tieto.com>
References: <1384270586-9853-1-git-send-email-szymon.janc@tieto.com>
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
 android/adapter.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/adapter.h |   3 ++
 2 files changed, 116 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 65b3170..ac5878b 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -40,6 +40,7 @@
 #include "lib/sdp_lib.h"
 #include "lib/uuid.h"
 #include "src/sdp-client.h"
+#include "src/sdpd.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "ipc.h"
@@ -74,6 +75,7 @@ struct bt_adapter {
 
 	bool discovering;
 	uint32_t discoverable_timeout;
+	GSList *uuids;
 };
 
 struct browse_req {
@@ -986,6 +988,117 @@ static void load_link_keys(GSList *keys)
 	}
 }
 
+/* output uint128 is in host order */
+static void uuid16_to_uint128(uint16_t uuid, uint128_t *u128)
+{
+	uuid_t uuid16, uuid128;
+
+	sdp_uuid16_create(&uuid16, uuid);
+	sdp_uuid16_to_uuid128(&uuid128, &uuid16);
+
+	ntoh128(&uuid128.value.uuid128, u128);
+}
+
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
+static void remove_uuid(uint16_t uuid)
+{
+	uint128_t uint128;
+	struct mgmt_cp_remove_uuid cp;
+
+	uuid16_to_uint128(uuid, &uint128);
+	htob128(&uint128, (uint128_t *) cp.uuid);
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
+static void add_uuid(uint8_t svc_hint, uint16_t uuid)
+{
+	uint128_t uint128;
+	struct mgmt_cp_add_uuid cp;
+
+	uuid16_to_uint128(uuid, &uint128);
+
+	htob128(&uint128, (uint128_t *) cp.uuid);
+	cp.svc_hint = svc_hint;
+
+	mgmt_send(adapter->mgmt, MGMT_OP_ADD_UUID,
+				adapter->index, sizeof(cp), &cp,
+				add_uuid_complete, NULL, NULL);
+}
+
+int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint)
+{
+	uint16_t uuid;
+
+	/* TODO support all types? */
+	if (rec->svclass.type != SDP_UUID16) {
+		warn("Ignoring unsupported UUID type");
+		return -EINVAL;
+	}
+
+	uuid = rec->svclass.value.uuid16;
+
+	if (g_slist_find(adapter->uuids, GUINT_TO_POINTER(uuid))) {
+		DBG("UUID 0x%x already added", uuid);
+		return -EALREADY;
+	}
+
+	adapter->uuids = g_slist_prepend(adapter->uuids,
+						GUINT_TO_POINTER(uuid));
+
+	add_uuid(svc_hint, uuid);
+
+	return add_record_to_server(&adapter->bdaddr, rec);
+}
+
+void bt_adapter_remove_record(uint32_t handle)
+{
+	sdp_record_t *rec;
+	GSList *uuid_found;
+	uint16_t uuid;
+
+	rec = sdp_record_find(handle);
+	if (!rec)
+		return;
+
+	uuid = rec->svclass.value.uuid16;
+
+	uuid_found = g_slist_find(adapter->uuids, GUINT_TO_POINTER(uuid));
+	if (uuid_found) {
+		remove_uuid(uuid);
+
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
index c62b859..0e84cb0 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -32,3 +32,6 @@ const bdaddr_t *bt_adapter_get_address(void);
 
 bool bt_adapter_register(int sk);
 void bt_adapter_unregister(void);
+
+int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint);
+void bt_adapter_remove_record(uint32_t handle);
-- 
1.8.4.2

