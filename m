Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/8] attrib-server: Allocate 16-bits UUIDS at the begining of the list
Date: Wed, 25 Jan 2012 14:12:37 +0100
Message-Id: <1327497161-14764-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1327497161-14764-4-git-send-email-sancane@gmail.com>
References: <1327497161-14764-1-git-send-email-sancane@gmail.com>
 <1327497161-14764-2-git-send-email-sancane@gmail.com>
 <1327497161-14764-3-git-send-email-sancane@gmail.com>
 <1327497161-14764-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   42 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 93b7216..2b50fe4 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1270,30 +1270,35 @@ void attrib_free_sdp(uint32_t sdp_handle)
 	remove_record_from_server(sdp_handle);
 }
 
-uint16_t attrib_db_find_avail(struct btd_adapter *adapter, bt_uuid_t *svc_uuid,
-								uint16_t nitems)
+static uint16_t find_uuid16_avail(struct btd_adapter *adapter, uint16_t nitems)
 {
 	struct gatt_server *server;
 	uint16_t handle;
 	GSList *l;
 
-	g_assert(nitems > 0);
-
 	l = g_slist_find_custom(servers, adapter, adapter_cmp);
 	if (l == NULL)
 		return 0;
 
 	server = l->data;
+	if (server->database == NULL)
+		return 0x0001;
 
-	for (l = server->database, handle = 0; l; l = l->next) {
+	for (l = server->database, handle = 0x0001; l; l = l->next) {
 		struct attribute *a = l->data;
 
-		if (handle && (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
+		if ((bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
 				bt_uuid_cmp(&a->uuid, &snd_uuid) == 0) &&
 				a->handle - handle >= nitems)
 			/* Note: the range above excludes the current handle */
 			return handle;
 
+		if (a->len == 16 && (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
+				bt_uuid_cmp(&a->uuid, &snd_uuid) == 0)) {
+			/* 128 bit UUID service definition */
+			return 0;
+		}
+
 		if (a->handle == 0xffff)
 			return 0;
 
@@ -1306,6 +1311,31 @@ uint16_t attrib_db_find_avail(struct btd_adapter *adapter, bt_uuid_t *svc_uuid,
 	return 0;
 }
 
+static uint16_t find_uuid128_avail(struct btd_adapter *adapter, uint16_t nitems)
+{
+	/* TODO: Allocate 128 uuids at the end of the list */
+	return 0;
+}
+
+uint16_t attrib_db_find_avail(struct btd_adapter *adapter, bt_uuid_t *svc_uuid,
+								uint16_t nitems)
+{
+	g_assert(nitems > 0);
+
+	if (svc_uuid->type == BT_UUID16)
+		return find_uuid16_avail(adapter, nitems);
+	else if (svc_uuid->type == BT_UUID128)
+		return find_uuid128_avail(adapter, nitems);
+	else {
+		char uuidstr[MAX_LEN_UUID_STR];
+
+		bt_uuid_to_string(svc_uuid, uuidstr, MAX_LEN_UUID_STR);
+		error("Service uuid: %s is neither a 16-bit nor a 128-bit uuid",
+								uuidstr);
+		return 0;
+	}
+}
+
 struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
 				bt_uuid_t *uuid, int read_reqs, int write_reqs,
 						const uint8_t *value, int len)
-- 
1.7.8.4

