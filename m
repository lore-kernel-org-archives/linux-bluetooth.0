Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/eir: Add support for parsing service data
Date: Mon, 13 Apr 2015 16:54:05 +0300
Message-Id: <1428933245-8289-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1428933245-8289-1-git-send-email-luiz.dentz@gmail.com>
References: <1428933245-8289-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/eir.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/eir.h |  8 +++++++
 2 files changed, 88 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index bc17305..34f6e16 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -43,6 +43,14 @@
 
 #define EIR_OOB_MIN (2 + 6)
 
+static void sd_free(void *data)
+{
+	struct eir_sd *sd = data;
+
+	free(sd->uuid);
+	g_free(sd);
+}
+
 void eir_data_free(struct eir_data *eir)
 {
 	g_slist_free_full(eir->services, free);
@@ -55,6 +63,8 @@ void eir_data_free(struct eir_data *eir)
 	eir->randomizer = NULL;
 	g_slist_free_full(eir->msd_list, g_free);
 	eir->msd_list = NULL;
+	g_slist_free_full(eir->sd_list, sd_free);
+	eir->sd_list = NULL;
 }
 
 static void eir_parse_uuid16(struct eir_data *eir, const void *data,
@@ -155,6 +165,63 @@ static void eir_parse_msd(struct eir_data *eir, const uint8_t *data,
 	eir->msd_list = g_slist_append(eir->msd_list, msd);
 }
 
+static void eir_parse_sd(struct eir_data *eir, uuid_t *service,
+					const uint8_t *data, uint8_t len)
+{
+	struct eir_sd *sd;
+	char *uuid;
+
+	uuid = bt_uuid2string(service);
+	if (!uuid)
+		return;
+
+	sd = g_malloc(sizeof(*sd));
+	sd->uuid = uuid;
+	sd->data_len = len;
+	memcpy(&sd->data, data, sd->data_len);
+
+	eir->sd_list = g_slist_append(eir->sd_list, sd);
+}
+
+static void eir_parse_uuid16_data(struct eir_data *eir, const uint8_t *data,
+								uint8_t len)
+{
+	uuid_t service;
+
+	if (len < 2 || len > EIR_SD_MAX_LEN)
+		return;
+
+	service.value.uuid16 = get_le16(data);
+	eir_parse_sd(eir, &service, data + 2, len - 2);
+}
+
+static void eir_parse_uuid32_data(struct eir_data *eir, const uint8_t *data,
+								uint8_t len)
+{
+	uuid_t service;
+
+	if (len < 4 || len > EIR_SD_MAX_LEN)
+		return;
+
+	service.value.uuid32 = get_le32(data);
+	eir_parse_sd(eir, &service, data + 4, len - 4);
+}
+
+static void eir_parse_uuid128_data(struct eir_data *eir, const uint8_t *data,
+								uint8_t len)
+{
+	uuid_t service;
+	int k;
+
+	if (len < 16 || len > EIR_SD_MAX_LEN)
+		return;
+
+	for (k = 0; k < 16; k++)
+		service.value.uuid128.data[k] = data[16 - k - 1];
+
+	eir_parse_sd(eir, &service, data + 16, len - 16);
+}
+
 void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 {
 	uint16_t len = 0;
@@ -259,9 +326,22 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			eir->did_version = data[6] | (data[7] << 8);
 			break;
 
+		case EIR_SVC_DATA16:
+			eir_parse_uuid16_data(eir, data, data_len);
+			break;
+
+		case EIR_SVC_DATA32:
+			eir_parse_uuid32_data(eir, data, data_len);
+			break;
+
+		case EIR_SVC_DATA128:
+			eir_parse_uuid128_data(eir, data, data_len);
+			break;
+
 		case EIR_MANUFACTURER_DATA:
 			eir_parse_msd(eir, data, data_len);
 			break;
+
 		}
 
 		eir_data += field_len + 1;
diff --git a/src/eir.h b/src/eir.h
index 279da70..219ee79 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -60,6 +60,7 @@
 #define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
 					    Device Capable (Host) */
 
+#define EIR_SD_MAX_LEN              238  /* 240 (EIR) - 2 (len) */
 #define EIR_MSD_MAX_LEN             236  /* 240 (EIR) - 2 (len & type) - 2 */
 
 struct eir_msd {
@@ -68,6 +69,12 @@ struct eir_msd {
 	uint8_t data_len;
 };
 
+struct eir_sd {
+	char *uuid;
+	uint8_t data[EIR_SD_MAX_LEN];
+	uint8_t data_len;
+};
+
 struct eir_data {
 	GSList *services;
 	unsigned int flags;
@@ -84,6 +91,7 @@ struct eir_data {
 	uint16_t did_version;
 	uint16_t did_source;
 	GSList *msd_list;
+	GSList *sd_list;
 };
 
 void eir_data_free(struct eir_data *eir);
-- 
2.1.0

