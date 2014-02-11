Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 01/11] android/bluetooth: Handle 128-bit UUIDs
Date: Tue, 11 Feb 2014 17:58:11 +0100
Message-ID: <1392137901-3403-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It's now possible to add record with 128-bit UUID Service Class which
are used for custom applications. To simplify implementation adapter
uuids list stores now full UUID in uuid_t structure instead of uint16_t
short UUID.
---
 android/bluetooth.c | 61 ++++++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 9f8e7b4..c064fe8 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1459,17 +1459,6 @@ static void load_link_keys(GSList *keys, bt_bluetooth_ready cb)
 	}
 }
 
-/* output uint128 is in host order */
-static void uuid16_to_uint128(uint16_t uuid, uint128_t *u128)
-{
-	uuid_t uuid16, uuid128;
-
-	sdp_uuid16_create(&uuid16, uuid);
-	sdp_uuid16_to_uuid128(&uuid128, &uuid16);
-
-	ntoh128(&uuid128.value.uuid128, u128);
-}
-
 static uint8_t get_adapter_uuids(void)
 {
 	struct hal_ev_adapter_props_changed *ev;
@@ -1478,7 +1467,6 @@ static uint8_t get_adapter_uuids(void)
 	int len = uuid_count * sizeof(uint128_t);
 	uint8_t buf[BASELEN_PROP_CHANGED + len];
 	uint8_t *p;
-	int i;
 
 	memset(buf, 0, sizeof(buf));
 	ev = (void *) buf;
@@ -1491,14 +1479,9 @@ static uint8_t get_adapter_uuids(void)
 	p = ev->props->val;
 
 	for (; list; list = g_slist_next(list)) {
-		uint16_t uuid = GPOINTER_TO_UINT(list->data);
-		uint128_t uint128;
-
-		uuid16_to_uint128(uuid, &uint128);
+		uuid_t *uuid = list->data;
 
-		/* Android expects swapped bytes in uuid */
-		for (i = 0; i < 16; i++)
-			p[15 - i] = uint128.data[i];
+		memcpy(p, &uuid->value.uuid128, sizeof(uint128_t));
 
 		p += sizeof(uint128_t);
 	}
@@ -1523,12 +1506,12 @@ static void remove_uuid_complete(uint8_t status, uint16_t length,
 	get_adapter_uuids();
 }
 
-static void remove_uuid(uint16_t uuid)
+static void remove_uuid(uuid_t *uuid)
 {
 	uint128_t uint128;
 	struct mgmt_cp_remove_uuid cp;
 
-	uuid16_to_uint128(uuid, &uint128);
+	ntoh128((uint128_t *) uuid->value.uuid128.data, &uint128);
 	htob128(&uint128, (uint128_t *) cp.uuid);
 
 	mgmt_send(mgmt_if, MGMT_OP_REMOVE_UUID, adapter.index, sizeof(cp), &cp,
@@ -1549,14 +1532,14 @@ static void add_uuid_complete(uint8_t status, uint16_t length,
 	get_adapter_uuids();
 }
 
-static void add_uuid(uint8_t svc_hint, uint16_t uuid)
+static void add_uuid(uint8_t svc_hint, uuid_t *uuid)
 {
 	uint128_t uint128;
 	struct mgmt_cp_add_uuid cp;
 
-	uuid16_to_uint128(uuid, &uint128);
-
+	ntoh128((uint128_t *) uuid->value.uuid128.data, &uint128);
 	htob128(&uint128, (uint128_t *) cp.uuid);
+
 	cp.svc_hint = svc_hint;
 
 	mgmt_send(mgmt_if, MGMT_OP_ADD_UUID, adapter.index, sizeof(cp), &cp,
@@ -1565,22 +1548,19 @@ static void add_uuid(uint8_t svc_hint, uint16_t uuid)
 
 int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint)
 {
-	uint16_t uuid;
+	uuid_t *uuid;
 
-	/* TODO support all types? */
-	if (rec->svclass.type != SDP_UUID16) {
-		warn("Ignoring unsupported UUID type");
-		return -EINVAL;
-	}
+	uuid = sdp_uuid_to_uuid128(&rec->svclass);
 
-	uuid = rec->svclass.value.uuid16;
+	if (g_slist_find_custom(adapter.uuids, uuid, sdp_uuid_cmp)) {
+		char uuid_str[32];
 
-	if (g_slist_find(adapter.uuids, GUINT_TO_POINTER(uuid))) {
-		DBG("UUID 0x%x already added", uuid);
+		sdp_uuid2strn(uuid, uuid_str, sizeof(uuid_str));
+		DBG("UUID %s already added", uuid_str);
 		return -EALREADY;
 	}
 
-	adapter.uuids = g_slist_prepend(adapter.uuids, GUINT_TO_POINTER(uuid));
+	adapter.uuids = g_slist_prepend(adapter.uuids, uuid);
 
 	add_uuid(svc_hint, uuid);
 
@@ -1591,20 +1571,21 @@ void bt_adapter_remove_record(uint32_t handle)
 {
 	sdp_record_t *rec;
 	GSList *uuid_found;
-	uint16_t uuid;
 
 	rec = sdp_record_find(handle);
 	if (!rec)
 		return;
 
-	uuid = rec->svclass.value.uuid16;
-
-	uuid_found = g_slist_find(adapter.uuids, GUINT_TO_POINTER(uuid));
+	uuid_found = g_slist_find_custom(adapter.uuids, &rec->svclass,
+								sdp_uuid_cmp);
 	if (uuid_found) {
+		uuid_t *uuid = uuid_found->data;
+
 		remove_uuid(uuid);
 
-		adapter.uuids = g_slist_remove(adapter.uuids,
-							uuid_found->data);
+		adapter.uuids = g_slist_remove(adapter.uuids, uuid);
+
+		free(uuid);
 	}
 
 	remove_record_from_server(handle);
-- 
1.8.5.3

