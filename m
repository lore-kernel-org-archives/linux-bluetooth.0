Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 05/13 v3] client: introduce obc_session_mkdir
Date: Wed,  8 Feb 2012 11:44:01 +0200
Message-Id: <1328694249-22225-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328694249-22225-1-git-send-email-luiz.dentz@gmail.com>
References: <1328694249-22225-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
Fix using strerror(-errno)


 client/session.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/session.h |    3 ++
 2 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index e946cfd..2467e85 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1241,3 +1241,67 @@ fail:
 	pending_request_free(p);
 	return 0;
 }
+
+static void async_cb(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
+{
+	struct pending_request *p = user_data;
+	struct obc_session *session = p->session;
+	GError *gerr = NULL;
+	uint8_t code;
+
+	p->req_id = 0;
+
+	if (err != NULL) {
+		if (p->func)
+			p->func(p->session, err, p->data);
+		goto done;
+	}
+
+	code = g_obex_packet_get_operation(rsp, NULL);
+	if (code != G_OBEX_RSP_SUCCESS)
+		g_set_error(&gerr, OBEX_IO_ERROR, code, "%s",
+							g_obex_strerror(code));
+
+	if (p->func)
+		p->func(p->session, gerr, p->data);
+
+	if (gerr != NULL)
+		g_clear_error(&gerr);
+
+done:
+	pending_request_free(p);
+	session->p = NULL;
+
+	session_process_queue(session);
+}
+
+guint obc_session_mkdir(struct obc_session *session, const char *folder,
+				session_callback_t func, void *user_data,
+				GError **err)
+{
+	struct pending_request *p;
+
+	if (session->obex == NULL) {
+		g_set_error(err, OBEX_IO_ERROR, OBEX_IO_DISCONNECTED,
+						"Session disconnected");
+		return 0;
+	}
+
+	if (session->p != NULL) {
+		g_set_error(err, OBEX_IO_ERROR, OBEX_IO_BUSY, "Session busy");
+		return 0;
+	}
+
+
+	p = pending_request_new(session, NULL, NULL, func, user_data);
+
+	p->req_id = g_obex_mkdir(session->obex, folder, async_cb, p, err);
+	if (*err != NULL) {
+		pending_request_free(p);
+		return 0;
+	}
+
+	session->p = p;
+	return p->id;
+}
diff --git a/client/session.h b/client/session.h
index 65cf4bd..a424054 100644
--- a/client/session.h
+++ b/client/session.h
@@ -77,3 +77,6 @@ int obc_session_put(struct obc_session *session, char *buf,
 guint obc_session_setpath(struct obc_session *session, const char *path,
 				session_callback_t func, void *user_data,
 				GError **err);
+guint obc_session_mkdir(struct obc_session *session, const char *folder,
+				session_callback_t func, void *user_data,
+				GError **err);
-- 
1.7.7.6

