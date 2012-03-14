Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 2/6] map_ap.c: Add implementation for map_ap_get_*
Date: Wed, 14 Mar 2012 23:54:29 +0100
Message-Id: <1331765673-12860-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1331765673-12860-1-git-send-email-lkslawek@gmail.com>
References: <1331765673-12860-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/map_ap.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index 54e3bcf..1f56748 100644
--- a/src/map_ap.c
+++ b/src/map_ap.c
@@ -246,22 +246,72 @@ uint8_t *map_ap_encode(map_ap_t *ap, size_t *length)
 
 gboolean map_ap_get_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t *val)
 {
-	return FALSE;
+	struct ap_entry *entry;
+	int offset = find_ap_def_offset(tag);
+
+	if (offset < 0 || ap_defs[offset].type != APT_UINT8)
+		return FALSE;
+
+
+	entry = g_hash_table_lookup(ap, GINT_TO_POINTER(tag));
+	if (entry == NULL)
+		return FALSE;
+
+	*val = entry->val.u8;
+
+	return TRUE;
 }
 
 gboolean map_ap_get_u16(map_ap_t *ap, enum map_ap_tag tag, uint16_t *val)
 {
-	return FALSE;
+	struct ap_entry *entry;
+	int offset = find_ap_def_offset(tag);
+
+	if (offset < 0 || ap_defs[offset].type != APT_UINT16)
+		return FALSE;
+
+
+	entry = g_hash_table_lookup(ap, GINT_TO_POINTER(tag));
+	if (entry == NULL)
+		return FALSE;
+
+	*val = entry->val.u16;
+
+	return TRUE;
 }
 
 gboolean map_ap_get_u32(map_ap_t *ap, enum map_ap_tag tag, uint32_t *val)
 {
-	return FALSE;
+	struct ap_entry *entry;
+	int offset = find_ap_def_offset(tag);
+
+	if (offset < 0 || ap_defs[offset].type != APT_UINT32)
+		return FALSE;
+
+
+	entry = g_hash_table_lookup(ap, GINT_TO_POINTER(tag));
+	if (entry == NULL)
+		return FALSE;
+
+	*val = entry->val.u32;
+
+	return TRUE;
 }
 
 const char *map_ap_get_string(map_ap_t *ap, enum map_ap_tag tag)
 {
-	return NULL;
+	struct ap_entry *entry;
+	int offset = find_ap_def_offset(tag);
+
+	if (offset < 0 || ap_defs[offset].type != APT_STR)
+		return NULL;
+
+
+	entry = g_hash_table_lookup(ap, GINT_TO_POINTER(tag));
+	if (entry == NULL)
+		return NULL;
+
+	return entry->val.str;
 }
 
 gboolean map_ap_set_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t val)
-- 
1.7.5.1

