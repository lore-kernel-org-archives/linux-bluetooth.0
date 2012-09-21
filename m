Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 02/18] eir: Add support for parsing SSP hash and randomizer
Date: Fri, 21 Sep 2012 14:36:19 +0200
Message-ID: <1348230995-8967-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used over OOB mechanism.

---
 src/eir.c |   18 ++++++++++++++++++
 src/eir.h |    4 ++++
 2 files changed, 22 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index 50912a0..c29be40 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -44,6 +44,10 @@ void eir_data_free(struct eir_data *eir)
 	eir->services = NULL;
 	g_free(eir->name);
 	eir->name = NULL;
+	g_free(eir->hash);
+	eir->hash = NULL;
+	g_free(eir->randomizer);
+	eir->randomizer = NULL;
 }
 
 static void eir_parse_uuid16(struct eir_data *eir, void *data, uint8_t len)
@@ -170,6 +174,20 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 				break;
 			eir->appearance = bt_get_le16(data);
 			break;
+
+		case EIR_SSP_HASH:
+			if (data_len < 16)
+				break;
+			eir->hash = g_malloc(16);
+			memcpy(eir->hash, data, 16);
+			break;
+
+		case EIR_SSP_RANDOMIZER:
+			if (data_len < 16)
+				break;
+			eir->randomizer = g_malloc(16);
+			memcpy(eir->randomizer, data, 16);
+			break;
 		}
 
 		eir_data += field_len + 1;
diff --git a/src/eir.h b/src/eir.h
index 3c81024..e6e870a 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -33,6 +33,8 @@
 #define EIR_NAME_COMPLETE           0x09  /* complete local name */
 #define EIR_TX_POWER                0x0A  /* transmit power level */
 #define EIR_CLASS_OF_DEV            0x0D  /* Class of Device */
+#define EIR_SSP_HASH                0x0E  /* SSP Hash */
+#define EIR_SSP_RANDOMIZER          0x0F  /* SSP Randomizer */
 #define EIR_DEVICE_ID               0x10  /* device ID */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
 
@@ -48,6 +50,8 @@ struct eir_data {
 	uint8_t dev_class[3];
 	uint16_t appearance;
 	gboolean name_complete;
+	uint8_t *hash;
+	uint8_t *randomizer;
 };
 
 void eir_data_free(struct eir_data *eir);
-- 
1.7.9.5

