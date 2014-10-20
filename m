Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/2] core: Add Manufacturer Specific Data EIR field
Date: Mon, 20 Oct 2014 14:51:00 +0000
Message-Id: <1413816661-19290-2-git-send-email-fons@spotify.com>
In-Reply-To: <1413816661-19290-1-git-send-email-fons@spotify.com>
References: <1413816661-19290-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add data structure and parsing support.
---
 src/eir.c | 22 ++++++++++++++++++++++
 src/eir.h | 10 ++++++++++
 2 files changed, 32 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index d22ad91..2ea8731 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -53,6 +53,8 @@ void eir_data_free(struct eir_data *eir)
 	eir->hash = NULL;
 	g_free(eir->randomizer);
 	eir->randomizer = NULL;
+	g_slist_free_full(eir->msd_list, g_free);
+	eir->msd_list = NULL;
 }
 
 static void eir_parse_uuid16(struct eir_data *eir, const void *data,
@@ -137,6 +139,22 @@ static char *name2utf8(const uint8_t *name, uint8_t len)
 	return g_strdup(utf8_name);
 }
 
+static void eir_parse_msd(struct eir_data *eir, const uint8_t *data,
+								uint8_t len)
+{
+	struct eir_msd *msd;
+
+	if (len < 2 || len > 2 + sizeof(msd->data))
+		return;
+
+	msd = g_malloc(sizeof(*msd));
+	msd->company = get_le16(data);
+	msd->data_len = len - 2;
+	memcpy(&msd->data, data + 2, msd->data_len);
+
+	eir->msd_list = g_slist_append(eir->msd_list, msd);
+}
+
 void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 {
 	uint16_t len = 0;
@@ -240,6 +258,10 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			eir->did_product = data[4] | (data[5] << 8);
 			eir->did_version = data[6] | (data[7] << 8);
 			break;
+
+		case EIR_MANUFACTURER_DATA:
+			eir_parse_msd(eir, data, data_len);
+			break;
 		}
 
 		eir_data += field_len + 1;
diff --git a/src/eir.h b/src/eir.h
index e486fa2..86a9527 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -22,6 +22,8 @@
  *
  */
 
+#include <hci.h>
+
 #define EIR_FLAGS                   0x01  /* flags */
 #define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
 #define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
@@ -37,6 +39,7 @@
 #define EIR_SSP_RANDOMIZER          0x0F  /* SSP Randomizer */
 #define EIR_DEVICE_ID               0x10  /* device ID */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
+#define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer Specific Data */
 
 /* Flags Descriptions */
 #define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
@@ -47,6 +50,12 @@
 #define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
 					    Device Capable (Host) */
 
+struct eir_msd {
+	uint16_t company;
+	uint8_t data[HCI_MAX_EIR_LENGTH];
+	uint8_t data_len;
+};
+
 struct eir_data {
 	GSList *services;
 	unsigned int flags;
@@ -62,6 +71,7 @@ struct eir_data {
 	uint16_t did_product;
 	uint16_t did_version;
 	uint16_t did_source;
+	GSList *msd_list;
 };
 
 void eir_data_free(struct eir_data *eir);
-- 
1.9.1

