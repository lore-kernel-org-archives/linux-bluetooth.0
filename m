Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 5/7] src/eir: Added support for Slave Connection Interval Range AD
Date: Thu, 16 Feb 2017 18:03:13 +0000
Message-Id: <20170216180315.30531-6-eu@felipetonello.com>
In-Reply-To: <20170216180315.30531-1-eu@felipetonello.com>
References: <20170216180315.30531-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Slave Connection Interval Range data type contains the Peripheral's
preferred connection interval range, for all logical connections.
---
 src/eir.c | 7 +++++++
 src/eir.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index c984fa5a787c..98fe44beb4b3 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -346,6 +346,13 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			eir_parse_msd(eir, data, data_len);
 			break;
 
+		case EIR_SLAVE_CONN_INT:
+			if (data_len < 4)
+				break;
+			eir->le_min_conn_interval = get_le16(&data[0]);
+			eir->le_max_conn_interval = get_le16(&data[2]);
+			break;
+
 		}
 
 		eir_data += field_len + 1;
diff --git a/src/eir.h b/src/eir.h
index 219ee794b8ee..51aa875b1600 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -40,6 +40,7 @@
 #define EIR_SSP_HASH                0x0E  /* SSP Hash */
 #define EIR_SSP_RANDOMIZER          0x0F  /* SSP Randomizer */
 #define EIR_DEVICE_ID               0x10  /* device ID */
+#define EIR_SLAVE_CONN_INT          0x12  /* Slave Connection Interval Range */
 #define EIR_SOLICIT16               0x14  /* LE: Solicit UUIDs, 16-bit */
 #define EIR_SOLICIT128              0x15  /* LE: Solicit UUIDs, 128-bit */
 #define EIR_SVC_DATA16              0x16  /* LE: Service data, 16-bit UUID */
@@ -90,6 +91,8 @@ struct eir_data {
 	uint16_t did_product;
 	uint16_t did_version;
 	uint16_t did_source;
+	uint16_t le_min_conn_interval;
+	uint16_t le_max_conn_interval;
 	GSList *msd_list;
 	GSList *sd_list;
 };
-- 
2.11.1

