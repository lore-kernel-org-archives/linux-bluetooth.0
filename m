Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 2/4] map_ap.c: Add implementation for map_ap_set_*
Date: Fri, 13 Jan 2012 11:48:30 +0100
Message-Id: <1326451712-21784-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1326451712-21784-1-git-send-email-lkslawek@gmail.com>
References: <1326451712-21784-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/map_ap.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index bec2cc5..0ed097f 100644
--- a/src/map_ap.c
+++ b/src/map_ap.c
@@ -174,20 +174,68 @@ const char *map_ap_get_string(map_ap_t *ap, enum map_ap_tag tag)
 
 gboolean map_ap_set_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t val)
 {
-	return FALSE;
+	struct ap_entry *entry;
+	int tago = find_ap_def(tag);
+
+	if (tago < 0 || ap_defs[tago].type != APT_UINT8)
+		return FALSE;
+
+	entry = g_new0(struct ap_entry, 1);
+	entry->tag = tag;
+	entry->val8u = val;
+
+	g_hash_table_insert(ap, GINT_TO_POINTER(tag), entry);
+
+	return TRUE;
 }
 
 gboolean map_ap_set_u16(map_ap_t *ap, enum map_ap_tag tag, uint16_t val)
 {
-	return FALSE;
+	struct ap_entry *entry;
+	int tago = find_ap_def(tag);
+
+	if (tago < 0 || ap_defs[tago].type != APT_UINT16)
+		return FALSE;
+
+	entry = g_new0(struct ap_entry, 1);
+	entry->tag = tag;
+	entry->val16u = val;
+
+	g_hash_table_insert(ap, GINT_TO_POINTER(tag), entry);
+
+	return TRUE;
 }
 
 gboolean map_ap_set_u32(map_ap_t *ap, enum map_ap_tag tag, uint32_t val)
 {
-	return FALSE;
+	struct ap_entry *entry;
+	int tago = find_ap_def(tag);
+
+	if (tago < 0 || ap_defs[tago].type != APT_UINT32)
+		return FALSE;
+
+	entry = g_new0(struct ap_entry, 1);
+	entry->tag = tag;
+	entry->val32u = val;
+
+	g_hash_table_insert(ap, GINT_TO_POINTER(tag), entry);
+
+	return TRUE;
 }
 
 gboolean map_ap_set_string(map_ap_t *ap, enum map_ap_tag tag, const char *val)
 {
-	return FALSE;
+	struct ap_entry *entry;
+	int tago = find_ap_def(tag);
+
+	if (tago < 0 || ap_defs[tago].type != APT_STR)
+		return FALSE;
+
+	entry = g_new0(struct ap_entry, 1);
+	entry->tag = tag;
+	entry->valstr = g_strdup(val);
+
+	g_hash_table_insert(ap, GINT_TO_POINTER(tag), entry);
+
+	return TRUE;
 }
-- 
1.7.4.1

