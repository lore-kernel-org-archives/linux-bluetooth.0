Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 08/13 v3] client: introduce obc_session_delete
Date: Wed,  8 Feb 2012 11:44:04 +0200
Message-Id: <1328694249-22225-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328694249-22225-1-git-send-email-luiz.dentz@gmail.com>
References: <1328694249-22225-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
Fix using strerror(-errno)

 client/session.c |   29 +++++++++++++++++++++++++++++
 client/session.h |    3 +++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index dfc912d..7e7dea6 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1365,3 +1365,32 @@ guint obc_session_move(struct obc_session *session, const char *filename,
 	session->p = p;
 	return p->id;
 }
+
+guint obc_session_delete(struct obc_session *session, const char *file,
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
+	p = pending_request_new(session, NULL, NULL, func, user_data);
+
+	p->req_id = g_obex_delete(session->obex, file, async_cb, p, err);
+	if (*err != NULL) {
+		pending_request_free(p);
+		return 0;
+	}
+
+	session->p = p;
+	return p->id;
+}
diff --git a/client/session.h b/client/session.h
index 64548e9..ac5c27a 100644
--- a/client/session.h
+++ b/client/session.h
@@ -86,3 +86,6 @@ guint obc_session_copy(struct obc_session *session, const char *filename,
 guint obc_session_move(struct obc_session *session, const char *filename,
 				const char *destname, session_callback_t func,
 				void *user_data, GError **err);
+guint obc_session_delete(struct obc_session *session, const char *file,
+				session_callback_t func, void *user_data,
+				GError **err);
-- 
1.7.7.6

