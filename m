Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/3] eir: Add support for parsing  DeviceID info
Date: Sat, 18 Jan 2014 15:57:12 +0100
Message-Id: <1390057034-7983-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/eir.c | 10 ++++++++++
 src/eir.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index 5f3f059..d85ac7e 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -223,6 +223,16 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 				break;
 			eir->randomizer = g_memdup(data, 16);
 			break;
+
+		case EIR_DEVICE_ID:
+			if (data_len < 8)
+				break;
+
+			eir->did_source = data[0] | (data[1] << 8);
+			eir->did_vendor = data[2] | (data[3] << 8);
+			eir->did_product = data[4] | (data[5] << 8);
+			eir->did_version = data[6] | (data[7] << 8);
+			break;
 		}
 
 		eir_data += field_len + 1;
diff --git a/src/eir.h b/src/eir.h
index 888f382..3fa1cb3 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -49,6 +49,10 @@ struct eir_data {
 	uint8_t *hash;
 	uint8_t *randomizer;
 	bdaddr_t addr;
+	uint16_t did_vendor;
+	uint16_t did_product;
+	uint16_t did_version;
+	uint16_t did_source;
 };
 
 void eir_data_free(struct eir_data *eir);
-- 
1.8.5.3

