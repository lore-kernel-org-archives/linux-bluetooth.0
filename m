Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/18] eir: Add support creating EIR with hash and randomizer fields
Date: Fri, 21 Sep 2012 12:02:20 +0200
Message-ID: <1348221750-15345-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com>
References: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used to create EIR to be send over OOB channel.

---
 src/eir.c |   28 +++++++++++++++++++++++++---
 src/eir.h |    8 +++++---
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index 144f65c..0ef18e2 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -280,9 +280,11 @@ static void eir_generate_uuid128(GSList *list, uint8_t *ptr, uint16_t *eir_len)
 	}
 }
 
-void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
-			uint16_t did_product, uint16_t did_version,
-			uint16_t did_source, GSList *uuids, uint8_t *data)
+void eir_create(const char *name, int8_t tx_power,
+			uint8_t *hash, uint8_t *randomizer,
+			uint16_t did_vendor, uint16_t did_product,
+			uint16_t did_version, uint16_t did_source,
+			GSList *uuids, uint8_t *data)
 {
 	GSList *l;
 	uint8_t *ptr = data;
@@ -292,6 +294,26 @@ void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 	gboolean truncated = FALSE;
 	size_t name_len;
 
+	if (hash) {
+		*ptr++ = 17;
+		*ptr++ = EIR_SSP_HASH;
+
+		memcpy(ptr, hash, 16);
+		ptr += 16;
+
+		eir_len += 16 + 2;
+	}
+
+	if (randomizer) {
+		*ptr++ = 17;
+		*ptr++ = EIR_SSP_RANDOMIZER;
+
+		memcpy(ptr, randomizer, 16);
+		ptr += 16;
+
+		eir_len += 16 + 2;
+	}
+
 	name_len = strlen(name);
 
 	if (name_len > 0) {
diff --git a/src/eir.h b/src/eir.h
index d2d6dc7..844c162 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -58,9 +58,11 @@ struct eir_data {
 void eir_data_free(struct eir_data *eir);
 int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len);
 int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len);
-void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
-			uint16_t did_product, uint16_t did_version,
-			uint16_t did_source, GSList *uuids, uint8_t *data);
+void eir_create(const char *name, int8_t tx_power,
+			uint8_t *hash, uint8_t *randomizer,
+			uint16_t did_vendor, uint16_t did_product,
+			uint16_t did_version, uint16_t did_source,
+			GSList *uuids, uint8_t *data);
 
 gboolean eir_has_data_type(uint8_t *data, size_t len, uint8_t type);
 
-- 
1.7.9.5

