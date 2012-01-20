Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v5.1 4/5] map_ap.c: Add implementation for map_ap_decode()
Date: Fri, 20 Jan 2012 13:25:23 +0100
Message-Id: <1327062323-26466-1-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1326992516-2800-5-git-send-email-lkslawek@gmail.com>
References: <1326992516-2800-5-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
v5.1:
Fixed pointer arithmetic
Fixed format specifier for unsigned integers

 src/map_ap.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 97 insertions(+), 1 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index b71cd35..1c6185e 100644
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
@@ -76,6 +80,13 @@ struct ap_entry {
 	} val;
 };
 
+/* This comes from OBEX specs */
+struct obex_ap_header {
+	uint8_t tag;
+	uint8_t len;
+	uint8_t val[0];
+} __attribute__ ((packed));
+
 static int find_ap_def_offset(uint8_t tag)
 {
 	if (tag == 0 || tag > G_N_ELEMENTS(ap_defs))
@@ -111,9 +122,94 @@ void map_ap_free(map_ap_t *ap)
 	g_hash_table_destroy(ap);
 }
 
+static void ap_decode_u8(map_ap_t *ap, const struct obex_ap_header *hdr)
+{
+	if (hdr->len != 1) {
+		DBG("Value of tag %u is %u byte(s) long instead of expected "
+				"1 byte - skipped!", hdr->tag, hdr->len);
+		return;
+	}
+
+	map_ap_set_u8(ap, hdr->tag, hdr->val[0]);
+}
+
+static void ap_decode_u16(map_ap_t *ap, const struct obex_ap_header *hdr)
+{
+	uint16_t val;
+
+	if (hdr->len != 2) {
+		DBG("Value of tag %u is %u byte(s) long instead of expected "
+				"2 bytes - skipped!", hdr->tag, hdr->len);
+		return;
+	}
+
+	memcpy(&val, hdr->val, sizeof(val));
+	map_ap_set_u16(ap, hdr->tag, GUINT16_FROM_BE(val));
+}
+
+static void ap_decode_u32(map_ap_t *ap, const struct obex_ap_header *hdr)
+{
+	uint32_t val;
+
+	if (hdr->len != 4) {
+		DBG("Value of tag %u is %u byte(s) long instead of expected "
+				"4 bytes - skipped!", hdr->tag, hdr->len);
+		return;
+	}
+
+	memcpy(&val, hdr->val, sizeof(val));
+	map_ap_set_u32(ap, hdr->tag, GUINT32_FROM_BE(val));
+}
+
+static void ap_decode_str(map_ap_t *ap, const struct obex_ap_header *hdr)
+{
+	char *val = g_malloc0(hdr->len + 1);
+
+	memcpy(val, hdr->val, hdr->len);
+	map_ap_set_string(ap, hdr->tag, val);
+
+	g_free(val);
+}
+
 map_ap_t *map_ap_decode(const uint8_t *buffer, size_t length)
 {
-	return NULL;
+	map_ap_t *ap;
+	struct obex_ap_header *hdr;
+	uint32_t done;
+	int offset;
+
+	ap = map_ap_new();
+	if (!ap)
+		return NULL;
+
+	for (done = 0;  done < length; done += hdr->len + sizeof(*hdr)) {
+		hdr = (struct obex_ap_header *)(buffer + done);
+
+		offset = find_ap_def_offset(hdr->tag);
+
+		if (offset < 0) {
+			DBG("Unknown tag %u (length %u) - skipped.",
+							hdr->tag, hdr->len);
+			continue;
+		}
+
+		switch (ap_defs[offset].type) {
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
+	}
+
+	return ap;
 }
 
 uint8_t *map_ap_encode(map_ap_t *ap, size_t *length)
-- 
1.7.4.1

