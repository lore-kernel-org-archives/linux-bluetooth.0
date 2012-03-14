Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 4/6] MAP: Add implementation of map_ap_encode()
Date: Wed, 14 Mar 2012 23:54:31 +0100
Message-Id: <1331765673-12860-4-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1331765673-12860-1-git-send-email-lkslawek@gmail.com>
References: <1331765673-12860-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/map_ap.c |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index 1f56748..c852184 100644
--- a/src/map_ap.c
+++ b/src/map_ap.c
@@ -237,11 +237,98 @@ map_ap_t *map_ap_decode(const uint8_t *buffer, size_t length)
 	return ap;
 }
 
+static void ap_encode_u8(GString *buf, struct ap_entry *entry)
+{
+	struct obex_ap_header *hdr;
+
+	hdr = (struct obex_ap_header *)buf->str + buf->len;
+	g_string_set_size(buf, buf->len + sizeof(*hdr) + 1);
+
+	hdr->tag = entry->tag;
+	hdr->len = 1;
+	hdr->val[0] = entry->val.u8;
+}
+
+static void ap_encode_u16(GString *buf, struct ap_entry *entry)
+{
+	struct obex_ap_header *hdr;
+	uint16_t val;
+
+	hdr = (struct obex_ap_header *)buf->str + buf->len;
+
+	g_string_set_size(buf, buf->len + sizeof(*hdr) + 2);
+
+	hdr->tag = entry->tag;
+	hdr->len = 2;
+
+	val = GUINT16_TO_BE(entry->val.u16);
+	memcpy(hdr->val, &val, sizeof(val));
+}
+
+static void ap_encode_u32(GString *buf, struct ap_entry *entry)
+{
+	uint32_t val;
+	struct obex_ap_header *hdr;
+
+	hdr = (struct obex_ap_header *)buf->str + buf->len;
+	g_string_set_size(buf, buf->len + sizeof(*hdr) + 4);
+
+	hdr->tag = entry->tag;
+	hdr->len = 4;
+
+	val = GUINT32_TO_BE(entry->val.u16);
+	memcpy(hdr->val, &val, sizeof(val));
+}
+
+static void ap_encode_str(GString *buf, struct ap_entry *entry)
+{
+	size_t len;
+	struct obex_ap_header *hdr;
+
+	hdr = (struct obex_ap_header *)buf->str + buf->len;
+	len = strlen(entry->val.str);
+	g_string_set_size(buf, buf->len + sizeof(*hdr) + len);
+
+	hdr->tag = entry->tag;
+	hdr->len = len;
+
+	memcpy(hdr->val, entry->val.str, len);
+}
+
 uint8_t *map_ap_encode(map_ap_t *ap, size_t *length)
 {
-	*length = 0;
+	GString *buf;
+	GHashTableIter iter;
+	gpointer key, value;
+	struct ap_entry *entry;
+	int offset;
+
+	buf = g_string_new("");
+	g_hash_table_iter_init(&iter, ap);
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		entry = (struct ap_entry *)value;
+		offset = find_ap_def_offset(entry->tag);
+
+		switch (ap_defs[offset].type) {
+		case APT_UINT8:
+			ap_encode_u8(buf, entry);
+			break;
+		case APT_UINT16:
+			ap_encode_u16(buf, entry);
+			break;
+		case APT_UINT32:
+			ap_encode_u32(buf, entry);
+			break;
+		case APT_STR:
+			ap_encode_str(buf, entry);
+			break;
+		}
+	}
+
+	*length = buf->len;
 
-	return NULL;
+	return (uint8_t *)g_string_free(buf, FALSE);
 }
 
 gboolean map_ap_get_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t *val)
-- 
1.7.5.1

