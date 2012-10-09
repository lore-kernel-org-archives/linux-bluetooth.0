Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC obexd 05/11] fuse: Add readdir operation
Date: Tue,  9 Oct 2012 20:15:50 +0200
Message-Id: <1349806556-1978-5-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
References: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/gobexfuse.c |   23 ++++++++++
 fuse/helpers.c   |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fuse/helpers.h   |    2 +
 3 files changed, 154 insertions(+), 0 deletions(-)

diff --git a/fuse/gobexfuse.c b/fuse/gobexfuse.c
index cc5fedb..2bdfc09 100644
--- a/fuse/gobexfuse.c
+++ b/fuse/gobexfuse.c
@@ -89,7 +89,30 @@ void gobexfuse_destroy()
 	g_thread_join(main_gthread);
 }
 
+static int gobexfuse_readdir(const char *path, void *buf,
+			fuse_fill_dir_t filler, off_t offset,
+				struct fuse_file_info *fi)
+{
+	int len, i;
+	gchar *string;
+	GList *files;
+
+	filler(buf, ".", NULL, 0);
+	filler(buf, "..", NULL, 0);
+
+	files = gobexhlp_listfolder(session, path);
+	len = g_list_length(files);
+
+	for (i = 1; i < len; i++) { /* element for i==0 is NULL */
+		string = g_list_nth_data(files, i);
+		filler(buf, string, NULL, 0);
+	}
+
+	return session->status;
+}
+
 static struct fuse_operations gobexfuse_oper = {
+	.readdir = gobexfuse_readdir,
 	.init = gobexfuse_init,
 	.destroy = gobexfuse_destroy,
 };
diff --git a/fuse/helpers.c b/fuse/helpers.c
index 1b8082f..1d3faa5 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -381,3 +381,132 @@ void gobexhlp_setpath(struct gobexhlp_session *session, const char *path)
 
 	g_strfreev(path_v);
 }
+
+static void listfolder_xml_element(GMarkupParseContext *ctxt,
+			const gchar *element, const gchar **names,
+			const gchar **values, gpointer user_data,
+			GError **gerr)
+{
+	gchar *key, *pathname, *name = NULL;
+	struct gobexhlp_session *session = user_data;
+	struct stat *stbuf;
+	gint i = 0;
+
+	stbuf = g_malloc0(sizeof(struct stat));
+
+	if ((strcasecmp("file", element) == 0)) {
+		stbuf->st_mode = S_IFREG;
+	} else if ((strcasecmp("folder", element)) == 0) {
+		stbuf->st_mode = S_IFDIR;
+		stbuf->st_mtime = time(NULL);
+	} else {
+		g_free(stbuf);
+		return;
+	}
+
+	for (key = (gchar *) names[i]; key; key = (gchar *) names[++i]) {
+		if (g_str_equal("name", key) == TRUE) {
+			session->lsfiles = g_list_append(session->lsfiles,
+						g_strdup(values[i]));
+			name = g_strdup(values[i]);
+
+		} else if (g_str_equal("size", key) == TRUE) {
+			guint64 size;
+			size = g_ascii_strtoll(values[i], NULL, 10);
+			stbuf->st_size = size;
+
+		} else if (g_str_equal("created", key) == TRUE) {
+			GTimeVal time;
+			GDateTime *datetime;
+			g_time_val_from_iso8601(values[i], &time);
+			datetime = g_date_time_new_from_timeval_utc(&time);
+			stbuf->st_mtime = g_date_time_to_unix(datetime);
+		}
+	}
+
+	if (g_str_equal("/", session->setpath) == TRUE)
+		pathname = g_strdup_printf("/%s", name);
+	else
+		pathname = g_strdup_printf("%s/%s", session->setpath, name);
+
+	g_hash_table_replace(session->file_stat, pathname, stbuf);
+	g_free(name);
+}
+
+static const GMarkupParser parser = {
+	listfolder_xml_element,
+	NULL, NULL, NULL, NULL
+};
+
+static void complete_listfolder_func(GObex *obex, GError *err,
+				gpointer user_data)
+{
+	GMarkupParseContext *ctxt;
+	struct gobexhlp_session *session = user_data;
+	struct gobexhlp_buffer *buffer = session->buffer;
+
+	if (err == NULL) {
+		ctxt = g_markup_parse_context_new(&parser, 0, session, NULL);
+		g_markup_parse_context_parse(ctxt, buffer->data, buffer->size,
+							NULL);
+		g_markup_parse_context_free(ctxt);
+	}
+
+	complete_func(obex, err, user_data);
+}
+
+static gboolean async_get_consumer(const void *buf, gsize len,
+							gpointer user_data)
+{
+	struct gobexhlp_session *session = user_data;
+	struct gobexhlp_buffer *buffer = session->buffer;
+
+	if (buffer->size == 0)
+		buffer->data = g_malloc0(sizeof(char) * len);
+	else
+		buffer->data = g_realloc(buffer->data, buffer->size + len);
+
+	memcpy(buffer->data + buffer->size, buf, len);
+	buffer->size += len;
+
+	g_obex_suspend(session->obex);
+	g_obex_resume(session->obex);
+
+	return TRUE;
+}
+
+GList *gobexhlp_listfolder(struct gobexhlp_session* session,
+					const char *path)
+{
+	struct gobexhlp_buffer *buffer;
+	GObexPacket *req;
+	guint reqpkt;
+
+	gobexhlp_setpath(session, path);
+
+	g_print("gobexhlp_listfolder(%s)\n", path);
+
+	if (session->lsfiles != NULL) {
+		g_list_free_full(session->lsfiles, g_free);
+		session->lsfiles = NULL;
+	}
+
+	session->lsfiles = g_list_alloc();
+	buffer = g_malloc0(sizeof(struct gobexhlp_buffer));
+	session->buffer = buffer;
+
+	request_new(session, g_strdup_printf("listfolder %s", path));
+	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
+	g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, OBEX_FTP_LS,
+						strlen(OBEX_FTP_LS) + 1);
+	reqpkt = g_obex_get_req_pkt(session->obex, req,
+				async_get_consumer,
+				complete_listfolder_func,
+				session, &session->err);
+	request_wait_free(session);
+	g_free(buffer->data);
+	g_free(buffer);
+
+	return session->lsfiles;
+}
+
diff --git a/fuse/helpers.h b/fuse/helpers.h
index f1d787b..84238c9 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -51,4 +51,6 @@ struct gobexhlp_session* gobexhlp_connect(const char *srcstr,
 						const char *dstsrc);
 void gobexhlp_disconnect(struct gobexhlp_session* session);
 
+GList *gobexhlp_listfolder(struct gobexhlp_session* session, const char *path);
+
 
-- 
1.7.8.6

