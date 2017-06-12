Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: nsathish41@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v2 BlueZ 2/2] obexd/map: msg dummy implement message listing
Date: Mon, 12 Jun 2017 15:49:28 +0530
Message-Id: <1497262768-4988-2-git-send-email-nsathish41@gmail.com>
In-Reply-To: <1497262768-4988-1-git-send-email-nsathish41@gmail.com>
References: <1497262768-4988-1-git-send-email-nsathish41@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sathish Narasimman <sathish.narasimman@intel.com>

For messages dummy, message listing functionality in implemented in
this patch. The inputs for message listing is derived from the
mlisting.xml file that is to be present in each folder(inbox, sent,
drafts)

> ACL Data RX: Handle 256 flags 0x02 dlen 78
      Channel: 64 len 74 [PSM 3 mode 0] {chan 0}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x83 cr 1 dlci 0x20
         Control: 0xff poll/final 1
         Length: 69
         FCS: 0xc4
         Credits: 1
        83 00 45 cb 00 00 00 02 01 00 0d 00 73 00 65 00  ..E.........s.e.
        6e 00 74 00 00 42 00 18 78 2d 62 74 2f 4d 41 50  n.t..B..x-bt/MAP
        2d 6d 73 67 2d 6c 69 73 74 69 6e 67 00 4c 00 18  -msg-listing.L..
        01 02 00 0b 02 02 00 00 13 01 ff 06 01 00 07 00  ................
        08 00 09 01 00 c4                                ......
< ACL Data TX: Handle 256 flags 0x00 dlen 1017
      Channel: 65 len 1013 [PSM 3 mode 0] {chan 0}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x81 cr 0 dlci 0x20
         Control: 0xef poll/final 0
         Length: 28675
         FCS: 0x02
        90 08 63 4c 00 21 12 02 00 0b 19 15 32 30 31 37  ..cL.!......2017
        30 36 31 32 54 31 32 32 35 31 33 2d 20 35 33 30  0612T122513- 530
        00 0d 01 00 48 08 3f 3c 4d 41 50 2d 6d 73 67 2d  ....H.?<MAP-msg-
        6c 69 73 74 69 6e 67 20 76 65 72 73 69 6f 6e 3d  listing version=
        22 31 2e 30 22 3e 3c 6d 73 67 20 68 61 6e 64 6c  "1.0"><msg handl
        65 3d 22 30 34 30 30 30 30 30 30 30 30 30 30 30  e="0400000000000
        30 31 32 22 20 73 75 62 6a 65 63 74 3d 22 4e 6f  012" subject="No
        22 20 64 61 74 65 74 69 6d 65 3d 22 32 30 31 37  " datetime="2017
        30 35 32 34 54 31 37 30 31 35 37 22 20 73 65 6e  0524T170157" sen
        64 65 72 5f 61 64 64 72 65 73 73 69 6e 67 3d 22  der_addressing="
        22 20 72 65 63 69 70 69 65 6e 74 5f 61 64 64 72  " recipient_addr
        65 73 73 69 6e 67 3d 22 35 34 33 32 31 22 20 74  essing="54321" t
        79 70 65 3d 22 53 4d 53 5f 47 53 4d 22 20 72 65  ype="SMS_GSM" re
        63 65 70 74 69 6f 6e 5f 73 74 61 74 75 73 3d 22  ception_status="
        63 6f 6d 70 6c 65 74 65 22 20 61 74 74 61 63 68  complete" attach
        6d 65 6e 74 5f 73 69 7a 65 3d 22 30 22 2f 3e 0a  ment_size="0"/>.

	... and more
---
 obexd/plugins/messages-dummy.c | 186 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index 33056e2..3eca9ef 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -27,6 +27,7 @@
 
 #include <sys/types.h>
 #include <dirent.h>
+#include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
@@ -35,6 +36,8 @@
 
 #include "messages.h"
 
