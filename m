Return-Path: <cyrus@holtmann.org>
From: lkslawek@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v4 2/4] map_ap.c: Add implementation for map_ap_set_*
Date: Wed, 18 Jan 2012 20:06:23 +0100
Message-Id: <4f171842.9c010e0a.7b51.1deb@mx.google.com>
In-Reply-To: <1326913585-14577-1-git-send-email-y>
References: <1326913585-14577-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Slawomir Bochenski <lkslawek@gmail.com>

---
 src/map_ap.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index 78d085d..04b370f 100644
--- a/src/map_ap.c
+++ b/src/map_ap.c
@@ -175,20 +175,68 @@ const char *map_ap_get_string(map_ap_t *ap, enum map_ap_tag tag)
 
 gboolean map_ap_set_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t val)
 {
-	return FALSE;
+	struct ap_entry *entry;
+	int offset = find_ap_def_offset(tag);
+
+	if (offset < 0 || ap_defs[offset].type != APT_UINT8)
+		return FALSE;
+
+	entry = g_new0(struct ap_entry, 1);
+	entry->tag = tag;
+	entry->val.u8 = val;
+
+	g_hash_table_insert(ap, GINT_TO_POINTER(tag), entry);
+
+	return TRUE;
 }
 
 gboolean map_ap_set_u16(map_ap_t *ap, enum map_ap_tag tag, uint16_t val)
 {
-	return FALSE;
+	struct ap_entry *entry;
+	int offset = find_ap_def_offset(tag);
+
+	if (offset < 0 || ap_defs[offset].type != APT_UINT16)
+		return FALSE;
+
+	entry = g_new0(struct ap_entry, 1);
+	entry->tag = tag;
+	entry->val.u16 = val;
+
+	g_hash_table_insert(ap, GINT_TO_POINTER(tag), entry);
+
+	return TRUE;
 }
 
 gboolean map_ap_set_u32(map_ap_t *ap, enum map_ap_tag tag, uint32_t val)
 {
-	return FALSE;
+	struct ap_entry *entry;
+	int offset = find_ap_def_offset(tag);
+
+	if (offset < 0 || ap_defs[offset].type != APT_UINT32)
+		return FALSE;
+
+	entry = g_new0(struct ap_entry, 1);
+	entry->tag = tag;
+	entry->val.u32 = val;
+
+	g_hash_table_insert(ap, GINT_TO_POINTER(tag), entry);
+
+	return TRUE;
 }
 
 gboolean map_ap_set_string(map_ap_t *ap, enum map_ap_tag tag, const char *val)
 {
-	return FALSE;
+	struct ap_entry *entry;
+	int offset = find_ap_def_offset(tag);
+
+	if (offset < 0 || ap_defs[offset].type != APT_STR)
+		return FALSE;
+
+	entry = g_new0(struct ap_entry, 1);
+	entry->tag = tag;
+	entry->val.str = g_strdup(val);
+
+	g_hash_table_insert(ap, GINT_TO_POINTER(tag), entry);
+
+	return TRUE;
 }
-- 
1.7.5.1

