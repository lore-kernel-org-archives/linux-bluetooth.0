Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 14/18] eir: Add support for creating proper OOB EIR
Date: Fri, 21 Sep 2012 14:36:31 +0200
Message-ID: <1348230995-8967-15-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Address and total length field are mandatory part of OOB EIR.

---
 src/eir.c |   39 ++++++++++++++++++++++++++-------------
 src/eir.h |    2 +-
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index 78ae070..05b3723 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -282,7 +282,7 @@ static void eir_generate_uuid128(sdp_list_t *list, uint8_t *ptr,
 	}
 }
 
-int eir_create_oob(const char *name, uint32_t cod,
+int eir_create_oob(bdaddr_t *addr, const char *name, uint32_t cod,
 			uint8_t *hash, uint8_t *randomizer,
 			uint16_t did_vendor, uint16_t did_product,
 			uint16_t did_version, uint16_t did_source,
@@ -290,12 +290,19 @@ int eir_create_oob(const char *name, uint32_t cod,
 {
 	sdp_list_t *l;
 	uint8_t *ptr = data;
-	uint16_t eir_len = 0;
+	uint16_t eir_optional_len = 0;
+	uint16_t eir_total_len;
 	uint16_t uuid16[HCI_MAX_EIR_LENGTH / 2];
 	int i, uuid_count = 0;
 	gboolean truncated = FALSE;
 	size_t name_len;
 
+	eir_total_len =  sizeof(uint16_t) + sizeof(bdaddr_t);
+	ptr += sizeof(uint16_t);
+
+	memcpy(ptr, addr, sizeof(bdaddr_t));
+	ptr += sizeof(bdaddr_t);
+
 	if (cod > 0) {
 		uint8_t class[3];
 
@@ -309,7 +316,7 @@ int eir_create_oob(const char *name, uint32_t cod,
 		memcpy(ptr, class, sizeof(class));
 		ptr += sizeof(class);
 
-		eir_len += sizeof(class) + 2;
+		eir_optional_len += sizeof(class) + 2;
 	}
 
 	if (hash) {
@@ -319,7 +326,7 @@ int eir_create_oob(const char *name, uint32_t cod,
 		memcpy(ptr, hash, 16);
 		ptr += 16;
 
-		eir_len += 16 + 2;
+		eir_optional_len += 16 + 2;
 	}
 
 	if (randomizer) {
@@ -329,7 +336,7 @@ int eir_create_oob(const char *name, uint32_t cod,
 		memcpy(ptr, randomizer, 16);
 		ptr += 16;
 
-		eir_len += 16 + 2;
+		eir_optional_len += 16 + 2;
 	}
 
 	name_len = strlen(name);
@@ -347,7 +354,7 @@ int eir_create_oob(const char *name, uint32_t cod,
 
 		memcpy(ptr + 2, name, name_len);
 
-		eir_len += (name_len + 2);
+		eir_optional_len += (name_len + 2);
 		ptr += (name_len + 2);
 	}
 
@@ -362,7 +369,7 @@ int eir_create_oob(const char *name, uint32_t cod,
 		*ptr++ = (did_product & 0xff00) >> 8;
 		*ptr++ = (did_version & 0x00ff);
 		*ptr++ = (did_version & 0xff00) >> 8;
-		eir_len += 10;
+		eir_optional_len += 10;
 	}
 
 	/* Group all UUID16 types */
@@ -380,7 +387,8 @@ int eir_create_oob(const char *name, uint32_t cod,
 			continue;
 
 		/* Stop if not enough space to put next UUID16 */
-		if ((eir_len + 2 + sizeof(uint16_t)) > HCI_MAX_EIR_LENGTH) {
+		if ((eir_optional_len + 2 + sizeof(uint16_t)) >
+				HCI_MAX_EIR_LENGTH) {
 			truncated = TRUE;
 			break;
 		}
@@ -394,7 +402,7 @@ int eir_create_oob(const char *name, uint32_t cod,
 			continue;
 
 		uuid16[uuid_count++] = uuid->value.uuid16;
-		eir_len += sizeof(uint16_t);
+		eir_optional_len += sizeof(uint16_t);
 	}
 
 	if (uuid_count > 0) {
@@ -404,7 +412,7 @@ int eir_create_oob(const char *name, uint32_t cod,
 		ptr[1] = truncated ? EIR_UUID16_SOME : EIR_UUID16_ALL;
 
 		ptr += 2;
-		eir_len += 2;
+		eir_optional_len += 2;
 
 		for (i = 0; i < uuid_count; i++) {
 			*ptr++ = (uuid16[i] & 0x00ff);
@@ -413,10 +421,15 @@ int eir_create_oob(const char *name, uint32_t cod,
 	}
 
 	/* Group all UUID128 types */
-	if (eir_len <= HCI_MAX_EIR_LENGTH - 2)
-		eir_generate_uuid128(uuids, ptr, &eir_len);
+	if (eir_optional_len <= HCI_MAX_EIR_LENGTH - 2)
+		eir_generate_uuid128(uuids, ptr, &eir_optional_len);
 
-	return eir_len;
+	eir_total_len += eir_optional_len;
+
+	/* store total length */
+	bt_put_le16(eir_total_len, data);
+
+	return eir_total_len;
 }
 
 gboolean eir_has_data_type(uint8_t *data, size_t len, uint8_t type)
diff --git a/src/eir.h b/src/eir.h
index 0755da5..d8c5e32 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -53,7 +53,7 @@ struct eir_data {
 void eir_data_free(struct eir_data *eir);
 int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len);
 int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len);
-int eir_create_oob(const char *name, uint32_t cod,
+int eir_create_oob(bdaddr_t *addr, const char *name, uint32_t cod,
 			uint8_t *hash, uint8_t *randomizer,
 			uint16_t did_vendor, uint16_t did_product,
 			uint16_t did_version, uint16_t did_source,
-- 
1.7.9.5

