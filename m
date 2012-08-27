Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 21/33] eir: Add manufacturer and service data fields
Date: Mon, 27 Aug 2012 13:03:13 -0400
Message-Id: <1346087005-24693-22-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

For advertising, there are another possible fields, Service Data and
Manufacturer Specific Data.
---
 src/eir.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 src/eir.h |   16 ++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index 9d42917..676e303 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -38,12 +38,32 @@
 #include "glib-helper.h"
 #include "eir.h"
 
+static void svc_data_free(void *p)
+{
+	struct svc_data *sdata = p;
+
+	g_free(sdata->data);
+	g_free(sdata);
+}
+
+static void manuf_data_free(void *p)
+{
+	struct manuf_data *mdata = p;
+
+	g_free(mdata->data);
+	g_free(mdata);
+}
+
 void eir_data_free(struct eir_data *eir)
 {
 	g_slist_free_full(eir->services, g_free);
 	eir->services = NULL;
 	g_free(eir->name);
 	eir->name = NULL;
+	g_slist_free_full(eir->svcs_data, svc_data_free);
+	eir->svcs_data = NULL;
+	g_slist_free_full(eir->manufs_data, manuf_data_free);
+	eir->manufs_data = NULL;
 }
 
 static void eir_parse_uuid16(struct eir_data *eir, void *data, uint8_t len)
@@ -107,6 +127,8 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 	while (len < eir_len - 1) {
 		uint8_t field_len = eir_data[0];
 		uint8_t data_len, *data = &eir_data[2];
+		struct svc_data *sdata;
+		struct manuf_data *mdata;
 
 		/* Check for the end of EIR */
 		if (field_len == 0)
@@ -163,11 +185,32 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 			memcpy(eir->dev_class, data, 3);
 			break;
 
+		case EIR_SVC_DATA:
+			if (data_len < 2)
+				break;
+			sdata = g_new(struct svc_data, 1);
+			sdata->uuid = bt_get_le16(data);
+			sdata->data_len = data_len - 2;
+			sdata->data = g_memdup(data + 2, data_len - 2);
+			eir->svcs_data = g_slist_append(eir->svcs_data, sdata);
+			break;
+
 		case EIR_GAP_APPEARANCE:
 			if (data_len < 2)
 				break;
 			eir->appearance = bt_get_le16(data);
 			break;
+
+		case EIR_MANUF_DATA:
+			if (data_len < 2)
+				break;
+			mdata = g_new(struct manuf_data, 1);
+			mdata->company_id = bt_get_le16(data);
+			mdata->data_len = data_len - 2;
+			mdata->data = g_memdup(data + 2, data_len - 2);
+			eir->manufs_data = g_slist_append(eir->manufs_data,
+									mdata);
+			break;
 		}
 
 		eir_data += field_len + 1;
diff --git a/src/eir.h b/src/eir.h
index 3c81024..f8e6c7c 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -34,13 +34,27 @@
 #define EIR_TX_POWER                0x0A  /* transmit power level */
 #define EIR_CLASS_OF_DEV            0x0D  /* Class of Device */
 #define EIR_DEVICE_ID               0x10  /* device ID */
+#define EIR_SVC_DATA                0x16  /* service data */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
+#define EIR_MANUF_DATA              0xFF  /* manufacturer specific data */
 
 struct uuid_info {
 	uuid_t uuid;
 	uint8_t svc_hint;
 };
 
+struct svc_data {
+	uint16_t uuid;
+	uint8_t data_len;
+	uint8_t *data;
+};
+
+struct manuf_data {
+	uint16_t company_id;
+	uint8_t data_len;
+	uint8_t *data;
+};
+
 struct eir_data {
 	GSList *services;
 	int flags;
@@ -48,6 +62,8 @@ struct eir_data {
 	uint8_t dev_class[3];
 	uint16_t appearance;
 	gboolean name_complete;
+	GSList *svcs_data;
+	GSList *manufs_data;
 };
 
 void eir_data_free(struct eir_data *eir);
-- 
1.7.9.5

