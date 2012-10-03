Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v4 08/18] eir: Remove support for creating EIR with tx_power fields
Date: Wed, 3 Oct 2012 15:18:21 +0200
Message-ID: <1349270311-31103-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
References: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This field is not used for OOB EIR.

---
 src/eir.c |    9 +--------
 src/eir.h |    2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index f291bc5..ac9d13f 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -278,7 +278,7 @@ static void eir_generate_uuid128(GSList *list, uint8_t *ptr, uint16_t *eir_len)
 	}
 }
 
-void eir_create_oob(const char *name, int8_t tx_power, uint32_t cod,
+void eir_create_oob(const char *name, uint32_t cod,
 			uint8_t *hash, uint8_t *randomizer,
 			uint16_t did_vendor, uint16_t did_product,
 			uint16_t did_version, uint16_t did_source,
@@ -347,13 +347,6 @@ void eir_create_oob(const char *name, int8_t tx_power, uint32_t cod,
 		ptr += (name_len + 2);
 	}
 
-	if (tx_power != 0) {
-		*ptr++ = 2;
-		*ptr++ = EIR_TX_POWER;
-		*ptr++ = (uint8_t) tx_power;
-		eir_len += 3;
-	}
-
 	if (did_vendor != 0x0000) {
 		*ptr++ = 9;
 		*ptr++ = EIR_DEVICE_ID;
diff --git a/src/eir.h b/src/eir.h
index 55289f9..d5c4afc 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -58,7 +58,7 @@ struct eir_data {
 void eir_data_free(struct eir_data *eir);
 int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len);
 int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len);
-void eir_create_oob(const char *name, int8_t tx_power, uint32_t cod,
+void eir_create_oob(const char *name, uint32_t cod,
 			uint8_t *hash, uint8_t *randomizer,
 			uint16_t did_vendor, uint16_t did_product,
 			uint16_t did_version, uint16_t did_source,
-- 
1.7.9.5

