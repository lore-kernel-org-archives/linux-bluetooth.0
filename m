Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 2/6] Add Find By Type Value Response encoding/decoding functions
Date: Thu, 18 Nov 2010 15:48:44 -0200
Message-Id: <1290102524-26493-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <AANLkTikKFkhyjCQi4PzWbn4Y6kt3kqhNgvyUv4zNKxAQ@mail.gmail.com>
References: <AANLkTikKFkhyjCQi4PzWbn4Y6kt3kqhNgvyUv4zNKxAQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Find by type operation is used by Discover Primary Service by Service
UUID. Find By Type Value Response shall contain one or more group handles.
---
 attrib/att.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 attrib/att.h |    7 +++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 6c889f2..8655e5e 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -30,6 +30,8 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include <glib.h>
+
 #include "att.h"
 
 const char *att_ecode2str(uint8_t status)
@@ -271,6 +273,50 @@ uint16_t dec_find_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
 	return len;
 }
 
+uint16_t enc_find_by_type_resp(GSList *matches, uint8_t *pdu, int len)
+{
+	GSList *l;
+	uint16_t offset;
+
+	if (pdu == NULL || len < 5)
+		return 0;
+
+	pdu[0] = ATT_OP_FIND_BY_TYPE_RESP;
+
+	for (l = matches, offset = 1; l && len >= (offset + 4);
+					l = l->next, offset += 4) {
+		struct att_range *range = l->data;
+
+		att_put_u16(range->start, &pdu[offset]);
+		att_put_u16(range->end, &pdu[offset + 2]);
+	}
+
+	return offset;
+}
+
+GSList *dec_find_by_type_resp(const uint8_t *pdu, int len)
+{
+	struct att_range *range;
+	GSList *matches;
+	int offset;
+
+	if (pdu == NULL || len < 5)
+		return NULL;
+
+	if (pdu[0] != ATT_OP_FIND_BY_TYPE_RESP)
+		return NULL;
+
+	for (offset = 1, matches = NULL; len >= (offset + 4); offset += 4) {
+		range = malloc(sizeof(struct att_range));
+		range->start = att_get_u16(&pdu[offset]);
+		range->end = att_get_u16(&pdu[offset + 2]);
+
+		matches = g_slist_append(matches, range);
+	}
+
+	return matches;
+}
+
 uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 							uint8_t *pdu, int len)
 {
diff --git a/attrib/att.h b/attrib/att.h
index 9de338d..7c98b4a 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -122,6 +122,11 @@ struct att_data_list {
 	uint8_t **data;
 };
 
+struct att_range {
+	uint16_t start;
+	uint16_t end;
+};
+
 /* These functions do byte conversion */
 static inline uint8_t att_get_u8(const void *ptr)
 {
@@ -168,6 +173,8 @@ uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 			const uint8_t *value, int vlen, uint8_t *pdu, int len);
 uint16_t dec_find_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
 		uint16_t *end, uuid_t *uuid, uint8_t *value, int *vlen);
+uint16_t enc_find_by_type_resp(GSList *ranges, uint8_t *pdu, int len);
+GSList *dec_find_by_type_resp(const uint8_t *pdu, int len);
 struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, int len);
 uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 							uint8_t *pdu, int len);
-- 
1.7.3.2

