Return-Path: <cyrus@holtmann.org>
From: Divya Yadav <divya.yadav@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Divya Yadav <divya.yadav@samsung.com>
Subject: [PATCH obexd] MAP: Add application parameter parsing support
Date: Thu, 12 Jan 2012 18:29:21 +0530
Message-id: <1326373161-4618-1-git-send-email-divya.yadav@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add application parameter parsing and check for
mandatory parameters.
---
 plugins/mas.c      |  187 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 plugins/messages.h |   19 +++++
 2 files changed, 199 insertions(+), 7 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 17e54d8..d16015c 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -29,6 +29,7 @@
 #include <glib.h>
 #include <fcntl.h>
 #include <inttypes.h>
+#include <string.h>
 
 #include "obexd.h"
 #include "plugin.h"
@@ -102,18 +103,134 @@
 #define ML_BODY_BEGIN "<MAP-msg-listing version=\"1.0\">"
 #define ML_BODY_END "</MAP-msg-listing>"
 
+enum mas_apparam_tag {
+	MAXLISTCOUNT_T = 0x01,
+	STARTOFFSET_T = 0x02,
+	FILTERMESSAGETYPE_T = 0x03,
+	FILTERPERIODBEGIN_T = 0x04,
+	FILTERPERIODEND_T = 0x05,
+	FILTERREADSTATUS_T = 0x06,
+	FILTERRECIPIENT_T = 0x07,
+	FILTERORIGINATOR_T = 0x08,
+	FILTERPRIORITY_T = 0x09,
+	ATTACHMENT_T = 0x0A,
+	TRANSPARENT_T = 0x0B,
+	RETRY_T = 0x0C,
+	NEWMESSAGE_T = 0x0D,
+	NOTIFICATIONSTATUS_T = 0x0E,
+	MASINSTANCEID_T = 0x0F,
+	PARAMETERMASK_T = 0x10,
+	FOLDERLISTINGSIZE_T = 0x11,
+	MESSAGESLISTINGSIZE_T = 0x12,
+	SUBJECTLENGTH_T = 0x13,
+	CHARSET_T = 0x14,
+	FRACTIONREQUEST_T = 0x15,
+	FRACTIONDELIVER_T = 0x16,
+	STATUSINDICATOR_T = 0x17,
+	STATUSVALUE_T = 0x18,
+	MSETIME_T = 0x19,
+	INVALID_T = 0x99,
+};
+
+#define MAXLISTCOUNT_L 2
+#define STARTOFFSET_L 2
+#define ATTACHMENT_L 1
+#define CHARSET_L 1
+#define STATUSINDICATOR_L 1
+#define STATUSVALUE_L 1
+
 struct mas_session {
 	struct mas_request *request;
 	void *backend_data;
 	gboolean finished;
 	gboolean nth_call;
 	GString *buffer;
+	struct apparam_field *apparams;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
 			0xbb, 0x58, 0x2b, 0x40, 0x42, 0x0c, 0x11, 0xdb,
 			0xb0, 0xde, 0x08, 0x00, 0x20, 0x0c, 0x9a, 0x66  };
 
+struct apparam_header {
+	uint8_t tag;
+	uint8_t len;
+	uint8_t val[0];
+} __attribute__ ((packed));
+
+static struct apparam_field *msg_parse_apparam(const uint8_t *buffer,
+							uint32_t hlen)
+{
+	struct apparam_field *param = NULL;
+	struct apparam_header *hdr = NULL;
+	uint32_t len = 0;
+	uint16_t val16;
+
+	param = g_new0(struct apparam_field, 1);
+
+	while (len < hlen) {
+		hdr = (void *) (buffer + len);
+
+		switch (hdr->tag) {
+		case MAXLISTCOUNT_T:
+			if (hdr->len != MAXLISTCOUNT_L)
+				goto failed;
+
+			memcpy(&val16, hdr->val, sizeof(val16));
+			param->maxlistcount = GUINT16_FROM_BE(val16);
+			break;
+
+		case STARTOFFSET_T:
+			if (hdr->len != STARTOFFSET_L)
+				goto failed;
+
+			memcpy(&val16, hdr->val, sizeof(val16));
+			param->offset = GUINT16_FROM_BE(val16);
+			break;
+
+		case ATTACHMENT_T:
+			if (hdr->len != ATTACHMENT_L)
+				goto failed;
+
+			param->attachment = hdr->val[0];
+			break;
+
+		case CHARSET_T:
+			if (hdr->len != CHARSET_L)
+				goto failed;
+
+			param->charset = hdr->val[0];
+			break;
+
+		case STATUSINDICATOR_T:
+			if (hdr->len != STATUSINDICATOR_L)
+				goto failed;
+
+			param->status_indicator = hdr->val[0];
+			break;
+
+		case STATUSVALUE_T:
+			if (hdr->len != STATUSVALUE_L)
+				goto failed;
+
+			param->status_value = hdr->val[0];
+			break;
+
+		default:
+			goto failed;
+		}
+
+		len += hdr->len + sizeof(struct apparam_header);
+	}
+
+	return param;
+
+failed:
+	g_free(param);
+
+	return NULL;
+}
+
 static void reset_request(struct mas_session *mas)
 {
 	if (mas->buffer) {
@@ -121,6 +238,11 @@ static void reset_request(struct mas_session *mas)
 		mas->buffer = NULL;
 	}
 
+	if (mas->apparams) {
+		g_free(mas->apparams);
+		mas->apparams = NULL;
+	}
+
 	mas->nth_call = FALSE;
 	mas->finished = FALSE;
 }
