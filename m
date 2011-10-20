Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Simplify eir_parse function
Date: Thu, 20 Oct 2011 10:53:36 +0200
Message-Id: <1319100817-8477-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/eir.c |  155 +++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 80 insertions(+), 75 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index e82d30b..f188031 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -54,24 +54,72 @@
 void eir_data_free(struct eir_data *eir)
 {
 	g_slist_free_full(eir->services, g_free);
+	eir->services = NULL;
 	g_free(eir->name);
+	eir->name = NULL;
 }
 
-int eir_parse(struct eir_data *eir, uint8_t *eir_data)
+static void eir_parse_uuid16(struct eir_data *eir, uint8_t *data, uint8_t len)
 {
-	uint16_t len = 0;
-	size_t total;
-	size_t uuid16_count = 0;
-	size_t uuid32_count = 0;
-	size_t uuid128_count = 0;
-	uint8_t *uuid16 = NULL;
-	uint8_t *uuid32 = NULL;
-	uint8_t *uuid128 = NULL;
+	uint8_t *uuid_ptr = data;
+	uuid_t service;
+	char *uuid_str;
+	unsigned int i;
+	uint16_t val16;
+
+	service.type = SDP_UUID16;
+	for (i = 0; i < len / 2; i++) {
+		val16 = uuid_ptr[1];
+		val16 = (val16 << 8) + uuid_ptr[0];
+		service.value.uuid16 = val16;
+		uuid_str = bt_uuid2string(&service);
+		eir->services = g_slist_append(eir->services, uuid_str);
+		uuid_ptr += 2;
+	}
+}
+
+static void eir_parse_uuid32(struct eir_data *eir, uint8_t *data, uint8_t len)
+{
+	uint8_t *uuid_ptr = data;
 	uuid_t service;
 	char *uuid_str;
-	const char *name = NULL;
-	size_t name_len;
 	unsigned int i;
+	uint32_t val32;
+	int k;
+
+	service.type = SDP_UUID32;
+	for (i = 0; i < len / 4; i++) {
+		val32 = uuid_ptr[3];
+		for (k = 2; k >= 0; k--)
+			val32 = (val32 << 8) + uuid_ptr[k];
+		service.value.uuid32 = val32;
+		uuid_str = bt_uuid2string(&service);
+		eir->services = g_slist_append(eir->services, uuid_str);
+		uuid_ptr += 4;
+	}
+}
+
+static void eir_parse_uuid128(struct eir_data *eir, uint8_t *data, uint8_t len)
+{
+	uint8_t *uuid_ptr = data;
+	uuid_t service;
+	char *uuid_str;
+	unsigned int i;
+	int k;
+
+	service.type = SDP_UUID128;
+	for (i = 0; i < len / 16; i++) {
+		for (k = 0; k < 16; k++)
+			service.value.uuid128.data[k] = uuid_ptr[16 - k - 1];
+		uuid_str = bt_uuid2string(&service);
+		eir->services = g_slist_append(eir->services, uuid_str);
+		uuid_ptr += 16;
+	}
+}
+
+int eir_parse(struct eir_data *eir, uint8_t *eir_data)
+{
+	uint16_t len = 0;
 
 	eir->flags = -1;
 
@@ -86,92 +134,49 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data)
 		if (field_len == 0)
 			break;
 
+		len += field_len + 1;
+
+		/* Bail out if got incorrect length */
+		if (len > HCI_MAX_EIR_LENGTH) {
+			eir_data_free(eir);
+			return -EINVAL;
+		}
+
 		switch (eir_data[1]) {
 		case EIR_UUID16_SOME:
 		case EIR_UUID16_ALL:
-			uuid16_count = field_len / 2;
-			uuid16 = &eir_data[2];
+			eir_parse_uuid16(eir, &eir_data[2], field_len);
 			break;
+
 		case EIR_UUID32_SOME:
 		case EIR_UUID32_ALL:
-			uuid32_count = field_len / 4;
-			uuid32 = &eir_data[2];
+			eir_parse_uuid32(eir, &eir_data[2], field_len);
 			break;
+
 		case EIR_UUID128_SOME:
 		case EIR_UUID128_ALL:
-			uuid128_count = field_len / 16;
-			uuid128 = &eir_data[2];
+			eir_parse_uuid128(eir, &eir_data[2], field_len);
 			break;
+
 		case EIR_FLAGS:
 			eir->flags = eir_data[2];
 			break;
+
 		case EIR_NAME_SHORT:
 		case EIR_NAME_COMPLETE:
-			name = (const char *) &eir_data[2];
-			name_len = field_len - 1;
+			if (g_utf8_validate((char *) &eir_data[2],
+							field_len - 1, NULL))
+				eir->name = g_strndup((char *) &eir_data[2],
+								field_len - 1);
+			else
+				eir->name = g_strdup("");
 			eir->name_complete = eir_data[1] == EIR_NAME_COMPLETE;
 			break;
 		}
 
-		len += field_len + 1;
 		eir_data += field_len + 1;
 	}
 
-	/* Bail out if got incorrect length */
-	if (len > HCI_MAX_EIR_LENGTH)
-		return -EINVAL;
-
-	if (name != NULL) {
-		if (g_utf8_validate(name, name_len, NULL))
-			eir->name = g_strndup(name, name_len);
-		else
-			eir->name = g_strdup("");
-	}
-
-	total = uuid16_count + uuid32_count + uuid128_count;
-
-	/* No UUIDs were parsed, so skip code below */
-	if (!total)
-		return 0;
-
-	/* Generate uuids in SDP format (EIR data is Little Endian) */
-	service.type = SDP_UUID16;
-	for (i = 0; i < uuid16_count; i++) {
-		uint16_t val16 = uuid16[1];
-
-		val16 = (val16 << 8) + uuid16[0];
-		service.value.uuid16 = val16;
-		uuid_str = bt_uuid2string(&service);
-		eir->services = g_slist_append(eir->services, uuid_str);
-		uuid16 += 2;
-	}
-
-	service.type = SDP_UUID32;
-	for (i = uuid16_count; i < uuid32_count + uuid16_count; i++) {
-		uint32_t val32 = uuid32[3];
-		int k;
-
-		for (k = 2; k >= 0; k--)
-			val32 = (val32 << 8) + uuid32[k];
-
-		service.value.uuid32 = val32;
-		uuid_str = bt_uuid2string(&service);
-		eir->services = g_slist_append(eir->services, uuid_str);
-		uuid32 += 4;
-	}
-
-	service.type = SDP_UUID128;
-	for (i = uuid32_count + uuid16_count; i < total; i++) {
-		int k;
-
-		for (k = 0; k < 16; k++)
-			service.value.uuid128.data[k] = uuid128[16 - k - 1];
-
-		uuid_str = bt_uuid2string(&service);
-		eir->services = g_slist_append(eir->services, uuid_str);
-		uuid128 += 16;
-	}
-
 	return 0;
 }
 
-- 
1.7.1

