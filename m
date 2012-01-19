Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v5 5/5] map_ap.c: Add dumping of map_ap_t after decoding
Date: Thu, 19 Jan 2012 18:01:56 +0100
Message-Id: <1326992516-2800-6-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1326992516-2800-1-git-send-email-lkslawek@gmail.com>
References: <1326992516-2800-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/map_ap.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index 6c9c623..cbf433f 100644
--- a/src/map_ap.c
+++ b/src/map_ap.c
@@ -95,6 +95,29 @@ static int find_ap_def_offset(uint8_t tag)
 	return tag - 1;
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
@@ -209,6 +232,8 @@ map_ap_t *map_ap_decode(const uint8_t *buffer, size_t length)
 		}
 	}
 
+	g_hash_table_foreach(ap, ap_entry_dump, NULL);
+
 	return ap;
 }
 
-- 
1.7.5.1

