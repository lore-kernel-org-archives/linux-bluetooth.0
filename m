Return-Path: <cyrus@holtmann.org>
From: lkslawek@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v4 4/4] map_ap.c: Add dumping of map_ap_t after decoding
Date: Wed, 18 Jan 2012 20:06:25 +0100
Message-Id: <4f171845.9c010e0a.7b51.1df7@mx.google.com>
In-Reply-To: <1326913585-14577-1-git-send-email-y>
References: <1326913585-14577-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Slawomir Bochenski <lkslawek@gmail.com>

---
 src/map_ap.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index 657d86b..168d163 100644
--- a/src/map_ap.c
+++ b/src/map_ap.c
@@ -125,6 +125,29 @@ static int find_ap_def_offset(uint8_t tag)
 	return -1;
 }
 
+static void ap_entry_dump(gpointer tag, gpointer val, gpointer user_data)
+{
+	struct ap_entry *entry = val;
+	int offset;
+
+	offset = find_ap_def_offset(GPOINTER_TO_INT(tag));
+
+	switch (ap_defs[offset].type) {
+	case APT_UINT8:
+		DBG("%-30s %08x", ap_defs[offset].name, entry->val.u8);
+		break;
+	case APT_UINT16:
+		DBG("%-30s %08x", ap_defs[offset].name, entry->val.u16);
+		break;
+	case APT_UINT32:
+		DBG("%-30s %08x", ap_defs[offset].name, entry->val.u32);
+		break;
+	case APT_STR:
+		DBG("%-30s %s", ap_defs[offset].name, entry->val.str);
+		break;
+	}
+}
+
 static void ap_entry_free(gpointer val)
 {
 	struct ap_entry *entry = val;
@@ -239,6 +262,8 @@ map_ap_t *map_ap_decode(const uint8_t *buffer, size_t length)
 		}
 	}
 
+	g_hash_table_foreach(ap, ap_entry_dump, NULL);
+
 	return ap;
 }
 
-- 
1.7.5.1

