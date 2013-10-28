Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 5/5] android: Add and remove uuids in mgmt interface
Date: Mon, 28 Oct 2013 13:30:09 +0100
Message-ID: <1382963409-1012-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1382963409-1012-1-git-send-email-marcin.kraglak@tieto.com>
References: <1382963409-1012-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use mgmt interface for adding and removing uuids to adapter.
This is needed for proper changing adapter's class of device.
---
 android/adapter.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index b1cb5f8..bed0423 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -532,10 +532,105 @@ error:
 	ipc_send_rsp(io, HAL_SERVICE_ID_BLUETOOTH, status);
 }
 
+static int uuid_cmp(const void *a, const void *b)
+{
+	const sdp_record_t *rec = a;
+	const uuid_t *uuid = b;
+
+	return sdp_uuid_cmp(&rec->svclass, uuid);
+}
+
+static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid)
+{
+	if (uuid->type == SDP_UUID16)
+		sdp_uuid16_to_uuid128(uuid128, uuid);
+	else if (uuid->type == SDP_UUID32)
+		sdp_uuid32_to_uuid128(uuid128, uuid);
+	else
+		memcpy(uuid128, uuid, sizeof(*uuid));
+}
+
+static uint8_t get_uuid_mask(const uuid_t *uuid)
+{
+	if (uuid->type != SDP_UUID16)
+		return 0;
+
+	switch (uuid->value.uuid16) {
+	case DIALUP_NET_SVCLASS_ID:
+	case CIP_SVCLASS_ID:
+		return 0x42;    /* Telephony & Networking */
+	case IRMC_SYNC_SVCLASS_ID:
+	case OBEX_OBJPUSH_SVCLASS_ID:
+	case OBEX_FILETRANS_SVCLASS_ID:
+	case IRMC_SYNC_CMD_SVCLASS_ID:
+	case PBAP_PSE_SVCLASS_ID:
+		return 0x10;    /* Object Transfer */
+	case HEADSET_SVCLASS_ID:
+	case HANDSFREE_SVCLASS_ID:
+		return 0x20;    /* Audio */
+	case CORDLESS_TELEPHONY_SVCLASS_ID:
+	case INTERCOM_SVCLASS_ID:
+	case FAX_SVCLASS_ID:
+	case SAP_SVCLASS_ID:
+	/*
+	* Setting the telephony bit for the handsfree audio gateway
+	* role is not required by the HFP specification, but the
+	* Nokia 616 carkit is just plain broken! It will refuse
+	* pairing without this bit set.
+	*/
+	case HANDSFREE_AGW_SVCLASS_ID:
+		return 0x40;    /* Telephony */
+	case AUDIO_SOURCE_SVCLASS_ID:
+	case VIDEO_SOURCE_SVCLASS_ID:
+		return 0x08;    /* Capturing */
+	case AUDIO_SINK_SVCLASS_ID:
+	case VIDEO_SINK_SVCLASS_ID:
+		return 0x04;    /* Rendering */
+	case PANU_SVCLASS_ID:
+	case NAP_SVCLASS_ID:
+	case GN_SVCLASS_ID:
+		return 0x02;    /* Networking */
+	default:
+		return 0;
+	}
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
+	/*TODO inform that adapter uuids has been changed*/
+}
+
+static int add_uuid(uuid_t *uuid, uint8_t svc_hint)
+{
+	struct mgmt_cp_add_uuid cp;
+	uuid_t uuid128;
+	uint128_t uint128;
+
+	uuid_to_uuid128(&uuid128, uuid);
+
+	ntoh128((uint128_t *) uuid128.value.uuid128.data, &uint128);
+	htob128(&uint128, (uint128_t *) cp.uuid);
+	cp.svc_hint = svc_hint;
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_ADD_UUID,
+			0, sizeof(cp), &cp,
+			add_uuid_complete, adapter, NULL) > 0)
+		return 0;
+
+	return -EIO;
+}
+
 static void adapter_service_insert(sdp_record_t *rec)
 {
 	sdp_list_t *browse_list = NULL;
 	uuid_t browse_uuid;
+	bool new_uuid;
 
 	/* skip record without a browse group */
 	if (sdp_get_browse_groups(rec, &browse_list) < 0) {
@@ -552,6 +647,19 @@ static void adapter_service_insert(sdp_record_t *rec)
 	adapter->services = sdp_list_insert_sorted(
 				adapter->services, rec, record_sort);
 
+	if (!sdp_list_find(adapter->services, &rec->svclass, uuid_cmp))
+		new_uuid = true;
+	else
+		new_uuid = false;
+
+	adapter->services = sdp_list_insert_sorted(adapter->services, rec,
+							record_sort);
+
+	if (new_uuid) {
+		uint8_t svc_hint = get_uuid_mask(&rec->svclass);
+		add_uuid(&rec->svclass, svc_hint);
+	}
+
 done:
 	sdp_list_free(browse_list, free);
 }
@@ -569,6 +677,36 @@ int bt_adapter_service_add(sdp_record_t *rec)
 	return ret;
 }
 
+static void remove_uuid_complete(uint8_t status, uint16_t length,
+				const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+			error("Failed to remove UUID: %s (0x%02x)",
+		mgmt_errstr(status), status);
+		return;
+	}
+	/*TODO inform that adapter uuids has been changed*/
+}
+
+static int remove_uuid(uuid_t *uuid)
+{
+	struct mgmt_cp_remove_uuid cp;
+	uuid_t uuid128;
+	uint128_t uint128;
+
+	uuid_to_uuid128(&uuid128, uuid);
+
+	ntoh128((uint128_t *) uuid128.value.uuid128.data, &uint128);
+	htob128(&uint128, (uint128_t *) cp.uuid);
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_REMOVE_UUID,
+			0, sizeof(cp), &cp,
+			remove_uuid_complete, adapter, NULL) > 0)
+		return 0;
+
+	return -EIO;
+}
+
 void bt_adapter_service_remove(uint32_t handle)
 {
 	sdp_record_t *rec = sdp_record_find(handle);
@@ -578,6 +716,9 @@ void bt_adapter_service_remove(uint32_t handle)
 
 	adapter->services = sdp_list_remove(adapter->services, rec);
 
+	if (!sdp_list_find(adapter->services, &rec->svclass, uuid_cmp))
+		remove_uuid(&rec->svclass);
+
 	remove_record_from_server(rec->handle);
 }
 
-- 
1.8.2.2

