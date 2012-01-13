Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 3/4] map_ap.c: Add implementation for map_ap_decode()
Date: Fri, 13 Jan 2012 11:48:31 +0100
Message-Id: <1326451712-21784-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1326451712-21784-1-git-send-email-lkslawek@gmail.com>
References: <1326451712-21784-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/map_ap.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index 0ed097f..2e7758e 100644
--- a/src/map_ap.c
+++ b/src/map_ap.c
@@ -25,6 +25,10 @@
 #include <config.h>
 #endif
 
+#include <string.h>
+
+#include "log.h"
+
 #include "map_ap.h"
 
 enum ap_type {
@@ -103,6 +107,13 @@ struct ap_entry {
 	};
 };
 
+/* This comes from OBEX specs */
+struct obex_ap_header {
+	uint8_t tag;
+	uint8_t len;
+	uint8_t val[0];
+} __attribute__ ((packed));
+
 static int find_ap_def(uint8_t tag)
 {
 	int i;
@@ -142,7 +153,82 @@ void map_ap_free(map_ap_t *ap)
 
 map_ap_t *map_ap_decode(const uint8_t *buffer, size_t length)
 {
-	return NULL;
+	GHashTable *ap;
+	struct obex_ap_header *hdr;
+	uint32_t done = 0;
+	uint16_t val16;
+	uint32_t val32;
+	char *valstr;
+	int tago;
+
+	ap = map_ap_new();
+	if (!ap)
+		return NULL;
+
+	while (done < length) {
+		hdr = (void *) buffer + done;
+
+		tago = find_ap_def(hdr->tag);
+
+		if (tago < 0) {
+			DBG("Unknown tag %d (length %d) - skipped.",
+							hdr->tag, hdr->len);
+			goto skip;
+		}
+
+		switch (ap_defs[tago].type) {
+		case APT_UINT8:
+			if (hdr->len != 1) {
+				DBG("Value of tag %s (%d) is %d bytes long "
+						"instead of expected 1 byte - "
+						"skipped!", ap_defs[tago].name,
+						hdr->tag, hdr->len);
+				break;
+			}
+
+			map_ap_set_u8(ap, hdr->tag, hdr->val[0]);
+
+			break;
+		case APT_UINT16:
+			if (hdr->len != 2) {
+				DBG("Value of tag %s (%d) is %d bytes long "
+						"instead of expected 2 bytes - "
+						"skipped!", ap_defs[tago].name,
+						hdr->tag, hdr->len);
+				break;
+			}
+
+			memcpy(&val16, hdr->val, sizeof(val16));
+			map_ap_set_u16(ap, hdr->tag, GUINT16_FROM_BE(val16));
+
+			break;
+		case APT_UINT32:
+			if (hdr->len != 4) {
+				DBG("Value of tag %s (%d) is %d bytes long "
+						"instead of expected 4 bytes - "
+						"skipped!", ap_defs[tago].name,
+						hdr->tag, hdr->len);
+				break;
+			}
+
+			memcpy(&val32, hdr->val, sizeof(val32));
+			map_ap_set_u32(ap, hdr->tag, GUINT32_FROM_BE(val32));
+
+			break;
+		case APT_STR:
+			valstr = g_malloc0(hdr->len + 1);
+			memcpy(valstr, hdr->val, hdr->len);
+			map_ap_set_string(ap, hdr->tag, valstr);
+			g_free(valstr);
+
+			break;
+		}
+
+skip:
+		done += hdr->len + sizeof(struct obex_ap_header);
+	}
+
+	return ap;
 }
 
 uint8_t *map_ap_encode(map_ap_t *ap, size_t *length)
-- 
1.7.4.1

