Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v2 3/4] map_ap.c: Add implementation for map_ap_decode()
Date: Fri, 13 Jan 2012 14:33:37 +0100
Message-Id: <1326461618-26864-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1326461618-26864-1-git-send-email-lkslawek@gmail.com>
References: <1326461618-26864-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/map_ap.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 100 insertions(+), 1 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index b9f1835..d3729c5 100644
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
@@ -141,9 +152,97 @@ void map_ap_free(map_ap_t *ap)
 	g_hash_table_destroy(ap);
 }
 
+static void ap_decode_u8(map_ap_t *ap, const struct obex_ap_header *hdr)
+{
+	if (hdr->len != 1) {
+		DBG("Value of tag %d is %d bytes long instead of expected "
+				"1 byte - skipped!", hdr->tag, hdr->len);
+		return;
+	}
+
+	map_ap_set_u8(ap, hdr->tag, hdr->val[0]);
+}
+
+static void ap_decode_u16(map_ap_t *ap, const struct obex_ap_header *hdr)
+{
+	uint16_t val16;
+
+	if (hdr->len != 2) {
+		DBG("Value of tag %d is %d bytes long instead of expected "
+				"2 bytes - skipped!", hdr->tag, hdr->len);
+		return;
+	}
+
+	memcpy(&val16, hdr->val, sizeof(val16));
+	map_ap_set_u16(ap, hdr->tag, GUINT16_FROM_BE(val16));
+}
+
+static void ap_decode_u32(map_ap_t *ap, const struct obex_ap_header *hdr)
+{
+	uint32_t val32;
+
+	if (hdr->len != 4) {
+		DBG("Value of tag %d is %d bytes long instead of expected "
+				"4 bytes - skipped!", hdr->tag, hdr->len);
+		return;
+	}
+
+	memcpy(&val32, hdr->val, sizeof(val32));
+	map_ap_set_u32(ap, hdr->tag, GUINT32_FROM_BE(val32));
+}
+
+static void ap_decode_str(map_ap_t *ap, const struct obex_ap_header *hdr)
+{
+	char *valstr = g_malloc0(hdr->len + 1);
+
+	memcpy(valstr, hdr->val, hdr->len);
+	map_ap_set_string(ap, hdr->tag, valstr);
+
+	g_free(valstr);
+}
+
 map_ap_t *map_ap_decode(const uint8_t *buffer, size_t length)
 {
-	return NULL;
+	map_ap_t *ap;
+	struct obex_ap_header *hdr;
+	uint32_t done = 0;
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
+			ap_decode_u8(ap, hdr);
+			break;
+		case APT_UINT16:
+			ap_decode_u16(ap, hdr);
+			break;
+		case APT_UINT32:
+			ap_decode_u32(ap, hdr);
+			break;
+		case APT_STR:
+			ap_decode_str(ap, hdr);
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

