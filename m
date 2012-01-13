Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 4/4] map_ap.c: Add dumping of map_ap_t after decoding
Date: Fri, 13 Jan 2012 11:48:32 +0100
Message-Id: <1326451712-21784-4-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1326451712-21784-1-git-send-email-lkslawek@gmail.com>
References: <1326451712-21784-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/map_ap.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index 2e7758e..38e9500 100644
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
@@ -228,6 +251,8 @@ skip:
 		done += hdr->len + sizeof(struct obex_ap_header);
 	}
 
+	g_hash_table_foreach(ap, ap_entry_dump, NULL);
+
 	return ap;
 }
 
-- 
1.7.4.1

