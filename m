Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 15/25] eir: Add manufacturer and service data fields
Date: Fri, 21 Dec 2012 16:26:42 -0400
Message-Id: <1356121612-15172-16-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

For advertising, there are another possible fields, Service Data and
Manufacturer Specific Data.
---
 src/eir.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 src/eir.h |   16 ++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index 1b6db8c..96adc5c 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -41,6 +41,22 @@
 
 #define EIR_OOB_MIN (2 + 6)
 
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
@@ -51,6 +67,10 @@ void eir_data_free(struct eir_data *eir)
 	eir->hash = NULL;
 	g_free(eir->randomizer);
 	eir->randomizer = NULL;
+	g_slist_free_full(eir->svcs_data, svc_data_free);
+	eir->svcs_data = NULL;
+	g_slist_free_full(eir->manufs_data, manuf_data_free);
+	eir->manufs_data = NULL;
 }
 
 static void eir_parse_uuid16(struct eir_data *eir, void *data, uint8_t len)
@@ -139,6 +159,8 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 	while (len < eir_len - 1) {
 		uint8_t field_len = eir_data[0];
 		uint8_t data_len, *data = &eir_data[2];
+		struct svc_data *sdata;
+		struct manuf_data *mdata;
 
 		/* Check for the end of EIR */
 		if (field_len == 0)
@@ -193,6 +215,16 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 							(data[2] << 16);
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
@@ -209,6 +241,16 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 			if (data_len < 16)
 				break;
 			eir->randomizer = g_memdup(data, 16);
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
 			break;
 		}
 
diff --git a/src/eir.h b/src/eir.h
index 91e045e..e410753 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -36,7 +36,21 @@
 #define EIR_SSP_HASH                0x0E  /* SSP Hash */
 #define EIR_SSP_RANDOMIZER          0x0F  /* SSP Randomizer */
 #define EIR_DEVICE_ID               0x10  /* device ID */
+#define EIR_SVC_DATA                0x16  /* service data */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
+#define EIR_MANUF_DATA              0xFF  /* manufacturer specific data */
+
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
 
 struct eir_data {
 	GSList *services;
@@ -48,6 +62,8 @@ struct eir_data {
 	uint8_t *hash;
 	uint8_t *randomizer;
 	bdaddr_t addr;
+	GSList *svcs_data;
+	GSList *manufs_data;
 };
 
 void eir_data_free(struct eir_data *eir);
-- 
1.7.9.5

