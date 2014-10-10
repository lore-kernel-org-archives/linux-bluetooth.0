Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] core: Add Manufacturer Specific Data EIR field
Date: Fri, 10 Oct 2014 11:37:33 +0000
Message-Id: <1412941053-11835-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Athough the Manufacturer Specific Data field is not used internally,
it's useful for external plugins, e.g. iBeacon.
---
 src/eir.c | 8 ++++++++
 src/eir.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index d22ad91..f130855 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -240,6 +240,14 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			eir->did_product = data[4] | (data[5] << 8);
 			eir->did_version = data[6] | (data[7] << 8);
 			break;
+
+		case EIR_MANUFACTURER_DATA:
+			if (data_len < 2)
+				break;
+			eir->msd_company = get_le16(data);
+			eir->msd_data_len = data_len - 2;
+			memcpy(&eir->msd_data, data+2, eir->msd_data_len);
+			break;
 		}
 
 		eir_data += field_len + 1;
diff --git a/src/eir.h b/src/eir.h
index e486fa2..88a5bf0 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -37,6 +37,7 @@
 #define EIR_SSP_RANDOMIZER          0x0F  /* SSP Randomizer */
 #define EIR_DEVICE_ID               0x10  /* device ID */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
+#define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer Specific Data */
 
 /* Flags Descriptions */
 #define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
@@ -62,6 +63,9 @@ struct eir_data {
 	uint16_t did_product;
 	uint16_t did_version;
 	uint16_t did_source;
+	uint16_t msd_company;
+	uint8_t msd_data[HCI_MAX_EIR_LENGTH];
+	uint8_t msd_data_len;
 };
 
 void eir_data_free(struct eir_data *eir);
-- 
1.9.1

