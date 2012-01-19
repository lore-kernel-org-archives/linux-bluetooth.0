Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v5 1/5] MAP: Implementation of MAP AP core functions
Date: Thu, 19 Jan 2012 18:01:52 +0100
Message-Id: <1326992516-2800-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1326992516-2800-1-git-send-email-lkslawek@gmail.com>
References: <1326992516-2800-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds implementation for creation and destruction of map_ap_t and
the definitions of MAP supported application parameters.
---
 src/map_ap.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/src/map_ap.c b/src/map_ap.c
index 9d13adf..b3b4a3f 100644
--- a/src/map_ap.c
+++ b/src/map_ap.c
@@ -27,13 +27,88 @@
 
 #include "map_ap.h"
 
+enum ap_type {
+	APT_UINT8,
+	APT_UINT16,
+	APT_UINT32,
+	APT_STR
+};
+
+/* NOTE: ap_defs array has to be kept in sync with map_ap_tag. */
+static const struct ap_def {
+	const char *name;
+	enum ap_type type;
+} ap_defs[] = {
+	{ "MAXLISTCOUNT",		APT_UINT16 },
+	{ "STARTOFFSET",		APT_UINT16 },
+	{ "FILTERMESSAGETYPE",		APT_UINT8  },
+	{ "FILTERPERIODBEGIN",		APT_STR    },
+	{ "FILTERPERIODEND",		APT_STR    },
+	{ "FILTERREADSTATUS",		APT_UINT8  },
+	{ "FILTERRECIPIENT",		APT_STR    },
+	{ "FILTERORIGINATOR",		APT_STR    },
+	{ "FILTERPRIORITY",		APT_UINT8  },
+	{ "ATTACHMENT",			APT_UINT8  },
+	{ "TRANSPARENT",		APT_UINT8  },
+	{ "RETRY",			APT_UINT8  },
+	{ "NEWMESSAGE",			APT_UINT8  },
+	{ "NOTIFICATIONSTATUS",		APT_UINT8  },
+	{ "MASINSTANCEID",		APT_UINT8  },
+	{ "PARAMETERMASK",		APT_UINT32 },
+	{ "FOLDERLISTINGSIZE",		APT_UINT16 },
+	{ "MESSAGESLISTINGSIZE",	APT_UINT16 },
+	{ "SUBJECTLENGTH",		APT_UINT8  },
+	{ "CHARSET",			APT_UINT8  },
+	{ "FRACTIONREQUEST",		APT_UINT8  },
+	{ "FRACTIONDELIVER",		APT_UINT8  },
+	{ "STATUSINDICATOR",		APT_UINT8  },
+	{ "STATUSVALUE",		APT_UINT8  },
+	{ "MSETIME",			APT_STR    },
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
+	if (tag == 0 || tag > G_N_ELEMENTS(ap_defs))
+		return -1;
+
+	return tag - 1;
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