@@ -170,14 +292,39 @@ static int mas_get(struct obex_session *os, void *user_data)
 	struct mas_session *mas = user_data;
 	const char *type = obex_get_type(os);
 	const char *name = obex_get_name(os);
-	int ret;
-
-	DBG("GET: name %s type %s mas %p",
-			name, type, mas);
+	struct apparam_field *apparams = NULL;
+	const uint8_t *buffer = NULL;
+	ssize_t rsize = 0;
+	int ret = 0;
 
 	if (type == NULL)
 		return -EBADR;
 
+	if (mas->apparams) {
+		g_free(mas->apparams);
+		mas->apparams = NULL;
+	}
+
+	DBG("GET: name %s type %s mas %p", name, type, mas);
+
+	rsize = obex_get_apparam(os, &buffer);
+
+	if (rsize <= 0) {
+		if (g_ascii_strcasecmp(type, "x-bt/message") == 0) {
+			ret = -EBADR;
+			goto failed;
+		}
+	} else  {
+		apparams = msg_parse_apparam(buffer, rsize);
+
+		if (apparams == NULL) {
+			ret = -EBADR;
+			goto failed;
+		}
+
+		mas->apparams = apparams;
+	}
+
 	ret = obex_get_stream_start(os, name);
 	if (ret < 0)
 		goto failed;
@@ -195,13 +342,39 @@ static int mas_put(struct obex_session *os, void *user_data)
 	struct mas_session *mas = user_data;
 	const char *type = obex_get_type(os);
 	const char *name = obex_get_name(os);
-	int ret;
-
-	DBG("PUT: name %s type %s mas %p", name, type, mas);
+	struct apparam_field *apparams = NULL;
+	const uint8_t *buffer = NULL;
+	int ret = 0;
+	ssize_t rsize = 0;
 
 	if (type == NULL)
 		return -EBADR;
 
+	if (mas->apparams) {
+		g_free(mas->apparams);
+		mas->apparams = NULL;
+	}
+
+	DBG("PUT: name %s type %s mas %p", name, type, mas);
+
+	rsize = obex_get_apparam(os, &buffer);
+	if (rsize <= 0) {
+		if (g_ascii_strcasecmp(type, "x-bt/messageStatus") == 0 ||
+			g_ascii_strcasecmp(type, "x-bt/message") == 0) {
+			ret = -EBADR;
+			goto failed;
+		}
+	} else {
+		apparams = msg_parse_apparam(buffer, rsize);
+
+		if (apparams == NULL) {
+			ret = -EBADR;
+			goto failed;
+		}
+
+		mas->apparams = apparams;
+	}
+
 	ret = obex_put_stream_start(os, name);
 	if (ret < 0)
 		goto failed;
diff --git a/plugins/messages.h b/plugins/messages.h
index 00a040c..6cd0e0e 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -119,6 +119,25 @@ struct messages_filter {
 	uint8_t priority;
 };
 
+/* To store Application parameters.
+ * maxlistcount - Maximum number of Messages or folders to be sent,
+ *		if not mentioned it is 1024.
+ * offset - Offset from where the list is to be sent, if not mentioned it is 0.
+ * attachment - Indicates if any attachment i.e. ON or OFF.
+ * charset - Determines trans-coding of the text i.e. "Native" or "UTF-8".
+ * status_indicator - Indicates which status information is to be modified
+ *		i.e. "readStatus" or "deletedStatus".
+ * status_value - Indicates value to status_indicator i.e. "yes" or "no".
+ */
+struct apparam_field {
+	uint16_t maxlistcount;
+	uint16_t offset;
+	uint8_t attachment;
+	uint8_t charset;
+	uint8_t status_indicator;
+	uint8_t status_value;
+};
+
 /* This is called once after server starts.
  *
  * Returns value less than zero if error. This will prevent MAP plugin from
-- 
1.7.0.4

