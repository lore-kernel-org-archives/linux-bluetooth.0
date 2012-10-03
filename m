Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v4 09/18] eir: Return number of bytes written by eir_create_oob
Date: Wed, 3 Oct 2012 15:18:22 +0200
Message-ID: <1349270311-31103-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
References: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In OOB EIR is not zero padded.

---
 src/eir.c |    4 +++-
 src/eir.h |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index ac9d13f..b09c913 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -278,7 +278,7 @@ static void eir_generate_uuid128(GSList *list, uint8_t *ptr, uint16_t *eir_len)
 	}
 }
 
-void eir_create_oob(const char *name, uint32_t cod,
+int eir_create_oob(const char *name, uint32_t cod,
 			uint8_t *hash, uint8_t *randomizer,
 			uint16_t did_vendor, uint16_t did_product,
 			uint16_t did_version, uint16_t did_source,
@@ -410,6 +410,8 @@ void eir_create_oob(const char *name, uint32_t cod,
 	/* Group all UUID128 types */
 	if (eir_len <= HCI_MAX_EIR_LENGTH - 2)
 		eir_generate_uuid128(uuids, ptr, &eir_len);
+
+	return eir_len;
 }
 
 gboolean eir_has_data_type(uint8_t *data, size_t len, uint8_t type)
diff --git a/src/eir.h b/src/eir.h
index d5c4afc..036172e 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -58,7 +58,7 @@ struct eir_data {
 void eir_data_free(struct eir_data *eir);
 int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len);
 int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len);
-void eir_create_oob(const char *name, uint32_t cod,
+int eir_create_oob(const char *name, uint32_t cod,
 			uint8_t *hash, uint8_t *randomizer,
 			uint16_t did_vendor, uint16_t did_product,
 			uint16_t did_version, uint16_t did_source,
-- 
1.7.9.5