+#define MSG_LIST_XML "mlisting.xml"
+
 static char *root_folder = NULL;
 
 struct session {
@@ -52,6 +55,20 @@ struct folder_listing_data {
 	void *user_data;
 };
 
+struct message_listing_data {
+	struct session *session;
+	const char *name;
+	uint16_t max;
+	uint16_t offset;
+	uint8_t subject_len;
+	uint16_t size;
+	char *path;
+	FILE *fp;
+	const struct messages_filter *filter;
+	messages_get_messages_listing_cb callback;
+	void *user_data;
+};
+
 /* NOTE: Neither IrOBEX nor MAP specs says that folder listing needs to
  * be sorted (in IrOBEX examples it is not). However existing implementations
  * seem to follow the fig. 3-2 from MAP specification v1.0, and I've seen a
@@ -319,6 +336,139 @@ int messages_get_folder_listing(void *s, const char *name, uint16_t max,
 	return 0;
 }
 
+static void max_msg_element(GMarkupParseContext *ctxt, const char *element,
+				const char **names, const char **values,
+				gpointer user_data, GError **gerr)
+{
+	struct message_listing_data *mld = user_data;
+	const char *key;
+	int i;
+
+	for (i = 0, key = names[i]; key; key = names[++i]) {
+		if (g_strcmp0(names[i], "handle") == 0) {
+			mld->size++;
+			break;
+		}
+	}
+}
+
+static void msg_element(GMarkupParseContext *ctxt, const char *element,
+				const char **names, const char **values,
+				gpointer user_data, GError **gerr)
+{
+	struct message_listing_data *mld = user_data;
+	struct messages_message *entry = NULL;
+	int i;
+
+	entry = g_new0(struct messages_message, 1);
+	if (mld->filter->parameter_mask == 0) {
+		entry->mask = (entry->mask | PMASK_SUBJECT \
+			| PMASK_DATETIME | PMASK_RECIPIENT_ADDRESSING \
+			| PMASK_SENDER_ADDRESSING \
+			| PMASK_ATTACHMENT_SIZE | PMASK_TYPE \
+			| PMASK_RECEPTION_STATUS);
+	} else
+		entry->mask = mld->filter->parameter_mask;
+
+	for (i = 0 ; names[i]; ++i) {
+		if (g_strcmp0(names[i], "handle") == 0) {
+			entry->handle = g_strdup(values[i]);
+			mld->size++;
+			continue;
+		}
+		if (g_strcmp0(names[i], "attachment_size") == 0) {
+			entry->attachment_size = g_strdup(values[i]);
+			continue;
+		}
+		if (g_strcmp0(names[i], "datetime") == 0) {
+			entry->datetime = g_strdup(values[i]);
+			continue;
+		}
+		if (g_strcmp0(names[i], "subject") == 0) {
+			entry->subject = g_strdup(values[i]);
+			continue;
+		}
+		if (g_strcmp0(names[i], "recipient_addressing") == 0) {
+			entry->recipient_addressing = g_strdup(values[i]);
+			continue;
+		}
+		if (g_strcmp0(names[i], "sender_addressing") == 0) {
+			entry->sender_addressing = g_strdup(values[i]);
+			continue;
+		}
+		if (g_strcmp0(names[i], "type") == 0) {
+			entry->type = g_strdup(values[i]);
+			continue;
+		}
+		if (g_strcmp0(names[i], "reception_status") == 0)
+			entry->reception_status = g_strdup(values[i]);
+	}
+
+	if (mld->size > mld->offset)
+		mld->callback(mld->session, -EAGAIN, mld->size, 0, entry, mld->user_data);
+
+	g_free(entry->reception_status);
+	g_free(entry->type);
+	g_free(entry->sender_addressing);
+	g_free(entry->subject);
+	g_free(entry->datetime);
+	g_free(entry->attachment_size);
+	g_free(entry->handle);
+	g_free(entry);
+}
+
+static const GMarkupParser msg_parser = {
+        msg_element,
+        NULL,
+        NULL,
+        NULL,
+        NULL
+};
+
+static const GMarkupParser max_msg_parser = {
+        max_msg_element,
+        NULL,
+        NULL,
+        NULL,
+        NULL
+};
+
+static gboolean get_messages_listing(void *d)
+{
+
+	struct message_listing_data *mld = d;
+	/* 1024 is the maximum size of the line which is calculated to be more
+	 * sufficient*/
+	char buffer[1024];
+	GMarkupParseContext *ctxt;
+	size_t len;
+
+	while (fgets(buffer, 1024, mld->fp)) {
+		len = strlen(buffer);
+
+		if (mld->max == 0) {
+			ctxt = g_markup_parse_context_new(&max_msg_parser, 0, mld, NULL);
+			g_markup_parse_context_parse(ctxt, buffer, len, NULL);
+			g_markup_parse_context_free(ctxt);
+		} else {
+			ctxt = g_markup_parse_context_new(&msg_parser, 0, mld, NULL);
+			g_markup_parse_context_parse(ctxt, buffer, len, NULL);
+			g_markup_parse_context_free(ctxt);
+		}
+	}
+
+	if (mld->max == 0) {
+		mld->callback(mld->session, 0, mld->size, 0, NULL, mld->user_data);
+		goto done;
+	}
+
+	mld->callback(mld->session, 0, mld->size, 0, NULL, mld->user_data);
+
+done:
+	fclose(mld->fp);
+	return FALSE;
+}
+
 int messages_get_messages_listing(void *session, const char *name,
 				uint16_t max, uint16_t offset,
 				uint8_t subject_len,
@@ -326,7 +476,41 @@ int messages_get_messages_listing(void *session, const char *name,
 				messages_get_messages_listing_cb callback,
 				void *user_data)
 {
-	return -ENOSYS;
+	struct message_listing_data *mld;
+	struct session *s =  session;
+	char *path;
+
+	mld = g_new0(struct message_listing_data, 1);
+	mld->session = s;
+	mld->name = name;
+	mld->max = max;
+	mld->offset = offset;
+	mld->subject_len = subject_len;
+	mld->callback = callback;
+	mld->filter = filter;
+	mld->user_data = user_data;
+
+	path = g_build_filename(s->cwd_absolute, MSG_LIST_XML, NULL);
+	mld->fp = fopen(path, "r");
+	if (mld->fp == NULL) {
+		g_free(path);
+		messages_set_folder(s, mld->name, 0);
+		path = g_build_filename(s->cwd_absolute, MSG_LIST_XML, NULL);
+		mld->fp = fopen(path, "r");
+		if (mld->fp == NULL) {
+			int err = -errno;
+			DBG("fopen(): %d, %s", -err, strerror(-err));
+			g_free(path);
+			return -EBADR;
+		}
+	}
+
+
+	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, get_messages_listing,
+								mld, g_free);
+	g_free(path);
+
+	return 0;
 }
 
 int messages_get_message(void *session, const char *handle,
-- 
2.7.4

