Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Simplify eir_parse_uuid* functions
Date: Thu, 20 Oct 2011 14:53:04 +0200
Message-Id: <1319115184-16116-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/eir.c |   37 +++++++++++++++----------------------
 1 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index f188031..88a4807 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -59,43 +59,33 @@ void eir_data_free(struct eir_data *eir)
 	eir->name = NULL;
 }
 
-static void eir_parse_uuid16(struct eir_data *eir, uint8_t *data, uint8_t len)
+static void eir_parse_uuid16(struct eir_data *eir, void *data, uint8_t len)
 {
-	uint8_t *uuid_ptr = data;
+	uint16_t *uuid16 = data;
 	uuid_t service;
 	char *uuid_str;
 	unsigned int i;
-	uint16_t val16;
 
 	service.type = SDP_UUID16;
-	for (i = 0; i < len / 2; i++) {
-		val16 = uuid_ptr[1];
-		val16 = (val16 << 8) + uuid_ptr[0];
-		service.value.uuid16 = val16;
+	for (i = 0; i < len / 2; i++, uuid16++) {
+		service.value.uuid16 = btohs(bt_get_unaligned(uuid16));
 		uuid_str = bt_uuid2string(&service);
 		eir->services = g_slist_append(eir->services, uuid_str);
-		uuid_ptr += 2;
 	}
 }
 
-static void eir_parse_uuid32(struct eir_data *eir, uint8_t *data, uint8_t len)
+static void eir_parse_uuid32(struct eir_data *eir, void *data, uint8_t len)
 {
-	uint8_t *uuid_ptr = data;
+	uint32_t *uuid32 = data;
 	uuid_t service;
 	char *uuid_str;
 	unsigned int i;
-	uint32_t val32;
-	int k;
 
 	service.type = SDP_UUID32;
-	for (i = 0; i < len / 4; i++) {
-		val32 = uuid_ptr[3];
-		for (k = 2; k >= 0; k--)
-			val32 = (val32 << 8) + uuid_ptr[k];
-		service.value.uuid32 = val32;
+	for (i = 0; i < len / 4; i++, uuid32++) {
+		service.value.uuid32 = btohl(bt_get_unaligned(uuid32));
 		uuid_str = bt_uuid2string(&service);
 		eir->services = g_slist_append(eir->services, uuid_str);
-		uuid_ptr += 4;
 	}
 }
 
@@ -164,12 +154,15 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data)
 
 		case EIR_NAME_SHORT:
 		case EIR_NAME_COMPLETE:
-			if (g_utf8_validate((char *) &eir_data[2],
+			if (!g_utf8_validate((char *) &eir_data[2],
 							field_len - 1, NULL))
-				eir->name = g_strndup((char *) &eir_data[2],
+				break;
+
+			if (eir->name)
+				g_free(eir->name);
+
+			eir->name = g_strndup((char *) &eir_data[2],
 								field_len - 1);
-			else
-				eir->name = g_strdup("");
 			eir->name_complete = eir_data[1] == EIR_NAME_COMPLETE;
 			break;
 		}
-- 
1.7.1

