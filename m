Return-Path: <cyrus@holtmann.org>
From: lkslawek@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v4 1/4] MAP: Implementation of MAP AP core functions
Date: Wed, 18 Jan 2012 20:06:22 +0100
Message-Id: <4f171840.9c010e0a.7b51.1de9@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Slawomir Bochenski <lkslawek@gmail.com>

This adds implementation for creation and destruction of map_ap_t and
the definitions of MAP supported application parameters.
---
 src/map_ap.c |  107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 106 insertions(+), 1 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index 9d13adf..78d085d 100644
--- a/src/map_ap.c
+++ b/src/map_ap.c
@@ -27,13 +27,118 @@
 
 #include "map_ap.h"
 
+enum ap_type {
+	APT_UINT8,
+	APT_UINT16,
+	APT_UINT32,
+	APT_STR
+};
+
+static const struct ap_def {
+	enum map_ap_tag tag;
+	const char *name;
+	enum ap_type type;
+} ap_defs[] = {
+	{ MAP_AP_MAXLISTCOUNT,		"MAXLISTCOUNT",
+		APT_UINT16					},
+	{ MAP_AP_STARTOFFSET,		"STARTOFFSET",
+		APT_UINT16					},
+	{ MAP_AP_FILTERMESSAGETYPE,	"FILTERMESSAGETYPE",
+		APT_UINT8					},
+	{ MAP_AP_FILTERPERIODBEGIN,	"FILTERPERIODBEGIN",
+		APT_STR						},
+	{ MAP_AP_FILTERPERIODEND,	"FILTERPERIODEND",
+		APT_STR						},
+	{ MAP_AP_FILTERREADSTATUS,	"FILTERREADSTATUS",
+		APT_UINT8					},
+	{ MAP_AP_FILTERRECIPIENT,	"FILTERRECIPIENT",
+		APT_STR						},
+	{ MAP_AP_FILTERORIGINATOR,	"FILTERORIGINATOR",
+		APT_STR						},
+	{ MAP_AP_FILTERPRIORITY,	"FILTERPRIORITY",
+		APT_UINT8					},
+	{ MAP_AP_ATTACHMENT,		"ATTACHMENT",
+		APT_UINT8					},
+	{ MAP_AP_TRANSPARENT,		"TRANSPARENT",
+		APT_UINT8					},
+	{ MAP_AP_RETRY,			"RETRY",
+		APT_UINT8					},
+	{ MAP_AP_NEWMESSAGE,		"NEWMESSAGE",
+		APT_UINT8					},
+	{ MAP_AP_NOTIFICATIONSTATUS,	"NOTIFICATIONSTATUS",
+		APT_UINT8					},
+	{ MAP_AP_MASINSTANCEID,		"MASINSTANCEID",
+		APT_UINT8					},
+	{ MAP_AP_PARAMETERMASK,		"PARAMETERMASK",
+		APT_UINT32					},
+	{ MAP_AP_FOLDERLISTINGSIZE,	"FOLDERLISTINGSIZE",
+		APT_UINT16					},
+	{ MAP_AP_MESSAGESLISTINGSIZE,	"MESSAGESLISTINGSIZE",
+		APT_UINT16					},
+	{ MAP_AP_SUBJECTLENGTH,		"SUBJECTLENGTH",
+		APT_UINT8					},
+	{ MAP_AP_CHARSET,		"CHARSET",
+		APT_UINT8					},
+	{ MAP_AP_FRACTIONREQUEST,	"FRACTIONREQUEST",
+		APT_UINT8					},
+	{ MAP_AP_FRACTIONDELIVER,	"FRACTIONDELIVER",
+		APT_UINT8					},
+	{ MAP_AP_STATUSINDICATOR,	"STATUSINDICATOR",
+		APT_UINT8					},
+	{ MAP_AP_STATUSVALUE,		"STATUSVALUE",
+		APT_UINT8					},
+	{ MAP_AP_MSETIME,		"MSETIME",
+		APT_STR						},
+	{ MAP_AP_INVALID,		NULL,
+		0						},
+};
+
+struct ap_entry {
+	enum map_ap_tag tag;
+	union {
+		uint32_t u32;
+		uint16_t u16;
+		uint8_t u8;
+		char *str;
+	} val;
+};
+
+static int find_ap_def_offset(uint8_t tag)
+{
+	int i;
+
+	for (i = 0; ap_defs[i].tag != MAP_AP_INVALID; ++i)
+		if (ap_defs[i].tag == tag)
+			return i;
+
+	return -1;
+}
+
+static void ap_entry_free(gpointer val)
+{
+	struct ap_entry *entry = val;
+	int offset;
+
+	offset = find_ap_def_offset(entry->tag);
+
+	if (offset >= 0 && ap_defs[offset].type == APT_STR)
+		g_free(entry->val.str);
+
+	g_free(entry);
+}
+
 map_ap_t *map_ap_new(void)
 {
-	return NULL;
+	return g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
+								ap_entry_free);
 }
 
 void map_ap_free(map_ap_t *ap)
 {
+	if (!ap)
+		return;
+
+	g_hash_table_destroy(ap);
 }
 
 map_ap_t *map_ap_decode(const uint8_t *buffer, size_t length)
-- 
1.7.5.1

