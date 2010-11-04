Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH v3] Add support for sending large PBAP response in many parts
Date: Thu,  4 Nov 2010 16:18:33 +0200
Message-Id: <1288880313-30798-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added file buffer to cache pull results - temporary file will be deleted
when response is sent. Also added partial_resp variable to pbap_session
for holding information if more data will be available from source later.
It was needed to know when sent -EAGAIN to obex, if currently is no data
available in the buffer.
---
 plugins/pbap.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 3ea7d6b..6742ea7 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -116,6 +116,8 @@
   </attribute>								\
 </record>"
 
+#define PBAP_BUF_TEMPLATE "pbap_pullXXXXXX"
+
 struct aparam_header {
 	uint8_t tag;
 	uint8_t len;
@@ -143,6 +145,10 @@ struct pbap_session {
 	uint32_t find_handle;
 	GString *buffer;
 	struct cache cache;
+	gboolean partial_resp;
+	int fbuf_w;
+	int fbuf_r;
+	char *buf_path;
 };
 
 static const uint8_t PBAP_TARGET[TARGET_SIZE] = {
@@ -256,11 +262,27 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 		return;
 	}
 
-	if (!pbap->buffer)
-		pbap->buffer = g_string_new_len(buffer, bufsize);
-	else
-		pbap->buffer = g_string_append_len(pbap->buffer, buffer,
-								bufsize);
+	if (pbap->fbuf_w < 0) {
+		/* Creating file buffer for results*/
+		pbap->buf_path = g_build_filename(g_get_tmp_dir(),
+						PBAP_BUF_TEMPLATE, NULL);
+		pbap->fbuf_w = g_mkstemp(pbap->buf_path);
+
+		if (pbap->fbuf_w < 0)
+			return -EPERM;
+	}
+
+	write(pbap->fbuf_w, buffer, bufsize);
+
+	/* If partial_resp will be set to TRUE, then we won't end transmission
+	 * after sending one part of results to the client via obex*/
+	pbap->partial_resp = missed ? TRUE : FALSE;
+
+	/* If no more data in future, we close file buffer right now*/
+	if (!pbap->partial_resp) {
+		close(pbap->fbuf_w);
+		pbap->fbuf_w = -1;
+	}
 
 	obex_object_set_io_flags(pbap, G_IO_IN, 0);
 }
@@ -549,6 +571,8 @@ static void *pbap_connect(struct obex_session *os, int *err)
 	pbap = g_new0(struct pbap_session, 1);
 	pbap->folder = g_strdup("/");
 	pbap->find_handle = PHONEBOOK_INVALID_HANDLE;
+	pbap->fbuf_r = -1;
+	pbap->fbuf_w = -1;
 
 	if (err)
 		*err = 0;
@@ -829,6 +853,27 @@ fail:
 	return NULL;
 }
 
+static ssize_t pbap_read_fbuf(struct pbap_session *pbap, void *buf,
+								size_t count)
+{
+	ssize_t len;
+
+	if (pbap->fbuf_r < 0) {
+		pbap->fbuf_r = open(pbap->buf_path, 0);
+
+		if(pbap->fbuf_r < 0)
+			return -EPERM;
+	}
+
+	len = read(pbap->fbuf_r, buf, count);
+
+	if (len == 0 && pbap->partial_resp)
+		/* More data available later */
+		return -EAGAIN;
+	else
+		return len;
+}
+
 static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 								uint8_t *hi)
 {
@@ -837,17 +882,23 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 	DBG("buffer %p maxlistcount %d", pbap->buffer,
 						pbap->params->maxlistcount);
 
-	if (!pbap->buffer)
+	if (!pbap->buf_path && !pbap->buffer)
+		/* No response available now (no memory/file buffer exist)*/
 		return -EAGAIN;
 
-	/* PhoneBookSize */
-	if (pbap->params->maxlistcount == 0)
+	/* Result from pb size query is very short (only number) so it makes no
+	 * sense to create file buffer for it - using memory buff */
+	if (pbap->params->maxlistcount == 0) {
+		/* PhoneBookSize */
 		*hi = OBEX_HDR_APPARAM;
-	else
+
+		return string_read(pbap->buffer, buf, count);
+	} else {
 		/* Stream data */
 		*hi = OBEX_HDR_BODY;
 
-	return string_read(pbap->buffer, buf, count);
+		return pbap_read_fbuf(pbap, buf, count);
+	}
 }
 
 static ssize_t vobject_list_read(void *object, void *buf, size_t count,
@@ -893,6 +944,24 @@ static int vobject_close(void *object)
 		pbap->buffer = NULL;
 	}
 
+	if (pbap->fbuf_r >= 0) {
+		close(pbap->fbuf_r);
+		pbap->fbuf_r = -1;
+	}
+
+	if (pbap->fbuf_w >= 0) {
+		close(pbap->fbuf_w);
+		pbap->fbuf_w = -1;
+	}
+
+	if (pbap->buf_path) {
+		/* remove file buffer for pull queries */
+		unlink(pbap->buf_path);
+
+		g_free(pbap->buf_path);
+		pbap->buf_path = NULL;
+	}
+
 	return 0;
 }
 
-- 
1.7.0.4

