Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 13/18] eir: Remove struct uuid_info
Date: Fri, 21 Sep 2012 12:02:25 +0200
Message-ID: <1348221750-15345-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com>
References: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove struct uuid_info and convert functions to use sdp_record_t
list instead. This will allow to easily use services list from
struct btd_adapter to create EIR.

---
 src/eir.c |   29 ++++++++++++++++-------------
 src/eir.h |    7 +------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index 598c0e4..78ae070 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -224,7 +224,8 @@ int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len)
 
 #define SIZEOF_UUID128 16
 
-static void eir_generate_uuid128(GSList *list, uint8_t *ptr, uint16_t *eir_len)
+static void eir_generate_uuid128(sdp_list_t *list, uint8_t *ptr,
+							uint16_t *eir_len)
 {
 	int i, k, uuid_count = 0;
 	uint16_t len = *eir_len;
@@ -235,10 +236,11 @@ static void eir_generate_uuid128(GSList *list, uint8_t *ptr, uint16_t *eir_len)
 	uuid128 = ptr + 2;
 
 	for (; list; list = list->next) {
-		struct uuid_info *uuid = list->data;
-		uint8_t *uuid128_data = uuid->uuid.value.uuid128.data;
+		sdp_record_t *rec = list->data;
+		uuid_t *uuid = &rec->svclass;
+		uint8_t *uuid128_data = uuid->value.uuid128.data;
 
-		if (uuid->uuid.type != SDP_UUID128)
+		if (uuid->type != SDP_UUID128)
 			continue;
 
 		/* Stop if not enough space to put next UUID128 */
@@ -284,9 +286,9 @@ int eir_create_oob(const char *name, uint32_t cod,
 			uint8_t *hash, uint8_t *randomizer,
 			uint16_t did_vendor, uint16_t did_product,
 			uint16_t did_version, uint16_t did_source,
-			GSList *uuids, uint8_t *data)
+			sdp_list_t *uuids, uint8_t *data)
 {
-	GSList *l;
+	sdp_list_t *l;
 	uint8_t *ptr = data;
 	uint16_t eir_len = 0;
 	uint16_t uuid16[HCI_MAX_EIR_LENGTH / 2];
@@ -364,16 +366,17 @@ int eir_create_oob(const char *name, uint32_t cod,
 	}
 
 	/* Group all UUID16 types */
-	for (l = uuids; l != NULL; l = g_slist_next(l)) {
-		struct uuid_info *uuid = l->data;
+	for (l = uuids; l != NULL; l = l->next) {
+		sdp_record_t *rec = l->data;
+		uuid_t *uuid = &rec->svclass;
 
-		if (uuid->uuid.type != SDP_UUID16)
+		if (uuid->type != SDP_UUID16)
 			continue;
 
-		if (uuid->uuid.value.uuid16 < 0x1100)
+		if (uuid->value.uuid16 < 0x1100)
 			continue;
 
-		if (uuid->uuid.value.uuid16 == PNP_INFO_SVCLASS_ID)
+		if (uuid->value.uuid16 == PNP_INFO_SVCLASS_ID)
 			continue;
 
 		/* Stop if not enough space to put next UUID16 */
@@ -384,13 +387,13 @@ int eir_create_oob(const char *name, uint32_t cod,
 
 		/* Check for duplicates */
 		for (i = 0; i < uuid_count; i++)
-			if (uuid16[i] == uuid->uuid.value.uuid16)
+			if (uuid16[i] == uuid->value.uuid16)
 				break;
 
 		if (i < uuid_count)
 			continue;
 
-		uuid16[uuid_count++] = uuid->uuid.value.uuid16;
+		uuid16[uuid_count++] = uuid->value.uuid16;
 		eir_len += sizeof(uint16_t);
 	}
 
diff --git a/src/eir.h b/src/eir.h
index 036172e..0755da5 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -38,11 +38,6 @@
 #define EIR_DEVICE_ID               0x10  /* device ID */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
 
-struct uuid_info {
-	uuid_t uuid;
-	uint8_t svc_hint;
-};
-
 struct eir_data {
 	GSList *services;
 	int flags;
@@ -62,7 +57,7 @@ int eir_create_oob(const char *name, uint32_t cod,
 			uint8_t *hash, uint8_t *randomizer,
 			uint16_t did_vendor, uint16_t did_product,
 			uint16_t did_version, uint16_t did_source,
-			GSList *uuids, uint8_t *data);
+			sdp_list_t *uuids, uint8_t *data);
 
 gboolean eir_has_data_type(uint8_t *data, size_t len, uint8_t type);
 
-- 
1.7.9.5

