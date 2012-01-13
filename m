Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v2 4/4] map_ap.c: Add dumping of map_ap_t after decoding
Date: Fri, 13 Jan 2012 14:33:38 +0100
Message-Id: <1326461618-26864-4-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1326461618-26864-1-git-send-email-lkslawek@gmail.com>
References: <1326461618-26864-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/map_ap.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index d3729c5..a5cd6a0 100644
--- a/src/map_ap.c
+++ b/src/map_ap.c
@@ -125,6 +125,29 @@ static int find_ap_def(uint8_t tag)
 	return -1;
 }
 
+static void ap_entry_dump(gpointer tag, gpointer val, gpointer user_data)
+{
+	struct ap_entry *entry = val;
+	int tago;
+
+	tago = find_ap_def(GPOINTER_TO_INT(tag));
+
+	switch (ap_defs[tago].type) {
+	case APT_UINT8:
+		DBG("%-30s %08x", ap_defs[tago].name, entry->val8u);
+		break;
+	case APT_UINT16:
+		DBG("%-30s %08x", ap_defs[tago].name, entry->val16u);
+		break;
+	case APT_UINT32:
+		DBG("%-30s %08x", ap_defs[tago].name, entry->val32u);
+		break;
+	case APT_STR:
+		DBG("%-30s %s", ap_defs[tago].name, entry->valstr);
+		break;
+	}
+}
+
 static void ap_entry_free(gpointer val)
 {
 	struct ap_entry *entry = val;
@@ -242,6 +265,8 @@ skip:
 		done += hdr->len + sizeof(struct obex_ap_header);
 	}
 
+	g_hash_table_foreach(ap, ap_entry_dump, NULL);
+
 	return ap;
 }
 
-- 
1.7.4.1

