Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 04/18] eir: Add eir_parse_oob function
Date: Fri, 21 Sep 2012 14:36:21 +0200
Message-ID: <1348230995-8967-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will parse EIR received over OOB. Such EIR contains mandatory
and optional part.

---
 src/eir.c |   25 +++++++++++++++++++++++++
 src/eir.h |    2 ++
 2 files changed, 27 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index 4b054ea..144f65c 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -38,6 +38,8 @@
 #include "glib-helper.h"
 #include "eir.h"
 
+#define EIR_OOB_MIN (2 + 6)
+
 void eir_data_free(struct eir_data *eir)
 {
 	g_slist_free_full(eir->services, g_free);
@@ -197,6 +199,29 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 	return 0;
 }
 
+int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len)
+{
+
+	if (eir_len < EIR_OOB_MIN)
+		return -1;
+
+	if (eir_len != bt_get_le16(eir_data))
+		return -1;
+
+	eir_data += sizeof(uint16_t);
+	eir_len -= sizeof(uint16_t);
+
+	memcpy(&eir->addr, eir_data, sizeof(bdaddr_t));
+	eir_data += sizeof(bdaddr_t);
+	eir_len -= sizeof(bdaddr_t);
+
+	/* optional OOB EIR data */
+	if (eir_len > 0)
+		return eir_parse(eir, eir_data, eir_len);
+
+	return 0;
+}
+
 #define SIZEOF_UUID128 16
 
 static void eir_generate_uuid128(GSList *list, uint8_t *ptr, uint16_t *eir_len)
diff --git a/src/eir.h b/src/eir.h
index 3a52563..d2d6dc7 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -52,10 +52,12 @@ struct eir_data {
 	gboolean name_complete;
 	uint8_t *hash;
 	uint8_t *randomizer;
+	bdaddr_t addr;
 };
 
 void eir_data_free(struct eir_data *eir);
 int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len);
+int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len);
 void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 			uint16_t did_product, uint16_t did_version,
 			uint16_t did_source, GSList *uuids, uint8_t *data);
-- 
1.7.9.5

