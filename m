Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] core: Add Manufacturer Specific Data EIR field
Date: Mon, 13 Oct 2014 11:43:42 +0000
Message-Id: <1413200623-31278-3-git-send-email-fons@spotify.com>
In-Reply-To: <1413200623-31278-1-git-send-email-fons@spotify.com>
References: <1413200623-31278-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add data structure and parsing support.
---
 src/eir.c | 11 +++++++++++
 src/eir.h |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index d22ad91..8ebefaa 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -53,6 +53,8 @@ void eir_data_free(struct eir_data *eir)
 	eir->hash = NULL;
 	g_free(eir->randomizer);
 	eir->randomizer = NULL;
+	g_free(eir->msd);
+	eir->msd = NULL;
 }
 
 static void eir_parse_uuid16(struct eir_data *eir, const void *data,
@@ -240,6 +242,15 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			eir->did_product = data[4] | (data[5] << 8);
 			eir->did_version = data[6] | (data[7] << 8);
 			break;
+
+		case EIR_MANUFACTURER_DATA:
+			if (data_len < 2 || data_len > 2 + sizeof(eir->msd->data))
+				break;
+			eir->msd = g_malloc(sizeof(*eir->msd));
+			eir->msd->company = get_le16(data);
+			eir->msd->data_len = data_len - 2;
+			memcpy(&eir->msd->data, data + 2, eir->msd->data_len);
+			break;
 		}
 
 		eir_data += field_len + 1;
diff --git a/src/eir.h b/src/eir.h
index e486fa2..4cc9dbf 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -37,6 +37,7 @@
 #define EIR_SSP_RANDOMIZER          0x0F  /* SSP Randomizer */
 #define EIR_DEVICE_ID               0x10  /* device ID */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
+#define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer Specific Data */
 
 /* Flags Descriptions */
 #define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
@@ -47,6 +48,12 @@
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
@@ -62,6 +69,7 @@ struct eir_data {
 	uint16_t did_product;
 	uint16_t did_version;
 	uint16_t did_source;
+	struct eir_msd *msd;
 };
 
 void eir_data_free(struct eir_data *eir);
-- 
1.9.1

