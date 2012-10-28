Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC v2 obexd 04/11] fuse: Add request helpers and setpath operation
Date: Sun, 28 Oct 2012 02:29:19 +0200
Message-Id: <1351384166-15586-4-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1351384166-15586-1-git-send-email-dmp0x7c5@gmail.com>
References: <1351384166-15586-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/helpers.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/fuse/helpers.c b/fuse/helpers.c
index 856e1d5..1b8082f 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -273,3 +273,111 @@ void gobexhlp_disconnect(struct gobexhlp_session* session)
 
 	g_free(session);
 }
+
+void request_new(struct gobexhlp_session *session,
+					gchar *name)
+{
+	g_print("REQUEST %s\n", name);
+
+	if (session->request != NULL)
+		g_error("Another request (%s) active!\n",
+					session->request->name);
+
+	session->status = 0;
+	session->request = g_malloc0(sizeof(struct gobexhlp_request));
+	session->request->name = name;
+
+	/*
+	 * suspend/resume operations recreates g_io_add_watch(),
+	 * it fixes obex->io freeze during transfer
+	 */
+	g_obex_suspend(session->obex);
+	g_obex_resume(session->obex);
+}
+
+void request_wait_free(struct gobexhlp_session *session)
+{
+	g_print("WAIT for %s\n", session->request->name);
+
+	g_obex_suspend(session->obex);
+	g_obex_resume(session->obex);
+
+	if (session->err != NULL) {
+		g_print("ERROR: %s (%d)\n", session->err->message,
+						session->err->code);
+		g_error_free(session->err);
+		raise(SIGTERM);
+		return;
+	}
+
+	g_mutex_lock(gobexhlp_mutex);
+
+	while (session->request->complete != TRUE)
+		g_cond_wait(gobexhlp_cond, gobexhlp_mutex);
+
+	g_mutex_unlock(gobexhlp_mutex);
+
+	g_free(session->request->name);
+	g_free(session->request);
+	session->request = NULL;
+}
+
+static void complete_func(GObex *obex, GError *err,
+				gpointer user_data)
+{
+	struct gobexhlp_session *session = user_data;
+
+	if (err != NULL) {
+		g_print("ERROR: %s\n", err->message);
+		session->status = -ECANCELED;
+		g_error_free(err);
+	} else {
+		g_print("COMPLETE %s\n", session->request->name);
+	}
+
+	g_mutex_lock(gobexhlp_mutex);
+	session->request->complete = TRUE;
+	g_cond_signal(gobexhlp_cond);
+	g_mutex_unlock(gobexhlp_mutex);
+}
+
+static void response_func(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
+{
+	complete_func(obex, err, user_data);
+}
+
+void gobexhlp_setpath(struct gobexhlp_session *session, const char *path)
+{
+	guint i = 0, split = 0;
+	gchar **path_v;
+	gsize len;
+
+	g_print("gobexhlp_setpath(%s)\n", path);
+
+	if (g_str_has_prefix(path, session->setpath)) {
+		split = strlen(session->setpath);
+	} else {
+		request_new(session, g_strdup_printf("setpath root"));
+		g_obex_setpath(session->obex, "", response_func,
+						session, &session->err);
+		request_wait_free(session);
+	}
+
+	path_v = g_strsplit(path+split, "/", -1);
+	len = g_strv_length(path_v);
+
+	for (i = 0; i < len; i++)
+		if (path_v[i][0] != '\0') {
+			request_new(session,
+				g_strdup_printf("setpath %s", path_v[i]));
+			g_obex_setpath(session->obex, path_v[i],
+					response_func, session, &session->err);
+			request_wait_free(session);
+		}
+
+	g_free(session->setpath);
+	session->setpath = g_strdup(path);
+
+	g_strfreev(path_v);
+}
-- 
1.7.8.6

